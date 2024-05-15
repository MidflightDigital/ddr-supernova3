local playMode = GAMESTATE:GetPlayMode()
if playMode ~= 'PlayMode_Regular' and playMode ~= 'PlayMode_Rave' and playMode ~= 'PlayMode_Battle' then
	curStage = playMode;
end;
local sStage = GAMESTATE:GetCurrentStage();
local tRemap = {
	Stage_1st		= 1,
	Stage_2nd		= 2,
	Stage_3rd		= 3,
	Stage_4th		= 4,
	Stage_5th		= 5,
	Stage_6th		= 6,
};

if tRemap[sStage] == PREFSMAN:GetPreference("SongsPerPlay") then
	sStage = "Stage_Final";
else
	sStage = sStage;
end;

local t = Def.ActorFrame {};
t[#t+1] = Def.ActorFrame {
	InitCommand=function(self)
		self:sleep(3.01);
	end;

	---- DOOR OPEN > CLOSE  CLOSE > OPEN
	LoadActor(THEME:GetPathB("","doors close"));
	LoadActor(("DONK"))..{
		OnCommand=cmd(queuecommand,("Play"));
		PlayCommand=cmd(play;);
	};
	--- Flash SONG BANNER  sound------
	LoadActor("SoundStage") .. {
	};
};

t[#t+1] = Def.ActorFrame {
	InitCommand=function(self)
		self:y(SCREEN_CENTER_Y-124);
	end;
	LoadActor(THEME:GetPathG("","ScreenEvaluation bannerframe (doubleres)"))..{
		InitCommand=cmd(CenterX);
		OnCommand=cmd(zoomy,0;sleep,0.099;sleep,0.396;linear,0.2;zoomy,1;sleep,2);
	};
};

if not GAMESTATE:IsCourseMode() then
--song jacket--
t[#t+1] = Def.ActorFrame {
	OnCommand=cmd(playcommand,'Set';CenterX;y,SCREEN_CENTER_Y-134;zoomy,0;sleep,0.099;sleep,0.396;linear,0.2;zoomy,1);
	Def.Sprite {
		SetCommand=function(self)
		local song = GAMESTATE:GetCurrentSong();
			if song:HasBanner() then
				self:LoadFromSongBanner(GAMESTATE:GetCurrentSong());
				self:setsize(256,81);
			else
				self:Load(THEME:GetPathG("","Common fallback banner"));
				self:setsize(256,81);
			end;
		end;
	};
};
else
t[#t+1] = LoadActor("CourseDisplay");
end;


t[#t+1] = LoadActor("cd")..{
	PostInitCommand=function(s) s:zoomx(0.01):zoomy(0.01):x(SCREEN_CENTER_X)
		:y(SCREEN_CENTER_Y+SCREEN_CENTER_Y*0.4)
	end,
	OnCommand=function(s) s:accelerate(0.05):zoomx(1):accelerate(0.05):zoomy(1) end
};

t[#t+1] = Def.ActorFrame {
	Def.Quad{
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;zoomx,0;setsize,570,72;fadeleft,1;faderight,1;diffuse,color("0,1,0.5,1"));
		OnCommand=function(self)
			self:diffusealpha(0):zoomx(0)
			:linear(0.264):diffusealpha(1):zoomx(1);
		end;
	};
};

t[#t+1] = LoadActor("StageDisplay");

t[#t+1] = LoadActor("bottom_stage")..{
	InitCommand=cmd(CenterX;y,SCREEN_BOTTOM-27);
	OnCommand=cmd(addy,54;sleep,0.396;linear,0.2;addy,-54);
};

t[#t+1] = LoadActor("top_stage")..{
	InitCommand=cmd(CenterX;y,SCREEN_TOP+38);
	OnCommand=cmd(addy,-104;sleep,0.396;linear,0.198;addy,104);
};

for _, pn in pairs(GAMESTATE:GetEnabledPlayers()) do
	t[#t+1] = Def.Actor{
		OnCommand=function(self)
			if GAMESTATE:IsExtraStage() then
				GAMESTATE:ApplyStageModifiers(pn,"battery,4 lives,failimmediatecontinue")
			elseif GAMESTATE:IsExtraStage2() then
				GAMESTATE:ApplyStageModifiers(pn,"battery,1 lives,failimmediatecontinue")
			end;
		end;
	};
end;

return t
