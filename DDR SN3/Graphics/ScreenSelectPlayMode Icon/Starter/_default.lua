local t = Def.ActorFrame{
	-- Information panel
	LoadActor("info")..{
		InitCommand=cmd(halign,0;x,WideScale(SCREEN_LEFT,SCREEN_LEFT+80);y,SCREEN_BOTTOM-80);
		GainFocusCommand=function(s) MESSAGEMAN:Broadcast("PlayStarter") s:visible(true):addx(-11):decelerate(0.1):addx(11) end,
		LoseFocusCommand=cmd(visible,false);
		OffCommand=cmd(linear,0.133;addx,SCREEN_WIDTH);
	};
	LoadActor("badge")..{
		InitCommand=cmd(x,WideScale(SCREEN_CENTER_X+20,SCREEN_CENTER_X-5);y,SCREEN_BOTTOM-80);
		GainFocusCommand=cmd(zoomx,0;zoomy,0;visible,true;linear,0.05;zoomx,1;sleep,0.2;linear,0.1;zoomy,1;glowshift;effectcolor1,color("1,1,1,0.2");effectcolor2,color("0,0,0,0");effectperiod,1);
		LoseFocusCommand=cmd(visible,false);
		OffCommand=cmd(linear,0.133;addx,SCREEN_WIDTH);
	};
};

return t;
