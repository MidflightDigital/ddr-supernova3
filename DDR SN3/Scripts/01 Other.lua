-- �R���{�ݒ�
function GetPrevSteps()
	if PREFSMAN:GetPreference("OnlyDedicatedMenuButtons", true) then
		return "MenuUP"
	else
		return ""
	end
end;

function GetNextSteps()
	if PREFSMAN:GetPreference("OnlyDedicatedMenuButtons", true) then
		return "MenuDOWN"
	else
		return ""
	end
end;

function ComboTransformCommand( self, params )
	local x = 0
	local y = 38
	if params.bReverse then y = -23 end

	--[[
	if params.bCentered then
		if params.bReverse then
			y = y - 30
		else
			y = y + 40
		end
	end
	--]]
	self:x( x )
	self:y( y )
end


--This comes in handy in a number of places
function GetOrCreateChild(tab, field, kind)
    kind = kind or 'table'
    local out
    if not tab[field] then
        if kind == 'table' then
            out = {}
        elseif kind == 'number' then
            out = 0
        elseif kind == 'boolean_df' or kind == 'boolean' then
            out = false
        elseif kind == 'boolean_dt' then
            out = true
        else
            error("GetOrCreateChild: I don't know a default value for type "..kind)
        end
        tab[field] = out
    else out = tab[field] end
    return out
end

function TextBannerAfterSet(self,param)
	local Title=self:GetChild("Title")
	local Subtitle=self:GetChild("Subtitle")
	local Artist=self:GetChild("Artist")

	if Subtitle:GetText() ~= "" then
		--strip off whitespace at the beginning of the subtitle text
		--and the end of the title text
		local SubtitleText = Subtitle:GetText()
		local TitleText = Title:GetText()
		Title:settext(JoinStringsWithSpace(TitleText, SubtitleText))
	end

	Title:maxwidth(300/0.8)
	Title:y(-7)
	Title:zoom(0.8)

	Subtitle:visible(false)

	Artist:maxwidth(300/0.6)
	Artist:y(9)
	Artist:zoom(0.6)

end

function TextBannerGameplayAfterSet(self, param)
	TextBannerAfterSet(self)
	self:GetChild("Title"):maxwidth(200/0.8)
	self:GetChild("Artist"):maxwidth(200/0.6)
end

local difficultyToIconIndex = {
	Difficulty_Beginner		= 0,
	Difficulty_Easy			= 1,
	Difficulty_Medium		= 2,
	Difficulty_Hard			= 3,
	Difficulty_Challenge 	= 4,
	Difficulty_Edit			= 5
}
function GetDifficultyIconFrame(diff) return difficultyToIconIndex[diff] or difficultyToIconIndex['Difficulty_Edit'] end

function LoadStepsDisplayGameplayFrame(self,player)
	local difficultyStates = {
		Difficulty_Beginner	 = 0,
		Difficulty_Easy		 = 2,
		Difficulty_Medium	 = 4,
		Difficulty_Hard		 = 6,
		Difficulty_Challenge = 8,
		Difficulty_Edit		 = 10,
	};
	local selection;
	if GAMESTATE:IsCourseMode() then
		-- get steps of current course entry
		selection = GAMESTATE:GetCurrentTrail(player);
		local entry = selection:GetTrailEntry(GAMESTATE:GetLoadingCourseSongIndex()+1)
		selection = entry:GetSteps()
	else
		selection = GAMESTATE:GetCurrentSteps(player);
	end;
	local diff = selection:GetDifficulty()
	local state = difficultyStates[diff] or 10;
	if player == PLAYER_2 then state = state + 1; end;
	return state;
end;
-- summary evaluation banner handling (for 1-5 stages)
-- ganked from my ddr 5th mix port
local summaryBannerX = {
	MaxStages1 = { SCREEN_CENTER_X },
	MaxStages2 = {
		SCREEN_CENTER_X+45,
		SCREEN_CENTER_X-45
	},
	MaxStages3 = {
		SCREEN_CENTER_X+60,
		SCREEN_CENTER_X,
		SCREEN_CENTER_X-60
	},
	MaxStages4 = {
		SCREEN_CENTER_X+45,
		SCREEN_CENTER_X+15,
		SCREEN_CENTER_X-15,
		SCREEN_CENTER_X-45
	},
	MaxStages5 = {
		SCREEN_CENTER_X+60,
		SCREEN_CENTER_X+30,
		SCREEN_CENTER_X,
		SCREEN_CENTER_X-30,
		SCREEN_CENTER_X-60
	}
}

local summaryBannerY = {
	MaxStages1 = { SCREEN_CENTER_Y-140 },
	MaxStages2 = {
		SCREEN_CENTER_Y-130,
		SCREEN_CENTER_Y-150
	},
	MaxStages3 = {
		SCREEN_CENTER_Y-120,
		SCREEN_CENTER_Y-140,
		SCREEN_CENTER_Y-160
	},
	MaxStages4 = {
		SCREEN_CENTER_Y-125,
		SCREEN_CENTER_Y-135,
		SCREEN_CENTER_Y-145,
		SCREEN_CENTER_Y-155
	},
	MaxStages5 = {
		SCREEN_CENTER_Y-120,
		SCREEN_CENTER_Y-130,
		SCREEN_CENTER_Y-140,
		SCREEN_CENTER_Y-150,
		SCREEN_CENTER_Y-160
	}
}

function GetSummaryBannerX(num)
	local maxStages = PREFSMAN:GetPreference('SongsPerPlay')

	-- check how many stages were played...
	local playedStages = STATSMAN:GetStagesPlayed()
	if playedStages < maxStages then
		-- long versions and/or marathons were involved.
		if playedStages == 1 then return summaryBannerX.MaxStages1[1]
		elseif playedStages == 2 then return summaryBannerX.MaxStages2[num]
		elseif playedStages == 3 then return summaryBannerX.MaxStages3[num]
		elseif playedStages == 4 then return summaryBannerX.MaxStages4[num]
		end
	elseif playedStages > maxStages then
		-- extra stages
		if playedStages == 1 then return summaryBannerX.MaxStages1[1]
		elseif playedStages == 2 then return summaryBannerX.MaxStages2[num]
		elseif playedStages == 3 then return summaryBannerX.MaxStages3[num]
		elseif playedStages == 4 then return summaryBannerX.MaxStages4[num]
		elseif playedStages == 5 then return summaryBannerX.MaxStages5[num]
		end
	else
		-- normal behavior
		if maxStages == 1 then return summaryBannerX.MaxStages1[1]
		elseif maxStages == 2 then return summaryBannerX.MaxStages2[num]
		elseif maxStages == 3 then return summaryBannerX.MaxStages3[num]
		elseif maxStages == 4 then return summaryBannerX.MaxStages4[num]
		elseif maxStages == 5 then return summaryBannerX.MaxStages5[num]
		end
	end
end

function GetSummaryBannerY(num)
	local maxStages = PREFSMAN:GetPreference('SongsPerPlay')

	-- check how many stages were played...
	local playedStages = STATSMAN:GetStagesPlayed()
	if playedStages < maxStages then
		-- long versions and/or marathons were involved.
		if playedStages == 1 then return summaryBannerY.MaxStages1[1]
		elseif playedStages == 2 then return summaryBannerY.MaxStages2[num]
		elseif playedStages == 3 then return summaryBannerY.MaxStages3[num]
		elseif playedStages == 4 then return summaryBannerY.MaxStages4[num]
		end
	elseif playedStages > maxStages then
		-- extra stages
		if playedStages == 1 then return summaryBannerY.MaxStages1[1]
		elseif playedStages == 2 then return summaryBannerY.MaxStages2[num]
		elseif playedStages == 3 then return summaryBannerY.MaxStages3[num]
		elseif playedStages == 4 then return summaryBannerY.MaxStages4[num]
		elseif playedStages == 5 then return summaryBannerY.MaxStages5[num]
		end
	else
		-- normal behavior
		if maxStages == 1 then return summaryBannerY.MaxStages1[1]
		elseif maxStages == 2 then return summaryBannerY.MaxStages2[num]
		elseif maxStages == 3 then return summaryBannerY.MaxStages3[num]
		elseif maxStages == 4 then return summaryBannerY.MaxStages4[num]
		elseif maxStages == 5 then return summaryBannerY.MaxStages5[num]
		end
	end
end

-- JoinStringsWithSpace(a, b)
-- Joins a pair of strings by a space, removing other whitespace around it.
function JoinStringsWithSpace(a, b)
	return a:gsub("%s*$","").." "..b:gsub("^%s*","")
end

--MakeDeck(source)
--Takes a table and returns a deck based on that table.
--A deck is a function that, when it is called, returns a random value from
--a table. It will go through every entry in the table before repeating.
function MakeDeck(source)
	assert(source, "MakeDeck: you need to pass in a table")
	if not next(source) then
		Warn("MakeDeck: got empty table, returning nothing")
		return nil
	end
	local keys = nil
	local function FindKeys()
		keys = {}
		for key, _ in pairs(source) do
			table.insert(keys, key)
		end
	end
	FindKeys()
	return function()
		if next(keys) == nil then FindKeys() end
		return source[table.remove(keys, ((#keys == 1) and 1 or math.random(1,#keys)))]
	end
end

function GetProfileIDForPlayer(pn)
    if GAMESTATE:IsHumanPlayer(pn) then
        local profile = PROFILEMAN:GetProfile(pn)
        if profile == PROFILEMAN:GetMachineProfile() then
            return "!MACHINE"
        end
        if PROFILEMAN:ProfileWasLoadedFromMemoryCard(pn) then
            return (pn=='PlayerNumber_P1') and "!MC0" or "!MC1"
        end
        if GAMESTATE:Env() then
            local pidCache = GetOrCreateChild(GAMESTATE:Env(),"PlayerLocalIDs")
            if pidCache[pn] then
                return pidCache[pn]
            end
            --worst case scenario: we have to search all the local profiles to find it.
            for _, id in pairs(PROFILEMAN:GetLocalProfileIDs()) do
                if PROFILEMAN:GetLocalProfile(id) == profile then
                    pidCache[pn] = id
                    return id
                end
            end
            --apparently this just means we're using the machine profile if this all fails.
            pidCache[pn] = "!MACHINE"
            return "!MACHINE"
        end
    end
    return "!MACHINE"
end

--this gets the course song number or stage index, +1 as appropriate
function GameState:GetAppropriateStageNum()
	if self:IsCourseMode() then
		return self:GetCourseSongIndex() + 1
	else
		return self:GetCurrentStageIndex() + 1
	end
end

--Loads the file at path and runs it in the specified environment,
--or an empty one if no environment is provided. Catches any errors that occur.
--Returns false if the called function failed, true and anything else the function returned if it worked
function dofile_safer(path, env)
    env = env or {}
    if not FILEMAN:DoesFileExist(path) then
        --the file doesn't exist
        return false
    end
    local handle = RageFileUtil.CreateRageFile()
    handle:Open(path, 1)
    local code = loadstring(handle:Read(), path)
    handle:Close()
    handle:destroy()
    if not code then
        --an error occurred while compiling the file
        return false
    end
    setfenv(code, env)
    return pcall(code)
end

-- GetCharAnimPath(sPath)
-- Easier access to Characters folder (taken from ScreenHowToPlay.cpp)
function GetCharAnimPath(sPath) return "/Characters/"..sPath end

--GhostCopy(source)
--Returns an unwritable virtual copy of a table
function GhostCopy(source)
    local ghost_cache = setmetatable({}, {__mode="k"})
    return setmetatable({}, {
        __metatable = {__ghost=true},
        __newindex = function()
            error("tried to write to a ghost table", 2)
        end,
        __index = function(me, key)
            if ghost_cache[key] then return ghost_cache[key] end
            local result = source[key]
            if type(result) == "table" then
            	local mt = getmetatable(result)
            	if type(mt) ~= "table" or (not mt.__ghost) then
                	result = GhostCopy(result)
                end
                ghost_cache[key] = result
            end
            return result
        end
    })
end


function BitmapText:settextfmt(fmt, ...)
	return self:settext(string.format(fmt, ...))
end

--why did i write this code
do
    local cache = {}
    --this makes cache a weak table.
    --if any actor in the cache is garbage collected by Lua, it is removed.
    setmetatable(cache, {__mode="kv"})
    local function internal(self, starting)
        starting = starting or self
        if cache[self] ~= nil then
            --then for this actor no need to go through this process
            cache[starting] = cache[self]
            return cache[self]~=false and cache[self] or nil
        elseif self.ScreenType then
            --both roads end here
            cache[self] = self
            cache[starting] = self
            return self
        elseif self:GetParent() then
            return internal(self:GetParent(), starting)
        else
            --nil is indistinguishable from nothing, so use false instead
            cache[self] = false
            cache[starting] = false
            return nil
        end
    end
    function Actor:GetContainingScreen()
        return internal(self)
    end
end

--stuff for doing update functions that i love so -tertu
function CalculateWaitFrames(targetDelta, delta)
    return math.max(1, math.round(targetDelta/delta))-1
end

--returns a function that returns true if the function should run this update
function GetUpdateTimer(targetDelta)
    local frameCounter = 0
    return function()
        if frameCounter == 0 then
            frameCounter = CalculateWaitFrames(targetDelta, 1/DISPLAY:GetCumFPS())
            return true
        end
        frameCounter = frameCounter - 1
        return false
    end
end

--we need this function because we need to get the current Steps for non-human players.
--however, non-human players don't actually have a current Steps.
function GetCurrentStepsPossiblyCPU(pn)
	if not GAMESTATE:IsHumanPlayer(pn) then
		return GAMESTATE:GetCurrentSteps(GAMESTATE:GetMasterPlayerNumber())
	end
	return GAMESTATE:GetCurrentSteps(pn)
end

--The exit row needs to be enabled sometimes for ScreenPlayerOptions to work properly.
--These conditions are:
--If ThreeKeyNavigation is enabled.
--If ArbitrarySpeedMods are in use.
function EnableExitRow()
	if PREFSMAN:GetPreference "ThreeKeyNavigation" then
		return true
	end
	if ThemePrefs.Get "SpeedModSource" == "arbitrary" then
		return true
	end
	return false
end

function trim_whitespace(str)
	return str:gsub("^%s*",""):gsub("%s*$","")
end

function print_table(tbl)
	print('{')
	for k,v in pairs(tbl) do
		if type(v) == 'table' then
			print(tostring(k)..'='); print_table(v)
		else
			print(tostring(k)..'='..tostring(v))
		end
	end
	print('}')
end