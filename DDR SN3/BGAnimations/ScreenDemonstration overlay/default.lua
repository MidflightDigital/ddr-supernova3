local t = Def.ActorFrame{
	LoadActor("demup")..{
		InitCommand=cmd(x,SCREEN_LEFT;;halign,0;valign,0);
	};
	LoadActor("demdown")..{
		InitCommand=cmd(x,SCREEN_RIGHT;y,SCREEN_BOTTOM;halign,1;valign,1);
	};
	LoadActor("bar")..{
		InitCommand=cmd(halign,1;x,SCREEN_RIGHT;y,SCREEN_BOTTOM-60);
	};
};

--song jacket--
t[#t+1] = Def.ActorFrame{
	InitCommand=cmd(y,SCREEN_BOTTOM-125);
	Def.Sprite{
		OnCommand=function(self)
		local song = GAMESTATE:GetCurrentSong();
			if song:HasBanner() then
				self:LoadFromSongBanner(song);
				self:setsize(256,80);
			else
				self:Load(THEME:GetPathG("","Common fallback banner"));
				self:setsize(256,80);
			end;
		self:halign(1):x(SCREEN_RIGHT);
		end;
	};
};
--songinfo--
t[#t+1] = LoadFont("TextBanner text")..{
	InitCommand=cmd(halign,1;x,SCREEN_RIGHT-112;y,SCREEN_BOTTOM-65;zoom,0.9;draworder,50);
	CurrentSongChangedMessageCommand=function(self)
		local song = GAMESTATE:GetCurrentSong();
		if song then
		local text = song:GetDisplayFullTitle();
			self:diffusealpha(1);
			self:maxwidth(200);
			self:settext(text);
		end;
	end;
};
--artist--
t[#t+1] = LoadFont("TextBanner text")..{
	InitCommand=cmd(halign,1;x,SCREEN_RIGHT-112;y,SCREEN_BOTTOM-50;zoom,0.8;draworder,50);
	CurrentSongChangedMessageCommand=function(self)
		local song = GAMESTATE:GetCurrentSong();
		if song then
		local text = song:GetDisplayArtist();
			self:diffusealpha(1);
			self:maxwidth(200);
			self:settext(text);
		end;
	end;
};

return t;
