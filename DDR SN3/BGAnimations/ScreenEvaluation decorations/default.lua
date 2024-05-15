local t = LoadFallbackB();

t[#t+1] = StandardDecorationFromFileOptional("StyleIcon","StyleIcon");
t[#t+1] = StandardDecorationFromFile("StageDisplay","StageDisplay");

t[#t+1] = Def.ActorFrame{
	LoadActor( THEME:GetPathB("","optionicon_P1") ) .. {
		InitCommand=cmd(halign,0;player,PLAYER_1;x,SCREEN_LEFT+110;y,SCREEN_CENTER_Y;draworder,1);
		OnCommand=function(self)
			self:y(SCREEN_CENTER_Y+180):zoomy(0):linear(0.2):zoomy(1)
		end;
		OffCommand=cmd(linear,0.2;zoomy,0);
	};
	LoadActor( THEME:GetPathB("","optionicon_P2") ) .. {
		InitCommand=cmd(halign,1;player,PLAYER_2;x,SCREEN_RIGHT-110;y,SCREEN_CENTER_Y;draworder,1);
		OnCommand=function(self)
			self:y(SCREEN_CENTER_Y+180):zoomy(0):linear(0.2):zoomy(1)
		end;
		OffCommand=cmd(linear,0.2;zoomy,0);
	};
};

--Score Area
if GAMESTATE:IsPlayerEnabled('PlayerNumber_P1') then
--P1 Score Frame
t[#t+1]=Def.ActorFrame{
	OffCommand=cmd(linear,0.2;addx,-SCREEN_WIDTH);
	LoadActor("diff frame")..{
		InitCommand=cmd(halign,0;xy,SCREEN_LEFT,SCREEN_BOTTOM-104;);
	};
	Def.ActorFrame{
		Name = "ScoreFrameP1";
		Def.Quad{
			InitCommand=cmd(halign,0;xy,SCREEN_LEFT,SCREEN_BOTTOM-85;setsize,WideScale(192,256),24;diffuse,color("#666666"));
		};
		Def.Quad{
			InitCommand=cmd(halign,0;xy,SCREEN_LEFT,SCREEN_BOTTOM-85;setsize,WideScale(190,254),20;diffuse,color("0,0,0,1"));
		};
	};
};
end;

if GAMESTATE:IsPlayerEnabled('PlayerNumber_P2') then
t[#t+1]=Def.ActorFrame{
	OffCommand=cmd(linear,0.2;addx,SCREEN_WIDTH);
	LoadActor("diff frame")..{
		InitCommand=cmd(zoomx,-1;halign,0;xy,SCREEN_RIGHT,SCREEN_BOTTOM-104;);
	};
	Def.ActorFrame{
		Name = "ScoreFrameP2";
		Def.Quad{
			InitCommand=cmd(halign,1;xy,SCREEN_RIGHT,SCREEN_BOTTOM-85;setsize,WideScale(192,256),24;diffuse,color("#666666"));
		};
		Def.Quad{
			InitCommand=cmd(halign,1;xy,SCREEN_RIGHT,SCREEN_BOTTOM-85;setsize,WideScale(190,254),20;diffuse,color("0,0,0,1"));
		};
	};
};
end;

-- judge labels
t[#t+1] = LoadActor("labels")..{
	InitCommand=cmd(CenterX;y,SCREEN_CENTER_Y+32;zoomy,0);
	OnCommand=cmd(linear,0.3;zoomy,1);
	OffCommand=cmd(sleep,0.2;linear,0.2;zoomy,0);
};

t[#t+1] = LoadActor("frame")..{
	InitCommand=cmd(diffusealpha,0.5;CenterX;y,SCREEN_CENTER_Y+35;zoomy,0);
	OnCommand=cmd(linear,0.3;zoomy,1);
	OffCommand=cmd(sleep,0.2;linear,0.2;zoomy,0);
};

-- difficulty display
if ShowStandardDecoration("DifficultyIcon") then
	if GAMESTATE:GetPlayMode() == 'PlayMode_Rave' then
		-- in rave mode, we always have two players.
	else
		-- otherwise, we only want the human players
		for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
			local diffIcon = LoadActor(THEME:GetPathG(Var "LoadingScreen", "DifficultyIcon"), pn)
			t[#t+1] = StandardDecorationFromTable("DifficultyIcon" .. ToEnumShortString(pn), diffIcon);
		end
	end
end

t[#t+1] = LoadActor("../grade")..{
	OnCommand=cmd(play);
};

for pn in ivalues(PlayerNumber) do
	local MetricsName = "MachineRecord" .. PlayerNumberToString(pn);
	t[#t+1] = LoadActor( THEME:GetPathG(Var "LoadingScreen", "MachineRecord"), pn ) .. {
		InitCommand=function(self)
			self:player(pn);
			self:name(MetricsName);
			ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen");
		end;
	};
end

for pn in ivalues(PlayerNumber) do
	local MetricsName = "PersonalRecord" .. PlayerNumberToString(pn);
	t[#t+1] = LoadActor( THEME:GetPathG(Var "LoadingScreen", "PersonalRecord"), pn ) .. {
		InitCommand=function(self)
			self:player(pn);
			self:name(MetricsName);
			ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen");
		end;
	};
end
t[#t+1] = Def.ActorFrame {
	Condition=GAMESTATE:HasEarnedExtraStage() and GAMESTATE:IsExtraStage() and not GAMESTATE:IsExtraStage2();
	InitCommand=cmd(draworder,105);
	LoadActor( THEME:GetPathS("ScreenEvaluation","try Extra1" ) ) .. {
		Condition=THEME:GetMetric( Var "LoadingScreen","Summary" ) == false;
		OnCommand=cmd(play);
	};
};

for _, pn in pairs(GAMESTATE:GetEnabledPlayers()) do
	t[#t+1] = LoadActor("grade", pn)
end

local stageXPos = {
	P1 = -280,
	P2 = 280
}

if GAMESTATE:IsCourseMode() then
	local function FindText(pss)
		if pss:GetFailed() then
			return string.format("%02d STAGE",pss:GetSongsPassed())
		else
			return "CLEAR"
		end
	end
	for _, pn in pairs(GAMESTATE:GetHumanPlayers()) do
		local shortPn = ToEnumShortString(pn)
		t[#t+1] = Def.BitmapText{
			Font="_handelgothic bt 20px";
			InitCommand=cmd(x,SCREEN_CENTER_X+stageXPos[shortPn];y,SCREEN_CENTER_Y+20);
			OnCommand=function(s)
				local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)
				local darkLength = (#(tostring(pss:GetSongsPassed()))) == 1 and 1 or 0
				s:diffusealpha(0)
				:settext(FindText(pss))
				:AddAttribute(0,{Length=darkLength, Diffuse=color "#777777"})
				:sleep(0.8):diffusealpha(1)
			end;
			OffCommand=function(s) s:linear(1):diffusealpha(0) end;
		};
	end
end

t[#t+1] = Def.ActorFrame{
	LoadActor("P1")..{
		InitCommand=cmd(x,SCREEN_CENTER_X-240;y,SCREEN_CENTER_Y-30);
		BeginCommand=cmd(playcommand,"Check1");
		OnCommand=cmd(draworder,9;addx,-SCREEN_WIDTH;sleep,0.2;linear,0.2;addx,SCREEN_WIDTH);
		OffCommand=cmd(linear,0.2;addx,-SCREEN_WIDTH);
		Check1Command=function(self,param)
			if GAMESTATE:IsPlayerEnabled(0) == false then
				self:visible(false)
			end
		end;
	};
	LoadActor("P2")..{
		InitCommand=cmd(x,SCREEN_CENTER_X+240;y,SCREEN_CENTER_Y-30);
		BeginCommand=cmd(playcommand,"Check2");
		OnCommand=cmd(draworder,9;addx,SCREEN_WIDTH;sleep,0.2;linear,0.2;addx,-SCREEN_WIDTH);
		OffCommand=cmd(linear,0.2;addx,SCREEN_WIDTH);
		Check2Command=function(self,param)
			if GAMESTATE:IsPlayerEnabled(1) == false then
				self:visible(false)
			end
		end;
	};
}

return t
