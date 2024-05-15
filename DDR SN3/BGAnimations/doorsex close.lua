local t = LoadActor(THEME:GetPathB("","_doors"), "_newer door", 0.4, true )

t[#t+1] = Def.ActorFrame{
	LoadActor(THEME:GetPathS("","_siren"))..{
		OnCommand=cmd(playcommand,"Play");
		PlayCommand=cmd(sleep,0.8;play);
	};
};

return t
