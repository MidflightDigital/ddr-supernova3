--Animations for this quad are not defined here, unlike some other metrics.
local args = {...}
local pss = args[1]
local summary = args[2]
local course = args[3]
local pn = args[4]

local tier
if pss:GetFailed() then
	tier = 'Grade_Failed'
--i don't know how course grading works yet.
elseif ThemePrefs.Get "ConvertScoresAndGrades" and (not course) then
	if summary then
		--find the most popular difficulty. if there is a tie the hardest wins.
		local all_steps = STATSMAN:GetAccumStageStats():GetPlayerStageStats(pn):GetPlayedSteps()
		local winner = 'Difficulty_Beginner'
		local totals = {Difficulty_Beginner=0}
		local index = Enum.Reverse(Difficulty)
		for _, steps in pairs(all_steps) do
			local diff = steps:GetDifficulty()
			local count
			if not totals[diff] then
				count = 1
			else
				count = totals[diff] + 1
			end
			totals[diff] = count
			if count > totals[winner] or 
				(index[diff] > index[winner] and count == totals[winner]) 
			then
				winner = diff
			end
		end
		tier = SN2Grading.ScoreToGrade(pss:GetScore()/#all_steps, winner)
	else
		tier = SN2Grading.ScoreToGrade(pss:GetScore(), pss:GetPlayedSteps()[1]:GetDifficulty())
	end
elseif summary then
	tier = string.format("Grade_Tier%02d",STATSMAN:GetFinalGrade(pn))
else
	tier = pss:GetGrade()
end

--HACK: this happens in Rave sometimes. I don't know why.
if tier == 'Grade_Tier22' then
	tier = 'Grade_Failed'
end

return Def.Sprite{
	Texture = THEME:GetPathG("GradeDisplayEval", ToEnumShortString(tier))
}
