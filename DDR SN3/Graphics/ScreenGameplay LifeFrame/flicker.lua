local light = ThemePrefs.Get("LightMode")

local activeColor = {0.75,0.75,0.75,0.8}

local beginTime = GetTimeSinceStart()
local lastSeenTime = beginTime
local flickerState = false
local FlickerLog = nil
local FlickerPrint = nil
if SN3Debug then
    local flickerRecord = {}
    FlickerLog = function()
        table.insert(flickerRecord, true)
    end
    local oldDiff = 0
    FlickerPrint = function()
        local diff = math.floor(lastSeenTime-beginTime)
        if (diff % 15 == 0) and (diff ~= oldDiff) then
            oldDiff = diff
            SCREENMAN:SystemMessage("flicker debug: flickered avg "..tostring((#flickerRecord)/15).."Hz over last 15 sec")
            flickerRecord = {}
        end
    end
end

local targetDelta = 1/60

local timer = GetUpdateTimer(targetDelta)
local function FlickerUpdate(self, _)
    lastSeenTime = GetTimeSinceStart()
    if FlickerPrint then FlickerPrint() end
    if not timer() then return end
    if FlickerLog then FlickerLog() end 
    flickerState = not flickerState
    
    for pn, item in pairs(self:GetChildren()) do
        item:visible((GAMESTATE:GetPlayerState(pn):GetHealthState() == 'HealthState_Hot')
            and flickerState)
    end
   
end

if light then FlickerUpdate = nil end

local host = Def.ActorFrame{
    Name = "HotLifeFlicker",
    --don't use this flicker method in light mode
    InitCommand = function(self) self:SetUpdateFunction(FlickerUpdate) end;
    OffCommand = function(self) self:sleep(0.792):queuecommand("Terminate") end;
    TerminateCommand = function(self) self:SetUpdateFunction(nil) end;
}

local xPosPlayer = {
    P1 = -(SCREEN_WIDTH/6), 
    P2 = (SCREEN_WIDTH/6)
}

local LifeChangedHandler
if light then
    LifeChangedHandler = function(s, params)
        if params.LifeMeter:IsHot() then
            s:visible(true):diffuseblink():effectcolor1{0,0,0,0}:effectcolor2(activeColor):effectperiod(targetDelta)
        else
            s:stopeffect():visible(false)
        end
    end
else
    LifeChangedHandler=function() end
end

for _, pn in pairs(GAMESTATE:GetEnabledPlayers()) do
    table.insert(host,Def.Quad{
        Name = pn,
        InitCommand=function(self)
            local short = ToEnumShortString(pn)
            self:visible(false):setsize((SCREEN_WIDTH/2.53),13)
            :skewx(-0.9):diffuse(activeColor):x(xPosPlayer[short])
            :halign(0.75)
        end,
        OnCommand=function(s) s:draworder(3):zoomx(pn=='PlayerNumber_P2' and -1 or 1) end,
        LifeChangedMessageCommand=LifeChangedHandler,
        OffCommand=function(s) s:sleep(0.792):visible(false) end
    })
end
return host
