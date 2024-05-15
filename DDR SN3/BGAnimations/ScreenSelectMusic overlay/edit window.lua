local player = ({...})[1]
local dimensions = {x=376,y=124}
local short_player = ToEnumShortString(player)
local sideFlipMultiplier = short_player=='P1' and -1 or 1
local horizAlign, beginningX, endX
do
	local baseBeginningX = (dimensions.x/2)-8 
	local horizAligns = {P1=0,P2=1}
	horizAlign = horizAligns[short_player]
	beginningX = baseBeginningX * (sideFlipMultiplier)
	endX = -beginningX
end

local maxTextWidth = dimensions.x-72 --radar size and then some padding (8px before, 8px after, 8px after the radar)
local editColor = {0.75,0.75,0.75,1}

local t =  Def.ActorFrame{
	--become invisible at first in case our player isn't joined right now
	InitCommand=function(s) s:visible(false) end;
	--Def.Quad{InitCommand=function(s) s:setsize(dimensions.x,dimensions.y):diffuse{0,0,0,0.95} end};
	LoadActor("editwindow back");
	Def.BitmapText{
		Font="_futura std medium 20px",
		InitCommand=function(s) s:y(-10):x(beginningX):halign(horizAlign):maxwidth(maxTextWidth) end,
		HandleAppearCommand=function(s, params)
			local description = params.Steps:GetDescription()
			if params.Steps:GetAuthorCredit() == description then
				--center yourself, this is the only one that shows
				s:y(0)
			else
				s:y(-5)
			end
			s:settext(description) 
		end
	};
	Def.BitmapText{
		Font="_futura std medium 20px",
		InitCommand=function(s) s:y(11):zoom(0.6):x(beginningX):halign(horizAlign):maxwidth(maxTextWidth):max_dimension_use_zoom(true) end,
		HandleAppearCommand=function(s, params)
			local author = params.Steps:GetAuthorCredit() 
			if author == params.Steps:GetDescription() then
				--idk what to do about this situation. this is what happens to SM files.
				s:settext("")
			elseif author ~= ""  then
				s:settext("by "..author)
			else
				s:settext("by ???")
			end
		end
	};
	create_ddr_groove_radar(short_player.."EditRadar", (-dimensions.x/2+56)*sideFlipMultiplier, 0, player, 
		40, color("1,1,1,0.25"), {editColor,editColor,editColor,editColor,editColor}, "linear", 0);
	LoadActor(THEME:GetPathG("_ScreenSelectMusic","MeterDisplay"),
		{Difficulty='Difficulty_Edit',PositionX=16*sideFlipMultiplier,TrackPN=player})..
		{InitCommand=function(s) s:y((dimensions.y/2)-16):halign(horizAlign) end}
}
t.SetCommand = function(s)
	local steps = GAMESTATE:GetCurrentSteps(player)
	local song = GAMESTATE:GetCurrentSong()

	if GAMESTATE:GetCurrentSong() and steps and steps:GetDifficulty() == 'Difficulty_Edit' then
		s:playcommand("HandleAppear",{Steps=steps}):visible(true)
	else
		s:visible(false)
	end
end
t["CurrentSteps"..short_player.."ChangedMessageCommand"] = function(s) s:playcommand("Set") end
--if we get kicked out of a group due to player join, fire this so the window hides
t.CurrentSongChangedMessageCommand = function(s) s:playcommand("Set") end

return t