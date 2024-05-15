
local t = Def.ActorFrame{
  --[[Def.Quad{
    InitCommand=cmd(setsize,SCREEN_WIDTH-20,5;CenterX;y,SCREEN_CENTER_Y;fadeleft,0.5;faderight,0.5;diffuse,color("0,0,0,1"));
    OnCommand=cmd(zoomx,0;sleep,0.5;decelerate,0.4;zoomx,1);
    OffCommand=cmd(sleep,0.2;decelerate,0.2;zoomx,0);
  };
  LoadActor("backer")..{
    InitCommand=cmd(Center);
    OnCommand=cmd(zoomy,0;decelerate,0.4;zoomy,1);
    OffCommand=cmd(sleep,0.2;decelerate,0.2;zoomy,0);
  };]]--
  --[[LoadActor("style mockup")..{
    InitCommand=cmd(Center);
  };]]--
  
};

return t;
