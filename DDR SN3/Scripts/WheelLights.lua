local PColor = {
P1 = color "#00dcff",
P2 = color "#ff00cf"
};

local xPosPlayer = {
P1 = -158,
P2 = -153
};


local function GetSetCommand(pn, itemMode)
	local setItem = nil;
	return function(self, params)
		local short = ToEnumShortString(pn);
		local SongOrCourse, StepsOrTrail;
		local prof = PROFILEMAN:GetProfile(pn)

		if itemMode then
			if params then
				if params and (params.Course or params.Song) then
					setItem = params.Course or params.Song;
				else
					return;
				end;
			end;
			SongOrCourse = setItem;
		else
			SongOrCourse = GAMESTATE:GetCurrentCourse() or GAMESTATE:GetCurrentSong();
		end;

		if SongOrCourse then
			local sType = GAMESTATE:GetCurrentStyle():GetStepsType();
			local usingCourse = lua.CheckType("Course", SongOrCourse);
			if usingCourse then
				local cTrail = GAMESTATE:GetCurrentTrail(pn);
				if cTrail then
					local cDiff = GAMESTATE:GetCurrentTrail(pn):GetDifficulty();
					for _, trail in pairs(SongOrCourse:GetAllTrails()) do
						if (trail:GetStepsType() == sType) and
							(trail:GetDifficulty() == cDiff) then
							StepsOrTrail = trail;
							break;
						end;
					end;
				end;
			else
				local cSteps = GAMESTATE:GetCurrentSteps(pn);
				if cSteps then
					local sDiff = cSteps:GetDifficulty();
					StepsOrTrail = SongOrCourse:GetOneSteps(sType, sDiff);
				end;
			end;

			if StepsOrTrail then
				local hsList = prof:GetHighScoreListIfExists(SongOrCourse, StepsOrTrail);
				if hsList then
					local hScores = hsList:GetHighScores();
					if #hScores >= 1 then
						if (hScores[1]):GetGrade() ~= 'Grade_Failed' then
							self:visible(true);
							return;
						end;
					end;
				end;
			end;
		end;
		self:visible(false);
	end;
end;

function WheelLight(pn, itemMode)
	local function Response(s)
		if not itemMode then
			s:playcommand("Set", params);
		end
	end
	local function P1Response(s, params)
		if pn == 'PlayerNumber_P1' then
			s:playcommand("Set", params);
		end
	end
	local function P2Response(s, params)
		if pn == 'PlayerNumber_P2' then
			s:playcommand("Set", params);
		end
	end

	return Def.Sprite{
		Texture=THEME:GetPathG("MusicWheelItem Song","NormalPart/score");
    	InitCommand=function(s)
			local short = ToEnumShortString(pn)
			s:diffuse(PColor[short])
			if GAMESTATE:GetNumPlayersEnabled() == 2 then
				s:x(xPosPlayer[short]):zoomx(0.5)
			else
				s:x(-155)
			end;
			s:visible(false);
		end;
		CurrentSongChangedMessageCommand=Response;
		CurrentCourseChangedMessageCommand=Response;
		CurrentStepsP1ChangedMessageCommand=P1Response;
		CurrentTrailP1ChangedMessageCommand=P1Response;
		CurrentStepsP2ChangedMessageCommand=P2Response;
		CurrentTrailP2ChangedMessageCommand=P2Response;
		SetCommand=GetSetCommand(pn, itemMode);
	}
end
