-- Control
local TweenService = game:GetService("TweenService")
--

-- Items
local BlackScreen = script.Parent.Parent.Parent.BlackScreen
local TipText = BlackScreen.TipText
--

-- Values
local BlackScreenValues = script.Parent.Parent.Values.BlackScreenValues
local ShowBlackScreenValue = BlackScreenValues.ShowBlackScreenValue
local BlackScreenTimeValue = BlackScreenValues.BlackScreenTimeValue
--

-- Logic
local Tips = {
	"DON'T FORGET HOW TO BREATHE!",
	"NO MATTER WHICH WAY YOU SEND THE GOLD CARD, YOU'LL GET A BONUS EITHER WAY!",
	"TIRED OF MUSIC? TURN IT OFF!",
	"TIRED OF THE LEADERBOARD? TURN IT OFF!",
	"TEXT HERE",
	"YOU CAN RESET ALL YOUR PROGRESS!",
	"CHECK OUT THE CATALOG MORE OFTEN!",
	"YOU CAN USE SEVERAL BONUSES AT ONCE!",
	"YOU CAN PAUSE THE GAME, BUT YOU'LL BE PENALIZED FOR IT!",
	"THE MORE LEVEL YOU HAVE, THE FASTER THE GAME GOES, AFTER LOSING, THIS LEVEL IS RESET!"
}

local BlackScreenAnimationSettings = TweenInfo.new(
	0.5,
	Enum.EasingStyle.Sine,
	Enum.EasingDirection.InOut,
	0,
	false,
	0
)
--

-- Functions
function DoScreen(Mode)
	if Mode == "SHOW" then
		TweenService:Create(BlackScreen, BlackScreenAnimationSettings, { BackgroundTransparency = 0 }):Play()
		TweenService:Create(BlackScreen.Tip, BlackScreenAnimationSettings, { TextTransparency = 0 }):Play()
		TweenService:Create(BlackScreen.TipText, BlackScreenAnimationSettings, { TextTransparency = 0 }):Play()
	elseif Mode == "HIDE" then
		TweenService:Create(BlackScreen, BlackScreenAnimationSettings, { BackgroundTransparency = 1 }):Play()
		TweenService:Create(BlackScreen.Tip, BlackScreenAnimationSettings, { TextTransparency = 1 }):Play()
		TweenService:Create(BlackScreen.TipText, BlackScreenAnimationSettings, { TextTransparency = 1 }):Play()
	end
end
--

ShowBlackScreenValue.Changed:Connect(function()
	if ShowBlackScreenValue.Value == true then
		ShowBlackScreenValue.Value = false
		TipText.Text = Tips[math.random(1, #Tips)]
		DoScreen("SHOW")
		wait(BlackScreenTimeValue.Value)
		DoScreen("HIDE")
	end
end)