local t = Def.ActorFrame{
  LoadActor("closed")..{
    InitCommand=cmd(Center);
  };
  LoadFont("_handelgothic bt 20px")..{
    InitCommand=cmd(zoom,1.2;settext,"Select Your Fantasy\n- aston crowe";halign,1;x,SCREEN_RIGHT-40;y,SCREEN_TOP+40);
  };
};

return t;
