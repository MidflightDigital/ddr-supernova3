local t = Def.ActorFrame{};

t[#t+1] = Def.ActorFrame{
	Def.Quad{
		InitCommand=cmd(FullScreen);
		OnCommand=cmd(diffusealpha,0;sleep,1);
	};
};

return t;
