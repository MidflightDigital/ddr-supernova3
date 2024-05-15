local t = Def.ActorFrame {
  Def.Sprite{
  	Texture="MusicWheelItem Song NormalPart/Normal/new 2x1 (doubleres).png";
  	InitCommand=cmd(finishtweening;draworder,1);
  	OnCommand=function(self)
      self:diffusealpha(0):sleep(1):diffusealpha(1)
      if ThemePrefs.Get("LightMode") == true then
        self:pause()
      end;
    end;
  };
};

return t;
