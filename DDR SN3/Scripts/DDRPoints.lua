DDRPoints = {}

local ES = ToEnumShortString

local default_to_zero = {__index = function() return 0 end}

local base_points = {
	Beginner = 700,
	Easy = 600,
	Medium = 400,
	Hard = 100,
	Challenge = 150
}
setmetatable(base_points, default_to_zero)

local meter_bonus = {
	Beginner = 0,
	Easy = 40,
	Medium = 20,
	Hard = 20,
	Challenge = 20
}
setmetatable(meter_bonus, default_to_zero)

local zero_table = setmetatable({}, default_to_zero)
local step_values = {
	Beginner = {W1 = 1, W2 = 1, W3 = 1, Held = 1},
	Easy = {W1 = 1, W2 = 1, W3 = 1, Held = 1},
	Medium = {W1 = 2, W2 = 2, W3 = 2, W5 = -10, Miss = -20, Held = 2, LetGo = -20},
	Hard = {W1 = 3, W2 = 3, W3 = 2, W5 = -30, Miss = -60, Held = 3, LetGo = -20},
	Challenge = {W1 = 3, W2 = 3, W3 = 2, W5 = -30, Miss = -60, Held = 3, LetGo = -20}
}
for _, v in pairs(step_values) do
	setmetatable(v, default_to_zero)
end
setmetatable(step_values, {__index = function() return zero_table end}) 


function DDRPoints.GetBase(steps)
	local diff = ES(steps:GetDifficulty())
	return base_points[diff] + meter_bonus[diff]*math.min(10,steps:GetMeter())
end

function DDRPoints.GetStepAward(steps, judgment)
	local diff = ES(steps:GetDifficulty())
	return step_values[diff][ES(judgment)]
end
