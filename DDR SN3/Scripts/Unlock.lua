-- by not prefixing "local" before this variable,
-- it will have global scope throughout your theme
-- and can be accessed from any other theme file
ItemThatWasJustUnlocked = nil

function UnlockSomeStuffMaybe(text)
	
	-- How many unlocks are there? Get the number.
	local HowMany = UNLOCKMAN:GetNumUnlocks()
	
	if HowMany > 0 then
		
		-- Use the text that was typed to see if it matches any "Codes" set under
		-- [UnlockManager] in your Metrics.ini
		local UnlockSongs = UNLOCKMAN:GetSongsUnlockedByEntryID(text)
		
		-- The line above returns a table whether it finds anything or not
		-- so check the size of that table.
		if #UnlockSongs > 0 then
			
			local group = UnlockSongs[1]:GetGroupName()
			local title = UnlockSongs[1]:GetDisplayFullTitle()
			
			-- create a path out of the song's group and title
			local path = group.."/"..title
					
			-- set the variable with global scope equal to the path
			-- we'll use this variable later on ScreenUnlock2
			ItemThatWasJustUnlocked = path
			
			--unlock that song using the text the user typed in
			UNLOCKMAN:UnlockEntryID(text)
		else
		
			-- the lookup didn't find any locked content that matched the typed text
			-- so set this variable to nil
			ItemThatWasJustUnlocked = nil
		end
	
	end
end

Unlock = {}

--4000, 9000, 15000, 22000, 30000...
local function cost_tiers(tier)
	return 500*(tier^2+7*tier)
end

local function unlock_entries()
	local limit = UNLOCKMAN:GetNumUnlocks()
	local current = 0
	return function()
		if current < limit then
			current = current + 1
			return UNLOCKMAN:GetUnlockEntry(current-1)
		end
		return nil
	end
end

function UnlockEntry:GetCost()
	local code = tonumber(self:GetCode())
	if not code then return cost_tiers(1) end
	local tier = (code%10)+1
	return cost_tiers(tier)
end

do
	local function unlocks_compare(a, b)
		if a.cost ~= b.cost then return a.cost < b.cost end
		return a.song:GetTranslitFullTitle() < b.song:GetTranslitFullTitle()
	end
	function Unlock.GetSongs()
		local output = {}
		for entry in unlock_entries() do
			local song = entry:GetSong()
			if song then
				local cost = entry:GetCost()
				output[#output+1] = {song = song, cost = cost, entry = entry}
			end
		end
		table.sort(output, unlocks_compare)
	end
end
