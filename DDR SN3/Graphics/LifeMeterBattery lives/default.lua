-- xxx: needs editing for flashing
local player = Var "Player"
local curLives = nil
local lastLives = nil

local stream = "normal"
local lives = GAMESTATE:GetPlayerState(player):GetPlayerOptions('ModsLevel_Current'):BatteryLives()

if lives >= 4 then
	stream = "hot"
elseif lives == 1 then
	stream = "danger"
end

local t = Def.ActorFrame {};

t[#t+1] = Def.ActorFrame{
-- Battery full line
	LoadActor(THEME:GetPathG("","StreamDisplay " .. stream ))..{
		InitCommand=function(self)
			self:texcoordvelocity(0.8,0)
			self:setsize((SCREEN_WIDTH/2.53),13)
			self:skewx(-0.9)
		end;
		LifeChangedMessageCommand=function(self,params)
			if params.LostLife and params.Player == player then
				if params.LivesLeft == 1 then
					self:Load(THEME:GetPathG("StreamDisplay","danger"))
				elseif params.LivesLeft < 4 then
					self:Load(THEME:GetPathG("StreamDisplay","normal"))
				end
			end
		end;
	};
	-- 4 Battery empty red
	Def.Quad{
		InitCommand=function(self)
			self:diffusetopedge(color("#707171"));
			self:diffusebottomedge(color("#404040"));
			self:halign(1);
			self:skewx(-0.9);
			self:x(SCREEN_WIDTH/5);
		end;
		BeginCommand=function(self,params)
			self:setsize((SCREEN_WIDTH/10.12)*(4-math.min(4,lives)), 13);
		end;
		LifeChangedMessageCommand=function(self,params)
			if params.Player ~= player then return end;
			if not params.LostLife then return end;
			self:finishtweening();
			self:linear(0);
			self:diffusetopedge(color("#5d1115"));
			self:diffusebottomedge(color("#f50d0d"));
			self:setsize((SCREEN_WIDTH/10.12)*(4-math.min(4,params.LivesLeft)), 13);
			self:linear(0.33);
			self:diffusetopedge(color("#707171"));
			self:diffusebottomedge(color("#404040"));
		end;
	};
};
return t;
