-- gameplay life frame

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

-- todo: show oni on life meter battery as well
if GAMESTATE:GetPlayMode() == 'PlayMode_Oni' then lifeFrame = "special" end
if GAMESTATE:GetPlayMode() == 'PlayMode_Nonstop' then lifeFrame = "special" end
if GAMESTATE:GetPlayMode() == 'PlayMode_Rave' then lifeFrame = "special" end
if GAMESTATE:IsAnExtraStage() then lifeFrame = "special" end

-- fall back on the 4:3 frame if there's no frame available for this aspect ratio
if ResolveRelativePath(lifeFrame..suffix,1,true) then
	lifeFrame = lifeFrame .. suffix
	line = "lines" .. suffix
else
	Warn("ScreenGameplay LifeFrame: missing frame \""..lifeFrame..suffix.."\". Using fallback assets.")
	lifeFrame = lifeFrame.." 4_3"
	line = "lines 4_3"
end

-- fall back on 4:3 frame because tug doesn't like lua scripts.
if GAMESTATE:GetPlayMode() == "PlayMode_Rave" then
	lifeFrame = "special 4_3"
	line = "lines 4_3"
end

local xPosPlayer = {
    P1 = -(SCREEN_WIDTH/6.7),
    P2 = (SCREEN_WIDTH/6.7)
}

local xPosPlayerRave = {
	P1 = -(640/6.7),
    P2 = (640/6.7)
};

local t = Def.ActorFrame{}
t[#t+1] = LoadActor("flicker")
for _, pn in pairs(GAMESTATE:GetEnabledPlayers()) do
	t[#t+1] = LoadActor(lifeFrame)..{
		Name = pn,
		InitCommand=function(self)
			local short = ToEnumShortString(pn)
			if GAMESTATE:GetPlayMode() == "PlayMode_Rave" then
				self:x(xPosPlayerRave[short])
			else
				self:x(xPosPlayer[short])
			end;
			self:halign(0.75)
		end,
		OnCommand=function(s) s:zoomx(pn=='PlayerNumber_P2' and -1 or 1) end,
	};
	t[#t+1] = LoadActor(line)..{
		InitCommand=function(self)
			local short = ToEnumShortString(pn)
			if GAMESTATE:GetPlayMode() == "PlayMode_Rave" then
				self:x(xPosPlayerRave[short])
			else
				self:x(xPosPlayer[short])
			end;
			self:halign(0.75)
			:diffusealpha(0.4)
		end,
		OnCommand=function(s) s:zoomx(pn=='PlayerNumber_P2' and -1 or 1) end,
		BeginCommand=function(self,param)
			if GAMESTATE:PlayerIsUsingModifier('PlayerNumber_P1','battery') or GAMESTATE:GetPlayMode() == 'PlayMode_Oni' then
				self:visible(false);
			elseif GAMESTATE:PlayerIsUsingModifier('PlayerNumber_P2','battery') or GAMESTATE:GetPlayMode() == 'PlayMode_Oni' then
				self:visible(false);
			else
				self:visible(true);
			end;
		end;
	};
end;

t[#t+1] = LoadActor("../_shared/Badges/LifeBar/P1")..{
	InitCommand=function(self)
		if GAMESTATE:GetPlayMode() == "PlayMode_Rave" then
				self:x(-(640/2.08))
			else
				self:x(WideScale(-(SCREEN_WIDTH/2.08),-(SCREEN_WIDTH/2.12)))
			end;
	end;
	BeginCommand=function(self,param)
		if GAMESTATE:IsPlayerEnabled('PlayerNumber_P1') then
			self:visible(true);
		else
			self:visible(false);
		end;
	end;
};

t[#t+1] = LoadActor("../_shared/Badges/LifeBar/P2")..{
	InitCommand=function(self)
		if GAMESTATE:GetPlayMode() == "PlayMode_Rave" then
				self:x((640/2.08))
			else
				self:x(WideScale((SCREEN_WIDTH/2.08),(SCREEN_WIDTH/2.12)))
			end;
	end,
	BeginCommand=function(self,param)
		if GAMESTATE:IsPlayerEnabled('PlayerNumber_P2') then
			self:visible(true);
		else
			self:visible(false);
		end;
	end;
};

--Player 1 Risky Splitter
if GAMESTATE:IsPlayerEnabled('PlayerNumber_P1') then
t[#t+1] = LoadActor("splitter")..{
	InitCommand=function(self)
		self:x(-(SCREEN_WIDTH/5.7)):skewx(WideScale(-1.5,-0.9)):zoomto((SCREEN_WIDTH/2.54),14):halign(0.75);
	end;
	BeginCommand=function(self,param)
		if GAMESTATE:PlayerIsUsingModifier('PlayerNumber_P1','battery') or GAMESTATE:GetPlayMode() == 'PlayMode_Oni' then
			self:visible(true);
		else
			self:visible(false);
		end;
	end;
};
end;

--Player 2 Risky Splitter
if GAMESTATE:IsPlayerEnabled('PlayerNumber_P2') then
t[#t+1] = LoadActor("splitter")..{
	InitCommand=function(self)
		self:x((SCREEN_WIDTH/5.7)):skewx(WideScale(1.5,0.9)):zoomto((SCREEN_WIDTH/2.54),14):halign(0.25);
	end;
	BeginCommand=function(self,param)
		if GAMESTATE:PlayerIsUsingModifier('PlayerNumber_P2','battery') or GAMESTATE:GetPlayMode() == 'PlayMode_Oni' then
			self:visible(true);
		else
			self:visible(false);
		end;
	end;
};
end;

--Player 1 Danger
t[#t+1] = LoadActor("danger 2x1")..{
		InitCommand=cmd(x,WideScale(-160,-213.5);visible,false);
		HealthStateChangedMessageCommand=function(self, param)
			if GAMESTATE:IsPlayerEnabled('PlayerNumber_P1') then
				if param.HealthState == "HealthState_Danger" then
					self:visible(true);
				else
					self:visible(false);
				end;
			end;
		end;
};
--Player 2 Danger
t[#t+1] = LoadActor("danger 2x1")..{
		InitCommand=cmd(x,WideScale(160,213.5);visible,false);
		HealthStateChangedMessageCommand=function(self, param)
			if GAMESTATE:IsPlayerEnabled('PlayerNumber_P2') then
				if param.HealthState == "HealthState_Danger" then
					self:visible(true);
				else
					self:visible(false);
				end;
			end;
		end;
};


return t
