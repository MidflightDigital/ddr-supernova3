local t = Def.ActorFrame {
};

local PColor = {
    P1 = "#00dcff",
    P2 = "#ff00cf"
};

local xPosPlayer = {
	P1 = -158,
	P2 = -153
};

--lights
--ex wheel lights aren't necessary here and look weird

--score underlay
if GAMESTATE:GetCoinMode() == 'CoinMode_Home' and SCREENMAN:GetTopScreen() ~= "ScreenNetRoom" then
for _, pn in pairs(GAMESTATE:GetEnabledPlayers()) do
t[#t+1] = Def.ActorFrame {
	LoadActor("frame ex")..{
	OnCommand=cmd(queuecommand,"Set");
	BeginCommand=function(self,param)
		if not GAMESTATE:IsPlayerEnabled('PlayerNumber_P1') then
			self:croptop(0.5)
		elseif not GAMESTATE:IsPlayerEnabled('PlayerNumber_P2') then
			self:cropbottom(0.5)
		end
	end;
	CurrentSongChangedMessageCommand=cmd(playcommand,"Set");
	CurrentCourseChangedMessageCommand=cmd(playcommand,"Set");
	CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"Set");
	CurrentTrailP1ChangedMessageCommand=cmd(playcommand,"Set");
	CurrentStepsP2ChangedMessageCommand=cmd(playcommand,"Set");
	CurrentTrailP2ChangedMessageCommand=cmd(playcommand,"Set");
	SetCommand= function(self)
	local SongOrCourse, StepsOrTrail;
		if GAMESTATE:IsCourseMode() then
			SongOrCourse = GAMESTATE:GetCurrentCourse();
			StepsOrTrail = GAMESTATE:GetCurrentTrail(pn);
		else
			SongOrCourse = GAMESTATE:GetCurrentSong();
			StepsOrTrail = GAMESTATE:GetCurrentSteps(pn);
		end;

	if SongOrCourse and StepsOrTrail then
		local st = StepsOrTrail:GetStepsType();
		local diff = StepsOrTrail:GetDifficulty();
		local courseType = GAMESTATE:IsCourseMode() and SongOrCourse:GetCourseType() or nil;

		if PROFILEMAN:IsPersistentProfile(pn) then
			--player
			profile = PROFILEMAN:GetProfile(pn);
		else
			-- machine profile
			profile = PROFILEMAN:GetMachineProfile();
		end;

		scorelist = profile:GetHighScoreList(SongOrCourse,StepsOrTrail);
		assert(scorelist)
		local scores = scorelist:GetHighScores();
		if scores[1] then
			topscore = scores[1]:GetScore()
		else
			topscore = 0;
		end;
		assert(topscore)
		if topscore ~= 0 then
			self:diffusealpha(1)
		else
			self:diffusealpha(0)
		end
	end;
	end;
	};
};
end;
end

--Scores
local yPosPlayer = {
	P1 = -78,
	P2 = 78
};

local xPosPlayerScore = {
	P1 = 78,
	P2 = -78
};

local ScoreHalign = {
	P1 = 1,
	P2 = 0
};

--Player Scores
for _, pn in pairs(GAMESTATE:GetEnabledPlayers()) do
t[#t+1] = Def.BitmapText{
	Font="ScreenSelectMusic score",
	CurrentSongChangedMessageCommand=cmd(playcommand,"Set");
	CurrentCourseChangedMessageCommand=cmd(playcommand,"Set");
	CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"Set");
	CurrentTrailP1ChangedMessageCommand=cmd(playcommand,"Set");
	CurrentStepsP2ChangedMessageCommand=cmd(playcommand,"Set");
	CurrentTrailP2ChangedMessageCommand=cmd(playcommand,"Set");
	InitCommand=function(self)
		local short = ToEnumShortString(pn)
		self:x(xPosPlayerScore[short]):y(yPosPlayer[short]):halign(ScoreHalign[short])
		:diffusealpha(0)
	end;
	OnCommand=cmd(queuecommand,"Set");
	SetCommand= function(self)
	local SongOrCourse, StepsOrTrail;
		if GAMESTATE:IsCourseMode() then
			SongOrCourse = GAMESTATE:GetCurrentCourse();
			StepsOrTrail = GAMESTATE:GetCurrentTrail(pn);
		else
			SongOrCourse = GAMESTATE:GetCurrentSong();
			StepsOrTrail = GAMESTATE:GetCurrentSteps(pn);
		end;

	if SongOrCourse and StepsOrTrail then
		local st = StepsOrTrail:GetStepsType();
		local diff = StepsOrTrail:GetDifficulty();
		local courseType = GAMESTATE:IsCourseMode() and SongOrCourse:GetCourseType() or nil;

		if PROFILEMAN:IsPersistentProfile(pn) then
			--player
			profile = PROFILEMAN:GetProfile(pn);
		else
			-- machine profile
			profile = PROFILEMAN:GetMachineProfile();
		end;

		scorelist = profile:GetHighScoreList(SongOrCourse,StepsOrTrail);
		assert(scorelist)
		local scores = scorelist:GetHighScores();
		if scores[1] then
			topscore = scores[1]:GetScore()
		else
			topscore = 0;
		end;
		assert(topscore)
		if topscore ~= 0 then
			self:ClearAttributes():diffusealpha(1)
			local attr = GetLeadingAttribute(topscore, 7, {0.5,0.5,0.5,1})
			if attr then
				self:AddAttribute(0, attr)
			end
			self:settext(string.format("%07d",tostring(math.floor(topscore))))
		else
			self:diffusealpha(0)
		end
	end;
	end;
};
end;

return t;
