--[[
This script was taken from KENp's DDR X2 theme
and was recoded by FlameyBoy and Inorizushi
]]--

local ProfileInfoCache = {}
setmetatable(ProfileInfoCache, {__index =
function(table, ind)
    local out = {}
    local prof = PROFILEMAN:GetLocalProfileFromIndex(ind-1)
    out.SongsAndCoursesPercentCompleteAllDifficultiesSingle = prof:GetSongsAndCoursesPercentCompleteAllDifficulties('StepsType_Dance_Single')
    out.SongsAndCoursesPercentCompleteAllDifficultiesDouble = prof:GetSongsAndCoursesPercentCompleteAllDifficulties('StepsType_Dance_Double')
    out.TotalCaloriesBurned = prof:GetTotalCaloriesBurned()
    out.CaloriesBurnedToday = prof:GetCaloriesBurnedToday()
    out.LastPlayedSong = prof:GetLastPlayedSong()
    out.DisplayName = prof:GetDisplayName()
    out.NumTotalSongsPlayed = prof:GetNumTotalSongsPlayed()
    out.UserTable = prof:GetUserTable()
    rawset(table, ind, out)
    return out
end
})

--�d�����e����---------------------------
function LoadCard(cColor,cColor2,Player,IsJoinFrame)
	local t = Def.ActorFrame {
		LoadActor( THEME:GetPathG("ScreenSelectProfile/ScreenSelectProfile","CardBG01") ) .. {
			InitCommand=function(self)
				if Player==PLAYER_2 then
					self:zoomx(-1);
				end
				(cmd(shadowlength,0;zoomy,0;diffuse,cColor))(self);
			end;
			OnCommand=cmd(sleep,0.3;linear,0.3;zoomy,1;);
			OffCommand=function(self)
				if IsJoinFrame then
					(cmd(sleep,0.5;linear,0.2;zoomy,0.100;diffusealpha,0))(self);
				else
					(cmd(linear,0.2;zoomy,0.100;diffusealpha,0))(self);
				end
			end;
		};
		LoadActor( THEME:GetPathG("ScreenSelectProfile/ScreenSelectProfile","CardBG02") ) .. {
			InitCommand=function(self)
        if Player==PLAYER_2 then
          self:x(3);
        end;
				(cmd(shadowlength,0;zoomy,0;diffuse,cColor2))(self);
			end;
			OnCommand=cmd(sleep,0.3;linear,0.3;zoomy,1;);
			OffCommand=function(self)
				if IsJoinFrame then
					(cmd(sleep,0.5;linear,0.2;zoomy,0.100;linear,0.2;zoomx,0;diffusealpha,1))(self);
				else
					(cmd(linear,0.2;zoomy,0.100;linear,0.2;zoomx,0;diffusealpha,1))(self);
				end
			end;
		};

		LoadActor( THEME:GetPathG("ScreenSelectProfile/ScreenSelectProfile","CardBG03") ) .. {
			InitCommand=function(self)
				if Player==PLAYER_2 then
					self:zoomx(-1);
				end
				(cmd(shadowlength,0;zoomy,0))(self);
			end;
			OnCommand=cmd(sleep,0.3;linear,0.3;zoomy,1;);
			OffCommand=function(self)
				if IsJoinFrame then
					(cmd(sleep,0.5;linear,0.2;zoomy,0.100;linear,0.2;zoomx,0;diffusealpha,1))(self);
				else
					(cmd(linear,0.2;zoomy,0.100;linear,0.2;zoomx,0;diffusealpha,1))(self);
				end
			end;
		};
    LoadActor( THEME:GetPathG("ScreenSelectProfile/ScreenSelectProfile","CardBG04") ) .. {
			InitCommand=function(self)
				if Player==PLAYER_2 then
					self:x(3);
				end
			  (cmd(shadowlength,0;y,65;zoomy,0;zoomx,0.5;diffuse,cColor))(self);
			end;
      OnCommand=function(self)
        if IsJoinFrame then
          (cmd(sleep,0.8;linear,0.3;zoomy,0))(self);
        else
          (cmd(sleep,0.8;linear,0.3;zoomy,0.5))(self);
        end;
      end;
			OffCommand=function(self)
				if IsJoinFrame then
					(cmd(sleep,0.5;linear,0.2;zoomy,0.100;diffusealpha,0))(self);
				else
					(cmd(linear,0.2;zoomy,0.100;diffusealpha,0))(self);
				end
			end;
		};
		LoadFont("_handelgothic bt 20px") .. {
		InitCommand=cmd(x,10;y,-94;zoom,0;diffuse,color("#03ff03");diffusetopedge,color("#02b102");diffusealpha,0.8;maxwidth,320);
		OnCommand=function(self)
			if Player== PLAYER_1 then
				self:settext("PLAYER:1");
			else
				self:settext("PLAYER:2");
				self:x(-7);
			end
			(cmd(sleep,0.6;diffusealpha,1;zoomy,0.40;zoomx,0.80))(self);
		end;
		OffCommand=cmd(stoptweening;linear,0.1;zoomy,0;diffusealpha,0);
	};

		LoadActor( THEME:GetPathG("ScreenSelectProfile/ScreenSelectProfile","LvWord") ) .. {
      InitCommand=function(self)
        if Player==PLAYER_2 then
          self:x(23);
        elseif Player==PLAYER_1 then
          self:x(18)
        end;
				(cmd(shadowlength,0;zoom,0;y,46;diffuse,cColor2))(self);
			end;
			OnCommand=cmd(sleep,0.6;zoom,0.5;);
			OffCommand=cmd(linear,0.02;zoom,0.100;diffusealpha,0);
		};

		LoadActor( THEME:GetPathG("ScreenSelectProfile/ScreenSelectProfile","DancerNameWord") ) .. {
      InitCommand=function(self)
        if Player==PLAYER_2 then
          self:x(-20);
        elseif Player==PLAYER_1 then
          self:x(-23)
        end;
				(cmd(shadowlength,0;zoom,0;y,-82.5;diffuse,cColor2))(self);
			end;
			OnCommand=cmd(sleep,0.6;zoom,0.4;);
			OffCommand=cmd(stoptweening;linear,0.02;zoom,0.100;diffusealpha,0);
		};
		LoadActor( THEME:GetPathG("ScreenSelectProfile/ScreenSelectProfile","RankWord") ) .. {
      InitCommand=function(self)
        if Player==PLAYER_2 then
          self:x(-35);
        elseif Player==PLAYER_1 then
          self:x(-38)
        end;
				(cmd(shadowlength,0;zoom,0;y,-40;diffuse,cColor2))(self);
      end;
			OnCommand=cmd(sleep,0.6;zoom,0.4;);
			OffCommand=cmd(stoptweening;linear,0.02;zoom,0.100;diffusealpha,0);
		};
	};

	return t
end

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


function SetRankFromRadarValue(selectRank, SingleTable)
	local Rank01;
	local Rank02 = "123";

	local singleMax = math.max(SingleTable[1],SingleTable[2],SingleTable[3],SingleTable[4],SingleTable[5]);
	local singleMin = math.min(SingleTable[1],SingleTable[2],SingleTable[3],SingleTable[4],SingleTable[5]);

	local totalMax = math.max(SingleTable[1],SingleTable[2],SingleTable[3],SingleTable[4],SingleTable[5]);

	-- local totalMin = math.min(SingleTable[1],SingleTable[2],SingleTable[3],SingleTable[4],SingleTable[5],
								-- DoubleTable[1],DoubleTable[2],DoubleTable[3],DoubleTable[4],DoubleTable[5]);

	if totalMax == SingleTable[1] then
		Rank01 = "Stream";
	elseif totalMax == SingleTable[2] then
		Rank01 = "Voltage";
	elseif totalMax == SingleTable[3] then
		Rank01 = "Air";
	elseif totalMax == SingleTable[4] then
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


	t[#t+1] = Def.ActorFrame {
		Name = 'JoinFrame';
		LoadCard(Color('Outline'),color('0,0,0,0'),Player,true);

		LoadActor( THEME:GetPathG("ScreenSelectProfile/ScreenSelectProfile","Start") ) .. {
			InitCommand=cmd(zoomy,0;diffuseshift;effectcolor1,Color('White');effectcolor2,color("#A5A6A5"));
			OnCommand=cmd(zoomy,0;zoomx,0;sleep,0.5;linear,0.1;zoomx,0.5;zoomy,0.5);
			OffCommand=cmd(sleep,0.5;linear,0.1;zoomy,0;diffusealpha,0);
		};

	};

	t[#t+1] = Def.ActorFrame {
		Name = 'BigFrame';
		LoadCard(PlayerColor(),color('1,1,1,1'),Player,false);
	};
	t[#t+1] = Def.ActorFrame {
		Name = 'SmallFrame';
		InitCommand=cmd(y,5);

		LoadActor( THEME:GetPathG("ScreenDataSaveSummary","MyGrooveRadarBackP1") )..{
      InitCommand=function(self)
        if Player==PLAYER_2 then
          self:x(3);
        end;
				(cmd(zoom,0.4;y,-2.5))(self);
      end;
			OnCommand=cmd(diffusealpha,0;sleep,0.6;linear,0.2;diffusealpha,1);
			OffCommand=cmd(linear,0.01;zoom,0;diffusealpha,0);
		};
	};
	t[#t+1] = Def.ActorScroller{
		Name = 'Scroller';
		NumItemsToDraw=1;

		OnCommand=cmd(draworder,1000;y,5;SetFastCatchup,true;SetMask,0,29;SetSecondsPerItem,0.15);
		TransformFunction=function(self, offset, itemIndex, numItems)
			local focus = scale(math.abs(offset),0,2,1,0);
			self:visible(false);
			self:y(math.floor( offset*20 ));

		end;
	};


	t[#t+1] = Def.ActorFrame {
		Name = "EffectFrame";
	};

	--�U���d��-----------------
	t[#t+1] = LoadFont("_handelgothic bt 20px") .. {
		Name = 'SelectedProfileText';
    InitCommand=function(self)
      if Player==PLAYER_2 then
        self:x(3);
      end;
      (cmd(y,-71;zoom,0.6;shadowlength,1;diffuse,color("1,1,1,0");strokecolor,Color("Outline");maxwidth,400))(self);
    end;
		OnCommand=cmd(sleep,0.6;linear,0.2;diffusealpha,1);
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
      (cmd(diffusealpha,0;valign,1;halign,1;y,50;zoom,0.3;strokecolor,color("#000000");maxwidth,50))(self);
    end;
		OnCommand=cmd(sleep,0.6;linear,0.2;diffusealpha,1);
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
		OnCommand=cmd(sleep,0.6;linear,0.2;diffusealpha,1;zoomy,0.3;zoomx,0.4;);
		OffCommand=cmd(stoptweening;linear,0.1;zoomy,0;diffusealpha,0);
	};

	t[#t+1]=LoadFont("_handelgothic bt 20px") .. {
		Name = 'selectRank';
    InitCommand=function(self)
      if Player==PLAYER_2 then
        self:x(3);
      end;
      (cmd(y,-54;zoom,0.5;diffuse,color("1,1,1,0");strokecolor,Color("Outline");maxwidth,350))(self);
    end;
		OnCommand=cmd(sleep,0.6;linear,0.2;diffusealpha,1);
		OffCommand=cmd(stoptweening;linear,0.1;zoomy,0;diffusealpha,0);
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
			OnCommand=cmd(sleep,0.6;linear,0.2;diffusealpha,1;diffuse,color("0.4,0.4,0.4,1"));
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
			OnCommand=cmd(sleep,0.6;linear,0.2;diffusealpha,1);
			OffCommand=cmd(stoptweening;linear,0.02;zoom,0.100;diffusealpha,0);

		};

	t[#t+1] = LoadFont("_handelgothic bt 20px") .. {
		Name = 'selectPlayerUID';
		InitCommand=cmd(visible,false);
	};
	------MyGrooveRadar
	if (Player == PLAYER_1) then
		t[#t+1] = LoadActor( THEME:GetPathG("ScreenSelectProfile/ScreenSelectProfile", "GrooveRadar" ),1,0.2,0.2,0.2,0.5,PLAYER_1,'single')..{
			Name = "GVRD1S";
      InitCommand=cmd(x,0;y,5;zoom,0.56;diffusealpha,0;diffuse,PlayerColor(PLAYER_1));
			OnCommand=cmd(sleep,0.6;linear,0.2;diffusealpha,1);
			OffCommand=cmd(linear,0.05;diffusealpha,0);
		};
		t[#t+1]=LoadFont("_russell square 16px") .. {
			Name = 'GVRD1Value_S1';
			InitCommand=cmd(horizalign,right;x,20+8.5;y,-25;zoom,0;diffuse,color("1,1,1,0");diffusebottomedge,PlayerColor(PLAYER_1);strokecolor,Color("Outline");maxwidth,220);
			OnCommand=cmd(sleep,0.6;linear,0.2;diffusealpha,1;zoom,0.35);
			OffCommand=cmd(stoptweening;linear,0.1;zoomy,0;diffusealpha,0);
		};
		t[#t+1]=LoadFont("_russell square 16px") .. {
			Name = 'GVRD1Value_S2';
			InitCommand=cmd(horizalign,right;x,-56+8.5;y,-6;zoom,0;diffuse,color("1,1,1,0");diffusebottomedge,PlayerColor(PLAYER_1);strokecolor,Color("Outline");maxwidth,220);
			OnCommand=cmd(sleep,0.6;linear,0.2;diffusealpha,1;zoom,0.35);
			OffCommand=cmd(stoptweening;linear,0.1;zoomy,0;diffusealpha,0);
		};
		t[#t+1]=LoadFont("_russell square 16px") .. {
			Name = 'GVRD1Value_S3';
			InitCommand=cmd(horizalign,right;x,-50+8.5;y,32;zoom,0;diffuse,color("1,1,1,0");diffusebottomedge,PlayerColor(PLAYER_1);strokecolor,Color("Outline");maxwidth,220);
			OnCommand=cmd(sleep,0.6;linear,0.2;diffusealpha,1;zoom,0.35);
			OffCommand=cmd(stoptweening;linear,0.1;zoomy,0;diffusealpha,0);
		};
		t[#t+1]=LoadFont("_russell square 16px") .. {
			Name = 'GVRD1Value_S4';
			InitCommand=cmd(horizalign,right;x,54+8.5;y,32;zoom,0;diffuse,color("1,1,1,0");diffusebottomedge,PlayerColor(PLAYER_1);strokecolor,Color("Outline");maxwidth,220);
			OnCommand=cmd(sleep,0.6;linear,0.2;diffusealpha,1;zoom,0.35);
			OffCommand=cmd(stoptweening;linear,0.1;zoomy,0;diffusealpha,0);
		};
		t[#t+1]=LoadFont("_russell square 16px") .. {
			Name = 'GVRD1Value_S5';
			InitCommand=cmd(horizalign,right;x,50+8.5;y,-6;zoom,0;diffuse,color("1,1,1,0");diffusebottomedge,PlayerColor(PLAYER_1);strokecolor,Color("Outline");maxwidth,220);
			OnCommand=cmd(sleep,0.6;linear,0.2;diffusealpha,1;zoom,0.35);
			OffCommand=cmd(stoptweening;linear,0.1;zoomy,0;diffusealpha,0);
		};



	else
		t[#t+1] = LoadActor( THEME:GetPathG("ScreenSelectProfile/ScreenSelectProfile", "GrooveRadar" ),1,0.2,0.2,0.2,0.5,PLAYER_2,'single')..{
			Name = "GVRD2S";
			InitCommand=cmd(x,3;y,5;zoom,0.56;diffusealpha,0;diffuse,PlayerColor(PLAYER_2));
			OnCommand=cmd(sleep,0.6;linear,0.2;diffusealpha,1;);
			OffCommand=cmd(linear,0.05;diffusealpha,0);
		};
		t[#t+1]=LoadFont("_russell square 16px") .. {
			Name = 'GVRD2Value_S1';
			InitCommand=cmd(horizalign,right;x,23+8.5;y,-25;zoom,0;diffuse,color("1,1,1,1");diffusebottomedge,PlayerColor(PLAYER_1);strokecolor,Color("Outline");maxwidth,220);
			OnCommand=cmd(sleep,0.6;linear,0.2;diffusealpha,1;zoom,0.35);
			OffCommand=cmd(stoptweening;linear,0.1;zoomy,0;diffusealpha,0);
		};
		t[#t+1]=LoadFont("_russell square 16px") .. {
			Name = 'GVRD2Value_S2';
			InitCommand=cmd(horizalign,right;x,-53+8.5;y,-6;zoom,0;diffuse,color("1,1,1,1");diffusebottomedge,PlayerColor(PLAYER_1);strokecolor,Color("Outline");maxwidth,220);
			OnCommand=cmd(sleep,0.6;linear,0.2;diffusealpha,1;zoom,0.35);
			OffCommand=cmd(stoptweening;linear,0.1;zoomy,0;diffusealpha,0);
		};
		t[#t+1]=LoadFont("_russell square 16px") .. {
			Name = 'GVRD2Value_S3';
			InitCommand=cmd(horizalign,right;x,-47+8.5;y,32;zoom,0;diffuse,color("1,1,1,1");diffusebottomedge,PlayerColor(PLAYER_1);strokecolor,Color("Outline");maxwidth,220);
			OnCommand=cmd(sleep,0.6;linear,0.2;diffusealpha,1;zoom,0.35);
			OffCommand=cmd(stoptweening;linear,0.1;zoomy,0;diffusealpha,0);
		};
		t[#t+1]=LoadFont("_russell square 16px") .. {
			Name = 'GVRD2Value_S4';
			InitCommand=cmd(horizalign,right;x,53+8.5;y,32;zoom,0;diffuse,color("1,1,1,1");diffusebottomedge,PlayerColor(PLAYER_1);strokecolor,Color("Outline");maxwidth,220);
			OnCommand=cmd(sleep,0.6;linear,0.2;diffusealpha,1;zoom,0.35);
			OffCommand=cmd(stoptweening;linear,0.1;zoomy,0;diffusealpha,0);
		};
		t[#t+1]=LoadFont("_russell square 16px") .. {
			Name = 'GVRD2Value_S5';
			InitCommand=cmd(horizalign,right;x,53+8.5;y,-6;zoom,0;diffuse,color("1,1,1,1");diffusebottomedge,PlayerColor(PLAYER_1);strokecolor,Color("Outline");maxwidth,220);
			OnCommand=cmd(sleep,0.6;linear,0.2;diffusealpha,1;zoom,0.35);
			OffCommand=cmd(stoptweening;linear,0.1;zoomy,0;diffusealpha,0);
		};
	end;



	return t;
end;

function UpdateInternal3(self, Player)

	local pn = (Player == PLAYER_1) and 1 or 2;
	local frame = self:GetChild(string.format('P%uFrame', pn));
	local scroller = frame:GetChild('Scroller');
	local seltext = frame:GetChild('SelectedProfileText');
	local joinframe = frame:GetChild('JoinFrame');
	local smallframe = frame:GetChild('SmallFrame');
	local bigframe = frame:GetChild('BigFrame');
	local selLevel = frame:GetChild('SelectedProfileLevel');
	local selectRank = frame:GetChild('selectRank');
	local selectPlayerUID = frame:GetChild('selectPlayerUID');
	local selSongsPlayed = frame:GetChild('selectSongsPlayed');
	local selLvBarBack = frame:GetChild('selectLvBarBack');
	local selLvBar = frame:GetChild('selectLvBar');
	--MyGrooveRadar
	local selPlayerUID;
	local selGVRDSingle = (Player == PLAYER_1) and frame:GetChild('GVRD1S') or frame:GetChild('GVRD2S');
	local selGVRDValue_S1 = (Player == PLAYER_1) and frame:GetChild('GVRD1Value_S1') or frame:GetChild('GVRD2Value_S1');
	local selGVRDValue_S2 = (Player == PLAYER_1) and frame:GetChild('GVRD1Value_S2') or frame:GetChild('GVRD2Value_S2');
	local selGVRDValue_S3 = (Player == PLAYER_1) and frame:GetChild('GVRD1Value_S3') or frame:GetChild('GVRD2Value_S3');
	local selGVRDValue_S4 = (Player == PLAYER_1) and frame:GetChild('GVRD1Value_S4') or frame:GetChild('GVRD2Value_S4');
	local selGVRDValue_S5 = (Player == PLAYER_1) and frame:GetChild('GVRD1Value_S5') or frame:GetChild('GVRD2Value_S5');

	local PcntLarger;
	--local selMostCoursePlayed = frame:GetChild('selectedMostCoursePlayed');
	if GAMESTATE:IsHumanPlayer(Player) then
		frame:visible(true);
		if MEMCARDMAN:GetCardState(Player) == 'MemoryCardState_none' then
			--using profile if any
			joinframe:visible(false);
			smallframe:visible(true);
			bigframe:visible(false);
			seltext:visible(true);
			scroller:visible(true);
			selLevel:visible(true);
			selectRank:visible(true);
			selSongsPlayed:visible(false);
			selLvBarBack:visible(true);
			selLvBar:visible(true);
			selGVRDSingle:visible(true);
			selGVRDValue_S1:visible(true);
			selGVRDValue_S2:visible(true);
			selGVRDValue_S3:visible(true);
			selGVRDValue_S4:visible(true);
			selGVRDValue_S5:visible(true);

			local ind = SCREENMAN:GetTopScreen():GetProfileIndex(Player);


			if ind > 0 then
				local profile = PROFILEMAN:GetLocalProfileFromIndex(ind-1);
				local PcntCompleteSingle = ProfileInfoCache[ind].SongsAndCoursesPercentCompleteAllDifficultiesSingle;
				local PcntCompleteDouble = ProfileInfoCache[ind].SongsAndCoursesPercentCompleteAllDifficultiesDouble;
				--HonorName

				if PcntCompleteSingle>PcntCompleteDouble then
					PcntLarger = PcntCompleteSingle;
				else
					PcntLarger = PcntCompleteDouble;
				end
				PcntLarger = PcntLarger*100;

				local Lv = math.ceil(math.sqrt(ProfileInfoCache[ind].TotalCaloriesBurned));
				local pcnt =(ProfileInfoCache[ind].TotalCaloriesBurned-((Lv-1)*(Lv-1))) /((Lv*Lv)-((Lv-1)*(Lv-1)));
				local totalPcnt = (PcntCompleteSingle + PcntCompleteDouble) / 2;
					--totalPcnt = PcntLarger;
				--local pcnt =((ProfileInfoCache[ind].TotalCaloriesBurned-((Lv-1)*(Lv-1))) /((Lv*Lv)-((Lv-1)*(Lv-1)));
				bigframe:visible(true);
				scroller:SetDestinationItem(ind-1);
				seltext:settext(ProfileInfoCache[ind].DisplayName);
				selLevel:settext(math.ceil(math.sqrt(ProfileInfoCache[ind].TotalCaloriesBurned) ));
				selSongsPlayed:settext(tostring(math.ceil(ProfileInfoCache[ind].NumTotalSongsPlayed)));
				selLvBar:cropright(1-pcnt);

				selPlayerUID = PROFILEMAN:GetLocalProfileFromIndex(ind-1):GetGUID();
				selectPlayerUID:settext(string.upper(string.sub(selPlayerUID,1,4).."-"..string.sub(selPlayerUID,5,8)));

				local RadarValueTableSingle = {};
				local RadarValueTableDouble = {};

				local profileID = PROFILEMAN:GetLocalProfileIDFromIndex(ind-1)
				local prefs = ProfilePrefs.Read(profileID)
				if SN3Debug then
					ProfilePrefs.Save(profileID)
				end

				----------Single Radar
				--Stream--
				RadarValueTableSingle[1] = MyGrooveRadar.GetRadarData(profileID, 'single', 'stream')
                selGVRDValue_S1:settext(string.format("%0.1f", RadarValueTableSingle[1]*100));
                --Voltage--
                RadarValueTableSingle[2] = MyGrooveRadar.GetRadarData(profileID, 'single', 'voltage')
                selGVRDValue_S2:settext(string.format("%0.1f", RadarValueTableSingle[2]*100));
                --Air--
                RadarValueTableSingle[3] = MyGrooveRadar.GetRadarData(profileID, 'single', 'air')
                selGVRDValue_S3:settext(string.format("%0.1f", RadarValueTableSingle[3]*100));
				--Freeze--
                RadarValueTableSingle[4] = MyGrooveRadar.GetRadarData(profileID, 'single', 'freeze')
                selGVRDValue_S4:settext(string.format("%0.1f", RadarValueTableSingle[4]*100));
				--Chaos--
                RadarValueTableSingle[5] = MyGrooveRadar.GetRadarData(profileID, 'single', 'chaos')
                selGVRDValue_S5:settext(string.format("%0.1f", RadarValueTableSingle[5]*100));

				-- Save the past values, which we will need later
				local pastValues = GetOrCreateChild(GAMESTATE:Env(), 'PastRadarValues')
				pastValues[Player] = DeepCopy(MyGrooveRadar.GetRadarTable(profileID))

				SetRankFromRadarValue(selectRank,RadarValueTableSingle);

			else
				if SCREENMAN:GetTopScreen():SetProfileIndex(Player, 1) then
					bigframe:visible(false);
					scroller:SetDestinationItem(0);
					self:queuecommand('UpdateInternal2');
				else
					joinframe:visible(false);
					smallframe:visible(false);
					bigframe:visible(false);
					scroller:visible(false);
					seltext:settext('No profile');
					selectPlayerUID:settext('------------');
					selLevel:settext('No level info');
					selectRank:settext('???');
					selSongsPlayed:visible(false);
					selLvBarBack:visible(true);
					selLvBar:visible(false);

					selGVRDSingle:visible(false);
					selGVRDValue_S1:visible(false);
					selGVRDValue_S2:visible(false);
					selGVRDValue_S3:visible(false);
					selGVRDValue_S4:visible(false);
					selGVRDValue_S5:visible(false);
				end;
			end;
		else
			--using card
			smallframe:visible(false);
			scroller:visible(false);
			seltext:settext('CARD');
			SCREENMAN:GetTopScreen():SetProfileIndex(Player, 0);
		end;
	else
		joinframe:visible(true);
		scroller:visible(false);
		seltext:visible(false);
		selectPlayerUID:visible(false);
		smallframe:visible(false);
		bigframe:visible(false);
		selLevel:visible(false);
		selectRank:visible(false);
		selSongsPlayed:visible(false);
		selLvBarBack:visible(false);
		selLvBar:visible(false);

		selGVRDSingle:visible(false);
		selGVRDValue_S1:visible(false);
		selGVRDValue_S2:visible(false);
		selGVRDValue_S3:visible(false);
		selGVRDValue_S4:visible(false);
		selGVRDValue_S5:visible(false);
	end;
end;

--�D�{��
local t = Def.ActorFrame {

	StorageDevicesChangedMessageCommand=function(self, params)
		self:queuecommand('UpdateInternal2');
	end;

	CodeMessageCommand = function(self, params)
		if params.Name == 'Start' or params.Name == 'Center' then
			MESSAGEMAN:Broadcast("StartButton");
			if not GAMESTATE:IsHumanPlayer(params.PlayerNumber) then
				SCREENMAN:GetTopScreen():SetProfileIndex(params.PlayerNumber, -1);
			else
				SCREENMAN:GetTopScreen():Finish();
			end;
		end;
		if params.Name == 'Up' or params.Name == 'Up2' or params.Name == 'DownLeft' then
			if GAMESTATE:IsHumanPlayer(params.PlayerNumber) then
				local ind = SCREENMAN:GetTopScreen():GetProfileIndex(params.PlayerNumber);
				if ind > 1 then
					if SCREENMAN:GetTopScreen():SetProfileIndex(params.PlayerNumber, ind - 1 ) then
						MESSAGEMAN:Broadcast("DirectionButton");
						self:queuecommand('UpdateInternal2');
					end;
				end;
			end;
		end;
		if params.Name == 'Down' or params.Name == 'Down2' or params.Name == 'DownRight' then
			if GAMESTATE:IsHumanPlayer(params.PlayerNumber) then
				local ind = SCREENMAN:GetTopScreen():GetProfileIndex(params.PlayerNumber);
				if ind > 0 then
					if SCREENMAN:GetTopScreen():SetProfileIndex(params.PlayerNumber, ind + 1 ) then
						MESSAGEMAN:Broadcast("DirectionButton");
						self:queuecommand('UpdateInternal2');
					end;
				end;
			end;
		end;
		if params.Name == 'Back' then
			if GAMESTATE:GetNumPlayersEnabled()==0 then
				SCREENMAN:GetTopScreen():Cancel();
			else
				MESSAGEMAN:Broadcast("BackButton");
				SCREENMAN:GetTopScreen():SetProfileIndex(params.PlayerNumber, -2);
			end;
		end;
	end;

	PlayerJoinedMessageCommand=function(self, params)
		self:queuecommand('UpdateInternal2');
	end;

	PlayerUnjoinedMessageCommand=function(self, params)
		self:queuecommand('UpdateInternal2');
	end;

	OnCommand=function(self, params)
		self:queuecommand('UpdateInternal2');
	end;

	UpdateInternal2Command=function(self)
		UpdateInternal3(self, PLAYER_1);
		UpdateInternal3(self, PLAYER_2);
	end;

	children = {
		Def.ActorFrame {
			Name = 'P1Frame';
			InitCommand=cmd(x,SCREEN_CENTER_X-160;y,SCREEN_CENTER_Y+20;zoom,2);
			OnCommand=cmd(sleep,8);
			OffCommand=cmd();
			PlayerJoinedMessageCommand=function(self,param)
				if param.Player == PLAYER_1 then
					(cmd(zoomx,2;zoomy,0.15;linear,0.175;zoomy,2;))(self);
				end;
			end;
			children = LoadPlayerStuff(PLAYER_1);
		};
		Def.ActorFrame {
			Name = 'P2Frame';
			InitCommand=cmd(x,SCREEN_CENTER_X+160;y,SCREEN_CENTER_Y+20;zoom,2;);
			OnCommand=cmd(sleep,8);
			OffCommand=cmd();
			PlayerJoinedMessageCommand=function(self,param)
				if param.Player == PLAYER_2 then
					(cmd(zoomx,2;zoomy,0.15;linear,0.175;zoomy,2;))(self);
				end;
			end;
			children = LoadPlayerStuff(PLAYER_2);
		};
		-- sounds
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
};


return t;
