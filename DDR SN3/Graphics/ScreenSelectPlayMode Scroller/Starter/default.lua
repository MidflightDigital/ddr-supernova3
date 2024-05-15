local path = "_shared/SelMode/";

local t = Def.ActorFrame{
	-- Information panel
	--[[LoadActor("color")..{
		OnCommand=cmd(diffuse,color("0,0,0,0.5");zoom,0);
		GainFocusCommand=cmd(stoptweening;decelerate,0.2;zoom,1);
		LoseFocusCommand=cmd(zoom,0);
	};]]--
	LoadActor(THEME:GetPathG("",path.."Titles/Starter"));
};

return t;
