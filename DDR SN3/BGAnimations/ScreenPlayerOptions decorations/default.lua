SOUND:DimMusic(1,math.huge)
local t = LoadFallbackB();
t[#t+1] = StandardDecorationFromFileOptional("Header","Header");
t[#t+1] = StandardDecorationFromFileOptional("Footer","Footer");
t[#t+1] = StandardDecorationFromFileOptional("StyleIcon","StyleIcon");
-- other items (balloons, etc.)

t[#t+1] = Def.Actor{
  InitCommand=function()
    local env = GAMESTATE:Env()
    env.SpeedChoice = nil
  end,
  SpeedChoiceChangedMessageCommand=function(_, params)
    local env = GAMESTATE:Env()
    if not env.SpeedChoice then
      env.SpeedChoice = {}
    end
    env.SpeedChoice[params.pn] = params
    MESSAGEMAN:Broadcast("AfterSpeedChoiceChanged")
  end,
}

local index = 0;
local row = "";
local name = "";
local choice = 0;

function setting(self,screen,pn)
	index = screen:GetCurrentRowIndex(pn);
	row = screen:GetOptionRow(index);
	name = row:GetName();
	choice = row:GetChoiceInRowWithFocus(pn);
	self:settext(THEME:GetString("OptionExplanations",name));
	if name ~= "Exit" then
    local explanation_name = THEME:GetMetric( "ScreenOptionsMaster",name.."Explanation" )
		if explanation_name then
      local text
      local has_explanation_func = THEME:HasMetric("ScreenOptionsMaster",name.."ExplanationFunction")
      if has_explanation_func then
        text = (THEME:GetMetric("ScreenOptionsMaster",name.."ExplanationFunction"))(pn)
      end
      if not text then
			  text = THEME:GetString("OptionItemExplanations",explanation_name..choice);
      end
      self:settext(text);
		else self:settext("");
		end;
	end;
	return self;
end;

if GAMESTATE:IsHumanPlayer(PLAYER_1) then
  t[#t+1] = LoadFont("Common Normal")..{
    InitCommand=cmd(x,SCREEN_CENTER_X-280;y,SCREEN_CENTER_Y+132;zoom,0.55;wrapwidthpixels,494;horizalign,left;valign,0;strokecolor,Color("Black"));
    OnCommand=cmd(queuecommand,"SetP1";addx,-SCREEN_WIDTH;sleep,0.5;accelerate,0.5;addx,SCREEN_WIDTH);
		OffCommand=cmd(sleep,0.2;accelerate,0.5;addx,SCREEN_WIDTH);
    SetP1Command=function(self)
      local screen = SCREENMAN:GetTopScreen();
      if screen then
        setting(self,screen,PLAYER_1);
      end;
    end;
    AfterSpeedChoiceChangedMessageCommand=cmd(playcommand,"SetP1");
    MenuLeftP1MessageCommand=cmd(playcommand,"SetP1");
    MenuRightP1MessageCommand=cmd(playcommand,"SetP1");
    MenuUpP1MessageCommand=cmd(playcommand,"SetP1");
    MenuDownP1MessageCommand=cmd(playcommand,"SetP1");
  };
end;

if GAMESTATE:IsHumanPlayer(PLAYER_2) then
  t[#t+1] = LoadFont("Common Normal")..{
    InitCommand=cmd(x,SCREEN_CENTER_X+70;y,SCREEN_CENTER_Y+132;zoom,0.55;wrapwidthpixels,494;horizalign,left;valign,0;strokecolor,Color("Black"));
    OnCommand=cmd(queuecommand,"SetP2";addx,-SCREEN_WIDTH;sleep,0.5;accelerate,0.5;addx,SCREEN_WIDTH);
		OffCommand=cmd(sleep,0.2;accelerate,0.5;addx,SCREEN_WIDTH);
    SetP2Command=function(self)
      local screen = SCREENMAN:GetTopScreen();
      if screen then
        setting(self,screen,PLAYER_2);
      end;
    end;
    AfterSpeedChoiceChangedMessageCommand=cmd(playcommand,"SetP2");
    MenuLeftP2MessageCommand=cmd(playcommand,"SetP2");
    MenuRightP2MessageCommand=cmd(playcommand,"SetP2");
    MenuUpP2MessageCommand=cmd(playcommand,"SetP2");
    MenuDownP2MessageCommand=cmd(playcommand,"SetP2");
  };
end;


return t
