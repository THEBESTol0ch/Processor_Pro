-- Control
local TweenService = game:GetService("TweenService")
--

-- Items
local Label = script.Parent
local MultiplierLabel = script.Parent.Parent:WaitForChild("Multiplier")
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
	Rotation = -5,
	Position = UDim2.new(Label.Position.X.Scale, Label.Position.X.Offset, Label.Position.Y.Scale - 0.3, Label.Position.Y.Offset),
	Size = UDim2.new(Label.Size.X.Scale, Label.Size.X.Offset + 100, Label.Size.Y.Scale, Label.Size.Y.Offset + 100)
}

local LabelTarget2 = {
	ImageTransparency = 1,
	Rotation = MultiplierLabel.Rotation,
	Position = MultiplierLabel.Position,
	Size = MultiplierLabel.Size
}

SoundEffect:Play()
TweenService:Create(Label, LabelAnimationSettings1, LabelTarget1):Play()
wait(0.7)
TweenService:Create(Label, LabelAnimationSettings2, LabelTarget2):Play()
wait(0.5)
MultiplierLabel:TweenPosition(UDim2.new(MultiplierLabel.Position.X.Scale, MultiplierLabel.Position.X.Offset, MultiplierLabel.Position.Y.Scale - 0.03, MultiplierLabel.Position.Y.Offset), Enum.EasingDirection.InOut, Enum.EasingStyle.Quint, 0.2, false)
wait(0.2)
MultiplierLabel:TweenPosition(UDim2.new(MultiplierLabel.Position.X.Scale, MultiplierLabel.Position.X.Offset, MultiplierLabel.Position.Y.Scale + 0.03, MultiplierLabel.Position.Y.Offset), Enum.EasingDirection.InOut, Enum.EasingStyle.Quint, 0.2, false)
wait(1)
Label:Destroy()