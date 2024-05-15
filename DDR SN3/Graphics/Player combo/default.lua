local c;
local cf;
local cfInv;
local player = Var "Player";
local ShowComboAt = THEME:GetMetric("Combo", "ShowComboAt");
local Pulse = THEME:GetMetric("Combo", "PulseCommand");
local PulseLabel = THEME:GetMetric("Combo", "PulseLabelCommand");

local NumberMinZoom = THEME:GetMetric("Combo", "NumberMinZoom");
local NumberMaxZoom = THEME:GetMetric("Combo", "NumberMaxZoom");
local NumberMaxZoomAt = THEME:GetMetric("Combo", "NumberMaxZoomAt");

local NumberMinX = THEME:GetMetric("Combo", "NumberMinX");
local NumberMaxX = THEME:GetMetric("Combo", "NumberMaxX");

local LabelMinX = THEME:GetMetric("Combo", "LabelMinX");
local LabelMaxX = THEME:GetMetric("Combo", "LabelMaxX");

local LabelMinZoom = THEME:GetMetric("Combo", "LabelMinZoom");
local LabelMaxZoom = THEME:GetMetric("Combo", "LabelMaxZoom");

local env = GAMESTATE:Env();
local starterMode = env.StarterMode == true;

local judgeNumberColoring, colorMode
do
	colorMode = ThemePrefs.Get("ComboColorMode");
	judgeNumberColoring = colorMode == "arcade" or colorMode == "waiei"
end
--you can pass nil to this function, it acts the same as passing nothing
--however, i think that passing nil makes the intent clearer -tertu
local function cfShowOnly(...)
	local cfMembersToShow = {...}

	--build an inverse version of the argument table to speed up lookup
	local cfMTSInv = {}
	for _, name in pairs(cfMembersToShow) do
		cfMTSInv[name] = true
	end

	for name, a in pairs(cf) do
		--"if the name of this actor was passed, make it visible, otherwise
		--hide it"
		a:visible(cfMTSInv[name] == true)
	end
end

local tns_reverse = Enum.Reverse(TapNoteScore)
local function worstJudgeClear()
	if (ScoringInfo and ScoringInfo.worstJudge) then
		local wj = ScoringInfo.worstJudge[player]
		if not wj then return end --don't need to do anything
		if (ScoringInfo.seed ~= GAMESTATE:GetStageSeed()) or
			(tns_reverse[wj] < tns_reverse['TapNoteScore_W3'])
		then
			ScoringInfo.worstJudge[player] = nil
			wj = nil
		end
		return wj
	end
end

local decideColor
do
	local tnsToParam = {
		TapNoteScore_W1 = "FullComboW1",
		TapNoteScore_W2 = "FullComboW2",
		TapNoteScore_W3 = "FullComboW3"
	}

	decideColor = function(tns, params)
		if starterMode then
			if tns == "FullComboW2" then
				if judgeNumberColoring then
					return ScoringInfo ~= nil
						and ScoringInfo.worstJudge ~= nil
						and ScoringInfo.worstJudge[player] ~= nil
				end
				--not arcade coloring
				return params.FullComboW1
					or params.FullComboW2
					or params.FullComboW3
			end
		elseif not judgeNumberColoring then
			return params[tnsToParam[tns]] or false
		elseif ScoringInfo and ScoringInfo.worstJudge then
			return tns == ScoringInfo.worstJudge[player]
		end
		--failsafe
		return false
	end

end

local function Label(lbl, params)
	if colorMode == "waiei" then
		if not (params.FullComboW1
			or params.FullComboW2
			or params.FullComboW3)
		then
			return 'LabelNormal'
		end
	end
	return lbl
end

local t = Def.ActorFrame {
	Def.ActorFrame {
		Name="ComboFrame";
		LoadFont( "combo", "marv" ) .. {
			Name="NumberW1";
			OnCommand = THEME:GetMetric("Combo", "NumberOnCommand");
		};
		LoadFont( "combo", "perf" ) .. {
			Name="NumberW2";
			OnCommand = THEME:GetMetric("Combo", "NumberOnCommand");
		};
		LoadFont( "combo", "great" ) .. {
			Name="NumberW3";
			OnCommand = THEME:GetMetric("Combo", "NumberOnCommand");
		};
		LoadFont( "combo", "normal") .. {
			Name="NumberNormal";
			OnCommand = THEME:GetMetric("Combo", "NumberOnCommand");
		};
		LoadActor("_combomarv") .. {
			Name="LabelW1";
			OnCommand = THEME:GetMetric("Combo", "LabelOnCommand");
		};
		LoadActor("_comboperfect") .. {
			Name="LabelW2";
			OnCommand = THEME:GetMetric("Combo", "LabelOnCommand");
		};
		LoadActor("_combogreat") .. {
			Name="LabelW3";
			OnCommand = THEME:GetMetric("Combo", "LabelOnCommand");
		};
		LoadActor("_combonormal") .. {
			Name="LabelNormal";
			OnCommand = THEME:GetMetric("Combo", "LabelOnCommand");
		};
	LoadActor(THEME:GetPathG("Combo","100Milestone")) .. {
		Name="OneHundredMilestone";
		InitCommand=cmd(visible,true);
		FiftyMilestoneCommand=cmd(playcommand,"Milestone");
	};
	LoadActor(THEME:GetPathG("Combo","1000Milestone")) .. {
		Name="OneThousandMilestone";
		InitCommand=cmd(visible,true);
		ToastyAchievedMessageCommand=cmd(playcommand,"Milestone");
	};
	};
	InitCommand = function(self)
		c = self:GetChildren();
		cf = c.ComboFrame:GetChildren();
		-- Inclu
		cfShowOnly(nil);
	end;
	ComboCommand=function(self, param)
		worstJudgeClear()
		if param.Misses then
			cfShowOnly(nil);
			return;
		end
		local iCombo = param.Misses or param.Combo;
		if not iCombo or iCombo < ShowComboAt then
			cfShowOnly(nil);
			return;
		end

		param.Zoom = scale( iCombo, 0, NumberMaxZoomAt, NumberMinZoom, NumberMaxZoom );
		param.Zoom = clamp( param.Zoom, NumberMinZoom, NumberMaxZoom );

		param.NumberX = scale( iCombo, 0, NumberMaxZoomAt, NumberMinX, NumberMaxX );
		param.NumberX = clamp( param.NumberX, NumberMinX, NumberMaxX );

		param.LabelZoom = scale( iCombo, 0, NumberMaxZoomAt, LabelMinZoom, LabelMaxZoom );
		param.LabelZoom = clamp( param.LabelZoom, LabelMinZoom, LabelMaxZoom );

		param.LabelX = scale( iCombo, 0, NumberMaxZoomAt, LabelMinX, LabelMaxX );
		param.LabelX = clamp( param.LabelX, LabelMinX, LabelMaxX );

		cf.NumberW1:settext( string.format("%i", iCombo) );
		cf.NumberW2:settext( string.format("%i", iCombo) );
		cf.NumberW3:settext( string.format("%i", iCombo) );
		cf.NumberNormal:settext( string.format("%i", iCombo) );

		-- FullCombo Rewards
		if decideColor('TapNoteScore_W1', param) then
			cfShowOnly('NumberW1', Label('LabelW1',param));
		elseif decideColor('TapNoteScore_W2', param) then
			cfShowOnly('NumberW2', Label('LabelW2',param));
		elseif decideColor('TapNoteScore_W3', param) then
			cfShowOnly('NumberW3', Label('LabelW3',param));
		elseif param.Combo then
			cfShowOnly('NumberNormal', 'LabelNormal');
		else
			cfShowOnly('NumberNormal', 'LabelNormal');
		end
		-- Pulse
		Pulse( cf.NumberW1, param );
		Pulse( cf.NumberW2, param );
		Pulse( cf.NumberW3, param );
		Pulse( cf.NumberNormal, param );
		PulseLabel( cf.LabelW1, param );
		PulseLabel( cf.LabelW2, param );
		PulseLabel( cf.LabelW3, param );
		PulseLabel( cf.LabelNormal, param );
		-- Milestone Logic
	end;
};

return t;
