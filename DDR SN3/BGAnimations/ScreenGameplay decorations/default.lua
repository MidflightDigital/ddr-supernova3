local t = Def.ActorFrame{};

t[#t+1] = StandardDecorationFromFileOptional("StageFrame","StageFrame");
t[#t+1] = StandardDecorationFromFile("LifeFrame","LifeFrame")
t[#t+1] = StandardDecorationFromFile("ScoreFrame","ScoreFrame")

-- stage display (normal)
t[#t+1] = StandardDecorationFromFile("StageDisplay","StageDisplay")

local LoadingScreen = Var "LoadingScreen"

--This is a helper function to make it easier to load metrics from the current screen definition.
local function m(metric,pn)
	if pn then
		metric = metric:gsub("PN", ToEnumShortString(pn))
	end
	return THEME:GetMetric(LoadingScreen,metric)
end

local ScoringPlayers = {}

local tns_reverse = Enum.Reverse(TapNoteScore)

t[#t+1] = Def.Actor{
    Name="ScoringController",
    JudgmentMessageCommand = function(_,params)
		SN2Scoring.PrepareScoringInfo(IsStarterMode())
        if not ScoringPlayers[params.Player] then
            ScoringPlayers[params.Player] = true
        end
		--worstJudge is used by the combo code
		if not ScoringInfo.worstJudge then
			ScoringInfo.worstJudge = {}
		end

		local wj = ScoringInfo.worstJudge[params.Player]
		if tns_reverse[params.TapNoteScore] <= tns_reverse['TapNoteScore_W1'] and
			tns_reverse[params.TapNoteScore] >= tns_reverse['TapNoteScore_Miss'] then
			if (not wj) or tns_reverse[params.TapNoteScore] < tns_reverse[wj] then
				ScoringInfo.worstJudge[params.Player] = params.TapNoteScore
			end
		end
        local es = (GAMESTATE:Env()).EndlessState
        if es then
            local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(params.Player)
            es.scoring.handleNoteScore(params.HoldNoteScore or params.TapNoteScore,
                GAMESTATE:GetCurrentStageIndex()+1,
                pss:GetCurrentCombo())
            --SCREENMAN:SystemMessage(es.scoring.getScoreString())
        end
    end,
}

local function ScoreUpdate()
    for pn, _ in pairs(ScoringPlayers) do
        local info = ScoringInfo[pn]
        local stage = GAMESTATE:IsCourseMode() and GAMESTATE:GetCourseSongIndex() + 1 or nil
        local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)
        local score = info.GetCurrentScore(pss, stage)
        pss:SetScore(score)
        local scoreDisplay = SCREENMAN:GetTopScreen():GetChild("Score"..ToEnumShortString(pn))
        if scoreDisplay and scoreDisplay:GetChild("Text") then
            scoreDisplay:GetChild("Text"):targetnumber(score)
        end
        pss:SetCurMaxScore(info.GetCurrentMaxScore(pss, stage))
    end
end

t[#t+1] = Def.ActorFrame{
    Name = "ScoringController2",
    InitCommand = function(s) s:SetUpdateFunction(ScoreUpdate) end
}

t[#t+1] = LoadActor( THEME:GetPathB("","optionicon_P1") ) .. {
	InitCommand=cmd(player,PLAYER_1;zoom,1.4;x,WideScale(SCREEN_LEFT+140,SCREEN_LEFT+140);draworder,1);
	OnCommand=function(self)
		if GAMESTATE:PlayerIsUsingModifier(PLAYER_1,'reverse') then
			self:y(SCREEN_TOP+70);
		else
			self:y(SCREEN_BOTTOM-70);
		end;
	end;
};
t[#t+1] = LoadActor( THEME:GetPathB("","optionicon_P2") ) .. {
	InitCommand=cmd(player,PLAYER_2;zoom,1.4;x,WideScale(SCREEN_RIGHT-140,SCREEN_RIGHT-140);draworder,1);
	OnCommand=function(self)
		if GAMESTATE:PlayerIsUsingModifier(PLAYER_2,'reverse') then
			self:y(SCREEN_TOP+70);
		else
			self:y(SCREEN_BOTTOM-70);
		end;
	end;
};

local diffXPos = {
	P1 = SCREEN_LEFT+75,
	P2 = SCREEN_RIGHT-75
}

for _, pn in pairs(GAMESTATE:GetEnabledPlayers()) do
  local shortPn = ToEnumShortString(pn)
  t[#t+1] = Def.ActorFrame{
    InitCommand=function(s)
      s:x(diffXPos[shortPn]):halign(0):draworder(2)
      if GAMESTATE:PlayerIsUsingModifier(pn,'reverse') then
        s:y(SCREEN_TOP+44)
      else
        s:y(SCREEN_BOTTOM-52)
      end;
    end;
		LoadActor("frame (doubleres)")..{
			InitCommand=function(s)
				s:zoomx(pn=='PlayerNumber_P2' and -1 or 1)
				if GAMESTATE:PlayerIsUsingModifier(pn,'reverse') then
					s:zoomy(-1)
				end;
			end;
		};
		LoadActor("frame colour (doubleres)")..{
			InitCommand=function(s)
				s:zoomx(pn=='PlayerNumber_P2' and -1 or 1)
				if GAMESTATE:PlayerIsUsingModifier(pn,'reverse') then
					s:zoomy(-1)
				end;
			end;
			OnCommand=cmd(playcommand,"Set");
			SetCommand=function(s)
				local diff = GAMESTATE:GetCurrentSteps(pn):GetDifficulty();
				s:diffuse(CustomDifficultyToColor(diff))
			end;
		};
    LoadFont("_itc avant garde gothic lt Bold 16px")..{
      OnCommand=cmd(zoom,0.8;playcommand,"Set");
      SetCommand=function(s)
        local diff = GAMESTATE:GetCurrentSteps(pn):GetDifficulty();
        s:settext(THEME:GetString("CustomDifficulty",ToEnumShortString(diff))):diffuse(color("#5a5a5a")):diffusetopedge(CustomDifficultyToColor(diff)):strokecolor(color("0,0,0,0.5")):uppercase(true)
        s:playcommand("Animate")
      end;
      AnimateCommand=cmd(diffusealpha,0;y,-10;linear,0.15;diffusealpha,1;y,0;sleep,3;linear,0.15;diffusealpha,0;y,10;sleep,0;y,-10;sleep,3;queuecommand,"Animate");
		};
    LoadFont("_itc avant garde gothic lt Bold 16px")..{
      OnCommand=cmd(playcommand,"Set";zoom,0.8;diffusealpha,0;sleep,3.45;queuecommand,"Animate");
      SetCommand=function(s)
        local meter = GAMESTATE:GetCurrentSteps(pn):GetMeter();
        local diff = string.gsub(GAMESTATE:GetCurrentSteps(pn):GetDifficulty(),"Difficulty_","");
        s:settext("Level "..meter):uppercase(true):diffuse(color("#5a5a5a")):diffusetopedge(CustomDifficultyToColor(diff)):strokecolor(color("0,0,0,0.5"))
      end;
      AnimateCommand=cmd(diffusealpha,0;y,-10;linear,0.15;diffusealpha,1;y,0;sleep,2.55;linear,0.15;diffusealpha,0;y,10;sleep,0.45;sleep,0;y,-10;sleep,3;queuecommand,"Animate");
    }
  }
end

return t
