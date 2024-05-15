local masterPlayer = ToEnumShortString(GAMESTATE:GetMasterPlayerNumber())

local t = Def.ActorFrame{
	-- Panel
	LoadActor(THEME:GetPathG("","_Style/_panel2 (doubleres)"))..{
		InitCommand=cmd(x,SCREEN_CENTER_X-402;y,SCREEN_CENTER_Y+32);
        OnCommand=cmd(zoom,0;diffusealpha,0;sleep,0.264;sleep,0.792;sleep,0.132;diffusealpha,1;decelerate,0.066;zoom,1;accelerate,0.066;zoom,0.8;decelerate,0.066;zoom,1);
		PadsOneMessageCommand=function(s) s:linear(0.1):x(SCREEN_CENTER_X-627):y(SCREEN_CENTER_Y-17) lastPad2=1 end;
		PadsTwoMessageCommand=function(s) s:linear(0.1):x(SCREEN_CENTER_X-207):y(SCREEN_CENTER_Y+71) lastPad2=2 end;
		OffCommand=cmd(sleep,0.264;accelerate,0.066;zoom,0.8;decelerate,0.066;zoom,1;accelerate,0.066;zoom,0);
	};
	LoadActor(THEME:GetPathG("","_Style/_panel (doubleres)"))..{
		InitCommand=cmd(x,SCREEN_CENTER_X-112;y,SCREEN_CENTER_Y+119;);
		OnCommand=cmd(zoom,0;diffusealpha,0;sleep,0.264;sleep,0.792;sleep,0.132;diffusealpha,1;decelerate,0.066;zoom,1;accelerate,0.066;zoom,0.8;decelerate,0.066;zoom,1);
        PadsOneMessageCommand=function(s) s:linear(0.1):x(SCREEN_CENTER_X-142):y(SCREEN_CENTER_Y+109) end;
        PadsTwoMessageCommand=function(s) s:linear(0.1):x(SCREEN_CENTER_X-112):y(SCREEN_CENTER_Y+119) end;
		OffCommand=cmd(sleep,0.264;accelerate,0.066;zoom,0.8;decelerate,0.066;zoom,1;accelerate,0.066;zoom,0);
	};

	--style
	LoadActor(THEME:GetPathG("","_Style/style1"))..{
		InitCommand=cmd(x,SCREEN_LEFT+120;y,SCREEN_CENTER_Y+183);
		OnCommand=cmd(zoom,0;sleep,0.264;bounceend,0.264;zoom,1);
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
	InitCommand=cmd(x,SCREEN_CENTER_X-140;y,SCREEN_CENTER_Y+96;zoom,12;rotationy,-140;cullmode,'CullMode_None';);
	OnCommand=function(self)
		if not GAMESTATE:IsHumanPlayer(PLAYER_2) then
			self:valign(1):draworder(90):diffusealpha(0):zoom(0):sleep(0.264):sleep(0.792):sleep(0.264):sleep(0.132):
			diffusealpha(1):decelerate(0.066):zoom(12):accelerate(0.066):zoom(10):decelerate(0.066):zoom(12);
		end;
	end;
	GainFocusCommand=cmd(bounceend,0.2;zoom,12);
	LoseFocusCommand=cmd(finishtweening;bouncebegin,0.2;zoom,0);
	OffCommand=cmd(sleep,0.132;accelerate,0.066;zoom,10;decelerate,0.066;zoom,12;accelerate,0.066;zoom,0);
};
else
t[#t+1] = Def.Model{
	Materials = "../../_Style/(5th) Emi/model.txt";
	Meshes = "../../_Style/(5th) Emi/model.txt";
	Bones = "../../_Style/(5th) Emi/Rest/Rest.redir";
	InitCommand=cmd(x,SCREEN_CENTER_X-140;y,SCREEN_CENTER_Y+96;zoom,12;rotationy,-140;cullmode,'CullMode_None';);
	OnCommand=function(self)
		if not GAMESTATE:IsHumanPlayer(PLAYER_1) then
			self:valign(1):draworder(90):diffusealpha(0):zoom(0):sleep(0.264):sleep(0.792):sleep(0.264):sleep(0.132):
			diffusealpha(1):decelerate(0.066):zoom(12):accelerate(0.066):zoom(10):decelerate(0.066):zoom(12);
		end;
	end;	GainFocusCommand=cmd(bounceend,0.2;zoom,12);
	LoseFocusCommand=cmd(finishtweening;bouncebegin,0.2;zoom,0);
	OffCommand=cmd(sleep,0.132;accelerate,0.066;zoom,10;decelerate,0.066;zoom,12;accelerate,0.066;zoom,0);
};
end;

return t;
