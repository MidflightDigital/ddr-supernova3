local x = Def.ActorFrame{

	CodeMessageCommand = function(self, params)
		if params.Name == 'Start' or params.Name == 'Center' then
			MESSAGEMAN:Broadcast("StartButton");
			SCREENMAN:GetTopScreen():Finish();
		end;
	end;

};



function SetRank02(Rank02, minValue)

	if minValue >=1.98 then
		Rank02 = "True God";
	elseif minValue >=1.80 then
		Rank02 = "Dazu God";
	elseif minValue >=1.60 then
		Rank02 = "God";
	elseif minValue >=1.40 then
		Rank02 = "Deity";
	elseif minValue >=1.20 then
		Rank02 = "Phoenix";
	elseif minValue >=1.00 then
		Rank02 = "Dragon";
	elseif minValue >=0.85 then
		Rank02 = "Emperor";
	elseif minValue >=0.70 then
		Rank02 = "King";
	elseif minValue >=0.55 then
		Rank02 = "Shogun";
	elseif minValue >=0.40 then
		Rank02 = "Noble";
	elseif minValue >=0.30 then
		Rank02 = "Knight";
	elseif minValue >=0.20 then
		Rank02 = "Samurai";
	elseif minValue >=0.10 then
		Rank02 = "Warrior";
	elseif minValue >0 then
		Rank02 = "Beginner";
	else
		Rank02 = "???";

	end

	return Rank02;
end


function SetRankFromRadarValue(selectRank, SingleTable, DoubleTable)
	local Rank01;
	local Rank02 = "123";

	local singleMax = math.max(SingleTable[1],SingleTable[2],SingleTable[3],SingleTable[4],SingleTable[5]);
	local doubleMax = math.max(DoubleTable[1],DoubleTable[2],DoubleTable[3],DoubleTable[4],DoubleTable[5]);
	local singleMin = math.min(SingleTable[1],SingleTable[2],SingleTable[3],SingleTable[4],SingleTable[5]);
	local doubleMin = math.min(DoubleTable[1],DoubleTable[2],DoubleTable[3],DoubleTable[4],DoubleTable[5]);

	local totalMax = math.max(SingleTable[1],SingleTable[2],SingleTable[3],SingleTable[4],SingleTable[5],
								DoubleTable[1],DoubleTable[2],DoubleTable[3],DoubleTable[4],DoubleTable[5]);

	-- local totalMin = math.min(SingleTable[1],SingleTable[2],SingleTable[3],SingleTable[4],SingleTable[5],
								-- DoubleTable[1],DoubleTable[2],DoubleTable[3],DoubleTable[4],DoubleTable[5]);

	if totalMax == SingleTable[1] or totalMax==DoubleTable[1] then
		Rank01 = "Stream";
	elseif totalMax == SingleTable[2] or totalMax==DoubleTable[2] then
		Rank01 = "Voltage";
	elseif totalMax == SingleTable[3] or totalMax==DoubleTable[3] then
		Rank01 = "Air";
	elseif totalMax == SingleTable[4] or totalMax==DoubleTable[4] then
		Rank01 = "Freeze";
	else
		Rank01 = "Chaos";
	end

	if (totalMax == SingleTable[1] or
		totalMax == SingleTable[2] or
		totalMax == SingleTable[3] or
		totalMax == SingleTable[4] or
		totalMax == SingleTable[5]) then

		Rank02 = SetRank02(Rank02,singleMin);
	else
		Rank02 = SetRank02(Rank02,doubleMin);
	end

	if Rank02 == "???" then
		Rank01 ="???"
	end

	selectRank:settext(Rank01.." ".. Rank02);
end;





function LoadPlayerStuff(Player)

	local t = {};
	local pn = (Player == PLAYER_1) and 1 or 2;
	local strpn = tostring(pn);

	t[#t+1] = Def.ActorFrame {
		Name = 'JoinFrame';
		--LoadCard(Color('Outline'),color('0,0,0,0'),Player,true);


		-- LoadActor( THEME:GetPathG("ScreenSelectProfile","Start") ) .. {
			-- InitCommand=cmd(shadowlength,0);
			-- OnCommand=cmd(diffuseshift;effectcolor1,Color('White');effectcolor2,color("#A5A6A5");playcommand,"Animate");
			-- AnimateCommand=cmd(smooth,0.1;zoomx,1.05;smooth,0.1;zoomx,1.0;queuecommand,"Animate");
			-- OffCommand=cmd(linear,0.1;zoomy,0;diffusealpha,0);
		-- };

	};

	t[#t+1] = Def.ActorFrame {
		Name = 'BigFrame';
		LoadCard(PlayerColor(),color('1,1,1,1'),Player,true);
	};
	t[#t+1] = Def.ActorFrame {
		Name = 'SmallFrame';
		InitCommand=cmd(y,5);

		LoadActor( THEME:GetPathG("ScreenDataSaveSummary","MyGrooveRadarBackP1") )..{
			InitCommand=cmd(zoom,0.4;y,-2.5;);
			OnCommand=cmd(diffusealpha,0;sleep,0.9;linear,0.2;diffusealpha,1);
			OffCommand=cmd(linear,0.01;zoom,0;diffusealpha,0);
		};
	};



	t[#t+1] = Def.ActorFrame {
		Name = "EffectFrame";
	};


	t[#t+1] = LoadFont("_handelgothic bt 20px") .. {
		Name = 'SelectedProfileText';
    InitCommand=function(self)
      if Player==PLAYER_2 then
        self:x(3);
      end;
      (cmd(y,-71;zoom,0.6;shadowlength,1;diffuse,color("1,1,1,0");strokecolor,Color("Outline");maxwidth,400))(self);
    end;
		OnCommand=cmd(sleep,0.8;linear,0.5;diffusealpha,1);
		OffCommand=cmd(stoptweening;linear,0.01;zoomy,0;diffusealpha,0);
	};

	t[#t+1] = LoadFont("_enjoysongnumber") .. {
		Name = 'SelectedProfileLevel';
    InitCommand=function(self)
      if Player==PLAYER_2 then
        self:x(58);
      else
        self:x(55)
      end;
      (cmd(valign,1;halign,1;y,50;zoom,0;strokecolor,color("#000000");maxwidth,50))(self);
    end;
		OnCommand=cmd(sleep,0.7;linear,0.05;diffusealpha,1;zoom,0.3);
		OffCommand=cmd(stoptweening;linear,0.1;zoomy,0;diffusealpha,0);
	};

t[#t+1] = LoadFont("_handelgothic bt 20px") .. {
		Name = 'selectedTotalCaloriesBurned';
		InitCommand=cmd(x,33.5;y,60;zoom,0;diffuse,color("1,1,1,1");strokecolor,Color("Outline");maxwidth,350);
		OnCommand=cmd(sleep,0.9;linear,0.05;diffusealpha,1;zoom,0.3);
		OffCommand=cmd(stoptweening;linear,0.1;zoomy,0;diffusealpha,0);
	};

	t[#t+1] = LoadFont("_handelgothic bt 20px") .. {
		Name = 'selectSongsPlayed';
    InitCommand=function(self)
      if Player==PLAYER_2 then
        self:x(28);
      else
        self:x(25)
      end;
      (cmd(y,-56;zoom,0;diffuse,color("1,1,1,1");diffusebottomedge,color("1,1,0.1,1");strokecolor,Color("Outline");maxwidth,150))(self);
    end;
		OnCommand=cmd(sleep,0.9;linear,0.05;diffusealpha,1;zoomy,0.3;zoomx,0.4;);
		OffCommand=cmd(stoptweening;linear,0.1;zoomy,0;diffusealpha,0);
	};

	t[#t+1] = Def.Sprite{
		Name = 'selectedMostSongPlayed';
		InitCommand=cmd(x,65;y,-32;zoom,0;scaletoclipped,40,40);
		OnCommand=cmd(sleep,1.9;linear,0.05;diffusealpha,1;diffuse,color("1,1,1,1");zoom,1;);
		OffCommand=cmd(stoptweening;linear,0.1;scaletoclipped,0,0;);
	};

	t[#t+1] = LoadActor( THEME:GetPathG("ScreenSelectProfile/ScreenSelectProfile","LvBar") ) .. {
			Name = 'selectLvBarBack';
      InitCommand=function(self)
        if Player==PLAYER_2 then
          self:x(1);
        else
          self:x(-2)
        end;
        (cmd(diffusealpha,0;y,46;zoomx,0.5;halign,1))(self);
      end;
			OnCommand=cmd(sleep,0.3;linear,0.3;diffusealpha,1;diffuse,color("0.4,0.4,0.4,1"));
			OffCommand=cmd(stoptweening;linear,0.02;zoom,0.100;diffusealpha,0);
	};
	t[#t+1] = LoadActor( THEME:GetPathG("ScreenSelectProfile/ScreenSelectProfile","LvBar") ) .. {
			Name = 'selectLvBar';
      InitCommand=function(self)
        if Player==PLAYER_2 then
          self:x(1);
        else
          self:x(-2)
        end;
        (cmd(diffusealpha,0;y,46;zoomx,0.5;halign,1))(self);
      end;
			OnCommand=cmd(sleep,0.3;linear,0.3;diffusealpha,1;);
			OffCommand=cmd(stoptweening;linear,0.02;zoom,0.100;diffusealpha,0);
		};

	t[#t+1]=LoadFont("_handelgothic bt 20px") .. {
		Name = 'selectTotalCalWord';
		InitCommand=cmd(x,-26;y,60;zoom,0;diffuse,color("1,1,1,1");strokecolor,Color("Outline");maxwidth,320);
		OnCommand=function(self)
			self:settext("Calories burned today:");
			(cmd(sleep,0.9;linear,0.05;diffusealpha,1;zoom,0.3))(self);
		end;
		OffCommand=cmd(stoptweening;linear,0.1;zoomy,0;diffusealpha,0);
	};

	----MyGrooveRadar
	if (Player == PLAYER_1) then ---------------P1
		------New MyGrooveRadar
		if GAMESTATE:GetCurrentStyle():GetStepsType() == "StepsType_Dance_Single" then
			t[#t+1] = LoadActor( THEME:GetPathG("ScreenDataSaveSummary", "GrooveRadar" ),0,0,0,0,0,1,0,PLAYER_1)..{  --00000/Style/IsPastValue ::  Single=1 Double=2 IsPastValue=0 or 1
				Name = "GVRD1";
				InitCommand=cmd(x,0;y,5;zoom,0.56;diffusealpha,0;diffuse,Color("Yellow"));
				OnCommand=cmd(sleep,0.9;linear,0.05;diffusealpha,1;);
				OffCommand=cmd(linear,0.05;diffusealpha,0);
			};
		else
			t[#t+1] = LoadActor( THEME:GetPathG("ScreenDataSaveSummary", "GrooveRadar" ),1,0.2,0.2,0.2,0.5,2,0,PLAYER_1)..{
				Name = "GVRD1";
				InitCommand=cmd(x,0;y,5;zoom,0.56;diffusealpha,0;diffuse,Color("Yellow"));
				OnCommand=cmd(sleep,0.9;linear,0.05;diffusealpha,1;);
				OffCommand=cmd(linear,0.05;diffusealpha,0);
			};
		end

		--Old My Groove Radar
		if GAMESTATE:GetCurrentStyle():GetStepsType() == "StepsType_Dance_Single" then
			t[#t+1] = LoadActor( THEME:GetPathG("ScreenDataSaveSummary", "GrooveRadar" ),0,0,0,0,0,1,1,PLAYER_1)..{  --00000/Style/IsPastValue ::  Single=1 Double=2 IsPastValue=0 or 1
				Name = "GVRD1P";
				InitCommand=cmd(x,0;y,5;zoom,0.56;diffusealpha,0;diffuse,PlayerColor(PLAYER_1));
				OnCommand=cmd(sleep,0.9;linear,0.05;diffusealpha,1;);
				OffCommand=cmd(linear,0.05;diffusealpha,0);
			};
		else
			t[#t+1] = LoadActor( THEME:GetPathG("ScreenDataSaveSummary", "GrooveRadar" ),0,0,0,0,0,2,1,PLAYER_1)..{
				Name = "GVRD1P";
				InitCommand=cmd(x,0;y,5;zoom,0.56;diffusealpha,0;diffuse,PlayerColor(PLAYER_1));
				OnCommand=cmd(sleep,0.9;linear,0.05;diffusealpha,1;);
				OffCommand=cmd(linear,0.05;diffusealpha,0);
			};
		end

	else -----------P2
				------New MyGrooveRadar
		if GAMESTATE:GetCurrentStyle():GetStepsType() == "StepsType_Dance_Single" then
			t[#t+1] = LoadActor( THEME:GetPathG("ScreenDataSaveSummary", "GrooveRadar" ),0,0,0,0,0,1,0,PLAYER_2)..{  --00000/Style/IsPastValue ::  Single=1 Double=2 IsPastValue=0 or 1
				Name = "GVRD2";
				InitCommand=cmd(x,0;y,49.5;zoom,0.56;diffusealpha,0;diffuse,Color("Yellow"));
				OnCommand=cmd(sleep,0.9;linear,0.05;diffusealpha,1;);
				OffCommand=cmd(linear,0.05;diffusealpha,0);
			};
		else
			t[#t+1] = LoadActor( THEME:GetPathG("ScreenDataSaveSummary", "GrooveRadar" ),1,0.2,0.2,0.2,0.5,2,0,PLAYER_2)..{
				Name = "GVRD2";
				InitCommand=cmd(x,0;y,49.5;zoom,0.56;diffusealpha,0;diffuse,Color("Yellow"));
				OnCommand=cmd(sleep,0.9;linear,0.05;diffusealpha,1;);
				OffCommand=cmd(linear,0.05;diffusealpha,0);
			};
		end



		t[#t+1]=LoadFont("_russell square 16px") .. {
			Name = 'GVRD2Value_N1';
			InitCommand=cmd(horizalign,right;x,20+8.5;y,9;zoom,0;diffuse,color("1,1,1,1");diffusebottomedge,Color("Yellow");strokecolor,Color("Outline");maxwidth,220);
			OnCommand=cmd(sleep,0.9;linear,0.05;diffusealpha,1;zoom,0.35);
			OffCommand=cmd(stoptweening;linear,0.1;zoomy,0;diffusealpha,0);
		};
		t[#t+1]=LoadFont("_russell square 16px") .. {
			Name = 'GVRD2Value_N2';
			InitCommand=cmd(horizalign,right;x,-45+8.5;y,24;zoom,0;diffuse,color("1,1,1,1");diffusebottomedge,Color("Yellow");strokecolor,Color("Outline");maxwidth,220);
			OnCommand=cmd(sleep,0.9;linear,0.05;diffusealpha,1;zoom,0.35);
			OffCommand=cmd(stoptweening;linear,0.1;zoomy,0;diffusealpha,0);
		};
		t[#t+1]=LoadFont("_russell square 16px") .. {
			Name = 'GVRD2Value_N3';
			InitCommand=cmd(horizalign,right;x,-40+8.5;y,59;zoom,0;diffuse,color("1,1,1,1");diffusebottomedge,Color("Yellow");strokecolor,Color("Outline");maxwidth,220);
			OnCommand=cmd(sleep,0.9;linear,0.05;diffusealpha,1;zoom,0.35);
			OffCommand=cmd(stoptweening;linear,0.1;zoomy,0;diffusealpha,0);
		};
		t[#t+1]=LoadFont("_russell square 16px") .. {
			Name = 'GVRD2Value_N4';
			InitCommand=cmd(horizalign,right;x,40+8.5;y,59;zoom,0;diffuse,color("1,1,1,1");diffusebottomedge,Color("Yellow");strokecolor,Color("Outline");maxwidth,220);
			OnCommand=cmd(sleep,0.9;linear,0.05;diffusealpha,1;zoom,0.35);
			OffCommand=cmd(stoptweening;linear,0.1;zoomy,0;diffusealpha,0);
		};
		t[#t+1]=LoadFont("_russell square 16px") .. {
			Name = 'GVRD2Value_N5';
			InitCommand=cmd(horizalign,right;x,45+8.5;y,24;zoom,0;diffuse,color("1,1,1,1");diffusebottomedge,Color("Yellow");strokecolor,Color("Outline");maxwidth,220);
			OnCommand=cmd(sleep,0.9;linear,0.05;diffusealpha,1;zoom,0.35);
			OffCommand=cmd(stoptweening;linear,0.1;zoomy,0;diffusealpha,0);
		};


		--Old My Groove Radar
		if GAMESTATE:GetCurrentStyle():GetStepsType() == "StepsType_Dance_Single" then
			t[#t+1] = LoadActor( THEME:GetPathG("ScreenDataSaveSummary", "GrooveRadar" ),0,0,0,0,0,1,1,PLAYER_2)..{  --00000/Style/IsPastValue ::  Single=1 Double=2 IsPastValue=0 or 1
				Name = "GVRD2P";
				InitCommand=cmd(x,0;y,49.5;zoom,0.56;diffusealpha,0;diffuse,PlayerColor(PLAYER_2));
				OnCommand=cmd(sleep,0.9;linear,0.05;diffusealpha,1;);
				OffCommand=cmd(linear,0.05;diffusealpha,0);
			};
		else
			t[#t+1] = LoadActor( THEME:GetPathG("ScreenDataSaveSummary", "GrooveRadar" ),0,0,0,0,0,2,1,PLAYER_2)..{
				Name = "GVRD2P";
				InitCommand=cmd(x,0;y,49.5;zoom,0.56;diffusealpha,0;diffuse,PlayerColor(PLAYER_2));
				OnCommand=cmd(sleep,0.9;linear,0.05;diffusealpha,1;);
				OffCommand=cmd(linear,0.05;diffusealpha,0);
			};
		end
		t[#t+1]=LoadFont("_russell square 16px") .. {
			Name = 'GVRD2Value_O1';
			InitCommand=cmd(horizalign,right;x,20+8.5;y,9+7;zoom,0;diffuse,color("1,1,1,1");diffusebottomedge,PlayerColor(PLAYER_2);strokecolor,Color("Outline");maxwidth,220);
			OnCommand=cmd(sleep,0.9;linear,0.05;diffusealpha,1;zoom,0.35);
			OffCommand=cmd(stoptweening;linear,0.1;zoomy,0;diffusealpha,0);
		};
		t[#t+1]=LoadFont("_russell square 16px") .. {
			Name = 'GVRD2Value_O2';
			InitCommand=cmd(horizalign,right;x,-45+8.5;y,24+7;zoom,0;diffuse,color("1,1,1,1");diffusebottomedge,PlayerColor(PLAYER_2);strokecolor,Color("Outline");maxwidth,220);
			OnCommand=cmd(sleep,0.9;linear,0.05;diffusealpha,1;zoom,0.35);
			OffCommand=cmd(stoptweening;linear,0.1;zoomy,0;diffusealpha,0);
		};
		t[#t+1]=LoadFont("_russell square 16px") .. {
			Name = 'GVRD2Value_O3';
			InitCommand=cmd(horizalign,right;x,-40+8.5;y,59+7;zoom,0;diffuse,color("1,1,1,1");diffusebottomedge,PlayerColor(PLAYER_2);strokecolor,Color("Outline");maxwidth,220);
			OnCommand=cmd(sleep,0.9;linear,0.05;diffusealpha,1;zoom,0.35);
			OffCommand=cmd(stoptweening;linear,0.1;zoomy,0;diffusealpha,0);
		};
		t[#t+1]=LoadFont("_russell square 16px") .. {
			Name = 'GVRD2Value_O4';
			InitCommand=cmd(horizalign,right;x,40+8.5;y,59+7;zoom,0;diffuse,color("1,1,1,1");diffusebottomedge,PlayerColor(PLAYER_2);strokecolor,Color("Outline");maxwidth,220);
			OnCommand=cmd(sleep,0.9;linear,0.05;diffusealpha,1;zoom,0.35);
			OffCommand=cmd(stoptweening;linear,0.1;zoomy,0;diffusealpha,0);
		};
		t[#t+1]=LoadFont("_russell square 16px") .. {
			Name = 'GVRD2Value_O5';
			InitCommand=cmd(horizalign,right;x,45+8.5;y,24+7;zoom,0;diffuse,color("1,1,1,1");diffusebottomedge,PlayerColor(PLAYER_2);strokecolor,Color("Outline");maxwidth,220);
			OnCommand=cmd(sleep,0.9;linear,0.05;diffusealpha,1;zoom,0.35);
			OffCommand=cmd(stoptweening;linear,0.1;zoomy,0;diffusealpha,0);
		};

	end;



	return t;
end;


--Update Internal Stuff
function UpdateInternal(self, Player)
	local pn = (Player == PLAYER_1) and 1 or 2;
	local style = (GAMESTATE:GetCurrentStyle():GetStepsType() == "StepsType_Dance_Single") and "S" or "D";
	local seltext = self:GetChild('SelectedProfileText');
	local joinframe = self:GetChild('JoinFrame');
	local smallframe = self:GetChild('SmallFrame');
	local bigframe = self:GetChild('BigFrame');
	local selLevel = self:GetChild('SelectedProfileLevel');
	local selTotalCaloriesBurned = self:GetChild('selectedTotalCaloriesBurned');
	local selectRank = self:GetChild('selectRank');
	local selSongsPlayed = self:GetChild('selectSongsPlayed');
	local selLvBarBack = self:GetChild('selectLvBarBack');
	local selLvBar = self:GetChild('selectLvBar');
	local selPercentComplete = self:GetChild('selectPercentComplete');
	local selTotalAttackrateWord = self:GetChild('selectTotalAttackrateWord');
	local selGVRD = (Player == PLAYER_1) and self:GetChild('GVRD1') or self:GetChild('GVRD2');
	local selGVRDP = (Player == PLAYER_1) and self:GetChild('GVRD1P') or self:GetChild('GVRD2P');

	local PcntCompleteSingle = PROFILEMAN:GetProfile(Player):GetSongsAndCoursesPercentCompleteAllDifficulties('StepsType_Dance_Single');
				local PcntCompleteDouble = PROFILEMAN:GetProfile(Player):GetSongsAndCoursesPercentCompleteAllDifficulties('StepsType_Dance_Double');
				--HonorName

				if PcntCompleteSingle>PcntCompleteDouble then
					PcntLarger = PcntCompleteSingle;
				else
					PcntLarger = PcntCompleteDouble;
				end
				PcntLarger = PcntLarger*100;


				local Lv = (math.ceil(math.sqrt(PROFILEMAN:GetProfile(Player):GetTotalCaloriesBurned())));
				local pcnt =((PROFILEMAN:GetProfile(Player):GetTotalCaloriesBurned())-((Lv-1)*(Lv-1))) /((Lv*Lv)-((Lv-1)*(Lv-1)));
				local totalPcnt = (PcntCompleteSingle + PcntCompleteDouble) / 2;
					--totalPcnt = PcntLarger;
				--local pcnt =((PROFILEMAN:GetProfile(Player):GetTotalCaloriesBurned())-((Lv-1)*(Lv-1))) /((Lv*Lv)-((Lv-1)*(Lv-1)));
				bigframe:visible(true);
				seltext:settext(PROFILEMAN:GetProfile(Player):GetDisplayName());
				selLevel:settext(math.ceil(math.sqrt(PROFILEMAN:GetProfile(Player):GetTotalCaloriesBurned())) );
				selTotalCaloriesBurned:settext((math.ceil(PROFILEMAN:GetProfile(Player):GetCaloriesBurnedToday()))..' kCals.');
				selLvBar:cropright(1-pcnt);
				local RadarFile = RageFileUtil:CreateRageFile()

				local selPlayerProf = PROFILEMAN:GetProfile(Player)

				local stype = GAMESTATE:GetCurrentStyle():GetStyleType()
				local style = ((stype == 'StyleType_OnePlayerTwoSides') or (stype == 'StyleType_TwoPlayersSharedSides'))
					and 'double'
					or 'single'

end

if GAMESTATE:IsPlayerEnabled(PLAYER_1) then
x[#x+1] = Def.ActorFrame {
			Name = 'P1Frame';
			InitCommand=cmd(x,SCREEN_CENTER_X-160;y,SCREEN_CENTER_Y+20;zoom,2);
			OnCommand=function(self)
				UpdateInternal(self, PLAYER_1);
			end;
			OffCommand=cmd();
			children = LoadPlayerStuff(PLAYER_1);
		};
end
if GAMESTATE:IsPlayerEnabled(PLAYER_2) then
x[#x+1] = Def.ActorFrame {
			Name = 'P2Frame';
			InitCommand=cmd(x,SCREEN_CENTER_X+160;y,SCREEN_CENTER_Y+20;zoom,2);
			OnCommand=function(self)
				UpdateInternal(self, PLAYER_2);
			end;
			OffCommand=cmd();
			children = LoadPlayerStuff(PLAYER_2);
		};
end

x[#x+1] = Def.ActorFrame {
	LoadActor( THEME:GetPathS("","Profile_in") )..{
		StartTransitioningCommand=cmd(play);
	};
	LoadActor( THEME:GetPathS("Common","start") )..{
		StartButtonMessageCommand=cmd(play);
	};
	LoadActor( THEME:GetPathS("","Profile_start") )..{
		StartButtonMessageCommand=cmd(play);
	};
	LoadActor( THEME:GetPathS("Common","cancel") )..{
		BackButtonMessageCommand=cmd(play);
	};
	LoadActor( THEME:GetPathS("","Profile_Move") )..{
		DirectionButtonMessageCommand=cmd(play);
	};
};


return x;
