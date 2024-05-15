local t = Def.ActorFrame{}

if SN3Debug and (not GAMESTATE:IsCourseMode()) then
	local yPositions = {
		PlayerNumber_P1 = SCREEN_TOP+115,
		PlayerNumber_P2 = SCREEN_BOTTOM-115
	}
	for _,pn in pairs(PlayerNumber) do
		t[#t+1] = Def.ActorFrame{InitCommand=function(s) s:x(EditWindowPosX()):y(yPositions[pn]) end,
			LoadActor("edit window", pn)}
	end
end

return t