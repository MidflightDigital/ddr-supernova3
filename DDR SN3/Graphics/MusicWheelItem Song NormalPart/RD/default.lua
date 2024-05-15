local group_colors = {
	["1-Licenses"]= "#FFFFFF",
	["2-KONAMI Originals"]= "#00CC00",
	["3-Requests"]= "#FFFF00",
	["4-Revivials"]= "#33CCFF",
	["5-NOVAmix"]= "#FF00FF",
	["6a-ENCORE EXTRA STAGE"]= "#FF9933",
	["6b-EXTRA STAGE"]= "#FF0000",
	["7-DLC"]= "#FF9933",
};

local t = Def.ActorFrame {
	--Main
	Def.Quad{
		InitCommand=cmd(setsize,148,148);
		SetCommand=function(self, param)
			local Song = param.Song;
			if Song then
				--local color_grp= group_colors[Song:GetGroupName()] or "FFFFFF"
				--self:diffuse(color(color_grp));
				self:diffuse(SongAttributes.GetMenuColor(Song))
			end;
		end;
	};
	--Shade
	Def.Quad{
		InitCommand=cmd(setsize,148,148;fadetop,0.8;diffuse,color("0,0,0,0.75"));
	};
	--Black BG
	Def.Quad{
		InitCommand=cmd(setsize,128,128;diffuse,color("0,0,0,1"));
	};
	Def.Sprite{
		Name="Banner";
		InitCommand=cmd(scaletoclipped,128,128);
		SetCommand=function(self,param)
			local Song = param.Song;
			if Song then
				if Song:HasJacket() then
					self:Load(Song:GetJacketPath() );
				elseif Song:HasBackground() then
					self:Load(Song:GetBackgroundPath());
				elseif Song:HasBanner() then
					self:Load(Song:GetBannerPath());
				else
					self:Load(THEME:GetPathG("","Common fallback Jacket"));
				end;
			end;
		end;
	};
--new song
LoadActor("../../ScreenSelectMusic NewSong")..{
	InitCommand=cmd(x,-138;y,-25;finishtweening;draworder,1;visible,SCREENMAN:GetTopScreen() ~= "ScreenNetRoom");
	OnCommand=cmd(diffusealpha,0;sleep,1;diffusealpha,1);
	SetCommand=function(self,param)
		if param.Song then
			if PROFILEMAN:IsSongNew(param.Song) then
				self:visible(true);
			else
				self:visible(false);
			end
		else
			self:visible(false);
		end
	end;
};
};

for _, pn in pairs(GAMESTATE:GetEnabledPlayers()) do
	table.insert(t, WheelLightEX(pn, true))
end

return t;
