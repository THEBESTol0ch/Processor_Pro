-- Control
local TweenService = game:GetService("TweenService")
--

-- Items
local Label = script.Parent
--

local LabelAnimationSettings1 = TweenInfo.new(
	0.3,
	Enum.EasingStyle.Sine,
	Enum.EasingDirection.Out,
	0,
	false,
	0
)

local LabelAnimationSettings2 = TweenInfo.new(
	0.3,
	Enum.EasingStyle.Sine,
	Enum.EasingDirection.In,
	0,
	false,
	0
)

local LabelTarget1 = {
	BackgroundTransparency = 0.8
}

local LabelTarget2 = {
	BackgroundTransparency = 1
}

TweenService:Create(Label, LabelAnimationSettings1, LabelTarget1):Play()
wait(0.3)
TweenService:Create(Label, LabelAnimationSettings2, LabelTarget2):Play()
wait(1)
Label:Destroy()