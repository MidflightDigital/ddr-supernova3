local t = Def.ActorFrame {};

t[#t+1] = Def.ActorFrame{
	LoadActor(THEME:GetPathS("","_ins in"))..{
		StartTransitioningCommand=cmd(play);
	};
};

return t;
