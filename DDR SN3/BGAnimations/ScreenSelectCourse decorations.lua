-- when they say fallback they mean fallback, as in "sorry, we're going to
-- import the stuff from ScreenSelectMusic decorations anyways" fallback.
local t = LoadFallbackB();

--QUAD THE COURSE LIST BG BECAUSE LOL TOO LAZY TO PHOTOSHOP
--Green stroke because fuck it.
t[#t+1] = Def.Quad{
  InitCommand=cmd(valign,0;setsize,289,300;x,BannerFramePosX()-8;y,SCREEN_CENTER_Y-64;diffuse,color("#06ff00");diffusebottomedge,color("0,0,0,1"));
  OnCommand=cmd(addx,-500;sleep,0.264;decelerate,0.52;addx,500;sleep,0.1;linear,0);
  OffCommand=cmd(sleep,0.033;accelerate,0.33;addx,-500);
};
--The actual black insert.
t[#t+1] = Def.Quad{
  InitCommand=cmd(valign,0;setsize,288,300;x,BannerFramePosX()-8;y,SCREEN_CENTER_Y-64;diffuse,color("0,0,0,1"));
  OnCommand=cmd(addx,-500;sleep,0.264;decelerate,0.52;addx,500;sleep,0.1;linear,0);
  OffCommand=cmd(sleep,0.033;accelerate,0.33;addx,-500);
};
--Gotta love quads man. -Inorizushi

t[#t+1] = StandardDecorationFromFile("BannerFrame","BannerFrame")
t[#t+1] = StandardDecorationFromFile("NumCourseStages","NumCourseStages")
t[#t+1] = StandardDecorationFromFile("CourseTime","CourseTime")

-- course contents list (the worst part)
t[#t+1] = StandardDecorationFromFile("CourseContentsList","CourseContentsList")

return t
