local t = LoadFallbackB()

-- The math.floor(10000*aspect) trick is used to circumvent float precision problems.
local aspectRatioSuffix = {
	[math.floor(10000*4/3)] = " 4_3",
	[math.floor(10000*16/9)] = " 16_9",
	[math.floor(10000*16/10)] = " 16_9"
}

--fall back on the 4:3 frame if we don't know about this aspect ratio at all
setmetatable(aspectRatioSuffix,{__index=function() return " standard" end})
local suffix = aspectRatioSuffix[math.floor(10000*PREFSMAN:GetPreference("DisplayAspectRatio"))]

-- fall back on the 4:3 frame if there's no frame available for this aspect ratio
if ResolveRelativePath(suffix,1,true) then
	aspect = suffix
else
	Warn("ScreenSelectPlayMode decorations: missing image \""..suffix.."\". Using fallback assets.")
	aspect = "4_3"
end

local choice

local playImages = {}
for _, file in
	pairs(FILEMAN:GetDirListing("/Themes/"..THEME:GetCurThemeName().."/Graphics/_shared/SelMode/Images/"..aspect.."/", false, true))
do
	if ActorUtil.GetFileType(file) == 'FileType_Bitmap' then
		--this clustercuss extracts the part of the filename that is actually the filename
		--first it takes the last part of the file name and extracts the part that isn't the extension
		--then it trims whitespace, and finally removes tags (such as doubleres)
		local name = string.lower(string.match(file, "/([^/]-)%.%w+"):gsub("^%s*",""):gsub("%s*$", ""):gsub("% (.-%)", ""))
		if name then
			playImages[name] = file
			print(name)
		end
	end
end

local playTitles = {}
for _, file in
	pairs(FILEMAN:GetDirListing("/Themes/"..THEME:GetCurThemeName().."/Graphics/_shared/SelMode/Titles/", false, true))
do
	if ActorUtil.GetFileType(file) == 'FileType_Bitmap' then
		--this clustercuss extracts the part of the filename that is actually the filename
		--first it takes the last part of the file name and extracts the part that isn't the extension
		--then it trims whitespace, and finally removes tags (such as doubleres)
		local name = string.lower(string.match(file, "/([^/]-)%.%w+"):gsub("^%s*",""):gsub("%s*$", ""):gsub("% (.-%)", ""))
		if name then
			playTitles[name] = file
			print(name)
		end
	end
end

local heardBefore = false

t[#t+1] = Def.ActorFrame{
	LoadActor(THEME:GetPathS("","_swoosh"))..{
		OnCommand=cmd(play);
	};
	LoadActor("highlight")..{
    InitCommand=cmd(Center;setsize,SCREEN_WIDTH,92);
    OnCommand=cmd(cropright,0.5;cropleft,0.5;sleep,0.3;linear,0.3;cropleft,0;cropright,0);
    OffCommand=cmd(linear,0.1;diffusealpha,0);
  };
	--Cursor
	Def.ActorFrame{
		InitCommand=cmd(x,WideScale(SCREEN_RIGHT-120,SCREEN_RIGHT-180);CenterY;zoom,0.7);
		LoadActor(THEME:GetPathG("","_shared/SelMode/Cursor/backer"))..{
			PlaySelectionMessageCommand=function(self, params)
				self:finishtweening()
				self:diffusealpha(0):rotationz(-20)
				self:linear(0.2)
				self:diffusealpha(1):rotationz(0)
			end;
			OffCommand=function(self)
				self:finishtweening()
				self:diffusealpha(1):rotationz(0)
				self:linear(0.2)
				self:diffusealpha(0):rotationz(-20)
		end;
		};
		LoadActor(THEME:GetPathG("","_shared/SelMode/Cursor/top"))..{
			PlaySelectionMessageCommand=function(self, params)
				self:finishtweening()
				self:diffusealpha(0):addx(-100)
				self:linear(0.2)
				self:diffusealpha(1):addx(100)
			end;
			OffCommand=function(self, params)
				self:finishtweening()
				self:linear(0.2)
				self:diffusealpha(0):addx(-100)
			end;
		};
		LoadActor(THEME:GetPathG("","_shared/SelMode/Cursor/bottom"))..{
			PlaySelectionMessageCommand=function(self, params)
				self:finishtweening()
				self:diffusealpha(0):addx(100)
				self:linear(0.2)
				self:diffusealpha(1):addx(-100)
			end;
			OffCommand=function(self, params)
				self:finishtweening()
				self:linear(0.2)
				self:diffusealpha(0):addx(100)
			end;
		};
	};
	Def.Sprite{
		InitCommand=function(s) s:zoom(0.4):halign(0):xy(SCREEN_LEFT+12,SCREEN_CENTER_Y-22):diffuse(color("0,0,0,1"))
			for _, file in pairs(playImages) do s:Load(file) end
		end;
		--OnCommand=cmd(addx,-640;sleep,0.116;accelerate,0.25;addx,640);
		PlaySelectionMessageCommand=function(self, params)
			choice = string.lower(params.Choice)
			self:finishtweening()
			if heardBefore then
				self:linear(0.1);
			else heardBefore = true end
			self:linear(0.1):diffuse(color("0,0,0,1")):queuecommand("PlaySelectionPart2")
		end;
		PlaySelectionPart2Command=function(self)
			if playImages[choice] then
				self:Load(playImages[choice])
			end;
			self:linear(0.1):diffuse(color("1,1,1,1"))
		end;
		OffCommand=cmd(linear,0.1;halign,0.5;CenterX;sleep,1;linear,0.1;zoomy,0);
	};
	--Title
	Def.Sprite{
		InitCommand=function(s) s:halign(0):xy(SCREEN_LEFT+12,SCREEN_CENTER_Y-154):diffusealpha(0)
			for _, file in pairs(playTitles) do s:Load(file) end
		end;
		PlaySelectionMessageCommand=function(self, params)
			choice = string.lower(params.Choice)
			self:finishtweening():x(SCREEN_LEFT+12)
			if heardBefore then
				self:sleep(0.2);
			else heardBefore = true end
			self:diffusealpha(0):sleep(0.2):addx(100):queuecommand("PlaySelectionPart2")
		end;
		PlaySelectionPart2Command=function(self)
			if playTitles[choice] then
				self:Load(playTitles[choice])
			end;
			self:decelerate(0.2):addx(-105):diffusealpha(1):smooth(0.2):addx(5)
		end;
		OffCommand=cmd(linear,0.1;halign,0.5;CenterX;sleep,1;linear,0.1;zoomy,0);
	};
	LoadFont("_gotham Bold 18px")..{
		InitCommand=cmd(diffuse,color("#FFFFFF");strokecolor,color("#004402");xy,SCREEN_LEFT+12,SCREEN_CENTER_Y+96;halign,0;valign,0;vertspacing,2;zoom,WideScale(0.75,1));
		OffCommand=cmd(linear,0.1;halign,0.5;CenterX;sleep,1;linear,0.1;zoomy,0);
		PlaySelectionMessageCommand=function(self, params)
			local choice = params.Choice
			self:zoomy(0)
			if choice == "Battle" then
				if GAMESTATE:IsHumanPlayer(PLAYER_2) == false then
					self:settext(THEME:GetString("ScreenSelectPlayMode","DescriptionBattleCPU"))
				elseif GAMESTATE:IsHumanPlayer(PLAYER_2) == true then
					self:settext(THEME:GetString("ScreenSelectPlayMode","DescriptionBattleVS"))
				end;
			else
				self:settext(THEME:GetString("ScreenSelectPlayMode","Description"..choice))
			end;
			self:finishtweening():zoomy(0):sleep(0.2):decelerate(0.4):zoomy(WideScale(0.75,1))
		end;
	};
	Def.ActorFrame{
		InitCommand=cmd(x,WideScale(SCREEN_RIGHT-120,SCREEN_RIGHT-180);CenterY;);
		LoadActor("flash")..{
			PlaySelectionMessageCommand=function(self, params)
				self:finishtweening()
				self:diffusealpha(1):zoom(0)
				self:linear(0.2)
				self:diffusealpha(0):zoom(1.5)
			end;
		};
	};
};

return t
