local function s(name)
	return THEME:GetString("MissionMode",name)
end

local function sf(name, ...)
	return string.format(s(name), ...)
end

local function j(tns)
	return THEME:GetString("TapNoteScore", ToEnumShortString(tns))
end

local Predefs = {}

--[[
current evaluation times:
cleared_check (run after song if it was cleared)
always_check (always run after song)
If either returns true, the mission is cleared.
]]

function Predefs.Clear()
	return {cleared_check = function() return true end, text = s("Clear")}
end

function Predefs.FullCombo()
	return {cleared_check = function(pss) return pss:FullCombo() end, text = s("FullCombo")}
end

function Predefs.FullComboOfScore(tns)
	return {cleared_check = function(pss) return pss:FullComboOfScore(tns) end, text = sf("FullComboOfScore", j(tns))}
end

do
	local function mincombo_condition(value)
		return function(pss)
			local combos = pss:GetComboList()
			for _, record in pairs(combos) do
				if record.Count >= value then
					return true
				end
			end
			return false
		end
	end
		
	function Predefs.MinCombo(value)
		return {cleared_check = mincombo_condition(value), text = sf("MinCombo", value)}
	end
end

function Predefs.MinGrade(grade)
	local er = Enum.Reverse(Grade)
	return {cleared_check = function(pss) return er[pss:GetGrade()] <= er[grade] end, text = sf("MinGrade", THEME:GetString("Grade", ToEnumShortString(grade)))}
end

--"clear with 70% life or greater" is Predefs.MinLife(0.7)
function Predefs.MinLife(amount)
	return {cleared_check = function(pss) return pss:GetCurrentLife() >= amount end, text = sf("MinLife", math.floor(amount*100))}
end

function Predefs.FullLife()
	return {cleared_check = function(pss) return pss:GetCurrentLife() >= 1 end, text = s("FullLife")}
end

function Predefs.JudgePercentage(tns, amount)
	return {cleared_check = function(pss) return pss:GetPercentageOfTaps(tns) >= amount end, text = sf("JudgePercentage", j(tns), math.floor(amount*100))}
end

function Predefs.MaxJudgeCount(tns, amount)
	return {cleared_check = function(pss) return pss:GetTapNoteScores(tns) <= amount end, text = sf("MaxJudgeCount", j(tns), amount)}
end

function Predefs.MinJudgeCount(tns, amount)
	return {cleared_check = function(pss) return pss:GetTapNoteScores(tns) >= amount end, text = sf("MinJudgeCount", j(tns), amount)}
end

function Predefs.MinScore(value)
	return {cleared_check = function(pss) return pss:GetScore() >= value end, text = sf("MinScore", commify(tostring(value)))}
end

function Predefs.ClearLives()
	return {cleared_check = function() return true end, text = s("ClearLives")}
end

MissionDefs = {
	[1] = {
		[1] = { song = "I Took A Pill in Ibiza (SeeB Remix)", diff = 'Difficulty_Beginner', normal = Predefs.Clear(), hard = Predefs.JudgePercentage('TapNoteScore_W2',0.7) },
		[2] = { song = "We Don't Talk Anymore", diff = 'Difficulty_Beginner', normal = Predefs.MinGrade('Grade_Tier05'), hard = Predefs.FullCombo() },
		[3] = { song = "Rockabye", diff = 'Difficulty_Easy', normal = Predefs.Clear(), hard = Predefs.MaxJudgeCount('TapNoteScore_W3', 35) },
		[4] = { song = "Danza Kuduro", diff = 'Difficulty_Beginner', normal = Predefs.MinCombo(30), hard = Predefs.MinGrade('Grade_Tier04') },
		[5] = { song = "Acapella", diff = 'Difficulty_Easy', normal = Predefs.MinJudgeCount('TapNoteScore_W2',30), hard = Predefs.MinCombo(50) },
		[6] = { song = "Stayin' Alive (Albina Mango Remix)", diff = 'Difficulty_Easy', normal = Predefs.MinLife(0.7), hard = {cleared_check = function(pss) return (pss:GetTapNoteScores('TapNoteScore_W5') + pss:GetTapNoteScores('TapNoteScore_Miss'))<=10 end, text = s("M0106Hard")} },
		[7] = { song = "PLASMA", diff = 'Difficulty_Easy', normal = Predefs.MinGrade('Grade_Tier05'), hard = Predefs.JudgePercentage('TapNoteScore_W2', 0.75) },
		[8] = { song = "DAZZLING SEASON", diff = 'Difficulty_Beginner', normal = Predefs.Clear(), hard = Predefs.FullLife() }
	},
	[2] = {
		[1] = { song = "earth scape", diff = 'Difficulty_Easy', normal = Predefs.MinGrade('Grade_Tier04'), hard = Predefs.FullComboOfScore('TapNoteScore_W2') },
		--missions 2 and 3 are not finished yet
		[8] = { song = "memento mori -intro-", diff = 'Difficulty_Beginner', normal = Predefs.FullCombo(), hard = Predefs.JudgePercentage('TapNoteScore_W1', 0.7) }
	},
	[3] = {
		[5] = { song = "A Cruel Angel's Thesis", diff = 'Difficulty_Easy', normal = {cleared_check = function(pss) return pss:FullCombo() and (pss:GetHoldNoteScores('HoldNoteScore_LetGo') == 0) end, text = s("M0305Normal")} },
		[6] = { song = "Shake It Off", diff = 'Difficulty_Easy', normal = Predefs.MinScore(750000) },
		[7] = { song = {"Xepher", "Zenius -I- vanisher"}, diff = 'Difficulty_Easy', normal = Predefs.Clear(), hard = Predefs.MinGrade('Grade_Tier04') },
		[8] = { song = "Everything", setup = function(po) po:BatteryLives(4) end, normal = Predefs.ClearLives(), hard = Predefs.FullComboOfScore('TapNoteScore_W2') }
	}
}
