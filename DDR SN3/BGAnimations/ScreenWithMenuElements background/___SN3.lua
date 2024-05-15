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
		LoadActor(THEME:GetPathB("","_shared/SN3/galaxy tint"))..{
			InitCommand=cmd(FullScreen;blend,Blend.Add;;diffusealpha,0.25);
		};
	};
	Def.ActorFrame{
		LoadActor(THEME:GetPathB("","_shared/SN3/bgrp01"))..{
			InitCommand=cmd(zoom,1;x,SCREEN_LEFT+200;y,SCREEN_CENTER_Y+180);
			OnCommand=cmd(blend,'BlendMode_Add';diffusealpha,0;sleep,0.5;playcommand,"Animate");
			AnimateCommand=cmd(zoom,1;diffusealpha,0;linear,0.65;zoom,1.3;diffusealpha,0.5;decelerate,1.5;zoom,1.6;diffusealpha,0;sleep,6;queuecommand,"Animate");
		};
		LoadActor(THEME:GetPathB("","_shared/SN3/rp00A1"))..{
			InitCommand=cmd(zoom,0.6;x,SCREEN_LEFT+200;y,SCREEN_CENTER_Y+180);
			OnCommand=cmd(blend,'BlendMode_Add';diffusealpha,0;sleep,0.5;playcommand,"Animate");
			AnimateCommand=cmd(zoom,0.6;diffusealpha,0;rotationz,0;linear,0.65;rotationz,230;zoom,0.9;diffusealpha,0.2;decelerate,1.5;rotationz,490;zoom,1.2;diffusealpha,0;sleep,6;queuecommand,"Animate");
		};
	};
	Def.ActorFrame{
		InitCommand=cmd(diffusealpha,0.25;blend,'BlendMode_Add';xy,SCREEN_RIGHT-200,SCREEN_CENTER_Y);
		LoadActor(THEME:GetPathB("","_shared/SN3/ring2"))..{
			InitCommand=cmd(zoom,0.35;spin;effectmagnitude,0,0,20);
		};
	};
};

return t;
