local t = Def.ActorFrame{};
local screenName = Var "LoadingScreen"

if screenName == "ScreenSelectMusicRD" then
  t[#t+1] = Def.ActorFrame{
    LoadActor("RD");
  };
else
  t[#t+1] = Def.ActorFrame{
    LoadActor("Normal");
  };
end;

return t
