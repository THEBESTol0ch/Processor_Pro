-- Control
local TweenService = game:GetService("TweenService")
--

-- Items
local Label = script.Parent
--

local LabelAnimationSettings = TweenInfo.new(
	0.5,
	Enum.EasingStyle.Sine,
	Enum.EasingDirection.Out,
	0,
	false,
	0
)

local LabelAnimationSettings2 = TweenInfo.new(
	0.5,
	Enum.EasingStyle.Sine,
	Enum.EasingDirection.In,
	0,
	false,
	0
)

local LabelTarget = {
	ImageTransparency = 1,
	Rotation = 5,
	Size = UDim2.new(Label.Size.X.Scale, Label.Size.X.Offset + 100, Label.Size.Y.Scale, Label.Size.Y.Offset + 100),
	ImageColor3 = Color3.new(1, 0, 0)
}

TweenService:Create(Label, LabelAnimationSettings, LabelTarget):Play()
wait(0.5)
Label:Destroy()