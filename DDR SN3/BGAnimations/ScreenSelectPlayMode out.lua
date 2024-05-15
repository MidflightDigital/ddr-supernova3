return Def.ActorFrame{
	Def.Quad{
		InitCommand=cmd(FullScreen);
		OnCommand=cmd(diffusealpha,0;sleep,2);
	};
	LoadActor(THEME:GetPathS("","_swoosh.mp3"))..{
		OnCommand=cmd(queuecommand,"Play");
		PlayCommand=cmd(play)
	};
  StartTransitioningCommand=function(self) SOUND:DimMusic(0,math.huge) end,
}
