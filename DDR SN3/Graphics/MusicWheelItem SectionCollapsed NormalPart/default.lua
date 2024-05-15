local group_colors = {
	["1-Licenses"]= color "#FFFFFF",
	["2-KONAMI Originals"]= color "#00CC00",
	["3-Requests"]= color "#FFFF00",
	["4-Revivials"]= color "#33CCFF",
	["5-NOVAmix"]= color "#FF00FF",
	["6a-ENCORE EXTRA STAGE"]= color "#FF9933",
	["6b-EXTRA STAGE"]= color "#FF0000",
	["7-DLC"]= color "#FF9933",
};

local group_names = {
	["1-Licenses"]= "Licenses",
	["2-KONAMI Originals"]= "KONAMI Originals",
	["3-Requests"]= "Requests",
	["4-Revivials"]= "Revivals",
	["5-NOVAmix"]= "NOVAmix",
	["6a-ENCORE EXTRA STAGE"]= "ENCORE EXTRA STAGE",
	["6b-EXTRA STAGE"]= "EXTRA STAGE",
	["7-DLC"]= "DLC",
};

local t = Def.ActorFrame {
	LoadActor(THEME:GetPathG("","_shared/MusicWheel/_section inner"))..{
		SetMessageCommand=function(self, param)
			local group = param.Text;
			local color_grp= group_colors[group] or SongAttributes.GetGroupColor(group);
			self:diffuse(color_grp);
		end;
	};
	LoadActor(THEME:GetPathG("","_shared/MusicWheel/_section outer"));
};

t[#t+1] = Def.ActorFrame{
	--GroupName
	Def.BitmapText{
		Font="_handelgothic bt 20px";
		InitCommand=cmd(halign,0;x,-140;maxwidth,256;);
		SetMessageCommand=function(self, param)
		local group = param.Text;
		local groupname = group_names[group];
			self:settext(groupname or SongAttributes.GetGroupName(group));
		local color_grp= group_colors[group] or SongAttributes.GetGroupColor(group);
			self:diffuse(color_grp);
		end;
	};
};

return t;
