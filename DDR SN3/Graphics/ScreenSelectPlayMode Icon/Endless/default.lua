local t = Def.ActorFrame{
	GainFocusCommand=function(self) MESSAGEMAN:Broadcast("PlayEndless") end;
	-- Information panel
	LoadActor(THEME:GetPathG("","_PlayMode/back"));
	LoadActor("color")..{
		OnCommand=cmd(diffuse,color("0.5,0.5,0.5,1"));
		GainFocusCommand=cmd(diffuse,color("#00ff1e"));
		LoseFocusCommand=cmd(diffuse,color("0.5,0.5,0.5,1"));
	};
	LoadActor(THEME:GetPathG("","_PlayMode/title back (doubleres)"))..{
		OnCommand=cmd(diffuse,color("1,1,1,1"));
		GainFocusCommand=cmd(diffuseshift;effectcolor1,color("#00ff1e");effectcolor2,color("#008803");effectperiod,0.25);
		LoseFocusCommand=cmd(stopeffect;diffuse,color("1,1,1,1"));
	};
	LoadActor(THEME:GetPathG("","_PlayMode/midoutline (doubleres)"))..{
		InitCommand=cmd(y,15);
		OnCommand=cmd(diffuse,color("#00ff1e");diffusealpha,0;zoom,0);
		GainFocusCommand=cmd(diffuseshift;effectcolor1,color("#00ff1e");effectcolor2,color("#008803");effectperiod,0.25;
			diffusealpha,0;zoom,0.5;linear,0.4;diffusealpha,1;zoom,0.9;linear,0.4;diffusealpha,0;zoom,1;sleep,1;queuecommand,"GainFocus");
		LoseFocusCommand=cmd(stopeffect;finishtweening;diffusealpha,0;zoom,0);
	};
	LoadActor("text");
};

return t;
