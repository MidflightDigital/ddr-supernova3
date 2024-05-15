local gc = Var("GameCommand");

return Def.ActorFrame {
	Def.Quad{
		InitCommand=cmd(setsize,220,26;x,4;);
		OnCommand=cmd(addx,100;cropleft,0.01;cropright,0.9;sleep,0.2;linear,0.3;cropright,0;faderight,0.2);
		GainFocusCommand=cmd(finishtweening;cropright,1;linear,0.166;diffusealpha,0.5;linear,0.2;cropright,0;);
		LoseFocusCommand=cmd(finishtweening;linear,0.5;diffusealpha,0;);
		OffCommand=cmd(linear,0.3;cropright,1);
	};
	LoadFont("_handelgothic bt 20px") .. {
		Text=gc:GetText(),
		InitCommand=function(self)
			self:uppercase(true):halign(0):zoomy(0.9):zoomx(1):diffusebottomedge(color("#30e823")):strokecolor(color("#000000"))
			if gc:GetText() == "SPECTRAL MASTER MODE" then
				self:zoomy(0.8):zoomx(0.9)
			end;
		end;
		GainFocusCommand=function(self) self:finishtweening():diffuse(color("1,1,1,1")):diffusetopedge(color("#a6f5a1")):diffusebottomedge(color("#30e823"))
    	MESSAGEMAN:Broadcast("TitleSelection", {Choice=gc:GetName()})
		end,
		LoseFocusCommand=function(self) self:stopeffect():diffuse(color("0.5,0.5,0.5,1")) end
	};
	Def.ActorFrame{
		LoadActor("title cursor")..{
			OnCommand=cmd(addx,100;cropright,0.8;sleep,0.2;linear,0.3;cropright,0;faderight,0.2;);
			GainFocusCommand=cmd(finishtweening;cropright,1;addx,-10;linear,0.125;cropright,0;diffusealpha,0.5;addx,10);
			LoseFocusCommand=cmd(finishtweening;linear,0.125;diffusealpha,0);
			OffCommand=cmd(linear,0.3;cropright,1);
		};
	};

};
