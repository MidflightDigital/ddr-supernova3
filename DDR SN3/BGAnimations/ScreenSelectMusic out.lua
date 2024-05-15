LoadFromProfilePrefs()
return Def.ActorFrame{
	LoadActor(THEME:GetPathS("","_swoosh"))..{
		StartTransitioningCommand=cmd(play);
	};
	StartTransitioningCommand=function(self) SOUND:DimMusic(0,math.huge) end,
};
