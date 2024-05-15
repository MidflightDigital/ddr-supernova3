--Explanation of these values:
--The game seems to treat every BPM below about 100 and above about 270 exactly the same.
--110 is about the lowest BPM where there will always be showing bar pieces.
--This is not necessarily true at 100 BPM, so a negative value is generated.
--155 is simply 270-115, the spread between 0 and 1. - tertu

--13/86 was chosen because it's roughly the height of two bar pieces -tertu

local twiddleDistance = 13/86

local function CalculateBaseForBPM(bpm)
	return 1 - (((clamp(bpm, 100, 300) - 110) / 140)+twiddleDistance/2)
end

local gauge = nil

local targetDelta = 1/60
local timer = GetUpdateTimer(targetDelta)

local bpmBase = 0
local function ConstantBPM(self)
	--Randomly vibrate the tip below a target BPM.
	--Observing SN2 in practice seems to suggest that the base BPM is the maximum value reachable.
	--So, we just subtract a random number.
	if not timer() then return end
	gauge:croptop(clamp(bpmBase - ((math.random()-0.5)*twiddleDistance), 0, 1))
end

local bpmDispTarget = nil
local function VariedBPM(self)
	--Set the current BPM based on what the BPMDisplay is currently showing.
	--This depends on SNBPMDisplay (which puts the exact current value it's displaying in its aux)
	if not bpmDispTarget then error("started VariedBPM without a target, can't continue") end
	local curBPM = bpmDispTarget:getaux()
	gauge:croptop(clamp(CalculateBaseForBPM(curBPM), 0, 1))
end

local function RandomBPM(self)
	--Shoot the gauge up and down. It's faster to let the engine handle the details.
	if gauge:GetTweenTimeLeft()==0 then
		return gauge:playcommand "Random"
	end
end

return Def.ActorFrame{
	CurrentSongChangedMessageCommand=function(self)
		local song = GAMESTATE:GetCurrentSong()
		if not gauge then
			gauge = self:GetChild "bpm gauge bright"
		end
		if not song then
			--set the meter to 0
			self:SetUpdateFunction(nil)
			gauge:finishtweening():croptop(1)
			return
		end

		if song:IsDisplayBpmRandom() or song:IsDisplayBpmSecret() then
			self:SetUpdateFunction(RandomBPM)
		else
			gauge:finishtweening()
			if song:IsDisplayBpmConstant() then
				bpmBase = CalculateBaseForBPM(song:GetDisplayBpms()[1])
				self:SetUpdateFunction(ConstantBPM)
			else
				if not bpmDispTarget then
					bpmDispTarget = SCREENMAN:GetTopScreen():GetChild("SNBPMDisplayHost"):GetChild("BPMDisplay")
				end
				self:SetUpdateFunction(VariedBPM)
			end
		end
	end;
	Def.Sprite {
	Name="bpm gauge bright",
	Texture="newgauge",
		InitCommand=function(self)
			self:hibernate(1.25):x(BPMMeterPosX()):y(SCREEN_CENTER_Y-122):visible(false):croptop(1)
		end,
		OnCommand=function(self)
			self:sleep(0.264):visible(true)
		end,
		OffCommand=function(self)
			self:finishtweening():visible(false)
		end,
		RandomCommand=function(self)
			self:croptop(1):linear(0.25):croptop(0):linear(0.25):croptop(1)
		end
	};
};
