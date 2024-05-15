function IsStarterMode()
	if GAMESTATE then
		local env = GAMESTATE:Env()
		if GAMESTATE:Env() then
			if not env.StarterMode then
				return false
			end
			return true
		end
	end
	--the question is not yet meaningful if we get here
	return nil
end

local outputPath = THEME:GetAbsolutePath("Other/SongManager Starter.txt", true)
local isolatePattern = "/([^/]+)/?$" --in English, "everything after the last forward slash unless there is a terminator"
local combineFormat = "%s/%s"
local meterCutoffs = {
	_MeterType_DDR = 3,
	_MeterType_DDRX = 5,
	_MeterType_ITG = 3,
	_MeterType_Pump = 6
}
setmetatable(meterCutoffs, {__index=function(t, _) return t._MeterType_DDR or 3 end})
function AssembleStarter()
	if not (SONGMAN and GAMESTATE) then return end
	local set = {}
	local stepsType = GAMESTATE:GetCurrentStyle():GetStepsType()
	--populate the groups
	for _, song in pairs(SONGMAN:GetAllSongs()) do
		local cutoff = meterCutoffs[SongAttributes.GetMeterType(song)]
		local beg = song:GetOneSteps(stepsType, 'Difficulty_Beginner')
		local easy = song:GetOneSteps(stepsType, 'Difficulty_Easy')
		if (beg and beg:GetMeter() <= cutoff) or (easy and easy:GetMeter() <= cutoff) then
			local shortSongDir = string.match(song:GetSongDir(),isolatePattern)
			local groupName = song:GetGroupName()
			local groupTbl = GetOrCreateChild(set, groupName)
			groupTbl[#groupTbl+1] = string.format(combineFormat, groupName, shortSongDir)
		end
	end
	--sort all the groups and collect their names, then sort that too
	local groupNames = {}
	for groupName, group in pairs(set) do
		if next(group) == nil then
			set[groupName] = nil
		else
			table.sort(group)
			groupNames[#groupNames+1] = groupName
		end
	end
	table.sort(groupNames)
	--then, let's make a representation of our eventual file in memory.
	local outputLines = {}
	for _, groupName in ipairs(groupNames) do
		outputLines[#outputLines+1] = "---"..groupName
		for _, path in ipairs(set[groupName]) do
			outputLines[#outputLines+1] = path
		end
	end
	--now, slam it all out to disk.
	local fHandle = RageFileUtil.CreateRageFile()
	--the mode is Write+FlushToDiskOnClose
	fHandle:Open(outputPath, 10)
	fHandle:Write(table.concat(outputLines,'\n'))
	fHandle:Close()
	fHandle:destroy()
end

function EnableStarterGameplayJunk()
	assert(GAMESTATE and GAMESTATE:Env(),
		"Wherever you are calling EnableStarterGameplayJunk, you can't do it there!")
	local env = GAMESTATE:Env()
	env.StarterMode = true
	SONGMAN:SetPreferredSongs("Starter")
end

--if we've never made the file before, it complains
--this is enough to make it not complain
if not FILEMAN:DoesFileExist(outputPath) then
	local fHandle = RageFileUtil.CreateRageFile()
	fHandle:Open(outputPath, 10)
	fHandle:Write("\n")
	fHandle:Close()
	fHandle:destroy()
	assert(FILEMAN:DoesFileExist(outputPath), "creating placeholder Starter preferred sort file failed")
end
