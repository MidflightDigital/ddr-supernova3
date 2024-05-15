--The bannerframe is the banner, the frame that contains it, and graphics
--that should be overlaid on it. This is used for course and normal eval.
local xy = {...}
return Def.ActorFrame{
	InitCommand=function(s) s:xy(unpack(xy)) end; 
	OnCommand=cmd(zoomy,0;sleep,0.25;linear,0.15;zoomy,1);
	OffCommand=cmd(linear,0.15;zoomy,0);
	Def.Sprite{Texture=THEME:GetPathG("ScreenEvaluationNew", "bannerframe");};
	Def.Banner{
		InitCommand=function(s)
			if not GAMESTATE:IsCourseMode() then
				s:LoadFromSong(GAMESTATE:GetCurrentSong())
			else
				s:LoadFromCourse(GAMESTATE:GetCurrentCourse())
			end
			s:y(-10.5):setsize(256,80) 
		end
	}
}