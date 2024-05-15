--This defines the central frame of the evaluation screen.
--It is drawn as a thinner quad that is entirely black and covers the whole width
--then a thicker quad only in the center which fades from quadColor to black,
--through midColor. As the thicker quad needs its corners cut out, an ActorMultiVertex
--draws four triangles which mask those corners.

local args = {...}
local metrics = args[1]
--the absolute right side of the shape
metrics.RIGHT = metrics.WIDTH/2
--the absolute left side of the shape
metrics.LEFT = -metrics.RIGHT
--the height of the central rectangle of the shape
metrics.QHEIGHT = metrics.QTOP - metrics.QBOTTOM
--the width of the ears of the tabs
metrics.TAB_WIDTH = metrics.ITEM_HEIGHT
--the left edge of the top/bottom of the tabs
metrics.TAB_LEFT = metrics.TLEFT + metrics.TAB_WIDTH
--the right edge of the top/bottom of the tabs
metrics.TAB_RIGHT = metrics.TRIGHT - metrics.TAB_WIDTH

local black = {0,0,0,1}
local maskVertices = {
	--top left corner
	{{metrics.TLEFT, metrics.QTOP, 0}, black},
	{{metrics.TLEFT, metrics.TOP, 0}, black},
	{{metrics.TAB_LEFT, metrics.TOP, 0}, black},
	--top right corner
	{{metrics.TRIGHT, metrics.QTOP, 0}, black},
	{{metrics.TRIGHT, metrics.TOP, 0}, black},
	{{metrics.TAB_RIGHT, metrics.TOP, 0}, black},
	--bottom left corner
	{{metrics.TLEFT, metrics.QBOTTOM, 0}, black},
	{{metrics.TLEFT, metrics.BOTTOM, 0}, black},
	{{metrics.TAB_LEFT, metrics.BOTTOM, 0}, black},
	--bottom right corner
	{{metrics.TRIGHT, metrics.QBOTTOM, 0}, black},
	{{metrics.TRIGHT, metrics.BOTTOM, 0}, black},
	{{metrics.TAB_RIGHT, metrics.BOTTOM, 0}, black}
}

local quadColor = color"#00CDBF"
local midColor = {0,quadColor[2]/2,quadColor[3]/2,1}

return Def.ActorFrame{
	--the base rectangle
	Def.Quad{
		InitCommand=function(s) s:zoomx(metrics.WIDTH):zoomy(metrics.QHEIGHT):diffuse(black) end
	},
	--the shaping mask
	Def.ActorMultiVertex{
		InitCommand=function(s) s:SetVertices(maskVertices):SetDrawState{Mode='DrawMode_Triangles'}:MaskSource() end
	},
	--the central colored quads
	Def.Quad{
		InitCommand=function(s) s:zoomx(metrics.CORE/2):zoomy(metrics.HEIGHT):halign(1)
			:diffuse(midColor):diffuseleftedge(black):diffuserightedge(quadColor):MaskDest()
		end
	},
	Def.Quad{
		InitCommand=function(s) s:zoomx(metrics.CORE/2):zoomy(metrics.HEIGHT):halign(0)
			:diffuse(midColor):diffuseleftedge(quadColor):diffuserightedge(black):MaskDest()
		end
	}
}