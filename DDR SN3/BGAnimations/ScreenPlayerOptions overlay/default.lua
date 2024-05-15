local MenuState = {
	PlayerNumber_P1 = {
		CurIndex = 1,
	},
	PlayerNumber_P2 = {
		CurIndex = 1,
	},
};

-- Change PlayMode CurIndex
local function MinusCurIndex()
	local minus = 0;
	if GAMESTATE:GetPlayMode() == "PlayMode_Oni" or GAMESTATE:GetPlayMode() == "PlayMode_Rave" then
		minus = 8;
	elseif GAMESTATE:GetPlayMode() == "PlayMode_Nonstop" or GAMESTATE:GetPlayMode() == "PlayMode_Endless" then
		minus = 1;
	end;
	return minus;
end;
local bMinusCurIndex = MinusCurIndex();

-- Change PlayMode CurIndex2
local function MinusCurIndex2()
	local minus = 0;
	if GAMESTATE:GetPlayMode() == "PlayMode_Oni" or GAMESTATE:GetPlayMode() == "PlayMode_Rave" then
		minus = 7;
	elseif GAMESTATE:GetPlayMode() == "PlayMode_Nonstop" or GAMESTATE:GetPlayMode() == "PlayMode_Endless" then
		minus = 0;
	end;
	return minus;
end;
local bMinusCurIndex2 = MinusCurIndex2();


local t = Def.ActorFrame {
  OffCommand=cmd(accelerate,0.25;addx,WideScale(SCREEN_WIDTH+50,SCREEN_WIDTH));
	MenuInputMessageCommand=function(self,params)
		if GAMESTATE:IsHumanPlayer(params.Player) then
			local curIndex = MenuState[params.Player].CurIndex
		--	StartButton is not work. (SM5b1a)
			if params.Input == "Up" then
				if curIndex == 1 then
					MenuState[params.Player].CurIndex = 1
				elseif curIndex > 1 then
					MenuState[params.Player].CurIndex = curIndex - 1
				end
				MESSAGEMAN:Broadcast("PlayerChangedFocus",{Player = params.Player, Direction = params.Input})
			elseif params.Input == "Down" then
				if curIndex < (13 - bMinusCurIndex) then
					MenuState[params.Player].CurIndex = curIndex + 1
				else
					MenuState[params.Player].CurIndex = 1
				end
				MESSAGEMAN:Broadcast("PlayerChangedFocus",{Player = params.Player, Direction = params.Input})
			end;
		end;
	end;

	MenuUpP1MessageCommand=function(self) MESSAGEMAN:Broadcast("MenuInput", { Player = PLAYER_1, Input = "Up", }); end;
	MenuUpP2MessageCommand=function(self) MESSAGEMAN:Broadcast("MenuInput", { Player = PLAYER_2, Input = "Up", }); end;
	MenuDownP1MessageCommand=function(self) MESSAGEMAN:Broadcast("MenuInput", { Player = PLAYER_1, Input = "Down", }); end;
	MenuDownP2MessageCommand=function(self) MESSAGEMAN:Broadcast("MenuInput", { Player = PLAYER_2, Input = "Down", }); end;
--	MenuStartP1MessageCommand=function(self) MESSAGEMAN:Broadcast("MenuInput", { Player = PLAYER_1, Input = "Start", }); end;
--	MenuStartP2MessageCommand=function(self) MESSAGEMAN:Broadcast("MenuInput", { Player = PLAYER_2, Input = "Start", }); end;
	CodeMessageCommand=function(self,params)
		MESSAGEMAN:Broadcast("MenuInput", { Player = params.PlayerNumber, Input = params.Name, })
	end;
	-- ScreenFilter Icon P1
  Def.Sprite {
		Name="ScreenFilterIconP1";
		InitCommand=cmd(zoom,0.5;x,SCREEN_CENTER_X-120;y,SCREEN_CENTER_Y+150;visible,false);
		PlayerChangedFocusMessageCommand=function(self,params)
			local curIndex = MenuState[PLAYER_1].CurIndex
			if curIndex == (11 - bMinusCurIndex2) then
				self:visible(true)
			else
				self:visible(false)
			end
		end;
	};
	-- ScreenFilter Icon P2
	Def.Sprite {
		Name="ScreenFilterIconP2";
		InitCommand=cmd(zoom,0.5;x,SCREEN_CENTER_X+120;y,SCREEN_CENTER_Y+150;visible,false);
		PlayerChangedFocusMessageCommand=function(self,params)
			local curIndex = MenuState[PLAYER_2].CurIndex
			if curIndex == (11 - bMinusCurIndex2) then
				self:visible(true)
			else
				self:visible(false)
			end
		end;
	};
};

local function Update(self)
  local SFIconP1 = self:GetChild("ScreenFilterIconP1");
  local LoadScreenFilterP1 = getenv("ScreenFilterP1")

	local SFIconP2 = self:GetChild("ScreenFilterIconP2");
  local LoadScreenFilterP2 = getenv("ScreenFilterP2")

	-- Set From Graphics/ScreenOptions more
	if getenv("PlayerOptionExitP1") then
		MenuState[PLAYER_1].CurIndex = 14 - bMinusCurIndex
		SFIconP1:visible(false);
	end;
	if getenv("PlayerOptionExitP2") then
		MenuState[PLAYER_2].CurIndex = 14 - bMinusCurIndex
		SFIconP2:visible(false);
	end;
  --screenfilter

	if LoadScreenFilterP1 ~= 0 then
	else
		SFIconP1:Load( THEME:GetPathB("ScreenPlayerOptions","overlay/ScreenFilterIcon_Off") );
	end;
	if LoadScreenFilterP1 == 3 then
		SFIconP1:Load( THEME:GetPathB("ScreenPlayerOptions","overlay/ScreenFilterIcon_Dark1") );
	elseif LoadScreenFilterP1 == 6 then
		SFIconP1:Load( THEME:GetPathB("ScreenPlayerOptions","overlay/ScreenFilterIcon_Darker") );
	elseif LoadScreenFilterP1 == 9 then
		SFIconP1:Load( THEME:GetPathB("ScreenPlayerOptions","overlay/ScreenFilterIcon_Darkest") );
	end;

	if LoadScreenFilterP2 ~= 0 then
	else
		SFIconP2:Load( THEME:GetPathB("ScreenPlayerOptions","overlay/ScreenFilterIcon_Off") );
	end;
	if LoadScreenFilterP2 == 3 then
		SFIconP2:Load( THEME:GetPathB("ScreenPlayerOptions","overlay/ScreenFilterIcon_Dark1") );
	elseif LoadScreenFilterP2 == 6 then
		SFIconP2:Load( THEME:GetPathB("ScreenPlayerOptions","overlay/ScreenFilterIcon_Darker") );
	elseif LoadScreenFilterP2 == 9 then
		SFIconP2:Load( THEME:GetPathB("ScreenPlayerOptions","overlay/ScreenFilterIcon_Darkest") );
	end;
end;

t.InitCommand=cmd(SetUpdateFunction,Update);

return t
