local args = ({...})[1]
local tickPos = args.PositionX
local diff = args.Difficulty

local trackPN = args.TrackPN
local FindSteps = function(song) return song:GetOneSteps(GAMESTATE:GetCurrentStyle():GetStepsType(), diff) end
if trackPN then
    FindSteps = function()
        local steps = GetCurrentStepsPossiblyCPU(trackPN)
        if steps and steps:GetDifficulty() == diff then
            return steps
        end
        return nil
    end
end

local diffColor
local hardXColor = DDRDiffList.HardXColor
local lightXColor = DDRDiffList.LightXColor
local darkXColor = DDRDiffList.DarkXColor

--[[TICKS UNDERLAY]]
local ticksUnder = Def.Sprite{
    Name="TicksUnder",
    Texture="ticks",
    InitCommand = function(self) self:halign(0):diffuse(DiffHelpers.DiffToColor(diff,true)) end,
}
DDRDiffList.MessageHandlers(ticksUnder, function(self, _, XMode)
    if XMode then --do x position for X mode
        self:x(tickPos-62)
    else --do x position for SN mode
        self:x(tickPos-80)
    end

    local diffColor = XMode and darkXColor or DiffHelpers.DiffToColor(diff, true)
    local song = GAMESTATE:GetCurrentSong()
    if song then
        local steps = FindSteps(song)
        if steps then
            local meter = steps:GetMeter()
            if meter > 10 and XMode then
                --this only happens in X mode so no need to pick an alternative
                self:diffuse(lightXColor):cropleft(math.min(1,(meter-10)/10))
            else
                self:diffuse(diffColor):cropleft(math.min(1,meter/10))
            end
        else
            self:diffuse(diffColor):cropleft(0)
        end
    else
        self:diffuse(diffColor):cropleft(0)
    end
end)
--[[END TICKS UNDERLAY]]

--[[TICKS OVERLAY]]
local ticksOver = Def.Sprite{
    Name = "TicksOver",
    Texture = "ticks",
    InitCommand = function(self) self:diffuse(DiffHelpers.DiffToColor(diff)):halign(0):cropright(1) end,
}
DDRDiffList.MessageHandlers(ticksOver, function(self, songChanged, XMode)
    --standard mode switching crapola
    if XMode then
        self:x(tickPos-62)
    else
        self:x(tickPos-80)
    end
    local diffColor = XMode and lightXColor or DiffHelpers.DiffToColor(diff)
    local song = GAMESTATE:GetCurrentSong()
    if song then
        if songChanged then self:stopeffect() end
        local steps = FindSteps(song)
        if steps then
            local meter = steps:GetMeter()
            if meter > 10 then
                if XMode then
                    self:diffuse(hardXColor):cropright(math.max(0,1-(meter-10)/10))
                else
                    self:diffuse(diffColor):cropright(0):glowshift():effectcolor1(color "#FFFFFF00"):effectcolor2(color "#FFFFFFFF")
                end
            else
                self:diffuse(diffColor):stopeffect():cropright(1-meter/10)
            end
        else
            self:stopeffect():cropright(1)
        end
    else
        self:stopeffect():cropright(1)
    end
end)
--[[END TICKS OVERLAY]]

--[[METER NUMBER]]
local meter = Def.BitmapText{
    Font="_handelgothic bt 20px";
    InitCommand=function(self) self:x(tickPos-78):diffuse{0.5,0.5,0.5,1}:zoom(0.75) end
}
DDRDiffList.MessageHandlers(meter, function(self, _, XMode)
    if XMode then
        self:visible(true)
    else
        self:visible(false)
        return --no use doing anything when it won't be used at all
    end
    local song = GAMESTATE:GetCurrentSong()
    if song then
        local steps = FindSteps(song)
        if steps then
            local meter = steps:GetMeter()
            if DiffHelpers.AnyPlayerSelected(diff) then
                if meter > 10 then
                    self:diffuse(hardXColor)
                else
                    self:diffuse(lightXColor)
                end
                self:settext(tostring(meter))
            else
                self:diffuse{1,1,1,1}
                self:settext(tostring(meter))
            end
        else
            self:settext ""
        end
    else
        self:settext ""
    end
end)

return Def.ActorFrame{ticksUnder,ticksOver,meter}
