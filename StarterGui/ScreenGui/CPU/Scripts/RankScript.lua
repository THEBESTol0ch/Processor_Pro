-- Items
local ScreenGui = script.Parent.Parent.Parent
local StartScreen = ScreenGui.StartScreen
local TaskScreen = ScreenGui.TaskScreen
local Menu = StartScreen.MenuScreen.Menu
local Rank1 = Menu.Rank
local Rank2 = StartScreen.Rank
local Rank2Background = StartScreen.RankBackground
local ProcessorButton = Menu.Processor.ProcessorButton
local Processor = TaskScreen.ProcessorBackground.Processor
local MenuButton = StartScreen.MenuButton
local RankUpButton = Menu.RankUpButton
local LevelUpAdd = game.ReplicatedStorage.LevelUpAdd
local Player = game.Players.LocalPlayer
--

-- Values
local Values = script.Parent.Parent.Values
local ResetProgressValue = Values.ResetProgressValue
local ProfitMoneyValue = Player:WaitForChild("leaderstats").Profit

local RankValues = Values.RankValues
local SetRankValue = Player:WaitForChild("leaderstats").Rank
local RankValue = RankValues.RankValue
local RankNamesValues = RankValues.RankNamesValues:GetChildren()
local RankCostsValues = RankValues.RankCostsValues
--

-- Remote Events
local RemoteEvents = game.ReplicatedStorage.RemoteEvents
local UpdateRankValueEvent = RemoteEvents.UpdateRankValueEvent
--

-- Logic
local Processors = {
	"http://www.roblox.com/asset/?id=14895525147",
	"http://www.roblox.com/asset/?id=14895525147",
	"http://www.roblox.com/asset/?id=14895528801",
	"http://www.roblox.com/asset/?id=14895528115",
	"http://www.roblox.com/asset/?id=14895529426",
}
--

-- Functions
function SetRank(Value)
	if SetRankValue.Value > 0 and SetRankValue.Value < #RankNamesValues + 1 then
		RankValue.Value = RankNamesValues[Value].Value
		Rank1.Text = RankNamesValues[Value].Value
		Rank2.Text = RankNamesValues[Value].Value
		Rank2Background.Text = RankNamesValues[Value].Value
		ProcessorButton.Image = Processors[Value]
		Processor.Image = Processors[Value]
		UpdateRankValueEvent:FireServer(Value)
	end
end
function ColorButtons(Color1, Color2)
	MenuButton.ImageColor3 = Color1
	MenuButton.TextLabel.TextColor3 = Color1
	RankUpButton.BackgroundColor3 = Color2
end
function DoCheck()
	if ProfitMoneyValue.Value >= RankCostsValues.RankCost1Value.Value and ProfitMoneyValue.Value < RankCostsValues.RankCost2Value.Value and RankValue.Value ~= RankNamesValues[2].Value then
		ColorButtons(Color3.fromRGB(255, 203, 98), Color3.fromRGB(255, 187, 98))
		return true
	elseif ProfitMoneyValue.Value >= RankCostsValues.RankCost2Value.Value and ProfitMoneyValue.Value < RankCostsValues.RankCost3Value.Value and RankValue.Value ~= RankNamesValues[3].Value then
		ColorButtons(Color3.fromRGB(255, 203, 98), Color3.fromRGB(255, 187, 98))
		return true
	elseif ProfitMoneyValue.Value >= RankCostsValues.RankCost3Value.Value and ProfitMoneyValue.Value < RankCostsValues.RankCost4Value.Value and RankValue.Value ~= RankNamesValues[4].Value then
		ColorButtons(Color3.fromRGB(255, 203, 98), Color3.fromRGB(255, 187, 98))
		return true
	elseif ProfitMoneyValue.Value >= RankCostsValues.RankCost4Value.Value and RankValue.Value ~= RankNamesValues[5].Value then
		ColorButtons(Color3.fromRGB(255, 203, 98), Color3.fromRGB(255, 187, 98))
		return true
	else
		ColorButtons(Color3.fromRGB(255, 255, 255), Color3.fromRGB(135, 100, 52))
	end
end
--

SetRankValue.Changed:Connect(function()
	SetRank(SetRankValue.Value)
end)

RankValue.Changed:Connect(function()
	DoCheck()
end)

ProfitMoneyValue.Changed:Connect(function()
	DoCheck()
end)

RankUpButton.MouseButton1Click:Connect(function()
	if DoCheck() == true and SetRankValue.Value > 0 and SetRankValue.Value < #RankNamesValues + 1 then
		SetRankValue.Value = SetRankValue.Value + 1
		UpdateRankValueEvent:FireServer(SetRankValue.Value)
		LevelUpAdd:Clone().Parent = Menu
	end
end)

ResetProgressValue.Changed:Connect(function()
	if ResetProgressValue.Value == true then
		SetRankValue.Value = 1
	end
end)

while true do
	wait(1)
	DoCheck()
	SetRank(SetRankValue.Value)
end