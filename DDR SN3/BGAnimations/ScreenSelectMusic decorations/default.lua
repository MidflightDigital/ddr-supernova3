local t = LoadFallbackB();
local extra = Var "LoadingScreen" == "ScreenSelectMusicExtra"
local normal = Var "LoadingScreen" == "ScreenSelectMusic" or Var "LoadingScreen" == "ScreenSelectMusicStarter"
SOUND:DimMusic(1,math.huge)


t[#t+1] = StandardDecorationFromFileOptional("StyleIcon","StyleIcon");
if not extra then
	t[#t+1] = StandardDecorationFromFileOptional("StageDisplay","StageDisplay")
end
t[#t+1] = StandardDecorationFromFile("BannerFrame","BannerFrame")
t[#t+1] = StandardDecorationFromFileOptional("BPMDisplay","BPMDisplay")
t[#t+1] = StandardDecorationFromFileOptional("SortDisplay","SortDisplay")

if normal or extra then
	t[#t+1] = Def.ActorFrame{
		LoadActor("diffback")..{
			InitCommand=cmd(x,DiffBGPosX();y,SCREEN_CENTER_Y+141;visible,GAMESTATE:IsCourseMode() == false);
			OnCommand=cmd(draworder,1;cropright,1;sleep,0.264;sleep,0.6;linear,0.4;cropright,0);
			OffCommand=cmd(sleep,0.033;accelerate,0.363;x,-237);
		};
		LoadActor("DDRDifficultyList.lua");
		LoadActor("_bg")..{
		OnCommand=cmd(CenterY;halign,1;x,SCREEN_RIGHT;zoomx,1.16;addx,SCREEN_WIDTH/640*328;sleep,0.412;linear,0.196;addx,-(SCREEN_WIDTH/640*328));
		OffCommand=cmd(sleep,0.016;accelerate,0.25;addx,SCREEN_WIDTH/640*328;);
		};
	};
end;

if normal then

if ThemePrefs.Get("LightMode") == false then

end;

if not ThemePrefs.Get("LightMode") then
	--custom BPM display/meter junk
	t[#t+1] = LoadActor("SNBPMDisplay.lua");
	t[#t+1] = LoadActor("gauge back")..{
		InitCommand=cmd(x,BPMMeterPosX();y,SCREEN_CENTER_Y-124);
		OnCommand=cmd(addx,-500;sleep,0.264;decelerate,0.52;addx,500;sleep,0.1;linear,0);
		OffCommand=cmd(sleep,0.033;accelerate,0.363;addx,-500);
	};
	t[#t+1] = LoadActor("bpmmeter.lua");
end

--the delay counter is a hack to prevent crashes
local delayCounter = 0
t[#t+1] = Def.Actor{
	CurrentSongChangedMessageCommand=cmd(playcommand,"Set");
	SetCommand=function(self)
		if delayCounter < 3 then
			delayCounter = delayCounter + 1
			return
		end
		local wheel = SCREENMAN:GetTopScreen():GetChild('MusicWheel')
		if wheel:GetSelectedType() == 'WheelItemDataType_Custom' then
			SOUND:DimMusic(0,math.huge);
		else
			SOUND:DimMusic(1,math.huge);
		end;
	end;
};

-------------------------------------------------------------------------------------------------------------------
-- Groove Radars
-------------------------------------------------------------------------------------------------------------------
t[#t+1] = Def.ActorFrame{
	Name = "Player 1";
	OnCommand=cmd(diffusealpha,0;addx,-400;sleep,0.1;linear,0.52;diffusealpha,0;addx,400;sleep,0.3;diffusealpha,0.75);
	CurrentSongChangedMessageCommand=function(self)
		local Song=GAMESTATE:GetCurrentSong()
			if not Song then
				self:diffusealpha(0)
			else
				self:diffusealpha(0.75)
			end;
		end;
	OffCommand=cmd(sleep,0.033;accelerate,0.33;addx,-400);
	create_ddr_groove_radar("P1_radar", RadarPosX(), SCREEN_CENTER_Y+16,
		PLAYER_1, 60, color("1,1,1,0.25"),
		{ColorGR.PLAYER_1, ColorGR.PLAYER_1, ColorGR.PLAYER_1, ColorGR.PLAYER_1, ColorGR.PLAYER_1},
		"accelerate", .25, true)
};
t[#t+1] = Def.ActorFrame{
	Name = "Player 2";
	OnCommand=cmd(diffusealpha,0;addx,-400;sleep,0.1;linear,0.52;diffusealpha,0;addx,400;sleep,0.3;diffusealpha,1);
	CurrentSongChangedMessageCommand=function(self)
		local Song=GAMESTATE:GetCurrentSong()
			if not Song then
				self:diffusealpha(0)
			else
				self:diffusealpha(0.75)
			end;
		end;
	OffCommand=cmd(sleep,0.033;accelerate,0.33;addx,-400);
	create_ddr_groove_radar("P2_radar", RadarPosX(), SCREEN_CENTER_Y+16,
		PLAYER_2, 60, color("1,1,1,0.25"),
		{ColorGR.PLAYER_2, ColorGR.PLAYER_2, ColorGR.PLAYER_2, ColorGR.PLAYER_2, ColorGR.PLAYER_2},
		"accelerate", .25, true)
};

if ThemePrefs.Get("LightMode") == false then
t[#t+1] = Def.ActorFrame{
	LoadActor("radar lights (doubleres)")..{
		InitCommand=function(self)
			self:xy(RadarPosX()+5,SCREEN_CENTER_Y+7)
		end;
		OnCommand=cmd(zoomy,0;addx,-400;sleep,0.264;linear,0.2;zoomy,0.3;addx,400;linear,0.2;zoomy,1);
		OffCommand=cmd(sleep,0.033;accelerate,0.33;addx,-400);
		CurrentSongChangedMessageCommand=function(self)
			local song = GAMESTATE:GetCurrentSong()
			if not song then return end
			if song:IsDisplayBpmRandom() or song:IsDisplayBpmSecret() then
				self:playcommand("Random")
			else
				self:diffuseshift():effectcolor1(color("1,1,1,0.75")):effectcolor2(color("1,1,1,0.25")):effectclock('beatnooffset')
			end;
		end;
		RandomCommand=function(self)
			self:diffuseshift():effectcolor1(color("1,1,1,0.75")):effectcolor2(color("1,1,1,0.25")):effectclock("musicnooffset"):effectperiod(0.15)
		end;
	};
};
end;

t[#t+1] = Def.ActorFrame{
	LoadActor("labels")..{
		InitCommand=cmd(x,RadarPosX()+5;y,SCREEN_CENTER_Y+7);
		OnCommand=cmd(diffusealpha,0;addx,-400;sleep,0.1;linear,0.52;diffusealpha,0;addx,400;sleep,0.3;diffusealpha,1);
		OffCommand=cmd(sleep,0.033;accelerate,0.33;addx,-400);
	};
};
end

-- song options text (e.g. 1.5xmusic)
t[#t+1] = StandardDecorationFromFileOptional("SongOptions","SongOptions")

-- other items (balloons, etc.)
t[#t+1] = StandardDecorationFromFile( "Balloon", "Balloon" );
t[#t+1] = Def.ActorFrame {
	LoadActor(THEME:GetPathS("","Music_In"))..{
		OnCommand=cmd(play);
	};
};

local xPosPlayer = {
    P1 = (-120),
    P2 = (120)
}

for _, pn in pairs(GAMESTATE:GetEnabledPlayers()) do
	t[#t+1] = Def.ActorFrame{
		InitCommand=function(s)
			local short = ToEnumShortString(pn)
			s:draworder(100)
			:xy(RadarPosX(),_screen.cy-46)
		end;
		OnCommand=cmd(addx,-500;sleep,0.264;decelerate,0.52;addx,500;sleep,0.1;linear,0);
		OffCommand=cmd(stoptweening;sleep,0.033;accelerate,0.33;addx,-500);
		LoadActor("_ShockArrow_mark "..pn)..{
			InitCommand=function(s)
				local short = ToEnumShortString(pn)
				s:zoom(0.75)
				:diffuseshift():effectcolor1(color("1,1,1,1")):effectcolor2(color("0.5,0.5,0.5,1")):effectperiod(1):queuecommand("Set")
				:x(xPosPlayer[short])
			end;
			SetCommand=function(s)
				local song = GAMESTATE:GetCurrentSong();
				local diffuse = 0
				if song then
					local steps = GAMESTATE:GetCurrentSteps(pn)
					if steps then
						if steps:GetRadarValues(pn):GetValue('RadarCategory_Mines') == 0 then
							yZoom = 0
						else
							yZoom = 0.75
						end
					else
						yZoom = 0
					end
				else
					yZoom = 0
				end
				s:finishtweening()
				s:linear(0.1):zoomy(yZoom)
			end;
			CurrentSongChangedMessageCommand=cmd(playcommand,"Set");
			CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"Set");
			CurrentStepsP2ChangedMessageCommand=cmd(playcommand,"Set");
		};
	};
end;

--new song--
if not GAMESTATE:IsCourseMode() then
	t[#t+1] = StandardDecorationFromFileOptional("NewSong","NewSong") .. {
		InitCommand=cmd(playcommand,"Set");
		BeginCommand=cmd(playcommand,"Set");
		CurrentSongChangedMessageCommand=cmd(playcommand,"Set");
		SetCommand=function(self)
	-- 		local pTargetProfile;
			local sSong;
			-- Start!
			if GAMESTATE:GetCurrentSong() then
				if PROFILEMAN:IsSongNew(GAMESTATE:GetCurrentSong()) then
					self:playcommand("Show");
				else
					self:playcommand("Hide");
				end
			else
				self:playcommand("Hide");
			end
		end;
	};
end;

return t
