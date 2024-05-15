do
	--if there isn't music for a specific screen it falls back to common
	local music = {
		common = {
			["SuperNOVA"] = "_sn1 (loop).ogg";
			["SuperNOVA 2"] = "_sn2 (loop).ogg";
			["SuperNOVA 3"] = "_sn3 (loop).ogg";
			["EXTREME"] = "_extreme (loop).ogg";
			["IIDX SIRIUS"] = "_SIRIUS MENU (loop).ogg";
			["DDRMAX 2"] = "_MAX2 (loop).ogg";
			["DDRMAX"] = "_MAX (loop).ogg";
			["aston crowe"] = "_crowe (loop).ogg";
			["dj vortivask"] = "_vortivask (loop).ogg";
		};
		mode = {
			["IIDX SIRIUS"] = "_SIRIUS MODE (loop).ogg";
		};
		profile = {
			["SuperNOVA"] = "_SN3 PROFILE (loop).ogg";
			["SuperNOVA 2"] = "_SN3 PROFILE (loop).ogg";
			["SuperNOVA 3"] = "_SN3 PROFILE (loop).ogg";
			["EXTREME"] = "_SN3 PROFILE (loop).ogg";
			["IIDX SIRIUS"] = "_SIRIUS PROFILE (loop).ogg";
			["DDRMAX 2"] = "_SN3 PROFILE (loop).ogg";
			["DDRMAX"] = "_SN3 PROFILE (loop).ogg";
			["aston crowe"] = "_crowe (loop).ogg";
			["dj vortivask"] = "_vortivask (loop).ogg";
		};
	}
	--thanks to this code
	for name,child in pairs(music) do
		if name ~= "common" then
			setmetatable(child, {__index=music.common})
		end
	end
	function GetMenuMusicPath(type, relative)
		local possibles = music[type] 
			or error("GetMenuMusicPath: unknown menu music type "..type, 2)
		local selection = ThemePrefs.Get("MenuMusic")
		local file = possibles[selection]
			or error("GetMenuMusicPath: no menu music defined for selection"..selection, 2)
		return relative and file or THEME:GetPathS("", file)
	end
end