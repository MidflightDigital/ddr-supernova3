local t = Def.ActorFrame{
		--style
	LoadActor(THEME:GetPathG("","_Style/style2"))..{
		InitCommand=cmd(x,SCREEN_LEFT+120;y,SCREEN_CENTER_Y+183);
		OffCommand=cmd(bouncebegin,0.264;zoom,0);
		GainFocusCommand=cmd(bounceend,0.2;zoom,1);
		LoseFocusCommand=cmd(finishtweening;bouncebegin,0.2;zoom,0);
	};
};

if GAMESTATE:IsPlayerEnabled("PlayerNumber_P1") then
t[#t+1] = Def.Model{
	Materials = "../../_Style/(5th) Rage/model.txt";
	Meshes = "../../_Style/(5th) Rage/model.txt";
	Bones = "../../_Style/(5th) Rage/Rest/Rest.redir";
	InitCommand=cmd(vertalign,bottom;x,SCREEN_CENTER_X-164;y,SCREEN_CENTER_Y+92;zoom,12;rotationy,-140;cullmode,'CullMode_None';);
	GainFocusCommand=cmd(visible,true;bounceend,0.2;zoom,12);
	LoseFocusCommand=cmd(finishtweening;bouncebegin,0.2;zoom,0;visible,false);
	OffCommand=cmd(sleep,0.132;accelerate,0.066;zoom,10;decelerate,0.066;zoom,12;accelerate,0.066;zoom,0);
};
else
t[#t+1] = Def.Model{
	Materials = "../../_Style/(5th) Emi/model.txt";
	Meshes = "../../_Style/(5th) Emi/model.txt";
	Bones = "../../_Style/(5th) Emi/Rest/Rest.redir";
	InitCommand=cmd(vertalign,bottom;x,SCREEN_CENTER_X-164;y,SCREEN_CENTER_Y+92;zoom,12;rotationy,-140;cullmode,'CullMode_None';);
	GainFocusCommand=cmd(bounceend,0.2;zoom,12);
	LoseFocusCommand=cmd(finishtweening;bouncebegin,0.2;zoom,0);
	OffCommand=cmd(sleep,0.132;accelerate,0.066;zoom,10;decelerate,0.066;zoom,12;accelerate,0.066;zoom,0);
};
end;

return t;
