local args = {...}
local pss = args[1]

--text for the stage counter
local stage_text
local failed = pss:GetFailed()
local dark_length = 0
if failed then
	local songs_passed = pss:GetSongsPassed()
	if songs_passed < 10 then dark_length = 1 end
	stage_text = string.format("%02d STAGE",pss:GetSongsPassed())
else
	stage_text ="CLEAR"
end


return Def.ActorFrame{
	Def.BitmapText{
		Font="_gotham Bold 18px";
		Text=stage_text;
		InitCommand=function(s) s:y(10):zoom(10/9) end;
		OnCommand=function(s)
			s:AddAttribute(0,
			{Length=dark_length, Diffuse=color "#777777"}
			)
		end;
	};
	Def.BitmapText{
		Font="ScoreDisplayNormal Text";
		InitCommand=function(s) s:y(-10) end;
		Text=SecondsToMMSSMsMs(pss:GetAliveSeconds());
	}	
}