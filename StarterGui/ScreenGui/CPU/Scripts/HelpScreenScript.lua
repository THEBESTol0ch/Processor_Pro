-- Control
local TweenService = game:GetService("TweenService")
--

-- Items
local ScreenGui = script.Parent.Parent.Parent
local TaskScreen = ScreenGui.TaskScreen
local StartScreen = ScreenGui.StartScreen
local HelpScreen = TaskScreen.HelpScreen
local PlayButton = HelpScreen.Info.PlayButton
local ExitButton = HelpScreen.ExitButton
local PauseButton = TaskScreen.PauseButton
--

-- Values
local Values = script.Parent.Parent.Values
local CreateTasksValue = Values.CreateTasksValues.CreateTasksValue
local DiedValue = Values.DiedValue
local ShowDeathScreenValue = Values.ShowDeathScreenValue

local BlackScreenValues = Values.BlackScreenValues
local ShowBlackScreenValue = BlackScreenValues.ShowBlackScreenValue
local BlackScreenTimeValue = BlackScreenValues.BlackScreenTimeValue
--

-- Logic
local HelpScreenOpened = true

local BackgroundAnimationSettings = TweenInfo.new(
	1,
	Enum.EasingStyle.Sine,
	Enum.EasingDirection.InOut,
	0,
	false,
	0
)
local HelpScreenAnimationSettings = TweenInfo.new(
	0.5,
	Enum.EasingStyle.Sine,
	Enum.EasingDirection.InOut,
	0,
	false,
	0
)
--

-- Functions
function DoHelpScreen(Mode)
	if Mode == "HIDE" then
		TweenService:Create(HelpScreen, BackgroundAnimationSettings, { BackgroundTransparency = 1 }):Play()
		TweenService:Create(HelpScreen.Info, HelpScreenAnimationSettings, { Position = UDim2.new(0, 0, 0.6, 0) }):Play()
		TweenService:Create(ExitButton, HelpScreenAnimationSettings, { Position = UDim2.new(1.1, 0, 0.905, 0) }):Play()
	elseif Mode == "SHOW" then
		TweenService:Create(HelpScreen, BackgroundAnimationSettings, { BackgroundTransparency = 0.5 }):Play()
		TweenService:Create(HelpScreen.Info, HelpScreenAnimationSettings, { Position = UDim2.new(0, 0, 0, 0) }):Play()
		TweenService:Create(ExitButton, HelpScreenAnimationSettings, { Position = UDim2.new(0.6, 0, 0.905, 0) }):Play()
	end
end
function DoPauseButton(Mode)
	if Mode == "HIDE" then
		TweenService:Create(PauseButton, HelpScreenAnimationSettings, { Position = UDim2.new(1.15, 0, 0.1, 0) }):Play()
	elseif Mode == "SHOW" then
		TweenService:Create(PauseButton, HelpScreenAnimationSettings, { Position = UDim2.new(0.95, 0, 0.1, 0) }):Play()
	end
end
--

PlayButton.MouseButton1Click:Connect(function()
	if HelpScreenOpened == true then
		HelpScreenOpened = false
		CreateTasksValue.Value = true
		DoHelpScreen("HIDE")
		DoPauseButton("SHOW")
	end
end)

PauseButton.MouseButton1Click:Connect(function()
	if HelpScreenOpened == false then
		HelpScreenOpened = true
		CreateTasksValue.Value = false
		DoHelpScreen("SHOW")
		DoPauseButton("HIDE")
	end
end)

ExitButton.MouseButton1Click:Connect(function()
	DiedValue.Value = true
end)

DiedValue.Changed:Connect(function()
	if DiedValue.Value == true then
		HelpScreenOpened = false
		CreateTasksValue.Value = false
		DoHelpScreen("HIDE")
		DoPauseButton("HIDE")
		ShowDeathScreenValue.Value = true
		wait(2)
		ShowBlackScreenValue.Value = true
		wait(BlackScreenTimeValue.Value / 2)
		StartScreen.Visible = true
		TaskScreen.Visible = false
		HelpScreenOpened = true
		DoHelpScreen("SHOW")
		ShowDeathScreenValue.Value = false
	end
end)