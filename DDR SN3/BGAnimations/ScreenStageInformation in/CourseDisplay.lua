local courseName = GAMESTATE:GetCurrentCourse():GetBannerPath()

local t = Def.ActorFrame{};

if courseName then
	-- banner
t[#t+1] = Def.Sprite {
	InitCommand=cmd(Center);
	BeginCommand=function(self)
		self:Load(courseName);
		self:setsize(256,80);
	end;
		--[[BeginCommand=function(self)
			if FILEMAN:DoesFileExist(course:GetBannerPath()) then
				self:Load(courseBanner);
				self:setsize(256,80);
			else
				self:Load(THEME:GetPathG("", "Common fallback banner"));
				-- self:Load(THEME:GetCurrentThemeDirectory() .. "Graphics/Common fallback banner (doubleres)");
				self:setsize(256,80);
			end
		end;
		--]]
	OnCommand=cmd(scaletoclipped,256,80;CenterX;y,SCREEN_CENTER_Y-134;zoomy,0;sleep,0.099;sleep,0.396;linear,0.099;zoomy,1);
}
else
t[#t+1] = LoadActor(THEME:GetPathG("","Common fallback banner"))..{
	InitCommand=cmd(Center);
	OnCommand=cmd(scaletoclipped,256,80;CenterX;y,SCREEN_CENTER_Y-134;zoomy,0;sleep,0.099;sleep,0.396;linear,0.099;zoomy,1);
}
end


return t;
