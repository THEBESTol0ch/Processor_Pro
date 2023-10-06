-- Control
local TweenService = game:GetService("TweenService")
--

-- Items
local Label = script.Parent
--

-- Sounds
local SoundEffect = game.SoundService.Effects.Effect4Sound
--

local LabelAnimationSettings1 = TweenInfo.new(
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

local LabelTarget1 = {
	ImageTransparency = 0,
	Position = UDim2.new(Label.Position.X.Scale, Label.Position.X.Offset, Label.Position.Y.Scale - 0.3, Label.Position.Y.Offset),
}

local LabelTarget2 = {
	ImageTransparency = 1,
	Rotation = math.random(-5, 5),
	Size = UDim2.new(Label.Size.X.Scale, Label.Size.X.Offset + 100, Label.Size.Y.Scale, Label.Size.Y.Offset + 100)
}

SoundEffect:Play()
TweenService:Create(Label, LabelAnimationSettings1, LabelTarget1):Play()
wait(1)
TweenService:Create(Label, LabelAnimationSettings2, LabelTarget2):Play()
wait(1)
Label:Destroy()