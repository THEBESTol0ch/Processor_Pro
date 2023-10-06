-- Items
local ScreenGui = script.Parent.Parent.Parent
local EffectsWorkspace = ScreenGui.TaskScreen.EffectsWorkspace
local Multiplier = EffectsWorkspace.Multiplier
local ReplicatedStorage = game.ReplicatedStorage
local MultiplierAdd = ReplicatedStorage.MultiplierAdd
local MultiplierRemove = ReplicatedStorage.MultiplierRemove
local FlowButton = ScreenGui.TaskScreen.BufferWorkspace.FlowButton
local Player = game.Players.LocalPlayer
--

-- Values
local Values = script.Parent.Parent.Values
local MultiplierValue = Values.MultiplierValue
local CorrectAnswersValue = Values.CorrectAnswersValue
local AwardValue = Values.AwardValue
local FineValue = Values.FineValue
local DiedValue = Values.DiedValue
local FlowValue = Player:WaitForChild("leaderstats").Flow
local CreateTasksValue = Values.CreateTasksValues.CreateTasksValue
--

-- Logic
local Multipliers = {
	Multiplier2ID = 14757539843,
	Multiplier3ID = 14757540439,
	Multiplier4ID = 14757541335,
	Multiplier8ID = 14757541951,
}
--

-- Functions
function SetMultiplier(Number)
	MultiplierValue.Value = Number
	if MultiplierValue.Value > 1 then
		local ClonedMultiplierAdd = MultiplierAdd:Clone()
		ClonedMultiplierAdd.Parent = EffectsWorkspace
		ClonedMultiplierAdd.Image = ("rbxassetid://"..Multipliers["Multiplier"..MultiplierValue.Value.."ID"])
		wait(1.2)
		if MultiplierValue.Value > 1 then
			Multiplier.ImageTransparency = 0
			Multiplier.Image = ("rbxassetid://"..Multipliers["Multiplier"..MultiplierValue.Value.."ID"])
		end
	elseif MultiplierValue.Value == 1 then
		Multiplier.ImageTransparency = 1
		local ClonedMultiplierRemove = MultiplierRemove:Clone()
		ClonedMultiplierRemove.Parent = EffectsWorkspace
		ClonedMultiplierRemove.Image = Multiplier.Image
	end
end
--

CorrectAnswersValue.Changed:Connect(function()
	if CorrectAnswersValue.Value == 0 then
		SetMultiplier(1)
	elseif CorrectAnswersValue.Value == 10 and MultiplierValue.Value ~= 2 then
		SetMultiplier(2)
	elseif CorrectAnswersValue.Value == 20 and MultiplierValue.Value ~= 3 then
		SetMultiplier(3)
	elseif CorrectAnswersValue.Value == 40 and MultiplierValue.Value ~= 4 then
		SetMultiplier(4)
	elseif CorrectAnswersValue.Value == 80 and MultiplierValue.Value ~= 8 then
		SetMultiplier(8)
	end
end)

AwardValue.Changed:Connect(function()
	CorrectAnswersValue.Value = CorrectAnswersValue.Value + 1
end)

FineValue.Changed:Connect(function()
	CorrectAnswersValue.Value = 0
end)

DiedValue.Changed:Connect(function()
	if DiedValue.Value == true then
		CorrectAnswersValue.Value = 0
	end
end)

FlowButton.MouseButton1Click:Connect(function()
	if FlowValue.Value > 0 and CreateTasksValue.Value == true and MultiplierValue.Value < 8 then
		FlowValue.Value = FlowValue.Value - 1
		if MultiplierValue.Value == 1 then
			SetMultiplier(2)
		elseif MultiplierValue.Value == 2 then
			SetMultiplier(3)
		elseif MultiplierValue.Value == 3 then
			SetMultiplier(4)
		elseif MultiplierValue.Value == 4 then
			SetMultiplier(8)
		end
	end
end)