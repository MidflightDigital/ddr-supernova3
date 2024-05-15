--This is a partial list of files that are no longer used in this version of the theme.
--If any are present, it's a good sign that the theme was installed over an old version.
local badFiles = {
"/Scripts/06 MyGrooveRadarHelpers.lua",
"/Scripts/05 ProfileData.lua",
"/Scripts/99 waiei.lua",
"/Scripts/ThemePrefs.lua",
"/Scripts/00 aaaOverride.lua",
"/Scripts/00 settings_system.lua",
"/BGAnimations/ScreenGameplay underlay/P1Cutin.lua",
"/BGAnimations/ScreenGameplay underlay/P2Cutin.lua",
"/Scripts/99 ReadPref.lua",
"/Scripts/01 ThemeInfo.lua"
}

for _, path in pairs(badFiles) do
    if FILEMAN:DoesFileExist(THEME:GetCurrentThemeDirectory()..path) then
    	print("SN3 is dirty.")
        SN3DirtyFlag = true
      	break
    end
end
EndlessAvailableFlag = Player.SetLife ~= nil
if (not EndlessAvailableFlag) then
	Warn("Your version of StepMania ("..ProductVersion()..") does not support a feature that is required by Endless Mode.\nEndless Mode will be disabled until you upgrade.")
end

if PREFSMAN:GetPreference("VideoRenderers"):find("^d3d") then
	Warn("Direct3D mode detected. Some visual effects may not work properly.\nDo not report these problems as bugs, they are limitations of Direct3D mode.")
end

--this is now here just to have an extra dirty check
-- theme identification:
themeInfo = {
ProductCode = "DDR SuperNOVA 3",
Name = "DDR SuperNOVA 3",
Version = "r7.0",
Date = "20180718",
Author = "MidflightDigital"
}