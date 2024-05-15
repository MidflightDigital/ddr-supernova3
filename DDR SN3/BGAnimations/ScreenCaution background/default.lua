local t = Def.ActorFrame{};

t[#t+1] = Def.ActorFrame {
	Def.Sprite{
		InitCommand=cmd(Center);
		OnCommand=function(self)
			if GAMESTATE:GetCoinMode() == "CoinMode_Home" then
				self:Load(THEME:GetPathB("","ScreenCaution background/home"));
			else
				self:Load(THEME:GetPathB("","ScreenCaution background/arcade"));
			end;
			self:diffusealpha(1):sleep(2):linear(0.165):diffusealpha(0);
		end;
	};
};

return t;
