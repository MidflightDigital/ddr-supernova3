--[[local t = Def.ActorFrame {
	LoadActor(("../../cleared"))..{
		StartTransitioningCommand=cmd(play);
	};

	---- DOOR OPEN > CLOSE  CLOSE > OPEN
	LoadActor(THEME:GetPathB("","Door1"))..{
		InitCommand=cmd(x,SCREEN_CENTER_X-SCREEN_WIDTH;CenterY;halign,1);
		OnCommand=cmd(sleep,1.3;linear,1;x,SCREEN_CENTER_X+51;sleep,4.7);
	};
	LoadActor(THEME:GetPathB("","Door2"))..{
		InitCommand=cmd(x,SCREEN_CENTER_X+SCREEN_WIDTH;CenterY;halign,0);
		OnCommand=cmd(sleep,1.3;linear,1;x,SCREEN_CENTER_X-51;sleep,4.7);
	};
};]]

local t = LoadActor(THEME:GetPathB("","_doors"), "_newer door", 1.5, true )
t[#t+1] = LoadActor(("../cheer"))..{
	StartTransitioningCommand=cmd(play);
};
t[#t+1] = LoadActor(("../../cleared"))..{
	StartTransitioningCommand=cmd(play);
};


if not (GAMESTATE:Env()).EndlessState then
	t[#t+1] = Def.ActorFrame{
		Def.Sprite{
			InitCommand=cmd(Center);
			SetCommand=function(self)
				if GAMESTATE:IsCourseMode() then
					song = GAMESTATE:GetCurrentCourse();
				else
					song = GAMESTATE:GetCurrentSong();
				end;
				if song:GetDisplayFullTitle() == "Tohoku EVOLVED" or song:GetDisplayFullTitle() == "Istanbul EVOLVED" then
					self:Load(THEME:GetPathB ("","ScreenGameplay out/normal/pray for all"));
				else
					self:Load(THEME:GetPathB ("","ScreenGameplay out/normal/cleared"));
				end;
			end;
		OnCommand=function(self)
			self:queuecommand("Set")
			self:diffusealpha(0):sleep(0.5):
			zoomy(0):zoomx(4):linear(0.198):
			diffusealpha(1):zoomy(1):zoomx(1):
			sleep(4.7):linear(0.132):
			zoomy(0):zoomx(4):diffusealpha(0)
		end;
		};
	};
end

return t
