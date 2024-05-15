local LoadingScreen = Var "LoadingScreen"
--smcmd is "screen metrics command", gmcmd is "general metrics command"
--these make it require a little less typing to run useful BPMDisplay related commands
local smcmd, gmcmd
do
	smcmd = function(s, name)
		return (THEME:GetMetric(LoadingScreen, name))(s)
	end
	gmcmd = function(s, name)
		return (THEME:GetMetric("BPMDisplay", name))(s)
	end
end

local counter = 0
local targetDelta = 1/60
local timer = GetUpdateTimer(targetDelta)

--displays 3 digit numbers 000, 111, 222... 999, 000... every 1/60 of a second (about)
local function RandomBPM(self, _)
	local s = self:GetChild"BPMDisplay"
	if not timer() then return end
	s:settext(string.rep(tostring(counter),3))
	counter = (counter+1)%10
end

local function textBPM(dispBPM)
	return string.format("%03d", math.round(dispBPM))
end

local goingUp = true
local startTime = GetTimeSinceStart()
local dispBPMs = {0,0}
--how long (in seconds) it should take to change from one BPM to the other
local length = 1
--how long to wait between reaching the target BPM and switching modes (in seconds)
local pause = 1
local function VariedBPM(self, _)
	local s = self:GetChild"BPMDisplay"
	local curTime = GetTimeSinceStart()
	local base = dispBPMs[goingUp and 1 or 2]
	local target = dispBPMs[goingUp and 2 or 1]
	--clamp doesn't sort its operands so we have to make sure they are correct
	local bpm = clamp(base+(target-base)*((curTime-startTime)/length), 
		goingUp and base or target, 
		goingUp and target or base)
	--aux is used to store the current BPM in non-truncated numeric form for use by the BPM meter
	s:aux(bpm):settext(textBPM(bpm))
	if curTime >= startTime + length + pause then
		goingUp = not goingUp
		startTime = curTime
	end
end


return Def.ActorFrame{
	--only ActorFrames and classes based on ActorFrame have update functions, which we need
	Name="SNBPMDisplayHost",
	Def.BitmapText{
		Font="BPMDisplay bpm",
		Name="BPMDisplay",
		InitCommand=function(s) s:aux(0):halign(0):settext "000":x(THEME:GetMetric(LoadingScreen,"BPMDisplayX"))
			:y(THEME:GetMetric(LoadingScreen,"BPMDisplayY")); return gmcmd(s, "SetNoBpmCommand") end,
		OnCommand=function(s) return smcmd(s, "BPMDisplayOnCommand") end,
		OffCommand=function(s) return smcmd(s, "BPMDisplayOffCommand") end,
		CurrentSongChangedMessageCommand = function(s, _)
			local song = GAMESTATE:GetCurrentSong()
			if song then
				if song:IsDisplayBpmRandom() or song:IsDisplayBpmSecret() then
					gmcmd(s, song:IsDisplayBpmRandom() and "SetRandomCommand" or "SetExtraCommand")
					--I do not believe that it is necessary to reset this counter every time.
					--It may even be incorrect.
					counter = 0
					timer = GetUpdateTimer(targetDelta)
					--an aux value of -1 is intended as a special value but it is not used.
					s:aux(-1):settext "999":GetParent():SetUpdateFunction(RandomBPM)
				else
					--if the display BPM is random, GetDisplayBpms returns nonsense, so only do it here.
					dispBPMs = song:GetDisplayBpms()
					s:aux(dispBPMs[1]):settext(textBPM(dispBPMs[1]))
					if song:IsDisplayBpmConstant() then
						gmcmd(s, "SetNormalCommand")
						s:GetParent():SetUpdateFunction(nil)
					else						
						gmcmd(s, "SetChangeCommand")
						--These actually do need to be reset every time.
						goingUp = true
						startTime = GetTimeSinceStart()
						s:GetParent():SetUpdateFunction(VariedBPM)
					end
				end
			else
				gmcmd(s, "SetNoBpmCommand")
				s:aux(0):settext "000":GetParent():SetUpdateFunction(nil)
			end
		end
	}
}