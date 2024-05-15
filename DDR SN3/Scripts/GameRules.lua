--right now this function doesn't do anything useful
function MinimumTNSForCombo()
	return 'TapNoteScore_W3'
end

function ShowBeatBars()
	--the following chunk of code doesn't work right now for external reasons.
	--however, if something changes and it DOES, it will Magically Start
	--Working with no code changes. As it stands it probably takes 1 ms or so
	--to run and so can be left alone. -tertu
	if GAMESTATE then
		if GAMESTATE:IsDemonstration() then
			--show guidelines in demo mode about 1/20th of the time
			return math.random() > 0.95
		end
		--we can only decide whether to show guidelines for all players
		--so, we do it like Solo in 573 mixes: if either player wants
		--guidelines we show guidelines.
		for _, pn in pairs(GAMESTATE:GetEnabledPlayers()) do
			local profilePrefs = ProfilePrefs.Read(GetProfileIDForPlayer(pn))
			if profilePrefs.guidelines then
				return true
			end
		end
		--fall through
	end
	return false
end