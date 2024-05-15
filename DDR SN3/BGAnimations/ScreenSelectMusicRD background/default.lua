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
	LoadActor("tunnel")..{
		InitCommand=cmd(FullScreen);
	};
	Def.Quad{
		InitCommand=function(self)
			self:diffuse(color("1,0,0,0.4"))
			self:queuecommand("Animate")
			self:FullScreen()
		end;
		AnimateCommand = function(s)
			s:diffusealpha(0):sleep(0.5):accelerate(0.2):diffusealpha(0.4):sleep(0.5):accelerate(0.2):diffusealpha(0):queuecommand("Animate")
		end;
	};
	Def.ActorFrame{
		LoadActor(THEME:GetPathB("","_shared/stars"))..{
			InitCommand=cmd(halign,0;x,SCREEN_CENTER_X;diffusealpha,0.3;fadetop,0.5;fadebottom,0.5;faderight,0.283;rotationy,45);
			OnCommand=function(self)
				local w = DISPLAY:GetDisplayWidth() / self:GetWidth();
				local h = DISPLAY:GetDisplayHeight() / self:GetHeight();
				self:customtexturerect(0,0,w*0.5,h*0.5);
				self:texcoordvelocity(1,0);
			end;
		};
		LoadActor(THEME:GetPathB("","_shared/stars"))..{
			InitCommand=cmd(halign,1;x,SCREEN_CENTER_X;diffusealpha,0.3;fadetop,0.5;fadebottom,0.5;fadeleft,0.283;rotationy,-45);
			OnCommand=function(self)
				local w = DISPLAY:GetDisplayWidth() / self:GetWidth();
				local h = DISPLAY:GetDisplayHeight() / self:GetHeight();
				self:customtexturerect(0,0,w*0.5,h*0.5);
				self:texcoordvelocity(-1,0);
			end;
		};
	};
};

if ThemePrefs.Get("LightMode") then return t end


t[#t+1] = Def.ActorFrame{
	InitCommand=function(self)
		self:fov(120);
	end;
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
