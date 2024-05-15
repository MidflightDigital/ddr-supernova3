local t = Def.ActorFrame{};

t[#t+1] = Def.ActorFrame {
	-- Information panel
	Def.Sprite{
		InitCommand=cmd(halign,0;x,WideScale(SCREEN_LEFT,SCREEN_LEFT+80);y,SCREEN_BOTTOM-80);
		OnCommand=function(self)
			if GAMESTATE:GetNumPlayersEnabled() ~= 2 then
				self:Load(THEME:GetPathG("ScreenSelectPlayMode Icon","ChoiceBattle/cpu"));
			else
				self:Load(THEME:GetPathG("ScreenSelectPlayMode Icon","ChoiceBattle/vs"));
			end;
		end;
		GainFocusCommand=function(s) MESSAGEMAN:Broadcast("PlayBattle") s:visible(true):addx(-11):decelerate(0.1):addx(11) end,
		LoseFocusCommand=cmd(visible,false);
		OffCommand=cmd(linear,0.133;addx,SCREEN_WIDTH);
	};
};

if GAMESTATE:GetNumPlayersEnabled() ~= 2 then
t[#t+1] = Def.ActorFrame {
	LoadActor("tip")..{
		InitCommand=cmd(x,WideScale(SCREEN_CENTER_X+20,SCREEN_CENTER_X-5);y,SCREEN_BOTTOM-80;);
		GainFocusCommand=cmd(zoomx,0;zoomy,0;visible,true;linear,0.05;zoomx,1;sleep,0.2;linear,0.1;zoomy,1;glowshift;effectcolor1,color("1,1,1,0.2");effectcolor2,color("0,0,0,0");effectperiod,1);
		LoseFocusCommand=cmd(visible,false);
		OffCommand=cmd(linear,0.133;addx,SCREEN_WIDTH);
	};
};
end;

return t;
