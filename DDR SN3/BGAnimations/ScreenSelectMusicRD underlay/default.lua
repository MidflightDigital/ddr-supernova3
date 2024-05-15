local t = Def.ActorFrame{};

t[#t+1] = Def.ActorFrame{
  LoadActor(THEME:GetPathS("","_RD (loop)"))..{
    OnCommand=cmd(play);
  };

};

return t;
