return Def.ActorFrame{
	Def.BitmapText{
		Font= "Common Normal",
		Text= SN3DirtyFlag and THEME:GetString("ScreenSelfTest", "DirtyWarning") or "",
		InitCommand= function(self)
			self:xy(SCREEN_CENTER_X, SCREEN_CENTER_Y):wrapwidthpixels(SCREEN_WIDTH-16)
				:diffuse{1, 1, 1, 1}:strokecolor{0, 0, 0, 1}
		end,
		OnCommand= function()
			if not SN3DirtyFlag then
				SCREENMAN:GetTopScreen():StartTransitioningScreen("SM_GoToNextScreen")
			end
		end
	}
}
