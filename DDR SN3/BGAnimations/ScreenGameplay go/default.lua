return Def.ActorFrame{
	Def.Quad{
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;zoomx,0;setsize,570,72;fadeleft,1;faderight,1;diffuse,color("0,1,0.5,1"));
		OnCommand=function(self)
			self:diffusealpha(0):zoomx(0)
			:linear(0.264):diffusealpha(1):zoomx(1):sleep(0.75):linear(0.25):zoomx(0):diffusealpha(0);
		end;
	};
	LoadActor("go")..{
		InitCommand=cmd(Center);
		OnCommand=cmd(diffusealpha,0;zoomx,4;zoomy,0;accelerate,0.132;zoomx,1;zoomy,1;diffusealpha,1;sleep,1;accelerate,0.132;zoomx,4;zoomy,0;diffusealpha,0);
	};
};
