-- ScreenHowToPlay Overlay
-- The math.floor(10000*aspect) trick is used to circumvent float precision problems.
local aspectRatioSuffix = {
	[math.floor(10000*4/3)] = " 4_3",
	[math.floor(10000*16/9)] = " 16_9",
	[math.floor(10000*16/10)] = " 16_9"
}
--fall back on the 4:3 frame if we don't know about this aspect ratio at all
setmetatable(aspectRatioSuffix,{__index=function() return " standard" end})
local suffix = aspectRatioSuffix[math.floor(10000*PREFSMAN:GetPreference("DisplayAspectRatio"))]

local lifeFrame = "normal"

-- fall back on the 4:3 frame if there's no frame available for this aspect ratio
if ResolveRelativePath(THEME:GetPathG("ScreenGameplay","LifeFrame/"..lifeFrame..suffix),1,true) then
	lifeFrame = lifeFrame .. suffix
	line = "lines" .. suffix
else
	Warn("ScreenGameplay LifeFrame: missing frame \""..lifeFrame..suffix.."\". Using fallback assets.")
	lifeFrame = lifeFrame.." 4_3"
	line = "lines 4_3"
end

local t = Def.ActorFrame{
	LoadActor("howtoplay big")..{
		Name="HowToPlayBig";
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y);
		OnCommand=cmd(sleep,0.3;sleep,1.8;linear,0.2;addy,-50;croptop,1);
	};
	LoadActor("howtoplay small")..{
		Name="HowToPlaySmall";
		InitCommand=cmd(x,WideScale(SCREEN_CENTER_X+130,SCREEN_CENTER_X+200);y,SCREEN_TOP+25;);
		OnCommand=cmd(addy,-50;sleep,0.3;sleep,1.8;linear,0.2;addy,50);
	};
	LoadActor("feet")..{
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y);
		OnCommand=cmd(addy,-64;croptop,1;sleep,2.4;linear,0.233;addy,64;croptop,0;sleep,1.267;linear,0.233;addy,-64;croptop,1);
	};
	-- let the messages begin
	Def.ActorFrame {
		InitCommand=cmd(x,WideScale(SCREEN_CENTER_X-146,SCREEN_CENTER_X-240);y,SCREEN_CENTER_Y+37);
		LoadActor("text_up")..{
			OnCommand=cmd(zoomy,0;sleep,10;decelerate,0.3;zoomy,1;sleep,3.3;zoomy,0);
		};
		LoadActor("text_jump")..{
			OnCommand=cmd(zoomy,0;sleep,16.4;decelerate,0.3;zoomy,1;sleep,3.3;zoomy,0);
		};
		--Freeze 1
		LoadActor("text_freeze")..{
			OnCommand=cmd(zoomy,0;sleep,22.6;decelerate,0.3;zoomy,1;sleep,2;zoomy,0);
		};
		--Freeze 2
		LoadActor("text_missfreeze")..{
			OnCommand=cmd(zoomy,0;sleep,27.4;decelerate,0.3;zoomy,1;sleep,2;zoomy,0);
		};
		LoadActor("text_gameover")..{
			OnCommand=cmd(zoomy,0;sleep,32;decelerate,0.3;zoomy,1;);
		};
	};
	Def.ActorFrame{
	};
};
t[#t+1] = LoadActor(THEME:GetPathG("ScreenGameplay","LifeFrame/"..lifeFrame))..{
		InitCommand=function(self)
			self:x(WideScale(SCREEN_CENTER_X-172,SCREEN_CENTER_X-237)):y(SCREEN_TOP+25)
		end,
	};
t[#t+1] = LoadActor(THEME:GetPathG("ScreenGameplay","LifeFrame/"..line))..{
	InitCommand=function(self)
		self:x(WideScale(SCREEN_CENTER_X-172,SCREEN_CENTER_X-237)):y(SCREEN_TOP+25)
		:diffusealpha(0.4)
	end,
};

t[#t+1] = LoadActor(THEME:GetPathG("","_shared/Badges/LifeBar/P1"))..{
	InitCommand=function(self)
		self:x(SCREEN_LEFT+10):y(SCREEN_TOP+25)
	end;
};

return t;
