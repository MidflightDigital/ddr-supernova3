function SMOnlineScreen()
	for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
		if not IsSMOnlineLoggedIn(pn) then
			return "ScreenSMOnlineLogin"
		end
	end
	return "ScreenNetRoom"
end

function SelectMusicOrCourse()
	if IsNetSMOnline() then
		return "ScreenNetSelectMusic"
	elseif GAMESTATE:IsCourseMode() then
		return "ScreenSelectCourse"
	else
		return "ScreenSelectMusic"
	end
end

Branch.Init = function() return "ScreenInit" end
	
Branch.AfterInit = function()
	if GAMESTATE:GetCoinMode() == 'CoinMode_Home' then
		return Branch.TitleMenu()
	else
		return "ScreenLogo"
	end
end

Branch.NoiseTrigger = function()
	local hour = Hour()
	return hour > 3 and hour < 6 and "ScreenNoise" or "ScreenInit"
end

Branch.TitleMenu = function()
	-- home mode is the most assumed use of sm-ssc.
	if GAMESTATE:GetCoinMode() == "CoinMode_Home" then
		return "ScreenTitleMenu"
	end
	-- arcade junk:
	if GAMESTATE:GetCoinsNeededToJoin() > GAMESTATE:GetCoins() then
		-- if no credits are inserted, don't show the Join screen. SM4 has
		-- this as the initial screen, but that means we'd be stuck in a
		-- loop with ScreenInit. No good.
		return "ScreenTitleJoin"
	else
		return "ScreenTitleJoin"
	end
end

Branch.StartGame = function()
	if SONGMAN:GetNumSongs() == 0 and SONGMAN:GetNumAdditionalSongs() == 0 then
		return "ScreenHowToInstallSongs"
	end
	if PROFILEMAN:GetNumLocalProfiles() >=1 then
		return "ScreenSelectProfile"
	else
		return "ScreenCaution"
	end
end

Branch.Profile = function()
	if PROFILEMAN:GetNumLocalProfiles() >= 1 then
		return "ScreenSelectProfile"
	else
		return "ScreenCaution"
	end
end

Branch.Net = function()
	if IsNetSMOnline() then
		return SMOnlineScreen()
	else
		return "ScreenCaution"
	end
end

Branch.AfterSMOLogin = SMOnlineScreen()

Branch.BackOutOfPlayerOptions = function()
	return SelectMusicOrCourse()
end

Branch.InstructionsNormal = function()
	return PREFSMAN:GetPreference("ShowInstructions") and "ScreenInstructions" or "ScreenSelectMusic"
end

Branch.InstructionsCourse = function()
	return PREFSMAN:GetPreference("ShowInstructions") and "ScreenInstructions" or "ScreenSelectCourse"
end

Branch.AfterInstructions = function()
	return GAMESTATE:IsCourseMode() and "ScreenSelectCourse" or "ScreenSelectMusic"
end

Branch.GameplayScreen = function()
	if IsRoutine() then
		return "ScreenGameplayShared"
	elseif GAMESTATE:IsExtraStage() or GAMESTATE:IsExtraStage2() then
		return "ScreenGameplayExtra"
	end
	return "ScreenGameplay"
end

Branch.AfterGameplay = function()
	if IsNetSMOnline() then
		-- even though online mode isn't supported in this theme yet
		return "ScreenNetEvaluation"
	else
		if GAMESTATE:IsCourseMode() then
			if GAMESTATE:GetPlayMode() == 'PlayMode_Nonstop' then
				return "ScreenEvaluationNonstop"
			else	-- oni and endless are shared
				return "ScreenEvaluationOni"
			end
		elseif GAMESTATE:GetPlayMode() == 'PlayMode_Rave' then
			return "ScreenEvaluationRave"
		else
			return "ScreenEvaluationNormal"
		end
	end
end

Branch.AfterEvaluation = function()
	if GAMESTATE:GetSmallestNumStagesLeftForAnyHumanPlayer() >= 1 then
		return "ScreenProfileSave"
	elseif GAMESTATE:GetCurrentStage() == "Stage_Extra1" or GAMESTATE:GetCurrentStage() == "Stage_Extra2" then
		return "ScreenProfileSave"
	elseif STATSMAN:GetCurStageStats():AllFailed() then
		return "ScreenProfileSaveSummary"
	elseif GAMESTATE:IsCourseMode() then
		return "ScreenProfileSaveSummary"
	else
		return "ScreenEvaluationSummary"
	end
end

Branch.AfterSummary = "ScreenProfileSummary"
	
Branch.Network = function()
	return IsNetConnected() and "ScreenTitleMenu" or "ScreenTitleMenu"
end

Branch.AfterSaveSummary = function()
	if PROFILEMAN:GetNumLocalProfiles() >= 1 then
		return "ScreenDataSaveSummary"
	else
		return "ScreenGameOver"
	end
end

Branch.AfterDataSaveSummary = function()
	if GAMESTATE:AnyPlayerHasRankingFeats() then
		return "ScreenDataSaveSummaryEnd"
	else
		return "ScreenDataSaveSummaryEnd"
	end
end

-- needs to be tested
Branch.AfterProfileSave = function()
	if GAMESTATE:IsCourseMode() then
	-- course modes go to whatever, depending on ranking crap.
	-- 3.9 says it goes to ScreenNameEntry all the time.
	return "ScreenNameEntry"
	else
		if GAMESTATE:IsEventMode() then
			-- infinite play
			return SelectMusicOrCourse()
		elseif STATSMAN:GetCurStageStats():AllFailed() then
			-- if the player failed extra stage, don't game over.
			if GAMESTATE:IsExtraStage() or GAMESTATE:IsExtraStage2() then
				return "ScreenEvaluationSummary"
			else
				return "ScreenGameOver"
			end
		elseif GAMESTATE:GetSmallestNumStagesLeftForAnyHumanPlayer() == 0 then
			return "ScreenEvaluationSummary"
		else
			-- when do we get here??
			return SelectMusicOrCourse()
		end
	end
end

-- pick an ending screen
Branch.Ending = function()
	if GAMESTATE:IsEventMode() then
		return SelectMusicOrCourse()
	end
	-- best final grade better than AA: show the credits.
	-- otherwise, show music scroll.
	return STATSMAN:GetBestFinalGrade() <= 'Grade_Tier03' and "ScreenCredits" or "ScreenMusicScroll"
end
