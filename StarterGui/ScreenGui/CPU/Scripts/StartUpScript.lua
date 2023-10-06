-- Control
local UserInputService = game:GetService("UserInputService")
--

-- Items
local ScreenGui = script.Parent.Parent.Parent
local StartScreen = ScreenGui.StartScreen
local TaskScreen = ScreenGui.TaskScreen
local BlackScreen = ScreenGui.BlackScreen
--

-- Values
local BlackScreenValues = script.Parent.Parent.Values.BlackScreenValues
local ShowBlackScreenValue = BlackScreenValues.ShowBlackScreenValue
local BlackScreenTimeValue = BlackScreenValues.BlackScreenTimeValue
--

-- Sounds
local SoundEffects = game.SoundService.Effects
local ClickSound = SoundEffects.Effect5Sound
--

BlackScreen.Visible = true
ShowBlackScreenValue.Value = true
wait(BlackScreenTimeValue.Value / 2)
StartScreen.Visible = true
StartScreen.StatsScreen.Visible = false
TaskScreen.Visible = true
TaskScreen.HelpScreen.Visible = true

UserInputService.InputBegan:Connect(function(Input)
	local InputType = Input.UserInputType
	if InputType == Enum.UserInputType.MouseButton1 then
		local ClonedSound = ClickSound:Clone()
		ClonedSound.Parent = ClickSound.Parent
		ClonedSound.PlayOnRemove = true
		ClonedSound:Destroy()
	end
end)