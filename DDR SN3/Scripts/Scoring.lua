--[[Scoring.lua
This includes a few modules that all have to do with scoring and grading.
SN2Scoring and OldScoring are independent modules.
SN2Grading partially depends on SN2Scoring.
All information used is from http://aaronin.jp/ddrssystem.html. The
information used for SN2 was written by Aaron C.
]]

--SN2Scoring
--Implements the scoring system used by DDR SN2-2014.

--Shared functions/data

SN2Scoring = {}
--ScoringInfo is used and maintained solely by PrepareScoringInfo.
ScoringInfo = {
    seed = nil
}

--The multiplier tables have to be filled in completely.
--However, the deduction ones do not.
local normalScoringRules = 
{
    normal = 
    {
        multipliers =
        {
            TapNoteScore_W1 = 1,
            TapNoteScore_W2 = 1,
            TapNoteScore_W3 = 0.5,
            TapNoteScore_W4 = 0,
            TapNoteScore_W5 = 0,
            TapNoteScore_Miss = 0
        },
        deductions =
        {
            TapNoteScore_W2 = 10,
            TapNoteScore_W3 = 10
        }
    },
    starter = 
    {
        multipliers =
        {
            TapNoteScore_W1 = 1,
            TapNoteScore_W2 = 1,
            TapNoteScore_W3 = 1,
            TapNoteScore_W4 = 0.5,
            TapNoteScore_W5 = 0.5,
            TapNoteScore_Miss = 0
        },
        deductions = {}
    }    
}

local maxQuasiMultipliers = 
{
    TapNoteScore_W1 = 1,
    TapNoteScore_W2 = 1,
    TapNoteScore_W3 = 1,
    TapNoteScore_W4 = 1,
    TapNoteScore_W5 = 1,
    TapNoteScore_Miss = 1
}

--Given a thing which has functions hnsFuncName and tnsFuncName that take one
--argument and return the number of TNSes or HNSes there are in that thing,
--pack that information into something useful.
--This is a pretty bad function description, so just see how it's used.
local function GetScoreDataFromThing(thing, tnsFuncName, hnsFuncName)
    local output = {}
    --how class function lookup works internally in Lua
    local hnsFunc = thing[hnsFuncName]
    local tnsFunc = thing[tnsFuncName]
    for tns, _ in pairs(maxQuasiMultipliers) do
        output[tns] = tnsFunc(thing, tns)
    end
    for _, hns in pairs({'HoldNoteScore_Held', 'HoldNoteScore_LetGo'}) do
        assert(hnsFunc(thing, hns))
        output[hns] = hnsFunc(thing, hns)
    end
    return output
end

function SN2Scoring.PrepareScoringInfo(starterRules)
    if GAMESTATE then
        local stageSeed = GAMESTATE:GetStageSeed()
        --if the seed hasn't changed, we're in the same game so we don't want
        --to re-initialize
        if stageSeed == ScoringInfo.seed then return end
        ScoringInfo.seed = stageSeed
        local inCourse = GAMESTATE:IsCourseMode()
        local maker = inCourse and SN2Scoring.MakeCourseScoringFunctions or SN2Scoring.MakeNormalScoringFunctions
        --cool lua trick: GAMESTATE:GetCurrentTrail(pn) is equivalent to 
        --GameState.GetCurrentTrail(GAMESTATE,pn) so we can save the right
        --function to a variable and save... 3 lines of code or so...
        --oh well.
        local dataFetcher = inCourse and GameState.GetCurrentTrail or GameState.GetCurrentSteps
        for _,pn in pairs(GAMESTATE:GetEnabledPlayers()) do
            local data = dataFetcher(GAMESTATE,pn)
            if data then
                ScoringInfo[pn] = maker(data,pn,starterRules)
            end
        end
    end
end

--data format for this function:
--a table with a count of total holds, rolls, and taps called "Total"
--all earned TapNoteScores in the class W1-W5 and Miss under their native names
--all earned HoldNoteScores
function SN2Scoring.ComputeNormalScoreFromData(data, max, scoringRuleSet)
    scoringRuleSet = scoringRuleSet or normalScoringRules.normal
    local objectCount = data.Total
    local maxScore = 1000000
    local maxFraction = 0
    local totalDeductions = 0
    local tnsMultipliers, hnsMultipliers, deductions
    if max then
        tnsMultipliers = maxQuasiMultipliers
        hnsMultipliers = {HoldNoteScore_Held = 1, HoldNoteScore_LetGo = 1}
        deductions = {}
    else
        tnsMultipliers = scoringRuleSet.multipliers
        hnsMultipliers = {HoldNoteScore_Held = 1}
        deductions = scoringRuleSet.deductions
    end
    local scoreCount
    for tns, multiplier in pairs(tnsMultipliers) do
        scoreCount = data[tns]
        maxFraction = maxFraction + (scoreCount * multiplier)
        totalDeductions = totalDeductions + (scoreCount * (deductions[tns] or 0))
    end
    for hns, multiplier in pairs(hnsMultipliers) do
        scoreCount = data[hns]
        maxFraction = maxFraction + (scoreCount * multiplier)
    end
    return ((maxFraction/objectCount) * maxScore) - totalDeductions    
end


function SN2Scoring.GetSN2ScoreFromHighScore(steps, highScore)
    local scoreData = GetScoreDataFromThing(highScore, "GetTapNoteScore", 
        "GetHoldNoteScore")
    local radar = steps:GetRadarValues(pn)
    scoreData.Total = radar:GetValue('RadarCategory_TapsAndHolds')+
        radar:GetValue('RadarCategory_Holds')+radar:GetValue('RadarCategory_Rolls')
    return SN2Scoring.ComputeNormalScoreFromData(scoreData)
end

--Normal scoring

function SN2Scoring.MakeNormalScoringFunctions(stepsObject,pn,starterRules)
    local package = {}
    local radar = stepsObject:GetRadarValues(pn)
    local objectCount = radar:GetValue('RadarCategory_TapsAndHolds')+radar:GetValue('RadarCategory_Holds')+radar:GetValue('RadarCategory_Rolls')
    local scoringRuleSet = starterRules and normalScoringRules.starter or normalScoringRules.normal

    local function ComputeScore(pss, max)
        local computeData = GetScoreDataFromThing(pss, "GetTapNoteScores", "GetHoldNoteScores")
        computeData.Total = objectCount
        return SN2Scoring.ComputeNormalScoreFromData(computeData, max, scoringRuleSet)
    end

    package.AddTapScore = function() end
    package.AddHoldScore = function() end

    package.GetCurrentScore = function(pss, stage, exact)
        --stage is unused
        if exact then
            return ComputeScore(pss)
        end
        return 10 * math.round(ComputeScore(pss) / 10)
    end

    package.GetCurrentMaxScore = function(pss, stage)
        --ditto
        return ComputeScore(pss, true)
    end

    return package
end

--Course scoring

local function CourseNoteMultiplier(stage, score)
    --if you just pass a stage number, it gives you the maximum
    score = score or 'TapNoteScore_W1'

    --the multiplier starts at 3 and goes up by 1 every two stages cleared
    local baseMultiplier = math.floor(stage-1 / 2) + 3

    if score == 'TapNoteScore_W1' or score == 'HoldNoteScore_Held' then
        return baseMultiplier
    elseif score == 'TapNoteScore_W2' then
        return baseMultiplier - 1
    elseif score == 'TapNoteScore_W3' then
        return baseMultiplier - 2
    end
    return 0
end

function SN2Scoring.MakeCourseScoringFunctions(trailObject,pn)
    local package = {}
    local trailEntries = trailObject:GetTrailEntries()
    local totalSDP = 0

    for stage, entry in ipairs( trailEntries ) do
        local multiplier = CourseNoteMultiplier(stage)
        local radar = entry:GetSteps():GetRadarValues(pn)
        totalSDP = (radar:GetValue('RadarCategory_TapsAndHolds')
            +radar:GetValue('RadarCategory_Holds')
            +radar:GetValue('RadarCategory_Rolls'))
            * multiplier
            + totalSDP
    end
    
    local baseScore = 1000000
    local oldStageJudgments = {}
    local oldStageHoldJudgments = {}
    local totalOldMaxFractions = { real= 0, max=0 }
    local lastMaxFractions = {real=0, max=0}

    local function ComputeScore(pss, stage, max)
        local curStageJudgments = 
            { TapNoteScore_W1 = 0, TapNoteScore_W2 = 0, TapNoteScore_W3 = 0, TapNoteScore_W4 = 0, TapNoteScore_W5 = 0, TapNoteScore_Miss = 0}
        local curStageHoldJudgments = { HoldNoteScore_Held = 0, HoldNoteScore_LetGo = 0 }
        assert(#oldStageJudgments == #oldStageHoldJudgments, "Course ComputeScore: internal data inconsistency")
        --XXX: Add an AtEndOfSong function or something to not have to do this
        if #oldStageJudgments == stage then
            table.remove(oldStageJudgments)
            table.remove(oldStageHoldJudgments)
        else
            totalOldMaxFractions.real = lastMaxFractions.real
            totalOldMaxFractions.max = lastMaxFractions.max
        end
        --this allows us to skip a bunch of calculations that would otherwise be needed
        local maxFraction = max and totalOldMaxFractions.max or totalOldMaxFractions.real

        --There isn't really a way to get stage stats for each stage in the course, unfortunately.
        --So, we have to record how many judgments we got on each stage ourselves.
        for stage, set in pairs(oldStageJudgments) do
            for tns, count in pairs(set) do
                --eventually, the total number of judgments are added to this value, so this ends up giving the
                --number of each judgment hit on the current stage
                curStageJudgments[tns] = curStageJudgments[tns] - count
            end
        end
        --Same as above, but holds this time
        for stage, set in pairs(oldStageHoldJudgments) do
            for hns, count in pairs(set) do
                curStageHoldJudgments[hns] = curStageHoldJudgments[hns] - count
            end
        end

        --Okay, now we can figure out what the current judgment total is for this stage
        for tns, count in pairs(curStageJudgments) do
            count = count + pss:GetTapNoteScores(tns)
            assert(count >= 0, "Course ComputeScore: less than 0 "..tns)
            maxFraction = maxFraction + (count * CourseNoteMultiplier(stage, max and 'TapNoteScore_W1' or tns))
            curStageJudgments[tns] = count
        end
        for hns, count in pairs(curStageHoldJudgments) do
            count = count + pss:GetHoldNoteScores(hns)
            assert(count >= 0, "Course ComputeScore: less than 0 "..hns)
            maxFraction = maxFraction + (count * CourseNoteMultiplier(stage, max and 'HoldNoteScore_Held' or hns))
            curStageHoldJudgments[hns] = count
        end

        table.insert(oldStageJudgments, curStageJudgments)
        table.insert(oldStageHoldJudgments, curStageHoldJudgments)

        if max then
            lastMaxFractions.max = maxFraction
        else
            if SN3Debug and (lastMaxFractions.real ~= maxFraction) then
                SCREENMAN:SystemMessage("Current course fraction: "..maxFraction.."/"..totalSDP)
            end
            lastMaxFractions.real = maxFraction
        end

        --all that work for this
        return (maxFraction/totalSDP)*baseScore
    end

    package.GetCurrentScore = function(pss, stage, exact)
        if exact then
            return ComputeScore(pss, stage)
        end
        return math.floor(ComputeScore(pss, stage))
    end

    package.GetCurrentMaxScore = function(pss, stage)
        return ComputeScore(pss, stage, true)
    end

    return package
end

--SN2Grading
--Implements the grading system used by DDR SN2-2014.

SN2Grading = {}
--Edit is technically the "highest difficulty"
local grade_table = {
    Difficulty_Edit = {
        Grade_Tier01 = 1000000, --AAA+
        Grade_Tier02 = 990000, --AAA
        Grade_Tier03 = 950000, --AA
        Grade_Tier04 = 900000, --A
        Grade_Tier05 = 800000, --B
        Grade_Tier06 = 700000, --C
        Grade_Tier07 = 0 --D
    },
    Difficulty_Medium = {
        Grade_Tier04 = 850000,
        Grade_Tier05 = 750000,
        Grade_Tier06 = 600000
    },
    Difficulty_Easy = {
        Grade_Tier04 = 800000,
        Grade_Tier05 = 700000,
        Grade_Tier06 = 500000
    }
}
--i'm too lazy to fill this out in full, so this does it for me
do
    local rev_diff = Enum.Reverse(Difficulty)
    local max_diff = rev_diff.Difficulty_Challenge+1
    local min_diff = rev_diff.Difficulty_Beginner+1
    --DeepCopy is so that these are all independent
    local cur_grade_table = grade_table.Difficulty_Edit
    for idx=max_diff, min_diff, -1 do
        --inherit changes from the "parent"
        cur_grade_table = DeepCopy(cur_grade_table)
        local source_table = grade_table[Difficulty[idx]]
        if source_table then
           for k, v in pairs(source_table) do cur_grade_table[k] = v end
        end
        grade_table[Difficulty[idx]] = cur_grade_table
    end
end

function SN2Grading.ScoreToGrade(score, difficulty)
    local tiers = grade_table[difficulty]
    local output = nil
    local best = 0
    for grade, min_score in pairs(tiers) do
        if score >= min_score and min_score >= best then
            output = grade
            best = min_score
        end
    end
    return output
end

--returns score too because what the hell
function SN2Grading.GetSN2GradeFromHighScore(steps, highScore)
    local score = SN2Scoring.GetSN2ScoreFromHighScore(steps, highScore)
    return SN2Grading.ScoreToGrade(score, steps:GetDifficulty()), score
end

-- (c) 2015-2017 John Walstrom, "Inorizushi"
-- All rights reserved.
-- 
-- Permission is hereby granted, free of charge, to any person obtaining a
-- copy of this software and associated documentation files (the
-- "Software"), to deal in the Software without restriction, including
-- without limitation the rights to use, copy, modify, merge, publish,
-- distribute, and/or sell copies of the Software, and to permit persons to
-- whom the Software is furnished to do so, provided that the above
-- copyright notice(s) and this permission notice appear in all copies of
-- the Software and that both the above copyright notice(s) and this
-- permission notice appear in supporting documentation.
-- 
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
-- OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
-- MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF
-- THIRD PARTY RIGHTS. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR HOLDERS
-- INCLUDED IN THIS NOTICE BE LIABLE FOR ANY CLAIM, OR ANY SPECIAL INDIRECT
-- OR CONSEQUENTIAL DAMAGES, OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS
-- OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR
-- OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
-- PERFORMANCE OF THIS SOFTWARE.
