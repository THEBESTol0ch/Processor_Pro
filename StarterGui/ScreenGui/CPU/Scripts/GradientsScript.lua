-- Control
local TweenService = game:GetService("TweenService")
--

-- Items
local Gradients = script.Parent.Parent.Parent.TaskScreen.Gradients
local Player = game.Players.LocalPlayer
--

-- Values
local Values = script.Parent.Parent.Values
local CreateTasksValue = Values.CreateTasksValues.CreateTasksValue
local GradientSpeedValue = Values.GradientSpeedValue

local RankValues = Values.RankValues
local SetRankValue = Player:WaitForChild("leaderstats").Rank
local RankNamesValues = RankValues.RankNamesValues:GetChildren()
--

-- Logic
local GradientAnimationSettings = TweenInfo.new(
	0,
	Enum.EasingStyle.Linear,
	Enum.EasingDirection.InOut,
	0,
	false,
	0
)

local GradientTargetsArray = {
	{
		{ Position = UDim2.new(0.437, 0, 0.192, 0), Rotation = 0 },
		{ Position = UDim2.new(0.325, 0, 0.192, 0), Rotation = 0 },
		{ Position = UDim2.new(0.279, 0, 0.111, 0), Rotation = 45 },
		{ Position = UDim2.new(0.235, 0, 0.108, 0), Rotation = -45 },
		{ Position = UDim2.new(0.199, 0, 0.163, 0), Rotation = -90 },
		{ Position = UDim2.new(0.199, 0, 0.348, 0), Rotation = -90 },
	},
	{
		{ Position = UDim2.new(0.437, 0, 0.163, 0), Rotation = 0 },
		{ Position = UDim2.new(0.336, 0, 0.157, 0), Rotation = 0 },
		{ Position = UDim2.new(0.29, 0, 0.078, 0), Rotation = 45 },
		{ Position = UDim2.new(0.278, 0, 0.041, 0), Rotation = 90 },
		{ Position = UDim2.new(0.278, 0, -0.07, 0), Rotation = 90 },
	},
	{
		{ Position = UDim2.new(0.635, 0, 0.125, 0), Rotation = 45 },
		{ Position = UDim2.new(0.671, 0, 0.19, 0), Rotation = 45 },
		{ Position = UDim2.new(0.68, 0, 0.34, 0), Rotation = 90 },
	},
	{
		{ Position = UDim2.new(0.544, 0, 0.089, 0), Rotation = 0 },
		{ Position = UDim2.new(0.619, 0, 0.089, 0), Rotation = -45 },
		{ Position = UDim2.new(0.71, 0, -0.09, 0), Rotation = -45 },
		{ Position = UDim2.new(0.71, 0, -0.09, 0), Rotation = -45 },
	},
}
--

-- Functions
function AnimateGradient(Number)
	local Gradient = Gradients["Gradient"..Number]
	local Targets = GradientTargetsArray[Number]
	repeat
		TweenService:Create(Gradient, GradientAnimationSettings, Targets[1]):Play()
		wait(0.1)
		for Count = 2, #Targets, 1 do
			TweenService:Create(Gradient, TweenInfo.new(GradientSpeedValue.Value, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, 0, false, 0), Targets[Count]):Play()
			wait(GradientSpeedValue.Value)
		end
	until CreateTasksValue.Value == false
end
--

CreateTasksValue.Changed:Connect(function()
	if CreateTasksValue.Value == true then
		AnimateGradient(1)
	end
end)
CreateTasksValue.Changed:Connect(function()
	if CreateTasksValue.Value == true then
		AnimateGradient(2)
	end
end)
CreateTasksValue.Changed:Connect(function()
	if CreateTasksValue.Value == true then
		AnimateGradient(3)
	end
end)
CreateTasksValue.Changed:Connect(function()
	if CreateTasksValue.Value == true then
		AnimateGradient(4)
	end
end)

while true do
	wait(1)
	if SetRankValue.Value > 0 and SetRankValue.Value < #RankNamesValues + 1 then
		for _, Item in pairs(Gradients:GetDescendants()) do
			if Item:IsA("UIGradient") then
				Item.Enabled = false
			end
		end
		for _, Gradient in pairs(Gradients:GetChildren()) do
			Gradient["Gradient"..SetRankValue.Value].Enabled = true
		end
	end
end