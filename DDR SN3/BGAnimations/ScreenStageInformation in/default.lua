local t = Def.ActorFrame{}

if IsRDG() then
  t[#t+1] = LoadActor("rdg");
else
  t[#t+1] = LoadActor("normal");
end;

return t;
