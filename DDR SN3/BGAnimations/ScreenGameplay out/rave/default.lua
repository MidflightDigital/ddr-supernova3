local t = LoadActor(THEME:GetPathB("","_doors"), "_newer door", 1.5, true )
t[#t+1] = LoadActor(("../cheer"))..{
	StartTransitioningCommand=cmd(play);
};
t[#t+1] = LoadActor(("../../cleared"))..{
	StartTransitioningCommand=cmd(play);
};

t[#t+1] = Def.ActorFrame{
	Def.Sprite{
		InitCommand=cmd(Center);
		SetCommand=function(self)
			if GAMESTATE:IsWinner(PLAYER_1) then
				self:Load(THEME:GetPathB ("","ScreenGameplay out/rave/p1"))
			elseif GAMESTATE:IsWinner("PlayerNumber_P2") then
				self:Load(THEME:GetPathB ("","ScreenGameplay out/rave/p2"))
			elseif GAMESTATE:IsDraw() then
				self:Load(THEME:GetPathB ("","ScreenGameplay out/rave/draw"))
			end;
		end;
	OnCommand=function(self)
		self:queuecommand("Set")
			self:diffusealpha(0):sleep(0.5):
			zoomy(0):zoomx(4):linear(0.198):
			diffusealpha(1):zoomy(1):zoomx(1):
			sleep(2.604):linear(0.132):
			zoomy(0):zoomx(4):diffusealpha(0)
	end;
	};
};

return t