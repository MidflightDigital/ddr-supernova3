return Def.ActorFrame {
	Def.Quad{
		InitCommand=cmd(FullScreen;diffuse,color("0,0,0,1"));
		OnCommand=cmd(diffusealpha,0;linear,0.5;diffusealpha,0.5);
		OffCommand=cmd(linear,0.5;diffusealpha,0);
	};
	LoadActor( THEME:GetPathG("ScreenWithMenuElements","header/regular/new"))..{
		InitCommand=cmd(x,SCREEN_LEFT;halign,0;y,SCREEN_TOP+38);
		OffCommand=cmd(diffusealpha,0)
	};
	LoadActor( THEME:GetPathG("ScreenWithMenuElements","footer/rightbiased"))..{
		InitCommand=cmd(x,SCREEN_RIGHT;halign,1;y,SCREEN_BOTTOM-26);
		OffCommand=cmd(diffusealpha,0)
	};
	LoadActor(THEME:GetPathG("","_footer/con-sel.lua"))..{
		InitCommand=cmd(y,SCREEN_BOTTOM-36);
		OffCommand=cmd(diffusealpha,0)
	};
	LoadActor( THEME:GetPathG("ScreenWithMenuElements","header/regular/grid"))..{
		InitCommand=cmd(blend,Blend.Add;;diffuse,color("#044600");diffusealpha,0.2;x,SCREEN_LEFT;halign,0;y,SCREEN_TOP+38);
		OffCommand=cmd(diffusealpha,0)
	};
	LoadActor( THEME:GetPathG("ScreenWithMenuElements","header/regular/glow"))..{
		InitCommand=cmd(x,SCREEN_LEFT;halign,0;y,SCREEN_TOP+38);
		OnCommand=cmd(cropright,1;sleep,1;queuecommand,"Animate";draworder,100);
		AnimateCommand=cmd(decelerate,0.1;cropleft,0;cropright,1;decelerate,0.8;cropright,0;sleep,0.5;decelerate,0.8;cropleft,1;sleep,0.5;queuecommand,"Animate");
		OffCommand=cmd(finishtweening;diffusealpha,0);
	};
	LoadActor( THEME:GetPathG("ScreenWithMenuElements","header/Options"))..{
		InitCommand=cmd(x,SCREEN_LEFT+123;valign,1;y,SCREEN_TOP+38+8;zoom,1.01);
		OffCommand=cmd(diffusealpha,0)
	};
	--p1
	LoadActor( "../ScreenPlayerOptions underlay/Back" )..{
		InitCommand=cmd(Center;zoomto,SCREEN_WIDTH,480);
		OnCommand=cmd(addx,-SCREEN_WIDTH;sleep,0.5;accelerate,0.5;addx,SCREEN_WIDTH);
		OffCommand=cmd(sleep,0.2;accelerate,0.5;addx,SCREEN_WIDTH);
	};
	LoadActor( "../ScreenPlayerOptions underlay/Explanation" )..{
		InitCommand=cmd(visible,GAMESTATE:IsHumanPlayer(PLAYER_1);x,SCREEN_CENTER_X-300;y,SCREEN_CENTER_Y+150;halign,0);
		OnCommand=cmd(addx,-SCREEN_WIDTH;sleep,0.5;accelerate,0.5;addx,SCREEN_WIDTH);
		OffCommand=cmd(sleep,0.2;accelerate,0.5;addx,SCREEN_WIDTH);
	};
	--p2
	LoadActor( "../ScreenPlayerOptions underlay/Explanation" )..{
		InitCommand=cmd(visible,GAMESTATE:IsHumanPlayer(PLAYER_2);x,SCREEN_CENTER_X+300;y,SCREEN_CENTER_Y+150;halign,0;zoomx,-1);
		OnCommand=cmd(addx,-SCREEN_WIDTH;sleep,0.5;accelerate,0.5;addx,SCREEN_WIDTH);
		OffCommand=cmd(sleep,0.2;accelerate,0.5;addx,SCREEN_WIDTH);
	};
}
