--Special Features for SuperNOVA styled themes (Inorizushi)

--SelectMusic Positions

function WideSSM()
  if Var "LoadingScreen" == "ScreenSelectMusicExtra" then
    return true
  end
  return ThemePrefs.Get("XStyledMusicSelect") == "Wide Style"
end

SelectMusicXPositions =
{
  Style = {SCREEN_LEFT+30, SCREEN_CENTER_X-290},
  Shock = {SCREEN_LEFT+152, SCREEN_CENTER_X-168},
  Diff = {SCREEN_LEFT+122, SCREEN_CENTER_X-198},
  DiffBG = {SCREEN_LEFT+165, SCREEN_CENTER_X-155},
  ModP1 = {SCREEN_LEFT+109, SCREEN_CENTER_X-211},
  ModP2 = {SCREEN_LEFT+300, SCREEN_CENTER_X-20},
  Grades = {SCREEN_RIGHT-40, SCREEN_CENTER_X+280},
  Banner = {SCREEN_LEFT+141, SCREEN_CENTER_X - 179},
  BannerFrame = {SCREEN_LEFT+152, SCREEN_CENTER_X - 168},
  CD = {SCREEN_LEFT+250, SCREEN_CENTER_X-70},
  Stage = {SCREEN_LEFT+162, SCREEN_CENTER_X-158},
  BPMNum = {SCREEN_LEFT+256, SCREEN_CENTER_X-64},
  BPMMeter = {SCREEN_LEFT+283, SCREEN_CENTER_X-37},
  Radar = {SCREEN_LEFT + 144, SCREEN_CENTER_X-176},
  NewSong = {SCREEN_RIGHT-304, SCREEN_CENTER_X+16},
  Balloon = {SCREEN_RIGHT-240, SCREEN_CENTER_X+80},
  Wheel = {SCREEN_RIGHT-166, SCREEN_CENTER_X+154},
  EditWindow = {SCREEN_RIGHT-188, SCREEN_CENTER_X+172},
  WheelBG = {SCREEN_RIGHT, SCREEN_CENTER_X+380},
  HighlightBG = {SCREEN_RIGHT, SCREEN_CENTER_X+320}
}

for name, entry in pairs(SelectMusicXPositions) do
  _G[name.."PosX"] = function()
    return WideSSM() and entry[1] or entry[2]
  end
end

function RadarPosX()
  if Var "LoadingScreen" == "ScreenSelectMusicExtra" then
    return SCREEN_LEFT + 139
  else
    local entry = SelectMusicXPositions.Radar
    return WideSSM() and entry[1] or entry[2]
  end
end

function WheelScrollOn(self)
  local DO = 99
  if ThemePrefs.Get("XStyledMusicSelect") == "Wide Style" then
    self:draworder(DO)
    self:x(156)
  else
    self:draworder(DO)
    self:x(263)
  end
end
