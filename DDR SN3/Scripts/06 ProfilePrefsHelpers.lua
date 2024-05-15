local entryToPrefixMap = {
	['filter'] = "ScreenFilter",
	['character'] = "SNCharacter"
}

local function dbglog(msg)
	if SN3Debug then
		return print("LoadFromProfilePrefs: "..msg)
	end
end

function LoadFromProfilePrefs()
	dbglog("start")
	--note: unless you don't use the _fallback version of getenv/setenv this
	--code does not work
	local env = GAMESTATE:Env()
	if env.setupPerformed then
		dbglog("already ran this game")
		return
	end
	dbglog "first time through"
	env.setupPerformed = true
	for _, pn in pairs(GAMESTATE:GetEnabledPlayers()) do
		local prefs = ProfilePrefs.Read(GetProfileIDForPlayer(pn))
		local shortPn = ToEnumShortString(pn)
		for sourceName, destName in pairs(entryToPrefixMap) do
			destName = destName..shortPn
			dbglog("setting "..destName.." to "..tostring(prefs[sourceName]))
			env[destName] = prefs[sourceName]
			dbglog("getenv gives "..tostring(getenv(destName)))
		end
	end
end 
