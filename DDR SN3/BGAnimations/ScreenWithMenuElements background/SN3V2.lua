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
		LoadActor(THEME:GetPathB("","_shared/SN3/back"))..{
			InitCommand=cmd(FullScreen);
		--My god you are amazing kenp.
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
	};
	};
	Def.ActorFrame{
	InitCommand=cmd(x,SCREEN_LEFT+120;CenterY;blend,Blend.Add;;diffusealpha,0.6);
		LoadActor(THEME:GetPathB("","_shared/stars"))..{
			InitCommand=cmd(diffusealpha,0.3;fadetop,0.5;fadebottom,0.5;rotationy,16);
			OnCommand=function(self)
				local w = DISPLAY:GetDisplayWidth() / self:GetWidth();
				local h = DISPLAY:GetDisplayHeight() / self:GetHeight();
				self:customtexturerect(0,0,w*0.5,h*0.5);
				self:texcoordvelocity(-0.02,0);
			end;
		};
		LoadActor(THEME:GetPathB("","_shared/stars"))..{
			InitCommand=cmd(diffusealpha,0.3;fadetop,0.5;fadebottom,0.5;rotationy,16);
			OnCommand=function(self)
				local w = DISPLAY:GetDisplayWidth() / self:GetWidth();
				local h = DISPLAY:GetDisplayHeight() / self:GetHeight();
				self:customtexturerect(0,0,w*0.5,h*0.5);
				self:texcoordvelocity(-0.03,0);
			end;
		};
	};
};

if ThemePrefs.Get("LightMode") then return t end

t[#t+1] = Def.ActorFrame{
	InitCommand=function(self)
		self:fov(120);
		self:xy(SCREEN_LEFT-320,SCREEN_TOP-60);
	end;
	Def.ActorFrame{
		InitCommand=cmd(zbuffer,true;z,-500;blend,Blend.Add);
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
			AnimCommand=cmd(blend,Blend.Add;diffusealpha,0.5;rotationx,75;rotationy,-60;zoom,2.4;spin;effectmagnitude,0,0,100);
		};
		LoadActor(THEME:GetPathB("","_shared/IIDX 17/wakusei/ring.png"))..{
			InitCommand=cmd(queuecommand,"Anim");
			AnimCommand=cmd(blend,Blend.Add;diffusealpha,0.5;rotationx,85;rotationy,-15;zoom,2.5;spin,effectmagnitude,0,0,100);
		};
		LoadActor(THEME:GetPathB("","_shared/IIDX 17/wakusei/ring 2.png"))..{
			InitCommand=cmd(queuecommand,"Anim");
			AnimCommand=cmd(blend,Blend.Add;diffusealpha,1;rotationx,83;rotationy,10;zoom,2.5;spin,effctmagnitude,0,0,-100);
		};
	};
};

t[#t+1] = Def.ActorFrame{
	InitCommand=function(self)
		self:fov(120);
	end;
	LoadActor(THEME:GetPathB("","_shared/IIDX 17/shineget"))..{
		InitCommand=cmd(rotationy,16);
	};
	LoadActor(THEME:GetPathB("","_shared/IIDX 17/wakusei/meter 1 (stretch).png"))..{
		InitCommand=cmd(x,SCREEN_LEFT-80;CenterY;zoomtowidth,SCREEN_WIDTH;zoomtoheight,SCREEN_HEIGHT;rotationy,16);
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
