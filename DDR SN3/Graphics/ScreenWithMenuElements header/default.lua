local screenName = Var "LoadingScreen"
local headerTextImage

--this should probably be a metric
if screenName == "ScreenSelectMusic" then
    headerTextImage = "MusicStd (doubleres).png"
elseif screenName == "ScreenSelectMusicStarter" then
    headerTextImage = "MusicStrt (doubleres).png"
elseif screenName == "ScreenSelectMusicExtra" then
    headerTextImage = "extra (doubleres).png"
  elseif screenName == "ScreenSelectMusicRD" then
      headerTextImage = "_MusicRCD (doubleres).png"

elseif string.find(screenName, "Options") then
    headerTextImage = "Options (doubleres).png"

elseif screenName == "ScreenNetRoom" or screenName == "ScreenNetSelectMusic" or screenName == "ScreenSMOnlineLogin" then
    headerTextImage = "Online (doubleres).png"

elseif screenName == "ScreenMapControllers" then
	headerTextImage = "Options (doubleres).png"

elseif screenName == "ScreenSelectStyle" then
    headerTextImage = "Style (doubleres).png"

elseif screenName == "ScreenSelectPlayMode"
	or screenName == "ScreenSelectPlayCourseMode"
	or screenName == "ScreenSelectPlayModeMulti" then
    headerTextImage = "Mode (doubleres).png"

elseif screenName == "ScreenSelectCourse" then
    headerTextImage = "Course (doubleres).png"

elseif screenName == "ScreenSelectProfile" then
	headerTextImage = "profile (doubleres).png"

elseif screenName == "ScreenDataSaveSummary" then
	headerTextImage = "save (doubleres).png"

elseif string.find(screenName, "ScreenEvaluation")
  or screenName == "ScreenNetEvaluation" then
	headerTextImage = "eval (doubleres).png"
end

local headerBaseImage

if screenName == "ScreenSelectProfile" then
	headerBaseImage = "centerbase (doubleres).png"
elseif screenName == "ScreenDataSaveSummary" then
	headerBaseImage = "centerbase (doubleres).png"
elseif string.find(screenName, "ScreenEvaluation")
  or screenName == "ScreenNetEvaluation" then
	headerBaseImage = "centerbase (doubleres).png"
elseif screenName == "ScreenSelectMusicRD" then
	headerBaseImage = "RDbase (doubleres).png"
elseif screenName == "ScreenSelectMusicExtra" then
	headerBaseImage = "extrabase (doubleres).png"
else
	headerBaseImage = "regular/default.lua"
end

local function UpdateAni(self)
	local timer = SCREENMAN:GetTopScreen():GetChild "Timer"
	local ani = self:GetChild "ani"
	if timer and ani then
		local time = timer:GetSeconds()
		local ftime = time - math.floor(time)
		ani:rotationz(360*ftime)
	elseif timer then
		timer:visible(false)
		self:SetUpdateFunction(nil)
	end
end

--Base Anchoring
local out = Def.ActorFrame{
	InitCommand=function(self) self:SetUpdateFunction(UpdateAni) end;
	LoadActor(headerBaseImage)..{
		InitCommand=function(self)
			if screenName == "ScreenSelectProfile" then
				self:x(SCREEN_CENTER_X):halign(0.5)
			elseif string.find(screenName, "ScreenEvaluation")
  				or screenName == "ScreenNetEvaluation" then
				self:x(SCREEN_CENTER_X):halign(0.5)
			elseif screenName == "ScreenDataSaveSummary" then
				self:x(SCREEN_CENTER_X):halign(0.5)
      		elseif screenName == "ScreenSelectMusicExtra" then
				self:x(SCREEN_CENTER_X):halign(0.5)
			else
				self:x(SCREEN_LEFT-1.2):halign(0);
			end;
		end;
	};
}

if PREFSMAN:GetPreference("MenuTimer") == true then
	table.insert(out,LoadActor("time")..{
		InitCommand=cmd(x,SCREEN_RIGHT-50;y,SCREEN_TOP+12);
		OffCommand=cmd(bouncebegin,0.25;zoom,0);
	})
	table.insert(out,LoadActor("ani")..{
		Name="ani";
		InitCommand=cmd(x,SCREEN_RIGHT-50;y,SCREEN_TOP+12;diffusealpha,0.5);
		OnCommand=cmd(addy,-76;sleep,0.2;decelerate,0.2;addy,76;blend,Blend.Add);
		OffCommand=cmd(bouncebegin,0.25;zoom,0);
	})
end

--Text Anchoring
if headerTextImage then
	table.insert(out,LoadActor(headerTextImage)..{
		InitCommand=function(self)
			self:y(8):valign(1);
			if screenName == "ScreenSelectProfile" then
				self:x(SCREEN_CENTER_X):halign(0.5):y(10)
			elseif string.find(screenName, "ScreenEvaluation")
  				or screenName == "ScreenNetEvaluation" then
				self:x(SCREEN_CENTER_X):halign(0.5):y(10)
			elseif screenName == "ScreenDataSaveSummary" then
				self:x(SCREEN_CENTER_X):halign(0.5):y(10)
      elseif screenName == "ScreenSelectMusicExtra" then
				self:x(SCREEN_CENTER_X):halign(0.5):y(10)
      elseif screenName == "ScreenSelectMusicStarter" then
				self:x(SCREEN_LEFT+123):y(8)
      elseif screenName == "ScreenSelectMusic" then
				self:x(SCREEN_LEFT+123):y(8);
      elseif screenName == "ScreenSelectMusicRD" then
				self:x(SCREEN_CENTER_X):y(3)
			else
				self:x(SCREEN_LEFT+123):y(8);
			end;
		end;
	})
end

return out
