local t = Def.ActorFrame{
	-- Information panel
	LoadActor("info")..{
		InitCommand=cmd(halign,0;x,WideScale(SCREEN_LEFT,SCREEN_LEFT+80);y,SCREEN_BOTTOM-80);
		GainFocusCommand=function(s) MESSAGEMAN:Broadcast("PlayCourse") s:visible(true):addx(-11):decelerate(0.1):addx(11) end,
		LoseFocusCommand=cmd(visible,false);
		OffCommand=cmd(linear,0.133;addx,SCREEN_WIDTH);
	};
};

return t;
