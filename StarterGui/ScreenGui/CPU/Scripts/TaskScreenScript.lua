-- Control
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
--

-- Items
local ScreenGui = script.Parent.Parent.Parent
local ReplicatedStorage = game.ReplicatedStorage
local TaskScreen = ScreenGui.TaskScreen
local DeathScreen = TaskScreen.DeathScreen
local EffectsWorkspace = TaskScreen.EffectsWorkspace
local BufferWorkspace = TaskScreen.BufferWorkspace

local TaskWorkspace = TaskScreen.TaskWorkspace
local ResponseButton = BufferWorkspace.ResponseButton
local HackButton = BufferWorkspace.HackButton
local Bar = TaskScreen.ProcessorBackground.Bar
local BarFire = TaskScreen.ProcessorBackground.BarBackground.BarFire
local Money = TaskScreen.Money
local MoneyAdd = ReplicatedStorage.MoneyAdd
local ScreenFlash = ReplicatedStorage.ScreenFlash
local Player = game.Players.LocalPlayer
--

-- Values
local Values = script.Parent.Parent.Values
local CreateTasksValues = Values.CreateTasksValues
local CreateTasksValue = CreateTasksValues.CreateTasksValue
local CreateTasksNumberValue = CreateTasksValues.CreateTasksNumberValue
local ShowDeathScreenValue = Values.ShowDeathScreenValue
local DirectionValue = Values.DirectionValue
local RemoveTasksNumberValue = Values.RemoveTasksNumberValue
local AwardValue = Values.AwardValue
local FineValue = Values.FineValue
local AwardMoneyValue = Values.MoneyValues.AwardMoneyValue
local DiedValue = Values.DiedValue

local BonusValues = Values.BonusValues
local ResponseValue = Player:WaitForChild("leaderstats").Response
local ResponseActiveValue = BonusValues.ResponseActiveValue
local SlowMotionValue = BonusValues.SlowMotionValue
local FlowValue = Player:WaitForChild("leaderstats").Flow
local HackValue = Player:WaitForChild("leaderstats").Hack
local HackActiveValue = BonusValues.HackActiveValue
local ProcessorValue = Player:WaitForChild("leaderstats").Processor

local MoneyValues = Values.MoneyValues
local MoneyValue = MoneyValues.MoneyValue
--

-- Sounds
local SoundEffects = game.SoundService.Effects
local DeathSound = SoundEffects.Effect6Sound
local AwardSound = SoundEffects.Effect3Sound
local FineSound = SoundEffects.Effect2Sound
--

-- Logic
local HelpScreenOpened = true
local BarBlinking = false
local TaskWorkspaceBlinking = false
local PrevMoney = 0
local BarStandardSize = Bar.Size

local DeathScreenAnimationSettings = TweenInfo.new(
	1,
	Enum.EasingStyle.Quint,
	Enum.EasingDirection.Out,
	0,
	false,
	0
)

local BarAnimationSettings = TweenInfo.new(
	0.5,
	Enum.EasingStyle.Sine,
	Enum.EasingDirection.Out,
	0,
	false,
	0
)
local TaskWorkspaceBackgroundAnimationSettings1 = TweenInfo.new(
	0.5,
	Enum.EasingStyle.Quint,
	Enum.EasingDirection.In,
	0,
	false,
	0
)
local TaskWorkspaceBackgroundAnimationSettings2 = TweenInfo.new(
	2,
	Enum.EasingStyle.Sine,
	Enum.EasingDirection.Out,
	0,
	false,
	0
)
--

-- Functions
function DoDeathScreen(Mode)
	if Mode == "HIDE" then
		TweenService:Create(DeathScreen.LeftPart, DeathScreenAnimationSettings, { Size = UDim2.new(DeathScreen.LeftPart.Size.X.Scale, 0, 0, 0) }):Play()
		TweenService:Create(DeathScreen.RightPart, DeathScreenAnimationSettings, { Size = UDim2.new(DeathScreen.RightPart.Size.X.Scale, 0, 0, 0) }):Play()
	elseif Mode == "SHOW" then
		TweenService:Create(DeathScreen.LeftPart, DeathScreenAnimationSettings, { Size = UDim2.new(DeathScreen.LeftPart.Size.X.Scale, 0, 1, 0) }):Play()
		TweenService:Create(DeathScreen.RightPart, DeathScreenAnimationSettings, { Size = UDim2.new(DeathScreen.RightPart.Size.X.Scale, 0, 1, 0) }):Play()
	end
end

function BarBlink()
	if BarBlinking == false then
		BarBlinking = true
		TweenService:Create(BarFire, BarAnimationSettings, { ImageTransparency = 0.2 }):Play()
		wait(0.6)
		TweenService:Create(BarFire, BarAnimationSettings, { ImageTransparency = 1 }):Play()
		wait(0.6)
		BarBlinking = false
	end
end
function TaskWorkspaceBlink()
	if TaskWorkspaceBlinking == false then
		TaskWorkspaceBlinking = true
		TweenService:Create(EffectsWorkspace, TaskWorkspaceBackgroundAnimationSettings1, { BackgroundTransparency = 0.5 }):Play()
		wait(0.5)
		TweenService:Create(EffectsWorkspace, TaskWorkspaceBackgroundAnimationSettings2, { BackgroundTransparency = 1 }):Play()
		wait(2)
		TaskWorkspaceBlinking = false
	end
end

function DoEffectMoney(Item, Value, Color, BackgroundColor)
	Item.Money.Text = Value
	Item.Money.TextColor3 = Color
	Item.MoneyBackground.Text = Value
	Item.MoneyBackground.TextColor3 = BackgroundColor
end
function Find(Name, Task)
	for _, Item in pairs(Task:GetChildren()) do
		if Item:IsA("ImageLabel") then
			if Item.Name:split("_")[2] == Name then
				return Item.Name
			end
		end
	end
end
function CreateFlashScreen(Color)
	local ClonedFlashScreen = ScreenFlash:Clone()
	ClonedFlashScreen.Parent = EffectsWorkspace
	ClonedFlashScreen.BackgroundColor3 = Color
end

function CreateGate(Direction, Color)
	local ClonedGate = ReplicatedStorage[Direction.."_GateAdd"]:Clone()
	ClonedGate.Parent = EffectsWorkspace
	ClonedGate.ImageColor3 = Color
end
--

ResponseButton.MouseButton1Click:Connect(function()
	if ResponseValue.Value > 0 and ResponseActiveValue.Value == false and CreateTasksValue.Value == true then
		ResponseActiveValue.Value = true
		ResponseValue.Value = ResponseValue.Value - 1
		wait(10)
		ResponseActiveValue.Value = false
	end
end)
ResponseActiveValue.Changed:Connect(function()
	if ResponseActiveValue.Value == true then
		SlowMotionValue.Value = 0.5
		repeat
			TaskWorkspaceBlink()
			wait(0.1)
		until ResponseActiveValue.Value == false
		SlowMotionValue.Value = 0
	end
end)

HackButton.MouseButton1Click:Connect(function()
	if HackValue.Value > 0 and HackActiveValue.Value == false and CreateTasksValue.Value == true then
		HackActiveValue.Value = true
		HackValue.Value = HackValue.Value - 1
		wait(10)
		HackActiveValue.Value = false
	end
end)
HackActiveValue.Changed:Connect(function()
	if HackActiveValue.Value == true then
		repeat
			TaskWorkspaceBlink()
			wait(0.1)
		until HackActiveValue.Value == false
	end
end)

RunService.RenderStepped:Connect(function()
	if Bar.Size.X.Scale > 0.8 then
		BarBlink()
	end
end)

ShowDeathScreenValue.Changed:Connect(function()
	if ShowDeathScreenValue.Value == true then
		DoDeathScreen("SHOW")
		DeathSound:Play()
	elseif ShowDeathScreenValue.Value == false then
		DoDeathScreen("HIDE")
	end
end)

MoneyValue.Changed:Connect(function()
	Money.Text = ("$"..MoneyValue.Value)
	if MoneyValue.Value > 0 then
		local Sum = MoneyValue.Value - PrevMoney
		local ClonedMoneyAdd = MoneyAdd:Clone()
		if DirectionValue.Value == "LEFT" or DirectionValue.Value == "UP" then
			ClonedMoneyAdd.Position = UDim2.new(ClonedMoneyAdd.Position.X.Scale - 0.25, ClonedMoneyAdd.Position.X.Offset, ClonedMoneyAdd.Position.Y.Scale, ClonedMoneyAdd.Position.Y.Offset)
		elseif DirectionValue.Value == "RIGHT" or DirectionValue.Value == "DOWN" then
			ClonedMoneyAdd.Position = UDim2.new(ClonedMoneyAdd.Position.X.Scale + 0.25, ClonedMoneyAdd.Position.X.Offset, ClonedMoneyAdd.Position.Y.Scale, ClonedMoneyAdd.Position.Y.Offset)
		end
		ClonedMoneyAdd.Parent = EffectsWorkspace
		DoEffectMoney(ClonedMoneyAdd, ("+$"..Sum), Color3.fromRGB(111, 209, 19), Color3.fromRGB(50, 90, 8))
		PrevMoney = MoneyValue.Value
	end
end)

AwardValue.Changed:Connect(function()
	if AwardValue.Value == true then
		AwardValue.Value = false
		AwardSound:Play()
		MoneyValue.Value = MoneyValue.Value + AwardMoneyValue.Value
		CreateFlashScreen(Color3.new(0, 1, 0))
		if DirectionValue.Value == "LEFT" or DirectionValue.Value == "RIGHT" then
			CreateGate(DirectionValue.Value, Color3.new(0, 1, 0))
		end
	end
end)

FineValue.Changed:Connect(function()
	if FineValue.Value == true then
		FineValue.Value = false
		FineSound:Play()
		CreateTasksNumberValue.Value = 3
		Bar.Size = BarStandardSize
		CreateFlashScreen(Color3.new(1, 0, 0))
		if DirectionValue.Value == "LEFT" or DirectionValue.Value == "RIGHT" then
			CreateGate(DirectionValue.Value, Color3.new(1, 0, 0))
		end
	end
end)

DiedValue.Changed:Connect(function()
	if DiedValue.Value == false then
		Bar.Size = BarStandardSize
		PrevMoney = 0
	end
end)