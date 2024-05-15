local args = {...}
local pss = args[1]
local tnsToColor = {
    TapNoteScore_W3=color "#02EC20",
    TapNoteScore_W2=color "#FDF908",
    TapNoteScore_W1=color "#FFF2D9"
}

--Check each TNS from W1 down to miss.
--once we hit a TNS that we have full combo of, we stop.
local revTns = TapNoteScore:Reverse()
local bestTns = revTns.TapNoteScore_W1
local worstTns = revTns.TapNoteScore_Miss
for idx=bestTns, worstTns, -1 do
    local curTns = TapNoteScore[idx]
    if tnsToColor[curTns] then
        if pss:FullComboOfScore(curTns) then
            return Def.ActorFrame{
                LoadActor("ring")..{
                    InitCommand=function(self) self:diffuse(tnsToColor[curTns]):zoom(0) end;
                    OnCommand=function(self) self:sleep(0.5):linear(0.2):zoom(0.5):spin():effectmagnitude(0,0,-170) end;
                    OffCommand=function(self) self:linear(0.2):zoom(0) end
                },
                LoadActor("lines")..{
                    InitCommand=function(self) self:diffuse(tnsToColor[curTns]):zoom(0) end;
                    OnCommand=function(self) self:sleep(0.5):linear(0.2):zoom(0.6):spin():effectmagnitude(0,0,170) end;
                    OffCommand=function(self) self:linear(0.2):zoom(0) end
                }
            }
        end
    else break end
end

return Def.Actor{}
