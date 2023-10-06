-- Control
local TweenService = game:GetService("TweenService")
--

-- Items
local Label = script.Parent
local Money = Label.Money
local MoneyBackground = Label.MoneyBackground
--

local LabelAnimationSettings = TweenInfo.new(
	1,
	Enum.EasingStyle.Sine,
	Enum.EasingDirection.Out,
	0,
	false,
	0
)

local LabelTarget1 = {
	Position = UDim2.new(Label.Position.X.Scale, Label.Position.X.Offset, Label.Position.Y.Scale - 0.3, Label.Position.Y.Offset)
}

local TextTarget1 = {
	TextTransparency = 0
}
local TextTarget2 = {
	TextTransparency = 1
}

TweenService:Create(Label, LabelAnimationSettings, LabelTarget1):Play()
TweenService:Create(Money, LabelAnimationSettings, TextTarget1):Play()
TweenService:Create(MoneyBackground, LabelAnimationSettings, TextTarget1):Play()
wait(0.5)
TweenService:Create(Money, LabelAnimationSettings, TextTarget2):Play()
TweenService:Create(MoneyBackground, LabelAnimationSettings, TextTarget2):Play()
wait(1)
Label:Destroy()