--DO NOT TRY TO LOAD THIS ACTOR DIRECTLY!!
--IT WILL NOT WORK!!

local t = Def.ActorFrame{};

local function setVisibility(self)
    local shouldShowBGScripts = ShowCharacterAnimations()
    local bg = SCREENMAN:GetTopScreen():GetChild("SongBackground")
    if bg then
        bg:visible(not shouldShowBGScripts);
    end
    self:visible(shouldShowBGScripts);
end

t.OnCommand = setVisibility
t.CurrentSongChangedMessageCommand = setVisibility

local charName = ResolveCharacterName(GAMESTATE:GetMasterPlayerNumber())

local loadWorked = false
local potentialVideo = Characters.GetDancerVideo(charName)

if potentialVideo then
    loadWorked = true
	t[#t+1] = LoadActor( potentialVideo )..{
		InitCommand=cmd(draworder,1;Center;zoomto,SCREEN_WIDTH+38,SCREEN_HEIGHT+38;);	
	};

end
	
return {bg=t, worked=loadWorked};