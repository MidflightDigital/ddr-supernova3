local transform = function(self,offsetFromCenter,itemIndex,numitems)
	self:y( offsetFromCenter * 44 );
end
return Def.CourseContentsList {
	MaxSongs = 10;
    NumItemsToDraw = 5;
	SetCommand=function(self)
		self:SetFromGameState();
		self:SetCurrentAndDestinationItem(1);
		self:SetPauseCountdownSeconds(1);
		self:SetSecondsPauseBetweenItems( 0.25 );
--		self:SetTransformFromFunction(transform);
		--
		self:SetDestinationItem(1);
		self:SetLoop(false);
		self:SetMask(294,44);
	end;
	CurrentTrailP1ChangedMessageCommand=cmd(playcommand,"Set");
	CurrentTrailP2ChangedMessageCommand=cmd(playcommand,"Set");

	Display = Def.ActorFrame { 
		InitCommand=cmd(setsize,270,44);

		LoadActor(THEME:GetPathG("CourseEntryDisplay","bar"));
		LoadFont("Common Course")..{
				InitCommand=cmd(x,-110);
				SetSongCommand=function(self,param)
				self:settext(param.Number)
			end;
		};
		Def.TextBanner{
				InitCommand=cmd(x,-89;draworder,99;Load,"TextBannerGameplay";SetFromString,"","","","","","");
				SetSongCommand=function(self,param)
					if not param.Song or param.Secret then
						-- set fake ("??????????" with no artist)
						self:SetFromString("??????????","??????????", "","", "","")
						self:diffuse(color("#FFFFFF"))
					else
						-- set real
						self:SetFromSong(param.Song)
						self:diffuse(SongAttributes.GetMenuColor(param.Song))
					end
				end;
			};

 		LoadActor(THEME:GetPathF("StepsDisplay","ticks 2x1.png"))..{
				Name="FootClanMembershipToken"; -- teenage mutant ninja stepmania
				InitCommand=cmd(x,90;y,9;pause;);
				SetSongCommand=function(self,param)
					local difficulty = param.Difficulty
					local customDiff = GetCustomDifficulty(param.Steps:GetStepsType(),difficulty,nil)
					self:diffuse(CustomDifficultyToColor(customDiff))
				end;
			};
			LoadFont("ScreenMusicScroll titles")..{
				Name="DifficultyMeter";
				InitCommand=cmd(x,100;y,12;zoom,0.8);
				SetSongCommand=function(self,param)
					self:settext(param.Meter)
					local difficulty = param.Difficulty
					local customDiff = GetCustomDifficulty(param.Steps:GetStepsType(),difficulty,nil)
					self:diffuse(CustomDifficultyToColor(customDiff))
				end;
			};
			-- modifiers
			LoadFont("Common normal")..{
				InitCommand=cmd(x,128;y,10;halign,1;zoom,0.5);
				SetSongCommand=function(self,param)
					self:settext(param.Modifiers)
				end;
			};
	};
};