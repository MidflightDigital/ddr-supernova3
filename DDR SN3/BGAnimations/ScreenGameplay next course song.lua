-- BeforeLoadingNextCourseSongMessageCommand
-- StartCommand
-- ChangeCourseSongInMessageCommand
-- ChangeCourseSongOutMessageCommand
-- FinishCommand

local sStage = GAMESTATE:GetCurrentStage();
local tRemap = {
	Stage_1st		= 1,
	Stage_2nd		= 2,
	Stage_3rd		= 3,
	Stage_4th		= 4,
	Stage_5th		= 5,
	Stage_6th		= 6,
};

if tRemap[sStage] == PREFSMAN:GetPreference("SongsPerPlay") then
	sStage = "Stage_Final";
else
	sStage = sStage;
end;

return Def.ActorFrame {
	LoadActor(("failed"))..{
		ChangeCourseSongInMessageCommand=cmd(queuecommand,("Play"));
		PlayCommand=cmd(play;);
	};
	LoadActor(THEME:GetPathB("","_doors"), "_newer door", 0.2, true, true );
	LoadActor(THEME:GetPathG("","ScreenEvaluation bannerframe (doubleres)"))..{
		InitCommand=cmd(CenterX;y,SCREEN_CENTER_Y-124);
		ChangeCourseSongInMessageCommand=cmd(zoomy,0;sleep,0.099;sleep,0.396;linear,0.099;zoomy,1;);
		FinishCommand=cmd(sleep,2;linear,0.099;zoomy,0);
	};
	Def.Sprite{
		InitCommand=cmd(CenterX;y,SCREEN_CENTER_Y-130;scaletoclipped,256,80);
		BeforeLoadingNextCourseSongMessageCommand=function(self)
			self:LoadFromSongBanner( SCREENMAN:GetTopScreen():GetNextCourseSong() )
		end;
		StartCommand=function(self)
			self:zoomy(0):sleep(0.099):sleep(0.396):linear(0.099):zoomy(1)
		end;
		FinishCommand=cmd(sleep,2;linear,0.099;zoomy,0);
	};
	LoadActor("ScreenStageInformation in/bottom_stage")..{
		InitCommand=cmd(CenterX;y,SCREEN_BOTTOM+27);
		ChangeCourseSongInMessageCommand=cmd(finishtweening;sleep,0.396;linear,0.198;addy,-54);
		FinishCommand=cmd(sleep,2;linear,0.198;addy,54);
	};
	LoadActor("ScreenStageInformation in/top_stage")..{
		InitCommand=cmd(CenterX;y,SCREEN_TOP-66);
		ChangeCourseSongInMessageCommand=cmd(finishtweening;sleep,0.396;linear,0.198;addy,104);
		FinishCommand=cmd(sleep,2;linear,0.198;addy,-104);
	};
	LoadActor( THEME:GetPathG("_Stages/ScreenStageInformation", "Stage " .. ToEnumShortString(sStage) ) ) .. {
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y);
		ChangeCourseSongInMessageCommand=cmd(diffusealpha,0;sleep,0.396;diffusealpha,1);
		FinishCommand=cmd(sleep,2;diffusealpha,0);
	};
	-- Ready
	LoadActor(THEME:GetPathB("ScreenGameplay","ready/ready")) .. {
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;diffusealpha,0);
		ChangeCourseSongInMessageCommand=cmd(diffusealpha,0;);
		FinishCommand = cmd(sleep,2.2;diffusealpha,0;zoomx,4;zoomy,0;accelerate,0.09;zoomx,1;zoomy,1;diffusealpha,1;sleep,1;accelerate,0.132;zoomx,4;zoomy,0;diffusealpha,0);
	};
	--go
	LoadActor(THEME:GetPathB("ScreenGameplay","go/go")) .. {
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;diffusealpha,0);
		ChangeCourseSongInMessageCommand=cmd(diffusealpha,0;);
		FinishCommand = cmd(sleep,3.5;diffusealpha,0;zoomx,4;zoomy,0;accelerate,0.132;zoomx,1;zoomy,1;diffusealpha,1;sleep,1;accelerate,0.132;zoomx,4;zoomy,0;diffusealpha,0);
	};
};
