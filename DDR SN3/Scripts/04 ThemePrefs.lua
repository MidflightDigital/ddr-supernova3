local Prefs =
{
	XStyledMusicSelect =
	{
		Default = "Wide Style",
		Choices = { "X Style", "Wide Style" },
		Values = { "X Style", "Wide Style" }
	},
	XDifficultyList =
	{
		Default = "SN Style",
		Choices = { "X Style", "SN Style"},
		Values = { "X Style", "SN Style"}
	},
	EndlessLevel =
	{
		Default = 1,
		Choices = { "Lv. 1", "Lv. 2", "Lv. 3", "Lv. 4", "All", "Lv. 5" },
		Values = {1, 2, 3, 4, 5, 6}
	},
	JudgmentHeight =
	{
		Default = "Standard",
		Choices = {"Standard", "Old"},
		Values = {"Standard", "Old"}
	},
	MenuBG =
	{
		Default = "SuperNOVA 3",
		Choices = { "SuperNOVA", "SuperNOVA 2", "SuperNOVA 3", "SuperNOVA 3 v2", "IIDX SIRIUS" },
		Values = { "SuperNOVA", "SuperNOVA 2", "SuperNOVA 3", "SuperNOVA 3 v2", "IIDX SIRIUS" }
	},
	MenuMusic =
	{
		Default = "SuperNOVA 3",
		Choices = { "DDRMAX", "DDRMAX 2", "EXTREME", "SuperNOVA", "SuperNOVA 2", "SuperNOVA 3", "IIDX SIRIUS", "aston crowe", "dj vortivask" },
		Values = { "DDRMAX", "DDRMAX 2", "EXTREME", "SuperNOVA", "SuperNOVA 2", "SuperNOVA 3", "IIDX SIRIUS", "aston crowe", "dj vortivask" }
	},
	LightMode =
	{
		Default = false,
		Choices = {"No", "Yes"},
		Values = {false, true}
	},
	ComboColorMode =
	{
		Default = "arcade",
		Choices = {"Arcade Style", "Wii Style", "Waiei Style"},
		Values = {"arcade", "wii", "waiei"}
	},
	SpeedModSource =
	{
		Default = "internal",
		Choices = {"Standard", "From File", "SM5 Default"},
		Values = {"internal", "custom", "arbitrary"}
	},
	ConvertScoresAndGrades =
	{
		Default = false,
		Choices = {"No", "Yes"},
		Values = {false, true}
	},
}

ThemePrefs.InitAll(Prefs)

function ScreenGameplay_P1X()
	local st = GAMESTATE:GetCurrentStyle():GetStepsType();
	if st == "StepsType_Dance_Solo" then
		return SCREEN_CENTER_X;
	elseif st == "StepsType_Dance_Couple" then
		return WideScale(SCREEN_CENTER_X-175,SCREEN_CENTER_X-160);
	else
		return WideScale(SCREEN_CENTER_X-175,SCREEN_CENTER_X-240);
	end
end
function ScreenGameplay_P2X()
	local st = GAMESTATE:GetCurrentStyle():GetStepsType();
	if st == "StepsType_Dance_Solo" then
		return SCREEN_CENTER_X;
	elseif st == "StepsType_Dance_Couple" then
		return WideScale(SCREEN_CENTER_X+175,SCREEN_CENTER_X+160);
	else
		return WideScale(SCREEN_CENTER_X+175,SCREEN_CENTER_X+240);
	end
end


function OptionRowScreenFilter()
	--we use integers equivalent to the alpha value multiplied by 10
	--to work around float precision issues
	local choiceToAlpha = {0, 3, 6, 9}
	local alphaToChoice = {[0]=1, [3]=2, [6]=3, [9]=4}
	local t = {
		Name="Filter",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectOne",
		OneChoiceForAllPlayers = false,
		ExportOnChange = true,
		Choices = { THEME:GetString('OptionNames','Off'),
			THEME:GetString('OptionTitles', 'FilterDark'),
			THEME:GetString('OptionTitles', 'FilterDarker'),
			THEME:GetString('OptionTitles', 'FilterDarkest'),
		 },
		LoadSelections = function(self, list, pn)
			local pName = ToEnumShortString(pn)
			local filterValue = getenv("ScreenFilter"..pName)

			if filterValue ~= nil then
				local val = alphaToChoice[filterValue] or 1
				list[val] = true
			else
				setenv("ScreenFilter"..pName,0)
				list[1] = true
			end
		end,
		SaveSelections = function(self, list, pn)
			local pName = ToEnumShortString(pn)
			local found = false
			for i=1,#list do
				if not found then
					if list[i] == true then
						setenv("ScreenFilter"..pName,choiceToAlpha[i])
						found = true
					end
				end
			end
		end,
	};
	setmetatable(t, t)
	return t
end
local judgmentTransformYs = {
	Standard={normal=-76, reverse=67},
	Old={normal=-30, reverse=30}
}
setmetatable(judgmentTransformYs, {__index=function(this, _) return this.Standard end})

function JudgmentTransformCommand( self, params )
	self:x( 0 )
	self:y( judgmentTransformYs
		[ThemePrefs.Get("JudgmentHeight")]
		[params.bReverse and "reverse" or "normal"] )
end


function PlayerOptionsLines()
	local fixedLines = "2,3,4,5,6,7,10,8,9,11,12,13"
	local speedLine = "1,"
	local modSetting = ThemePrefs.Get "SpeedModSource"
	if modSetting == "custom" then
		speedLine = "1C,"
	elseif modSetting == "arbitrary" then
		speedLine = "1A,"
	end
	return speedLine..fixedLines
end

do
	local function speed_str(name, ...)
		return THEME:GetString("OptionItemExplanations", "Speed"..name):format(...)
	end

	function GetSpeedExplanation(pn)
		local modSetting = ThemePrefs.Get "SpeedModSource"
		if modSetting == "custom" then
			return speed_str("Fallback")
		elseif modSetting == "internal" then
			return nil
		end

		local mmod, cmod, xmod
		local sc = (GAMESTATE:Env()).SpeedChoice

		if sc then
			local our_sc = sc[pn]
			local speed = our_sc.speed
			if our_sc.mode ~= 'x' then
				xmod = 1
				if our_sc.mode == 'm' then
					mmod = speed
					cmod = nil
				else
					cmod = speed
					mmod = nil
				end
			else
				xmod = our_sc.speed/100
				mmod = nil
				cmod = nil
			end
		else
			local po = GAMESTATE:GetPlayerState(pn):GetPlayerOptions('ModsLevel_Current')
			mmod = po:MMod()
			cmod = po:CMod()
			xmod = po:XMod()
		end

		if mmod then
			return speed_str('M', mmod)
		elseif cmod then
			return speed_str('C', cmod)
		else
			if xmod == 1 then
				return speed_str('1x')
			elseif xmod < 1 then
				return speed_str('Lowx',xmod*100)
			else
				local formatted_speed
				if math.floor(xmod) == xmod then
					formatted_speed = tostring(math.floor(xmod))
				elseif math.floor(xmod*10)/10 == xmod then
					formatted_speed = tostring(math.floor(xmod*10)/10)
				else
					formatted_speed = string.format(xmod, "%.2f")
				end
				return speed_str('Highx', formatted_speed)
			end
		end
		return nil
	end
end