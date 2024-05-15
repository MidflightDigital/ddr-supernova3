local screenName = Var "LoadingScreen"

local footerBaseImage

if screenName == "ScreenSelectProfile" or screenName == "ScreenDataSaveSummary" then
  footerBaseImage = "centered (doubleres).png"
elseif screenName == "ScreenSelectMusicRD" then
  footerBaseImage = "RDbase (doubleres).png"
else
  footerBaseImage = "rightbiased (doubleres).png"
end

local t = Def.ActorFrame{
  LoadActor(footerBaseImage)..{
    OnCommand=function(self)
      if screenName == "ScreenSelectProfile" or screenName == "ScreenDataSaveSummary"
      or screenName == "ScreenSelectMusicRD" then
        self:x(SCREEN_CENTER_X):halign(0.5);
      else
        self:x(SCREEN_RIGHT):halign(1);
      end;
    end;
  };
};

if ThemePrefs.Get("LightMode") == false then
t[#t+1] = Def.ActorFrame{
  LoadActor("rightglow")..{
    OnCommand=function(self)
      if screenName == "ScreenSelectProfile" or screenName == "ScreenDataSaveSummary"
      or screenName == "ScreenSelectMusicRD" then
        self:cropleft(1)
      else
        self:x(SCREEN_RIGHT):halign(1):cropleft(1):sleep(1):queuecommand("Animate"):draworder(100);
      end;
    end;
		AnimateCommand=cmd(decelerate,0.1;cropright,0;cropleft,1;decelerate,0.8;cropleft,0;sleep,0.5;decelerate,0.8;cropright,1;sleep,0.5;queuecommand,"Animate");
		OffCommand=cmd(finishtweening);
	};
};
end;

if screenName == "ScreenSelectStyle" or screenName == "ScreenSelectPlayMode" then
t[#t+1] = Def.ActorFrame{
  LoadActor(THEME:GetPathG("","_footer/con-sel.lua"));
};
end

if screenName == "ScreenSelectMusic" or screenName == "ScreenSelectMusicExtra" or screenName == "ScreenSelectMusicStarter" then
t[#t+1] = Def.ActorFrame{
  LoadActor(THEME:GetPathG("","_footer/MusSel.lua"));
};
end

if screenName == "ScreenNetEvaluation" or string.find(screenName,"ScreenEvaluation") then
t[#t+1] = Def.ActorFrame{
  LoadActor(THEME:GetPathG("","_footer/skip.lua"));
};
end

return t;
