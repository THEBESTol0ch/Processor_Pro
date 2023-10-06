-- Control
local TweenService = game:GetService("TweenService")
--

-- Items
local ScreenGui = script.Parent.Parent.Parent
local ReplicatedStorage = game.ReplicatedStorage
local StartScreen = ScreenGui.StartScreen
local BufferWorkspace = ScreenGui.TaskScreen.BufferWorkspace
local Catalog = StartScreen.CatalogScreen.Catalog.Catalog
local CatalogScreen = StartScreen.CatalogScreen
local Menu = StartScreen.MenuScreen.Menu
local MoneyAdd = ReplicatedStorage.MoneyAdd
local OpenButton = StartScreen.CatalogButton
local ExitButton = CatalogScreen.ExitButton
local Player = game.Players.LocalPlayer
--

-- Values
local Values = script.Parent.Parent.Values
local WalletMoneyValue = Player:WaitForChild("leaderstats").Wallet
local CatalogOpenedValue = Values.CatalogOpenedValue
local MenuOpenedValue = Values.MenuOpenedValue
local ResetProgressValue = Values.ResetProgressValue

local RankValues = Values.RankValues
local SetRankValue = Player:WaitForChild("leaderstats").Rank
local RankNamesValues = RankValues.RankNamesValues:GetChildren()

local ResponseValue = Player:WaitForChild("leaderstats").Response
local FlowValue = Player:WaitForChild("leaderstats").Flow
local HackValue = Player:WaitForChild("leaderstats").Hack
local ProcessorValue = Player:WaitForChild("leaderstats").Processor
--

-- Remote Events
local RemoteEvents = game.ReplicatedStorage.RemoteEvents
--

-- Logic
local Frames = {
	"",
	"Response",
	"Flow",
	"Hack",
	"Processor"
}

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
--

-- Functions
function DoFrame(Frame, Mode)
	if Frame ~= "" then
		if Mode == "LOCK" then
			Catalog[Frame.Name].OrderButton.Visible = false
			Catalog[Frame.Name].LockScreen.Visible = true
			Catalog[Frame.Name].Lock.Visible = true
		elseif Mode == "UNLOCK" then
			Catalog[Frame.Name].OrderButton.Visible = true
			Catalog[Frame.Name].LockScreen.Visible = false
			Catalog[Frame.Name].Lock.Visible = false
		end
	end
end

function LockAllBonuses()
	DoFrame(Catalog.Response, "LOCK")
	DoFrame(Catalog.Flow, "LOCK")
	DoFrame(Catalog.Hack, "LOCK")
	DoFrame(Catalog.Processor, "LOCK")
end

function DoEffectMoney(Item, Value, Color, BackgroundColor)
	Item.Money.Text = Value
	Item.Money.TextColor3 = Color
	Item.MoneyBackground.Text = Value
	Item.MoneyBackground.TextColor3 = BackgroundColor
end

function Buy(ItemName)
	local Frame = Catalog[ItemName]
	local Price = tonumber(Frame.OrderButton.Price.Text:split("$")[2])
	local BonusValue = Player:FindFirstChild("leaderstats")[ItemName]
	if Price < WalletMoneyValue.Value and BonusValue.Value < 3 then
		local ClonedMoneyAdd = MoneyAdd:Clone()
		ClonedMoneyAdd.Parent = CatalogScreen
		DoEffectMoney(ClonedMoneyAdd, ("-$"..Price), Color3.fromRGB(170, 0, 0), Color3.fromRGB(86, 0, 0))
		WalletMoneyValue.Value = WalletMoneyValue.Value - Price
		BonusValue.Value += 1
	end
end

function DoCatalogScreen(Mode)
	if Mode == "HIDE" then
		TweenService:Create(CatalogScreen, BackgroundAnimationSettings, { BackgroundTransparency = 1 }):Play()
		TweenService:Create(Catalog.Parent, ScreenAnimationSettings, { Position = UDim2.new(0.5, 0, -0.5, 0) }):Play()
		TweenService:Create(ExitButton, ScreenAnimationSettings, { Position = UDim2.new(1.1, 0, 0.15, 0) }):Play()
	elseif Mode == "SHOW" then
		TweenService:Create(CatalogScreen, BackgroundAnimationSettings, { BackgroundTransparency = 0.5 }):Play()
		TweenService:Create(Catalog.Parent, ScreenAnimationSettings, { Position = UDim2.new(0.5, 0, 0.5, 0) }):Play()
		TweenService:Create(ExitButton, ScreenAnimationSettings, { Position = UDim2.new(0.9, 0, 0.15, 0) }):Play()
	end
end

function UpdateFrame(Frame)
	local Value = Player:WaitForChild("leaderstats")[Frame]
	local Button = BufferWorkspace[Frame.."Button"]
	local InventoryDisplay1 = Catalog[Frame].Info.InventoryDisplay.TextLabel
	local InventoryDisplay2 = Button.InventoryDisplay.TextLabel
	local RemoteEvent = RemoteEvents["Update"..Frame.."ValueEvent"]
	if Value.Value > 0 then
		Button.Visible = true
	elseif Value.Value == 0 then
		Button.Visible = false
	end
	InventoryDisplay1.Text = (Value.Value.."/3")
	InventoryDisplay2.Text = (Value.Value.."/3")
	RemoteEvent:FireServer(Value.Value)
end

function DoCheck()
	UpdateFrame("Response")
	UpdateFrame("Flow")
	UpdateFrame("Hack")
	UpdateFrame("Processor")
	if SetRankValue.Value > 0 and SetRankValue.Value < #RankNamesValues + 1 then
		LockAllBonuses()
		for Count = 1, SetRankValue.Value, 1 do
			local Frame = Frames[Count]
			if Frame ~= Frames[1] then
				DoFrame(Catalog[Frame], "UNLOCK")
			end
		end
	end
end
--

OpenButton.MouseButton1Click:Connect(function()
	if CatalogOpenedValue.Value == false and MenuOpenedValue.Value == false then
		CatalogOpenedValue.Value = true
		DoCatalogScreen("SHOW")
	end
end)
ExitButton.MouseButton1Click:Connect(function()
	if CatalogOpenedValue.Value == true then
		CatalogOpenedValue.Value = false
		DoCatalogScreen("HIDE")
	end
end)

Catalog.Response.OrderButton.MouseButton1Click:Connect(function()
	Buy(Catalog.Response.Name:split("Frame")[1])
end)
Catalog.Flow.OrderButton.MouseButton1Click:Connect(function()
	Buy(Catalog.Flow.Name:split("Frame")[1])
end)
Catalog.Hack.OrderButton.MouseButton1Click:Connect(function()
	Buy(Catalog.Hack.Name:split("Frame")[1])
end)
Catalog.Processor.OrderButton.MouseButton1Click:Connect(function()
	Buy(Catalog.Processor.Name:split("Frame")[1])
end)

ResponseValue.Changed:Connect(function()
	UpdateFrame("Response")
end)
FlowValue.Changed:Connect(function()
	UpdateFrame("Flow")
end)
HackValue.Changed:Connect(function()
	UpdateFrame("Hack")
end)
ProcessorValue.Changed:Connect(function()
	UpdateFrame("Processor")
end)

SetRankValue.Changed:Connect(function()
	DoCheck()
end)

ResetProgressValue.Changed:Connect(function()
	if ResetProgressValue.Value == true then
		ResponseValue.Value = 0
		FlowValue.Value = 0
		HackValue.Value = 0
		ProcessorValue.Value = 0
	end
end)

while true do
	wait(1)
	DoCheck()
end