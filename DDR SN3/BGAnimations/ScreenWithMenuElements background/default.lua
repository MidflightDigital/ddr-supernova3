local t = Def.ActorFrame{};

local BG = "";

if ThemePrefs.Get("MenuBG") == "SuperNOVA" then
  BG = "SN1"
elseif ThemePrefs.Get("MenuBG") == "SuperNOVA 2" then
  BG = "SN2"
elseif ThemePrefs.Get("MenuBG") == "SuperNOVA 3" then
  BG = "SN3"
elseif ThemePrefs.Get("MenuBG") == "SuperNOVA 3 v2" then
  BG = "SN3V2"
elseif ThemePrefs.Get("MenuBG") == "IIDX SIRIUS" then
  BG = "SIRIUS"
end;

t[#t+1] = Def.ActorFrame{
  LoadActor(BG..".lua");
};

return t
