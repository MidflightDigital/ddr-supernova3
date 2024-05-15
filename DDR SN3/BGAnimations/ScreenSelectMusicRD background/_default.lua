local t = Def.ActorFrame{};

t[#t+1] = Def.ActorFrame{
  LoadActor("tunnel15")..{
    InitCommand=cmd(FullScreen);
  };
};

return t;
