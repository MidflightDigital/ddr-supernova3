--This is an arbitrary-precision integer using implementation
--of the DDR X endless scoring method.
EndlessScoring = {}

local levelLookup = {3, 6, 8, 10}
setmetatable(levelLookup, {__index=function() return 10 end})

local MAX_SCORE = bn.Int(string.rep('9',30))
function EndlessScoring.Create(level)
    local score = bn.Int(bn.zero)
    local w1Counter = 0
    local noteCounter = 0
    local penaltyCounter = 0
    local tnsReverse = Enum.Reverse(PlayerNumber)
    local lastCombo = 0
    return {
    handleNoteScore = function(noteScore, stageNumber, curCombo)
        if score < MAX_SCORE then
            noteCounter = noteCounter + 1
            
            if noteScore == 'TapNoteScore_W1' then
                w1Counter = w1Counter + 1
            elseif tnsReverse[noteScore] and 
                tnsReverse[noteScore] < tnsReverse['TapNoteScore_W3']
            then
                penaltyCounter = penaltyCounter + math.floor(lastCombo/4)
            end

            local levelFactor
            if level == 1 then
                levelFactor = 2*(stageNumber^3)
            else
                levelFactor = stageNumber^3/levelLookup[level]
            end

            local effectiveNotes = noteCounter - penaltyCounter
            if noteScore == 'TapNoteScore_W1' then
                score = score + bn.Int(math.max(1, 3 * (effectiveNotes+w1Counter) * levelFactor ))
            elseif noteScore == 'TapNoteScore_W2' or noteScore == 'HoldNoteScore_Held' then
                score = score + bn.Int(math.max(1, 2 * effectiveNotes * levelFactor))
            elseif noteScore == 'TapNoteScore_W3' then
                score = score + bn.Int(math.max(1, effectiveNotes * levelFactor))
            end

            if score > MAX_SCORE then score = bn.Int(MAX_SCORE) end
            lastCombo = curCombo
        end
    end,
    getScoreString= function()
        return score:tostring()
    end
    }
end

--XXX: don't be a lazy bastard
local levelDivisor = {
    _MeterType_DDR = 1,
    _MeterType_DDRX = 1.5,
    _MeterType_ITG = 1,
    _MeterType_Pump = 1.65,
    _MeterType_Default = 1
}

Endless = {}

function Endless.GetSongChartBlock(stepsType, minLevel, maxLevel)
    local ret = {}
    assert(minLevel <= maxLevel)
    for _, song in pairs(SONGMAN:GetAllSongs()) do
        if UNLOCKMAN:IsSongLocked(song) == 0 then
            local divisor = levelDivisor[SongAttributes.GetMeterType(song)]
            for _, steps in pairs(song:GetStepsByStepsType(stepsType)) do
                if not (steps:GetDifficulty() == 'Difficulty_Edit') then
                    local meter = steps:GetMeter()
                    if (meter >= minLevel/divisor) and (meter <= maxLevel/divisor) then
                        table.insert(ret, {song, steps})
                    end
                end
            end
        end
    end
    return ret
end

--The first four are Lv. 1-4, the fifth is All, and the sixth is the unlockable
--Lv. 5.
--using -infinity as a lower bound rather than level 1 allows Pump and DDR X 1s
--(which end up being in the 0.6-0.7 range after division) to be included
local levelToRange = {
    {-math.huge,3},
    {3,5},
    {5,7},
    {7,9},
    {-math.huge,math.huge},
    {9,math.huge}
}

function Endless.CreateState(stepsType, endlessLevel, breakStages)
    assert((breakStages > 0) and stepsType and (endlessLevel >= 1) and (endlessLevel <= 6))
    local minLevel, maxLevel = unpack(levelToRange[endlessLevel])
    return {scoring=EndlessScoring.Create(endlessLevel), 
        choiceDeck = MakeDeck(Endless.GetSongChartBlock(stepsType, minLevel, maxLevel)),
        breakAfter=breakStages}
end

function EndlessLockedMessage()
    return SCREENMAN:SystemMessage(THEME:GetString("ScreenSelectPlayMode", "EndlessLocked"))
end