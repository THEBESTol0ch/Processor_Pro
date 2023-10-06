-- Control
local TweenService = game:GetService("TweenService")
--

-- Items
local ScreenGui = script.Parent.Parent.Parent
local StartScreen = ScreenGui.StartScreen
local TaskScreen = ScreenGui.TaskScreen
local StatsScreen = StartScreen.StatsScreen
local PlayButton = StartScreen.PlayButton
local WalletMoney = StartScreen.WalletMoney
local WalletMoneyBackground = StartScreen.WalletMoneyBackground
local RecordMoney = StatsScreen.RecordMoney.RecordMoney
local ResultMoney = StatsScreen.ResultMoney.ResultMoney
local Player = game.Players.LocalPlayer
--

-- Values
local Values = script.Parent.Parent.Values
local DiedValue = Values.DiedValue
local ResetProgressValue = Values.ResetProgressValue
local GameInProgressValue = Values.GameInProgressValue
local MenuOpenedValue = Values.MenuOpenedValue
local CatalogOpenedValue = Values.CatalogOpenedValue

local MoneyValues = Values.MoneyValues
local MoneyValue = MoneyValues.MoneyValue
local RecordMoneyValue = Player:WaitForChild("leaderstats").Record
local ProfitMoneyValue = Player:WaitForChild("leaderstats").Profit
local WalletMoneyValue = Player:WaitForChild("leaderstats").Wallet

local BlackScreenValues = Values.BlackScreenValues
local ShowBlackScreenValue = BlackScreenValues.ShowBlackScreenValue
local BlackScreenTimeValue = BlackScreenValues.BlackScreenTimeValue
--

-- Remote Events
local RemoteEvents = game.ReplicatedStorage.RemoteEvents
local UpdateRecordValueEvent = RemoteEvents.UpdateRecordValueEvent
local UpdateWalletValueEvent = RemoteEvents.UpdateWalletValueEvent
--

-- Logic
local CanEvent = true

local ProgressResetScreenAnimationSettings = TweenInfo.new(
	0.5,
	Enum.EasingStyle.Quint,
	Enum.EasingDirection.Out,
	0,
	false,
	0
)
--

-- Functions
function SetRecordMoney(Value)
	RecordMoneyValue.Value = Value
	RecordMoney.Text = ("$"..Value)
	UpdateRecordValueEvent:FireServer(Value)
end
function SetWalletMoney(Value)
	WalletMoneyValue.Value = Value
	WalletMoney.Text = ("$"..WalletMoneyValue.Value)
	WalletMoneyBackground.Text = ("$"..WalletMoneyValue.Value)
	UpdateWalletValueEvent:FireServer(Value)
end
function SetMoney(Value)
	MoneyValue.Value = Value
end
function SetResultMoney(Value)
	ResultMoney.Text = ("$"..Value)
end
--

PlayButton.MouseButton1Click:Connect(function()
	if GameInProgressValue.Value == false and DiedValue.Value == true and MoneyValue.Value == 0 and MenuOpenedValue.Value == false and CatalogOpenedValue.Value == false then
		DiedValue.Value = false
		ShowBlackScreenValue.Value = true
		wait(BlackScreenTimeValue.Value / 2)
		GameInProgressValue.Value = true
		StartScreen.Visible = false
		TaskScreen.Visible = true
	end
end)

DiedValue.Changed:Connect(function()
	if DiedValue.Value == true then
		StatsScreen.Visible = true
		GameInProgressValue.Value = false
		ProfitMoneyValue.Value = ProfitMoneyValue.Value + MoneyValue.Value
		SetWalletMoney(WalletMoneyValue.Value + MoneyValue.Value)
		if MoneyValue.Value > RecordMoneyValue.Value then
			SetRecordMoney(MoneyValue.Value)
		end
		wait(BlackScreenTimeValue.Value)
		if MoneyValue.Value > 0 then
			for Count = 0, MoneyValue.Value, math.round(MoneyValue.Value / 20) do
				wait(0.2)
				SetResultMoney(Count)
			end
		end
		SetResultMoney(MoneyValue.Value)
		SetMoney(0)
	end
end)

ResetProgressValue.Changed:Connect(function()
	StatsScreen.Visible = false
	SetRecordMoney(0)
	ProfitMoneyValue.Value = 0
	SetWalletMoney(0)
end)

while true do
	wait(1)
	SetRecordMoney(RecordMoneyValue.Value)
	SetWalletMoney(WalletMoneyValue.Value)
end