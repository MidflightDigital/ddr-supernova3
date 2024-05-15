return Def.ActorFrame{
	BeginCommand=cmd(playcommand,"Set";);
	CurrentSongChangedMessageCommand=cmd(finishtweening;playcommand,"Set";);
	LoadActor( THEME:GetPathG("ScreenWithMenuElements","StageDisplay/"..STATSMAN:GetCurStageStats():GetStage().." (doubleres)") )
};