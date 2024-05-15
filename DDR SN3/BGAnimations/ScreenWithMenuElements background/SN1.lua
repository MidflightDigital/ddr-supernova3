local t = Def.ActorFrame{
	FOV=130;
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
t[#t+1] = Def.ActorFrame{
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
	Def.ActorFrame{
		LoadActor(THEME:GetPathB("","_shared/SN1/_bg"))..{
			InitCommand=cmd(Center;zoom,8;spin;effectmagnitude,0,0,-1.5;diffuse,color("1,1,1,1"));
		};
	};
	Def.ActorFrame{
	InitCommand=cmd(spin;effectmagnitude,-1.5,2,-1.5;Center;zoom,0.5;blend,Blend.Add;);
		LoadActor(THEME:GetPathB("","_shared/SN1/SuperNOVABG.txt"))..{
			InitCommand=cmd(clearzbuffer,0;rotationx,-90;rotationz,-90;diffuse,color("0.75,0.75,0.75,0.5");zoom,8;fadebottom,1;blend,Blend.Add;;diffusealpha,0.25;glow,color("1,1,1,0.3"));
		};
		Def.ActorFrame{
			InitCommand=cmd(zoom,8;x,SCREEN_WIDTH/2);
			LoadActor(THEME:GetPathB("","_shared/SN1/SuperNovaBallFog (DoubleFaced).txt"))..{
				InitCommand=cmd(diffuse,color("1,1,1,0.5");spin;effectmagnitude,10,100,10;blend,Blend.Add;;diffusealpha,0.25;glow,color("1,1,1,0.3"));
			};
			LoadActor(THEME:GetPathB("","_shared/SN1/SuperNovaFogBall (DoubleFaced).txt"))..{
				InitCommand=cmd(diffuse,color("1,1,1,0.5");zoom,0.9;spin;effectmagnitude,10,100,10;blend,Blend.Add;;diffusealpha,0.25;glow,color("1,1,1,0.3"));
			};
			LoadActor(THEME:GetPathB("","_shared/SN1/SuperNovaBallLine (DoubleFaced).txt"))..{
				InitCommand=cmd(diffuse,color("0.8,0.8,0.8,1");rotationx,-200;rotationz,-90;rotationy,-60;spin;effectmagnitude,100,100,100;blend,Blend.Add;;diffusealpha,0.25;glow,color("1,1,1,0.3"));
			};
			LoadActor(THEME:GetPathB("","_shared/SN1/SuperNovaBallLine (DoubleFaced).txt"))..{
				InitCommand=cmd(diffuse,color("0.8,0.8,0.8,1");rotationx,200;rotationz,90;rotationy,60;spin;effectmagnitude,-100,-100,-100;blend,Blend.Add;;diffusealpha,0.25;glow,color("1,1,1,0.3"));
			};
			LoadActor(THEME:GetPathB("","_shared/SN1/SuperNovaBall (DoubleFaced).txt"))..{
				InitCommand=cmd(diffuse,color("0.6,0.6,0.6,1");spin;effectmagnitude,10,100,10;blend,Blend.Add;;diffusealpha,0.25;glow,color("1,1,1,0.3"));
			};
			Condition=not ThemePrefs.Get("LightMode");
		};
	};
	Def.ActorFrame{
		LoadActor(THEME:GetPathB("","_shared/SN1/SuperNOVALine.txt"))..{
			InitCommand=cmd(Center;rotationx,-200;rotationz,90;rotationy,60;zoom,12;spin;effectmagnitude,100,100,100;blend,Blend.Add;;diffusealpha,0.25;glow,color("1,1,1,0.3"));
		};
		LoadActor(THEME:GetPathB("","_shared/SN1/SuperNOVALine.txt"))..{
			InitCommand=cmd(Center;rotationx,200;rotationz,-90;rotationy,60;zoom,12;spin;effectmagnitude,-100,-100,-100;blend,Blend.Add;;diffusealpha,0.25;glow,color("1,1,1,0.3"));
		};
		Condition=not ThemePrefs.Get("LightMode");
	};
};

return t;
