local t = Def.ActorFrame {
};
t[#t+1] = Def.ActorFrame {
	InitCommand=function(self)
		self:fov(90);
	end;
	Def.ActorFrame{
	LoadActor("tile") ..{
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;zoomtowidth,SCREEN_WIDTH+400;zoomtoheight,SCREEN_HEIGHT+200;rotationx,-12);
		OnCommand=function(self)
			local w = DISPLAY:GetDisplayWidth() / self:GetWidth();
			local h = DISPLAY:GetDisplayHeight() / self:GetHeight();
			self:customtexturerect(0,0,w*0.5,h*0.5);
			self:texcoordvelocity(0.25,-0.25);
		end;
	};
	Def.Quad{
		InitCommand=cmd(diffusealpha,0;FullScreen;diffusetopedge,color("0,0,0,0.5"));
	};
	LoadActor("pad")..{
		InitCommand=cmd(x,WideScale(SCREEN_CENTER_X+130,SCREEN_CENTER_X+200);y,SCREEN_CENTER_Y+30;rotationx,-23;zoomy,0.8;zoomx,1);
	};
	Def.Quad {
		OnCommand=cmd(diffusealpha,0;sleep,62.0;accelerate,0.5;diffusealpha,1);
	};
};
};

return t;
