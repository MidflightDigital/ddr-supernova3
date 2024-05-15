local screenName = Var "LoadingScreen"

local t = Def.ActorFrame{
	LoadActor("new")..{
		InitCommand=cmd(x,SCREEN_LEFT;halign,0);
	};
	LoadActor("grid")..{
		InitCommand=cmd(blend,Blend.Add;;diffuse,color("#044600");x,SCREEN_LEFT;halign,0);
		OnCommand=cmd(diffusealpha,0.2);
	};
};

if ThemePrefs.Get("LightMode") == false then
t[#t+1] = Def.ActorFrame{
	LoadActor("glow")..{
		InitCommand=cmd(x,SCREEN_LEFT;halign,0);
		OnCommand=cmd(cropright,1;sleep,1;queuecommand,"Animate";draworder,100);
		AnimateCommand=cmd(decelerate,0.1;cropleft,0;cropright,1;decelerate,0.8;cropright,0;sleep,0.5;decelerate,0.8;cropleft,1;sleep,0.5;queuecommand,"Animate");
		OffCommand=cmd(finishtweening);
	};
};
end;

return t;
