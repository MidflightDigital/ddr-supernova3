local t = Def.ActorFrame{
};

t[#t+1] = Def.ActorFrame{
  LoadActor("p1_cursor")..{
    OnCommand=cmd(zoomy,0;sleep,0.283;linear,0.116;zoomy,1);
    OffCommand=cmd(zoomy,1;linear,0.116;zoomy,0);
  };
};

return t;
