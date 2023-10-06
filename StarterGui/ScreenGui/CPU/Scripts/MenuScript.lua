-- Control
local TweenService = game:GetService("TweenService")
--

-- Items
local ScreenGui = script.Parent.Parent.Parent
local StartScreen = ScreenGui.StartScreen
local MenuScreen = StartScreen.MenuScreen
local Menu = MenuScreen.Menu
local OpenButton = StartScreen.MenuButton
local ExitButton = MenuScreen.ExitButton
local ProcessorButton = Menu.Processor.ProcessorButton
local ProcessorBackground = Menu.Processor.Background
local ResetProgressButton = Menu.ResetProgressButton
local ResetProgressScreen = Menu.ResetProgressScreen
local ConfirmButton = ResetProgressScreen.ConfirmButton
local CancelButton = ResetProgressScreen.CancelButton
local StatsScreen = StartScreen.StatsScreen
local ProfitMoney = Menu.Profit.ProfitMoney
local WalletMoney = Menu.Wallet.WalletMoney
local NextRankMoney = Menu.NextRank.NextRankMoney
local MusicButton = Menu.Music.Button
local LeaderboardButton = Menu.Leaderboard.Button
local Leaderboard = StartScreen.Leaderboard
local Player = game.Players.LocalPlayer
--

-- Values
local Values = script.Parent.Parent.Values
local CatalogOpenedValue = Values.CatalogOpenedValue
local MenuOpenedValue = Values.MenuOpenedValue
local ResetProgressValue = Values.ResetProgressValue
local DisableMusicValue = Values.DisableMusicValue

local ProfitMoneyValue = Player:WaitForChild("leaderstats").Profit
local WalletMoneyValue = Player:WaitForChild("leaderstats").Wallet

local RankValues = Values.RankValues
local RankCostsValues = RankValues.RankCostsValues
local SetRankValue = Player:WaitForChild("leaderstats").Rank
local RankNamesValues = RankValues.RankNamesValues:GetChildren()
--

-- Sounds
local ResetProgressSound = game.SoundService.Effects.Effect1Sound
--

-- Remote Events
local RemoteEvents = game.ReplicatedStorage.RemoteEvents
local UpdateProfitValueEvent = RemoteEvents.UpdateProfitValueEvent
--

-- Logic
local CanEvent = true

local BackgroundAnimationSettings = TweenInfo.new(
	1,
	Enum.EasingStyle.Sine,
	Enum.EasingDirection.InOut,
	0,
	false,
	0
)
local ScreenAnimationSettings = TweenInfo.new(
	0.5,
	Enum.EasingStyle.Sine,
	Enum.EasingDirection.InOut,
	0,
	false,
	0
)
local ResetProgressScreenAnimationSettings = TweenInfo.new(
	0.5,
	Enum.EasingStyle.Quint,
	Enum.EasingDirection.Out,
	0,
	false,
	0
)
--

-- Functions
function DoMenuScreen(Mode)
	if Mode == "HIDE" then
		TweenService:Create(MenuScreen, BackgroundAnimationSettings, { BackgroundTransparency = 1 }):Play()
		TweenService:Create(Menu, ScreenAnimationSettings, { Position = UDim2.new(0.5, 0, -0.5, 0) }):Play()
		TweenService:Create(ExitButton, ScreenAnimationSettings, { Position = UDim2.new(1.12, 0, 0.15, 0) }):Play()
	elseif Mode == "SHOW" then
		TweenService:Create(MenuScreen, BackgroundAnimationSettings, { BackgroundTransparency = 0.5 }):Play()
		TweenService:Create(Menu, ScreenAnimationSettings, { Position = UDim2.new(0.5, 0, 0.5, 0) }):Play()
		TweenService:Create(ExitButton, ScreenAnimationSettings, { Position = UDim2.new(0.72, 0, 0.15, 0) }):Play()
	end
end
function DoCancel()
	TweenService:Create(ResetProgressScreen, ResetProgressScreenAnimationSettings, { Size = UDim2.new(1, 0, 0, 0) }):Play()
	ConfirmButton.Text = ("(10)")
	wait(2)
	CanEvent = true
end

function SetProfitMoney(Value)
	ProfitMoney.Text = ("$"..Value)
	UpdateProfitValueEvent:FireServer(Value)
end
function SetWalletMoney(Value)
	WalletMoney.Text = ("$"..Value)
end

function DoCheck()
	if SetRankValue.Value > 0 and SetRankValue.Value < #RankNamesValues then
		local Cost = RankCostsValues["RankCost"..SetRankValue.Value.."Value"].Value
		NextRankMoney.Text = "$"..Cost.." IN PROFIT"
	else
		NextRankMoney.Text = RankCostsValues.RankCost5Value.Value
	end
end
--

OpenButton.MouseButton1Click:Connect(function()
	if MenuOpenedValue.Value == false and CatalogOpenedValue.Value == false then
		MenuOpenedValue.Value = true
		DoMenuScreen("SHOW")
	end
end)

ExitButton.MouseButton1Click:Connect(function()
	if MenuOpenedValue.Value == true then
		MenuOpenedValue.Value = false
		DoMenuScreen("HIDE")
		DoCancel()
	end
end)

ProcessorButton.MouseButton1Click:Connect(function()
	ProcessorBackground.BackgroundColor3 = Color3.fromRGB(math.random(1, 255), math.random(1, 255), math.random(1, 255))
end)

ResetProgressButton.MouseButton1Click:Connect(function()
	if CanEvent == true then
		CanEvent = false
		TweenService:Create(ResetProgressScreen, ResetProgressScreenAnimationSettings, { Size = UDim2.new(1, 0, 0.28, 0) }):Play()
		local Count = 10
		repeat
			ConfirmButton.Text = ("("..Count..")")
			wait(1)
			Count = Count - 1
		until Count == 0 or ResetProgressScreen.Size.Y.Scale == 0
		if ResetProgressScreen.Size.Y.Scale > 0 then
			ConfirmButton.Text = "YES"
		end
	end
end)

CancelButton.MouseButton1Click:Connect(function()
	DoCancel()
end)

ConfirmButton.MouseButton1Click:Connect(function()
	if ResetProgressScreen.Size.Y.Scale > 0 and ConfirmButton.Text == "YES" then
		ResetProgressValue.Value = true
		ProcessorBackground.BackgroundColor3 = Color3.fromRGB(83, 83, 83)
		ResetProgressSound:Play()
		DoCancel()
	end
end)

MusicButton.MouseButton1Click:Connect(function()
	if DisableMusicValue.Value == false then
		DisableMusicValue.Value = true
		MusicButton.Check.Visible = true
	elseif DisableMusicValue.Value == true then
		DisableMusicValue.Value = false
		MusicButton.Check.Visible = false
	end
end)

LeaderboardButton.MouseButton1Click:Connect(function()
	if Leaderboard.Visible == true then
		LeaderboardButton.Check.Visible = true
		Leaderboard.Visible = false
	elseif Leaderboard.Visible == false then
		LeaderboardButton.Check.Visible = false
		Leaderboard.Visible = true
	end
end)

while true do
	wait(1)
	SetProfitMoney(ProfitMoneyValue.Value)
	SetWalletMoney(WalletMoneyValue.Value)
	DoCheck()
end