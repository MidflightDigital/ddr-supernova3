local t = Def.ActorFrame{};

t[#t+1] = Def.ActorFrame {
	Def.ActorFrame{
    LoadActor("star")..{
  		InitCommand=cmd(Center;zoomtowidth,SCREEN_WIDTH;zoomtoheight,SCREEN_HEIGHT);
  		OnCommand=function(self)
  			local w = DISPLAY:GetDisplayWidth() / self:GetWidth();
  			local h = DISPLAY:GetDisplayHeight() / self:GetHeight();
  			self:customtexturerect(0,0,w*0.5,h*0.5);
  			self:texcoordvelocity(0,0.5);
  			self:diffusealpha(0.3);
        self:diffuse(color("0.5,0.9,1,0.3"));
  		end;
  	};
	};
};

return t;
