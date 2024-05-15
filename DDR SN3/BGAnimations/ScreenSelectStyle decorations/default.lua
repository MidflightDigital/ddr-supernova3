local t = LoadFallbackB()

t[#t+1] = Def.Sprite{
	InitCommand=cmd(halign,1;x,SCREEN_RIGHT+2;y,SCREEN_CENTER_Y-75);
	OnCommand=function(s) s:addx(379):sleep(0.264):decelerate(0.264):addx(-379):decelerate(0.1):addx(11) end;
	Anim1Command=function(s) s:addx(-11) end,
	Anim2Command=function(s) s:decelerate(0.1):addx(11) end,
	PadsOneMessageCommand=function(s)
		s:queuecommand("Anim1"):Load(THEME:GetPathG("","ScreenSelectStyle Scroller/single (doubleres).png")):queuecommand("Anim2") end;
	PadsTwoMessageCommand=function(s)
		s:queuecommand("Anim1"):Load(THEME:GetPathG("","ScreenSelectStyle Scroller/versus (doubleres).png")):queuecommand("Anim2") end;
	PadsDoubleMessageCommand=function(s)
		s:queuecommand("Anim1"):Load(THEME:GetPathG("","ScreenSelectStyle Scroller/double (doubleres).png")):queuecommand("Anim2") end;
	OffCommand=cmd(decelerate,0.264;addx,(SCREEN_WIDTH)+440);
};

return t
