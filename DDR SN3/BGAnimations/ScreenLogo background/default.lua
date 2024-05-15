local counter = 0;
local t = Def.ActorFrame{};

t[#t+1] = Def.ActorFrame {
	Def.ActorFrame{
	InitCommand=cmd(Center);
		LoadActor("bg");
	};
	Def.ActorFrame{
	InitCommand=cmd(Center;blend,Blend.Add;;diffusealpha,0.6);
		LoadActor(THEME:GetPathB("","_shared/stars"))..{
			InitCommand=cmd(diffusealpha,0.3;fadetop,0.5;fadebottom,0.5);
		};
		LoadActor(THEME:GetPathB("","_shared/flash"))..{
			InitCommand=cmd(y,-50;x,-200;diffusealpha,0.5);
			OnCommand=cmd(spin;effectmagnitude,0,0,50);
		};
		LoadActor(THEME:GetPathB("","_shared/left flash"))..{
			OnCommand=cmd(blend,Blend.Add;;diffuse,color("#a8d313");diffusealpha,0;sleep,4;accelerate,0.2;diffusealpha,1;sleep,1;linear,1;diffusealpha,0;queuecommand,'On');
		};
		LoadActor(THEME:GetPathB("","_shared/right flash"))..{
			OnCommand=cmd(diffusealpha,0;sleep,2;accelerate,0.2;diffusealpha,1;sleep,0.5;linear,1;diffusealpha,0;sleep,2;queuecommand,'On');
		};
		LoadActor(THEME:GetPathB("","_shared/middle flash"))..{
			InitCommand=cmd(y,-240;CenterX;zoomx,SCREEN_WIDTH;fadetop,0.5;fadebottom,0.5);
			OnCommand=cmd(diffusealpha,0;blend,Blend.Add;;linear,2;diffusealpha,0.55;addy,SCREEN_HEIGHT;queuecommand,"Queue");
			QueueCommand=cmd(diffusealpha,0;addy,-SCREEN_HEIGHT;sleep,4;queuecommand,"On");
		};
		LoadActor(THEME:GetPathB("","_shared/right explosion"))..{
			OnCommand=cmd(diffusealpha,0;sleep,3;accelerate,0.2;diffusealpha,1;sleep,0.5;linear,1;diffusealpha,0;sleep,3;queuecommand,'On');
		};
		Condition=not ThemePrefs.Get("LightMode");
	};
	Def.ActorFrame{
		LoadActor("ddrsn_logo")..{
			InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y-8;zoom,0.9);
		};
		LoadActor("ddrsn_logo")..{
			InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y-8;zoom,0.9);
			OnCommand=cmd(sleep,2;diffusealpha,0.4;zoom,0.9;linear,2;zoom,1;diffusealpha,0;queuecommand,"Queue");
			QueueCommand=cmd(sleep,3.5;queuecommand,"On");
		};
		LoadActor("ddrsn_konami")..{
			InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_BOTTOM-40);
		};
	};
};

return t;
