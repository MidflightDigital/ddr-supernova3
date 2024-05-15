local t = Def.ActorFrame{
	-- Picture
	Def.Model{
		Materials = "../../_Style/(5th) Rage/model.txt";
		Meshes = "../../_Style/(5th) Rage/model.txt";
		Bones = "../../_Style/(5th) Rage/Rest/Rest.redir";
		InitCommand=cmd(vertalign,bottom;x,SCREEN_CENTER_X-210;y,SCREEN_CENTER_Y+74;zoom,12;rotationy,-140;cullmode,'CullMode_Front';);
		OnCommand=function(self)
			if GAMESTATE:IsHumanPlayer(PLAYER_2) then
				self:draworder(90):diffusealpha(0):zoom(0):sleep(0.264):sleep(0.792):sleep(0.264):sleep(0.132):diffusealpha(1):decelerate(0.066):zoom(12):accelerate(0.066):zoom(10):decelerate(0.066):zoom(12);
			else
				self:visible(false);
			end;
		end;
		GainFocusCommand=cmd(visible,true;bounceend,0.2;zoom,12);
		LoseFocusCommand=cmd(finishtweening;bouncebegin,0.2;zoom,0;visible,false);
		OffCommand=cmd(sleep,0.132;accelerate,0.066;zoom,10;decelerate,0.066;zoom,12;accelerate,0.066;zoom,0);
	};
	Def.Model{
		Materials = "../../_Style/(5th) Emi/model.txt";
		Meshes = "../../_Style/(5th) Emi/model.txt";
		Bones = "../../_Style/(5th) Emi/Rest/Rest.redir";
		InitCommand=cmd(vertalign,bottom;x,SCREEN_CENTER_X-110;y,SCREEN_CENTER_Y+115;zoom,12;rotationy,-140;cullmode,'CullMode_None';);
		OnCommand=function(self)
			if GAMESTATE:IsHumanPlayer(PLAYER_2) then
				self:draworder(90):diffusealpha(0):zoom(0):sleep(0.264):sleep(0.792):sleep(0.264):sleep(0.132):diffusealpha(1):decelerate(0.066):zoom(12):accelerate(0.066):zoom(10):decelerate(0.066):zoom(12);
			else
				self:visible(false);
			end;
		end;
		GainFocusCommand=cmd(visible,true;bounceend,0.2;zoom,12);
		LoseFocusCommand=cmd(finishtweening;bouncebegin,0.2;zoom,0;visible,false);
		OffCommand=cmd(sleep,0.132;accelerate,0.066;zoom,10;decelerate,0.066;zoom,12;accelerate,0.066;zoom,0);
	};
		--style
	LoadActor(THEME:GetPathG("","_Style/style2"))..{
		InitCommand=cmd(x,SCREEN_LEFT+120;y,SCREEN_CENTER_Y+183);
		OffCommand=cmd(bouncebegin,0.264;zoom,0);
		GainFocusCommand=cmd(bounceend,0.2;zoom,1);
		LoseFocusCommand=cmd(finishtweening;bouncebegin,0.2;zoom,0);
	};
};

return t;
