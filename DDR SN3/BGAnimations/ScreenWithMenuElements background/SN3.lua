local t = Def.ActorFrame{
};
local p = {
	red = color("1,0,0,0.812"),
	green = color("0,1,0,0.812"),
	blue = color("0,0,1,0.812"),
	yellow = color("1,1,0,0.812"),
	pink = color("1,0,1,0.812"),
	cyan = color("0,1,1,0.812")
}
local colorPatterns =
{
	--first pattern block: YRPBCG with different start indices
	{[0]=p.yellow, p.red, p.pink, p.blue, p.cyan, p.green},
	--second pattern block: GCBPRY with different start indices
	{[0]=p.pink, p.red, p.yellow, p.green, p.cyan, p.blue}
}
local curPattern = 1
local curPatternIdx = 0
t[#t+1] = Def.ActorFrame {
	InitCommand=function(self)
		self:fov(120);
	end;
	Def.ActorFrame{
		OnCommand=function(self)
		local seed = math.random(1,13);
			--seed breakdown:
			--8-13: pattern 1, increasing start color
			--2-7: pattern 2, increasing start color
			--1: rainbow
			if seed > 1 then
				if seed > 7 then
					curPattern = 1
					curPatternIdx = seed - 8
				else
					curPattern = 2
					curPatternIdx = seed - 2
				end
				self:diffuse(colorPatterns[curPattern][curPatternIdx])
				self:queuecommand("Animate")
			else
				self:rainbow();
				self:effectperiod(120);
			end;
		end;
		AnimateCommand = function(s)
			--bump the current color to the next color in the pattern
			curPatternIdx = (curPatternIdx + 1) % #(colorPatterns[curPattern])
			s:linear(20)
			:diffuse(colorPatterns[curPattern][curPatternIdx])
			:queuecommand("Animate")
		end;
		LoadActor(THEME:GetPathB("","_shared/SN3/back"))..{
			InitCommand=cmd(FullScreen);
		};
		LoadActor(THEME:GetPathB("","_shared/SN3/honeyleft"))..{
			InitCommand=cmd(CenterY;halign,0;x,SCREEN_LEFT;diffuse,color("1,1,1,0.1");blend,Blend.Add;zoom,0.75);
		};
		LoadActor(THEME:GetPathB("","_shared/SN3/honeyright"))..{
			InitCommand=cmd(CenterY;halign,1;x,SCREEN_RIGHT;diffuse,color("1,1,1,0.1");blend,Blend.Add;zoom,0.75);
		};
	};
	Def.ActorFrame{
	InitCommand=cmd(Center;blend,Blend.Add;;diffusealpha,0.6);
		LoadActor(THEME:GetPathB("","_shared/stars"))..{
			InitCommand=cmd(diffusealpha,0.3;fadetop,0.5;fadebottom,0.5);
			OnCommand=function(self)
				local w = DISPLAY:GetDisplayWidth() / self:GetWidth();
				local h = DISPLAY:GetDisplayHeight() / self:GetHeight();
				self:customtexturerect(0,0,w*1,h*1);
				self:texcoordvelocity(-0.02,0);
			end;
		};
		LoadActor(THEME:GetPathB("","_shared/flash"))..{
			InitCommand=cmd(y,-50;x,-200;diffusealpha,0.5);
			OnCommand=cmd(spin;effectmagnitude,0,0,50);
		};
		LoadActor(THEME:GetPathB("","_shared/left flash"))..{
			OnCommand=cmd(diffusealpha,0;sleep,4;accelerate,0.2;diffusealpha,1;sleep,0.5;linear,1;diffusealpha,0;queuecommand,'On');
		};
		LoadActor(THEME:GetPathB("","_shared/right flash"))..{
			OnCommand=cmd(diffusealpha,0;sleep,2;accelerate,0.2;diffusealpha,1;sleep,0.5;linear,1;diffusealpha,0;sleep,2;queuecommand,'On');
		};
		LoadActor(THEME:GetPathB("","_shared/round grid"))..{
			InitCommand=cmd(diffusealpha,0.5;blend,Blend.Add;);
		};
		LoadActor(THEME:GetPathB("","_shared/middle flash"))..{
			InitCommand=cmd(y,-240;CenterX;zoomx,SCREEN_WIDTH;fadetop,0.5;fadebottom,0.5);
			OnCommand=cmd(diffusealpha,0;blend,Blend.Add;;linear,2;diffusealpha,0.55;addy,SCREEN_HEIGHT;queuecommand,"Queue");
			QueueCommand=cmd(diffusealpha,0;addy,-SCREEN_HEIGHT;sleep,4;queuecommand,"On");
		};
		Condition=not ThemePrefs.Get("LightMode");
	};
};

t[#t+1] = Def.ActorFrame{
	InitCommand=function(self)
		self:Center()
		self:zoom(0.4)
	end;
	Def.ActorFrame{
		InitCommand=cmd(zbuffer,true;z,-1000;);
		Def.ActorFrame{
			InitCommand=cmd(rotationx,12;rotationz,22);
			LoadActor(THEME:GetPathB("","_shared/SN3/SuperNovaFogBall.txt"))..{
				InitCommand=cmd(diffusealpha,0.25;blend,Blend.Add;zoom,20;spin;effectmagnitude,0,80,0);
			};
			LoadActor(THEME:GetPathB("","_shared/SN3/2ndSuperNovaFogBall.txt"))..{
				InitCommand=cmd(diffusealpha,0.25;blend,Blend.Add;zoom,20;spin;effectmagnitude,0,-80,0);
			};
		};
		LoadActor(THEME:GetPathB("","_shared/IIDX 17/wakusei/ring.png"))..{
			InitCommand=cmd(queuecommand,"Anim");
			AnimCommand=cmd(blend,Blend.Add;diffusealpha,0.5;rotationx,75;rotationy,-60;zoom,2.2;spin;effectmagnitude,0,0,75);
		};
		LoadActor(THEME:GetPathB("","_shared/IIDX 17/wakusei/ring.png"))..{
			InitCommand=cmd(queuecommand,"Anim");
			AnimCommand=cmd(blend,Blend.Add;diffusealpha,0.5;rotationx,85;rotationy,-15;zoom,2.2;spin,effectmagnitude,0,0,75);
		};
		LoadActor(THEME:GetPathB("","_shared/IIDX 17/wakusei/ring 2.png"))..{
			InitCommand=cmd(queuecommand,"Anim");
			AnimCommand=cmd(blend,Blend.Add;diffusealpha,1;rotationx,83;rotationy,10;zoom,2.2;spin,effectmagnitude,0,0,-75);
		};
		Condition=not ThemePrefs.Get("LightMode");
	};
};

t[#t+1] = Def.ActorFrame{
	InitCommand=function(self)
		self:fov(120);
	end;
	LoadActor(THEME:GetPathB("","_shared/IIDX 17/wakusei/meter 1 (stretch).png"))..{
		InitCommand=cmd(CenterX;y,SCREEN_CENTER_Y+20;zoomtowidth,SCREEN_WIDTH;zoomtoheight,SCREEN_HEIGHT);
		OnCommand=function(self)
			local w = DISPLAY:GetDisplayWidth() / self:GetWidth();
			local h = DISPLAY:GetDisplayHeight() / self:GetHeight();
			self:customtexturerect(0,0,w*0.5,h*0.5);
			self:rotationz(180)
			self:texcoordvelocity(-0.2,0);
			self:blend(Blend.Add);
		end;
	};
	LoadActor(THEME:GetPathB("","_shared/IIDX 17/wakusei/meter 1 (stretch).png"))..{
		InitCommand=cmd(CenterX;y,SCREEN_CENTER_Y-20;zoomtowidth,SCREEN_WIDTH;zoomtoheight,SCREEN_HEIGHT);
		OnCommand=function(self)
			local w = DISPLAY:GetDisplayWidth() / self:GetWidth();
			local h = DISPLAY:GetDisplayHeight() / self:GetHeight();
			self:customtexturerect(0,0,w*0.5,h*0.5);
			self:texcoordvelocity(-0.2,0);
			self:blend(Blend.Add);
		end;
	};
};

t[#t+1] = Def.ActorFrame{
	LoadActor(THEME:GetPathB("","_shared/SN3/scan"))..{
		InitCommand=cmd(FullScreen;blend,Blend.Add;;diffusealpha,0.25);
	};
}

return t;
