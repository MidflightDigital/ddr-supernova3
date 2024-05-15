local imagePrefix, speed, isClose, twoPart = ...
if not (imagePrefix	and speed and (isClose~=nil)) then
	Warn("_doors malfunction")
	Warn(debug.traceback())
	error("_doors parameter problem: check the log for a traceback")
end
local coordinates = {
	top = {starting=isClose and SCREEN_TOP-SCREEN_HEIGHT or SCREEN_TOP, ending=isClose and SCREEN_TOP or SCREEN_TOP-SCREEN_HEIGHT },
	bottom = {starting=isClose and SCREEN_BOTTOM+SCREEN_HEIGHT or SCREEN_BOTTOM, ending=isClose and SCREEN_BOTTOM or SCREEN_BOTTOM+SCREEN_HEIGHT }
}
local t = Def.ActorFrame {
	---- DOOR OPEN > CLOSE  CLOSE > OPEN
	Def.ActorFrame{
		LoadActor(THEME:GetPathB("",imagePrefix..'2'))..{
		InitCommand=cmd(y,coordinates.bottom.starting;x,SCREEN_CENTER_X;valign,1);
			OnCommand=function(s)
				if twoPart then
					s:y(coordinates.bottom.starting):accelerate(speed):y(coordinates.bottom.ending)
				else
					s:accelerate(speed):y(coordinates.bottom.ending)
				end
			end;
			OffCommand=function(s)
				if twoPart then
					s:accelerate(speed):y(coordinates.bottom.starting)
				end
			end;
			StartCommand=function(s) s:playcommand("On") end;
			FinishCommand=function(s) s:sleep(2):queuecommand("Off") end;
		};
	};
	Def.ActorFrame{
		LoadActor(THEME:GetPathB("",imagePrefix..'1'))..{
		InitCommand=cmd(y,coordinates.top.starting;x,SCREEN_CENTER_X;valign,0);
			OnCommand=function(s)
				if twoPart then
					s:y(coordinates.top.starting):accelerate(speed):y(coordinates.top.ending)
				else
					s:accelerate(speed):y(coordinates.top.ending)
				end
			end;
			OffCommand=function(s)
				if twoPart then
					s:accelerate(speed):y(coordinates.top.starting)
				end
			end;
			StartCommand=function(s) s:queuecommand("On") end;
			FinishCommand=function(s) s:sleep(2):queuecommand("Off") end;
		};
	};
};

return t
