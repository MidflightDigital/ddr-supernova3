function SMOnlineScreen()
	for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
		if not IsSMOnlineLoggedIn(pn) then
			return "ScreenSMOnlineLogin"
		end
	end
	return "ScreenNetRoom"
end

function CorrectSSM()
	if IsStarterMode() then
		return "ScreenSelectMusicStarter"
	else
		return "ScreenSelectMusic"
	end
end

function SelectMusicOrCourse()
	if IsNetSMOnline() then
		return "ScreenNetSelectMusic"
	elseif GAMESTATE:IsCourseMode() then
		return "ScreenSelectCourse"
	else
		return CorrectSSM()
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
	-- XXX: we don't theme this screen
	if SONGMAN:GetNumSongs() == 0 and SONGMAN:GetNumAdditionalSongs() == 0 then
		return "ScreenHowToInstallSongs"
	end
	if PROFILEMAN:GetNumLocalProfiles() >=1 then
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
	return PREFSMAN:GetPreference("ShowInstructions") and "ScreenInstructions" or CorrectSSM()
end

Branch.AfterInstructions = function()
	return GAMESTATE:IsCourseMode() and "ScreenSelectCourse" or CorrectSSM()
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
		if IsStarterMode() then
			return "ScreenEvaluationNewStarter"
		else
			return "ScreenEvaluationNewNormal"
		end
	end
end

Branch.AfterEvaluation = function()
	--normal
	if GAMESTATE:GetSmallestNumStagesLeftForAnyHumanPlayer() >= 1 then
		return "ScreenProfileSave"
	elseif GAMESTATE:GetCurrentStage() == "Stage_Extra1" then
		if STATSMAN:GetCurStageStats():AllFailed() then
			return "ScreenEvaluationNewSummary"
		else
			return "ScreenProfileSave"
		end;
	elseif STATSMAN:GetCurStageStats():AllFailed() then
		return "ScreenProfileSaveSummary"
	elseif GAMESTATE:IsCourseMode() then
		return "ScreenProfileSaveSummary"
	else
		return "ScreenEvaluationNewSummary"
	end
end

Branch.AfterSummary = "ScreenProfileSaveSummary"

Branch.Network = function()
	return "ScreenTitleMenu"
end

Branch.AfterSaveSummary = function()
	if PROFILEMAN:GetNumLocalProfiles() >= 1 then
		return "ScreenDataSaveSummary"
	else
		return "ScreenGameOver"
	end
end

Branch.AfterDataSaveSummary = function()
	return "ScreenDataSaveSummaryEnd"
end


-- pick an ending screen
Branch.Ending = function()
	if GAMESTATE:IsEventMode() then
		return SelectMusicOrCourse()
	end
	local going = Grade:Compare(STATSMAN:GetBestFinalGrade(), 'Grade_Tier03') <= 0
	-- best final grade better than AA: show the credits.
	-- otherwise, show music scroll.

	--enable this line once credits are complete
	--return going and "ScreenCredits" or "ScreenMusicScroll"
	return "ScreenMusicScroll"
end

Branch.AfterProfileLoad = function()
	return "ScreenSelectStyle"
end

Branch.AfterProfileSave = function()
	if GAMESTATE:IsEventMode() then
		return SelectMusicOrCourse()
	elseif STATSMAN:GetCurStageStats():AllFailed() then
		return "ScreenGameOver"
	elseif GAMESTATE:IsExtraStage() or GAMESTATE:IsExtraStage2() then
		--Part of the score-based Extra Stage hack.
		--Doing anything except failing a song will earn ES, so we decide if it was actually earned.
		local stats = STATSMAN:GetPlayedStageStats(1)
		local actuallyQualified = false
		for _, pn in pairs(GAMESTATE:GetHumanPlayers()) do
			actuallyQualified = actuallyQualified or stats:GetPlayerStageStats(pn):GetScore() >= 950000
		end
		if actuallyQualified then
			return SelectMusicOrCourse()
		else
			return "ScreenEvaluationNewSummary"
		end
	elseif GAMESTATE:GetSmallestNumStagesLeftForAnyHumanPlayer() == 0 then
		if not GAMESTATE:IsCourseMode() then
			return "ScreenEvaluationNewSummary"
		else
			return "ScreenGameOver"
		end
	else
		return SelectMusicOrCourse()
	end
end
