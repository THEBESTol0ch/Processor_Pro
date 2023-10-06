-- Items
local ScreenGui = script.Parent.Parent.Parent
local Level = ScreenGui.TaskScreen.Level
local TaskScreen = ScreenGui.TaskScreen
local TaskWorkspace = TaskScreen.TaskWorkspace
local EffectsWorkspace = TaskScreen.EffectsWorkspace
local LevelUpAdd = game.ReplicatedStorage.LevelUpAdd
--

-- Values
local Values = script.Parent.Parent.Values
local LevelValue = Values.LevelValues.LevelValue
local LevelUpCountValue = Values.LevelValues.LevelUpCountValue
local CreateTasksValue = Values.CreateTasksValues.CreateTasksValue
local CreateTasksTimeValue = Values.CreateTasksValues.CreateTasksTimeValue
local RemoveTasksNumberValue = Values.RemoveTasksNumberValue
local DiedValue = Values.DiedValue
--

-- Logic
local TimeToGetLevel = 30
--

-- Fucntions
function StartCount()
	LevelUpCountValue.Value = TimeToGetLevel
	repeat
		if LevelUpCountValue.Value > 0 then
			wait(1)
			LevelUpCountValue.Value = LevelUpCountValue.Value - 1
			Level.Text = ("NEXT LEVEL: "..LevelUpCountValue.Value)
		end
	until LevelUpCountValue.Value == 0 or CreateTasksValue.Value == false

	if LevelUpCountValue.Value == 0 and CreateTasksValue.Value == true then
		LevelValue.Value = LevelValue.Value + 1
	end
end
--

CreateTasksValue.Changed:Connect(function()
	if CreateTasksValue.Value == true then
		repeat
			StartCount()
		until CreateTasksValue.Value == false
		Level.Text = ""
		LevelUpCountValue.Value = 0
	end
end)

LevelValue.Changed:Connect(function()
	if LevelValue.Value > 0 then
		LevelUpAdd:Clone().Parent = EffectsWorkspace
		RemoveTasksNumberValue.Value = math.round(#TaskWorkspace:GetChildren() / 3)
	end
	if LevelValue.Value == 0 then
		CreateTasksTimeValue.Value = 1
	elseif LevelValue.Value == 1 then
		CreateTasksTimeValue.Value = 0.8
	elseif LevelValue.Value == 2 then
		CreateTasksTimeValue.Value = 0.7
	elseif LevelValue.Value == 3 then
		CreateTasksTimeValue.Value = 0.6
	end
end)

DiedValue.Changed:Connect(function()
	if DiedValue.Value == true then
		LevelValue.Value = 0
	end
end)