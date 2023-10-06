-- Items
local Gate = script.Parent
--

-- Logic
local GatePosShow = UDim2.new(Gate.Position.X.Scale + 0.06, Gate.Position.X.Offset, Gate.Position.Y.Scale, Gate.Position.Y.Offset)
local GatePosHide = UDim2.new(Gate.Position.X.Scale - 0.06, Gate.Position.X.Offset, Gate.Position.Y.Scale, Gate.Position.Y.Offset)
--

Gate:TweenPosition(GatePosShow, Enum.EasingDirection.InOut, Enum.EasingStyle.Sine, 0.1, false)
wait(0.5)
Gate:TweenPosition(GatePosHide, Enum.EasingDirection.InOut, Enum.EasingStyle.Sine, 0.1, false)
wait(1)
Gate:Destroy()