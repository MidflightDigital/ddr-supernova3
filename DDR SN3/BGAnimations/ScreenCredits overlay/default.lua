local t = Def.ActorFrame{
	LoadActor( "music" )..{
		OnCommand=cmd(play);
		OffCommand=cmd(stop);
	};
};

local credfile = RageFileUtil.CreateRageFile()
credfile:Open(THEME:GetAbsolutePath("Other/credits.txt"), 1)
local creditsData = CreditsDef.Load(credfile)
credfile:Close(); credfile:destroy()

local function GetScrollerItem(text, col)
	return Def.BitmapText{
		Font='_futura std medium 20px',
		Text=text,
		InitCommand=function(s) s:diffuse(col):halign(0) end
	}
end

local u = {}
for sec_number, section in ipairs(creditsData) do
	u[#u+1] = GetScrollerItem(section[1], color "#00CDBF")
	for i=2,#section do
		u[#u+1] = GetScrollerItem(section[i], color "#FFFFFF")
	end
	if sec_number ~= #creditsData then
		for i=1,2 do
			u[#u+1] = Def.Actor{}
		end
	end
end

for i=1,30 do
	u[#u+1] = Def.Actor{}
end

t[#t+1] = Def.ActorFrame{
	LoadFont("_futura std medium 20px")..{
		InitCommand=function(self)
			self:settext("DanceDanceRevolution SuperNOVA 3")
			:zoom(1.5)
			:Center()
		end;
		OnCommand=cmd(diffusealpha,0;zoom,8;sleep,1;accelerate,1;zoom,1.5;diffusealpha,1;decelerate,2;zoom,2;zoomx,2;diffusealpha,0;queuecommand,"StartScroll");
		StartScrollCommand=function() MESSAGEMAN:Broadcast("StartCreditsScroller") end;
	};
};

t[#t+1] = Def.ActorScroller{
	SecondsPerItem=0.7,
	PaddingBefore=1,
	PaddingAfter=5,
	BeginCommand=function()
		SCREENMAN:GetTopScreen():PostScreenMessage( 'SM_MenuTimer', (#u*0.7) )
	end,
	InitCommand=function(s) s:x(SCREEN_CENTER_X/4):y(SCREEN_BOTTOM+50) end,
	StartCreditsScrollerMessageCommand=function(s) s:ScrollWithPadding(1,5) end,
	TransformFunction=function(s, offset) s:y(offset*22) end,
	NumItemsToDraw=#u,
	children=u
}

return t;
