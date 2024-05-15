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
		LoadActor(THEME:GetPathB("","_shared/back"))..{
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
			InitCommand=cmd(diffusealpha,0.5);
		};
		LoadActor(THEME:GetPathB("","_shared/middle flash"))..{
			InitCommand=cmd(y,-240;CenterX;zoomx,SCREEN_WIDTH;fadetop,0.5;fadebottom,0.5);
			OnCommand=cmd(diffusealpha,0;blend,Blend.Add;;linear,2;diffusealpha,0.55;addy,SCREEN_HEIGHT;queuecommand,"Queue");
			QueueCommand=cmd(diffusealpha,0;addy,-SCREEN_HEIGHT;sleep,4;queuecommand,"On");
		};
		Condition=not ThemePrefs.Get("LightMode");
	};
	Def.ActorFrame{
		InitCommand=cmd(Center;zoom,1.5;diffuse,color("1,1,1,1"));
		LoadActor("ball");
		LoadActor("shine")..{
			InitCommand=cmd(diffuse,color("0.5,0.5,0.5,0.5"));
		};
		LoadActor("inside circle rim")..{
			InitCommand=cmd(spin;effectmagnitude,0,0,5);
		};
		LoadActor("outer rim")..{
			InitCommand=cmd(spin;effectmagnitude,5,10,20);
		};
		LoadActor("middle rim")..{
			InitCommand=cmd(spin;effectmagnitude,-35,20,-50);
		};
		LoadActor("inner rim")..{
			InitCommand=cmd(spin;effectmagnitude,0,0,30);
		};
		Condition=not ThemePrefs.Get("LightMode");
	};
};

return t;
