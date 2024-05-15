-- ScreenMusicScroll overlay
-- todo: sort the songs somehow

local songTitles = {}
for idx, song in ipairs(SONGMAN:GetAllSongs()) do
	songTitles[idx] = song:GetTranslitFullTitle()
end

--sort them
table.sort(songTitles)

local function MakeSongItem(title)
	return LoadFont("MusicList titles")..{
		Text=title;
		InitCommand=cmd(diffuse,color("1,1,1,1");zoom,0.75;halign,0;maxwidth,300);
	};
end;

local numItems = 36;

local scrollerChildren = {};
for title in ivalues(songTitles) do
	table.insert(scrollerChildren,MakeSongItem(title))
end;

--padding to force all the song titles to scroll off the screen
for i=(#scrollerChildren)+1, (#scrollerChildren)+math.floor(numItems/2) do
	scrollerChildren[i] = Def.Actor{}
end

local secondsPerItem = 0.15
local paddingBefore = 4
local paddingAfter = 4

return Def.ActorFrame{
	Def.ActorScroller{
		SecondsPerItem=secondsPerItem;
		NumItemsToDraw=numItems;
		InitCommand=cmd(x,SCREEN_LEFT+52;y,SCREEN_BOTTOM-88);
		BeginCommand=function(self)
			SCREENMAN:GetTopScreen():PostScreenMessage( 'SM_MenuTimer', math.min(30,(secondsPerItem * (#scrollerChildren + paddingBefore + paddingAfter))) );
		end;
		OnCommand=cmd(ScrollWithPadding,paddingBefore,paddingAfter);
		TransformFunction=function(self,offset,itemIndex,numItems)
			self:y(offset * 22);
		end;
		children = scrollerChildren;
	};
};
