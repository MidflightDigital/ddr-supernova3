local t = Def.ActorFrame{};

t[#t+1] = Def.ActorFrame {
	Def.ActorFrame{
		LoadActor(THEME:GetPathB("","_shared/IIDX 17/wakusei/bg.png"))..{
			InitCommand=cmd(FullScreen);
		};
		LoadActor(THEME:GetPathB("","_shared/IIDX 17/wakusei/wakusei.png"))..{
			InitCommand=cmd(queuecommand,"Anim");
			AnimCommand=cmd(zoom,1;diffusealpha,1;rotationz,10;x,SCREEN_LEFT+70;CenterY;sleep,2;linear,8;x,SCREEN_LEFT+150;zoom,0.8;rotationz,0;
			sleep,2;linear,8;x,SCREEN_LEFT+70;zoom,1;rotationz,10;linear,0;diffusealpha,0;queuecommand,"Anim");
		};
	};
};

if ThemePrefs.Get("LightMode") then return t end

t[#t+1] = Def.ActorFrame{
	LoadActor(THEME:GetPathB("","_shared/IIDX 17/wakusei/wakka 1"))..{
		InitCommand=cmd(queuecommand,"Anim");
		AnimCommand=cmd(blend,Blend.Add;;zoom,1;x,SCREEN_LEFT+58;y,SCREEN_CENTER_Y+16;rotationy,10;rotationx,85;diffusealpha,1;linear,2;rotationz,180;linear,8;rotationz,900;
		rotationy,0;zoom,0.8;x,SCREEN_LEFT+150;linear,2;rotationz,720;linear,8;rotationz,0;x,SCREEN_LEFT+58;zoom,1;rotationy,10;linear,0;diffusealpha,0;queuecommand,"Anim");
	};
	LoadActor(THEME:GetPathB("","_shared/IIDX 17/wakusei/wakka 1"))..{
		InitCommand=cmd(queuecommand,"Anim");
		AnimCommand=cmd(blend,Blend.Add;;zoom,1;x,SCREEN_LEFT+70;y,SCREEN_CENTER_Y-13;rotationy,10;rotationx,85;diffusealpha,1;linear,2;rotationz,-180;linear,8;rotationz,-900;
		rotationy,0;zoom,0.8;x,SCREEN_LEFT+150;linear,2;rotationz,-720;linear,8;rotationz,0;x,SCREEN_LEFT+70;zoom,1;rotationy,10;linear,0;diffusealpha,0;queuecommand,"Anim");
	};
	LoadActor(THEME:GetPathB("","_shared/IIDX 17/wakusei/wakka 2"))..{
		InitCommand=cmd(queuecommand,"Anim");
		AnimCommand=cmd(blend,Blend.Add;zoom,1;x,SCREEN_LEFT+46;y,SCREEN_CENTER_Y+49;rotationy,10;rotationx,84;diffusealpha,1;linear,2;rotationz,270;linear,8;rotationz,1080;
		rotationy,0;zoom,0.8;x,SCREEN_LEFT+150;y,SCREEN_CENTER_Y+39;linear,2;rotationz,810;linear,8;rotationz,0;x,SCREEN_LEFT+46;y,SCREEN_CENTER_Y+49;zoom,1;rotationy,10;linear,0;diffusealpha,0;queuecommand,"Anim");
	};
	LoadActor(THEME:GetPathB("","_shared/IIDX 17/wakusei/wakka 2"))..{
		InitCommand=cmd(queuecommand,"Anim");
		AnimCommand=cmd(blend,Blend.Add;zoom,1;x,SCREEN_LEFT+73;y,SCREEN_CENTER_Y-48;rotationy,10;rotationx,84;diffusealpha,1;linear,2;rotationz,-270;linear,8;rotationz,-1080;
		rotationy,0;zoom,0.8;x,SCREEN_LEFT+150;y,SCREEN_CENTER_Y-40;linear,2;rotationz,-810;linear,8;rotationz,0;x,SCREEN_LEFT+73;y,SCREEN_CENTER_Y-48;zoom,1;rotationy,10;linear,0;diffusealpha,0;queuecommand,"Anim");
	};
	LoadActor(THEME:GetPathB("","_shared/IIDX 17/wakusei/wakka 3"))..{
		InitCommand=cmd(queuecommand,"Anim");
		AnimCommand=cmd(blend,Blend.Add;zoom,1;x,SCREEN_LEFT+41;y,SCREEN_CENTER_Y+83;rotationy,10;rotationx,83;diffusealpha,1;linear,2;rotationz,-90;linear,8;rotationz,-720;
		rotationy,0;zoom,0.8;x,SCREEN_LEFT+150;y,SCREEN_CENTER_Y+69;linear,2;rotationz,-630;linear,8;rotationz,0;x,SCREEN_LEFT+41;y,SCREEN_CENTER_Y+83;zoom,1;rotationy,10;linear,0;diffusealpha,0;queuecommand,"Anim");
	};
	LoadActor(THEME:GetPathB("","_shared/IIDX 17/wakusei/wakka 2"))..{
		InitCommand=cmd(queuecommand,"Anim");
		AnimCommand=cmd(blend,Blend.Add;zoom,1;x,SCREEN_LEFT+72;y,SCREEN_CENTER_Y-84;rotationy,10;rotationx,83;diffusealpha,1;linear,2;rotationz,90;linear,8;rotationz,720;
		rotationy,0;zoom,0.8;x,SCREEN_LEFT+150;y,SCREEN_CENTER_Y-68;linear,2;rotationz,630;linear,8;rotationz,0;x,SCREEN_LEFT+72;y,SCREEN_CENTER_Y-84;zoom,1;rotationy,10;linear,0;diffusealpha,0;queuecommand,"Anim");
	};
	LoadActor(THEME:GetPathB("","_shared/IIDX 17/wakusei/wakka 4"))..{
		InitCommand=cmd(queuecommand,"Anim");
		AnimCommand=cmd(blend,Blend.Add;zoom,1;x,SCREEN_LEFT+30;y,SCREEN_CENTER_Y+113;rotationy,10;rotationx,82;diffusealpha,1;linear,2;rotationz,270;linear,8;rotationz,1260;
		rotationy,0;zoom,0.8;x,SCREEN_LEFT+150;y,SCREEN_CENTER_Y+94;linear,2;rotationz,900;linear,8;rotationz,0;x,SCREEN_LEFT+30;y,SCREEN_CENTER_Y+113;zoom,1;rotationy,10;linear,0;diffusealpha,0;queuecommand,"Anim");
	};
	LoadActor(THEME:GetPathB("","_shared/IIDX 17/wakusei/wakka 4"))..{
		InitCommand=cmd(queuecommand,"Anim");
		AnimCommand=cmd(blend,Blend.Add;zoom,1;x,SCREEN_LEFT+76;y,SCREEN_CENTER_Y-116;rotationy,10;rotationx,82;diffusealpha,1;linear,2;rotationz,-270;linear,8;rotationz,-1260;
		rotationy,0;zoom,0.8;x,SCREEN_LEFT+150;y,SCREEN_CENTER_Y-95;linear,2;rotationz,-900;linear,8;rotationz,0;x,SCREEN_LEFT+76;y,SCREEN_CENTER_Y-116;zoom,1;rotationy,10;linear,0;diffusealpha,0;queuecommand,"Anim");
	};
	LoadActor(THEME:GetPathB("","_shared/IIDX 17/wakusei/wakka 5"))..{
		InitCommand=cmd(queuecommand,"Anim");
		AnimCommand=cmd(blend,Blend.Add;zoom,1;x,SCREEN_LEFT+24;y,SCREEN_CENTER_Y+147;rotationy,10;rotationx,81;diffusealpha,1;linear,2;rotationz,-270;linear,8;rotationz,-1080;
		rotationy,0;zoom,0.8;x,SCREEN_LEFT+150;y,SCREEN_CENTER_Y+121;linear,2;rotationz,-810;linear,8;rotationz,0;x,SCREEN_LEFT+24;y,SCREEN_CENTER_Y+147;zoom,1;rotationy,10;linear,0;diffusealpha,0;queuecommand,"Anim");
	};
	LoadActor(THEME:GetPathB("","_shared/IIDX 17/wakusei/wakka 5"))..{
		InitCommand=cmd(queuecommand,"Anim");
		AnimCommand=cmd(blend,Blend.Add;zoom,1;x,SCREEN_LEFT+88;y,SCREEN_CENTER_Y-154;rotationy,10;rotationx,81;diffusealpha,1;linear,2;rotationz,270;linear,8;rotationz,1080;
		rotationy,0;zoom,0.8;x,SCREEN_LEFT+150;y,SCREEN_CENTER_Y-122;linear,2;rotationz,810;linear,8;rotationz,0;x,SCREEN_LEFT+88;y,SCREEN_CENTER_Y-154;zoom,1;rotationy,10;linear,0;diffusealpha,0;queuecommand,"Anim");
	};
	LoadActor(THEME:GetPathB("","_shared/IIDX 17/wakusei/wakka 6"))..{
		InitCommand=cmd(queuecommand,"Anim");
		AnimCommand=cmd(blend,Blend.Add;zoom,1;x,SCREEN_LEFT+15;y,SCREEN_CENTER_Y+180;rotationy,10;rotationx,80;diffusealpha,1;linear,2;rotationz,450;linear,8;rotationz,1440;
		rotationy,0;zoom,0.8;x,SCREEN_LEFT+150;y,SCREEN_CENTER_Y+149;linear,2;rotationz,990;linear,8;rotationz,0;x,SCREEN_LEFT+15;y,SCREEN_CENTER_Y+180;zoom,1;rotationy,10;linear,0;diffusealpha,0;queuecommand,"Anim");
	};
	LoadActor(THEME:GetPathB("","_shared/IIDX 17/wakusei/wakka 6"))..{
		InitCommand=cmd(queuecommand,"Anim");
		AnimCommand=cmd(blend,Blend.Add;zoom,1;x,SCREEN_LEFT+94;y,SCREEN_CENTER_Y-183;rotationy,10;rotationx,80;diffusealpha,1;linear,2;rotationz,-180;
		linear,8;rotationz,-1440;rotationy,0;zoom,0.8;x,SCREEN_LEFT+150;y,SCREEN_CENTER_Y-149;linear,2;rotationz,-990;linear,8;rotationz,0;x,SCREEN_LEFT+94;y,SCREEN_CENTER_Y-183;zoom,1;rotationy,10;linear,0;diffusealpha,0;queuecommand,"Anim");
	};
	LoadActor(THEME:GetPathB("","_shared/IIDX 17/wakusei/ring.png"))..{
		InitCommand=cmd(queuecommand,"Anim");
		AnimCommand=cmd(blend,Blend.Add;x,SCREEN_LEFT+70;CenterY;diffusealpha,0.5;rotationx,75;rotationy,-60;zoom,1.4;linear,2;rotationz,180;
		linear,8;rotationz,900;zoom,1.1;x,SCREEN_LEFT+150;linear,2;rotationz,720;linear,8;rotationz,0;x,70;zoom,1.4;linear,0;diffusealpha,0;queuecommand,"Anim");
	};
	LoadActor(THEME:GetPathB("","_shared/IIDX 17/wakusei/ring.png"))..{
		InitCommand=cmd(queuecommand,"Anim");
		AnimCommand=cmd(blend,Blend.Add;x,SCREEN_LEFT+70;y,SCREEN_CENTER_Y;diffusealpha,0.5;rotationx,85;rotationy,-15;zoom,1.5;linear,2;rotationz,180;linear,8;rotationz,900;
		zoom,1.3;rotationx,85;x,SCREEN_LEFT+150;linear,2;rotationz,720;linear,8;rotationz,0;rotationx,85;x,SCREEN_LEFT+70;zoom,1.5;linear,0;diffusealpha,0;queuecommand,"Anim");
	};
	LoadActor(THEME:GetPathB("","_shared/IIDX 17/wakusei/ring 2.png"))..{
		InitCommand=cmd(queuecommand,"Anim");
		AnimCommand=cmd(blend,Blend.Add;x,SCREEN_LEFT+70;CenterY;diffusealpha,1;rotationx,83;rotationy,10;zoom,2.5;linear,2;rotationz,180;linear,8;rotationz,900;
		zoom,2;rotationx,83;x,SCREEN_LEFT+150;linear,2;rotationz,720;linear,8;rotationz,0;rotationx,83;x,SCREEN_LEFT+70;zoom,2.5;linear,0;diffusealpha,0;queuecommand,"Anim");
	};
	LoadActor(THEME:GetPathB("","_shared/IIDX 17/shineget"));
	LoadActor(THEME:GetPathB("","_shared/IIDX 17/wakusei/meter 2 (stretch).png"))..{
		InitCommand=cmd(CenterX;y,SCREEN_CENTER_Y-80;zoomtowidth,SCREEN_WIDTH;zoomtoheight,SCREEN_HEIGHT);
		OnCommand=function(self)
			local w = DISPLAY:GetDisplayWidth() / self:GetWidth();
			local h = DISPLAY:GetDisplayHeight() / self:GetHeight();
			self:customtexturerect(0,0,w*0.5,h*0.5);
			self:texcoordvelocity(-0.2,0);
			self:blend(Blend.Add);
		end;
	};
	LoadActor(THEME:GetPathB("","_shared/IIDX 17/wakusei/meter 1 (stretch).png"))..{
		InitCommand=cmd(x,SCREEN_LEFT-80;CenterY;zoomtowidth,SCREEN_WIDTH;zoomtoheight,SCREEN_HEIGHT);
		OnCommand=function(self)
			local w = DISPLAY:GetDisplayWidth() / self:GetWidth();
			local h = DISPLAY:GetDisplayHeight() / self:GetHeight();
			self:customtexturerect(0,0,w*0.5,h*0.5);
			self:rotationz(90)
			self:texcoordvelocity(0.2,0);
			self:blend(Blend.Add);
		end;
	};
};

return t;
