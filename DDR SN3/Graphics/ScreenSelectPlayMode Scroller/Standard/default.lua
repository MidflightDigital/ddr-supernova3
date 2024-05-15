local t = Def.ActorFrame{
	-- Information panel
	LoadActor("color")..{
		OnCommand=cmd(diffuse,color("0,0,0,0.5");decelerate,0.2;zoom,1);
		GainFocusCommand=cmd(stoptweening;decelerate,0.2;zoom,1);
		LoseFocusCommand=cmd(zoom,0);
	};
};

return t;
