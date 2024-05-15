return Def.ActorFrame{
	LoadActor("_newer door2")..{
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_BOTTOM;valign,1);
		OnCommand=cmd(linear,0.792;y,SCREEN_BOTTOM+SCREEN_HEIGHT);
	};
	LoadActor("_newer door1")..{
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_TOP;valign,0);
		OnCommand=cmd(linear,0.792;y,SCREEN_TOP-SCREEN_HEIGHT);
	};
}
