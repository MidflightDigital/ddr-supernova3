local t = Def.ActorFrame{};

t[#t+1] = Def.ActorFrame{
	LoadActor(THEME:GetPathS("","_swoosh.mp3"))..{
		OnCommand=cmd(queuecommand,"Play");
		PlayCommand=cmd(play)
	};
};

return t;
