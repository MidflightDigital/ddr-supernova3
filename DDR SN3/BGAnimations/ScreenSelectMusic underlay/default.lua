local t = Def.ActorFrame {};
function IsRDG()
	if GAMESTATE then
		local env = GAMESTATE:Env()
		if GAMESTATE:Env() then
			return false
		end
	end
end
local factors = {201, 167, 135, 104, 75, 47, 21, -3, -28, -53, -79, -107, -136, -167, -199}

for i=1,15 do
	local ri = (i==9) and 8 or i
	t[ri] = Def.ActorFrame {
		LoadActor( "w"..string.format("%02u", ri) )..{
			OnCommand=cmd(x,WheelBGPosX();y,SCREEN_CENTER_Y+factors[ri];addx,SCREEN_WIDTH/640*328;sleep,0.412;linear,0.196;addx,-(SCREEN_WIDTH/640*328));
			OffCommand=cmd(sleep,0.016;accelerate,0.25;addx,(SCREEN_WIDTH/2));
		};
	}
end

t[#t+1] = Def.ActorFrame {
	LoadActor(THEME:GetPathG("","_shared/MusicWheel/_section inner"))..{
		InitCommand=cmd(x,HighlightBGPosX()-4;halign,1;zoom,1.05;y,SCREEN_CENTER_Y-17;diffuseshift;effectcolor1,1,1,1,1;effectcolor2,0.5,0.5,0.5,1;effectperiod,3;);
		OnCommand=cmd(addx,SCREEN_WIDTH/2;sleep,0.6;decelerate,0.34;addx,-SCREEN_WIDTH/2);
		OffCommand=cmd(sleep,0.016;accelerate,0.25;addx,SCREEN_WIDTH);
	};
};

--[[song_colors= {
	["MAX 300"]= "1,0,0,1",
	["MAXX UNLIMITED"] = "0.2,1,0.5",
	["The legend of MAX"]= "1,0,1,1",
};

t[#t+1] = Def.Quad{
	InitCommand=cmd(FullScreen;blend,Blend.Add;);
	SetCommand=function(s)
		local song = GAMESTATE:GetCurrentSong()
		if song then
			local songname = song:GetDisplayMainTitle()
			if song_colors[songname] ~= nil then
				s:diffuse(color(song_colors[songname]))
			else
				s:diffuse(color("0,1,0,1"))
			end;
		else
			s:diffuse(color("0,0,1,1"))
		end;
	end;
	CurrentSongChangedMessageCommand=cmd(queuecommand,"Set");
}]]--

return t
