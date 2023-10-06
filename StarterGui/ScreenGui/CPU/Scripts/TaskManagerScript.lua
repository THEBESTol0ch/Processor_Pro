-- Control
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
--

-- Items
local ScreenGui = script.Parent.Parent.Parent
local TaskScreen = ScreenGui.TaskScreen
local TaskWorkspace = TaskScreen.TaskWorkspace
local BufferWorkspace = TaskScreen.BufferWorkspace
local EffectsWorkspace = TaskScreen.EffectsWorkspace
local Bar = TaskScreen.ProcessorBackground.Bar
local Player = game.Players.LocalPlayer
local UpGate = BufferWorkspace.UP_Gate

local ReplicatedStorage = game.ReplicatedStorage
local StandardTaskBackgrounds = ReplicatedStorage.TaskBackgrounds.Standard
local SpecialTaskBackgrounds = ReplicatedStorage.TaskBackgrounds.Special
local StandardTaskArrows = ReplicatedStorage.TaskArrows.Standard
local SpecialTaskArrows = ReplicatedStorage.TaskArrows.Special
local KeyIcons = ReplicatedStorage.KeyIcons
local ProcessorAdd = ReplicatedStorage.ProcessorAdd
--

-- Values
local Values = script.Parent.Parent.Values
local SlowMotionValue = Values.BonusValues.SlowMotionValue
local AwardValue = Values.AwardValue
local FineValue = Values.FineValue
local DiedValue = Values.DiedValue
local TaskNumberValue = Values.TaskNumberValue
local MultiplierValue = Values.MultiplierValue
local DirectionValue = Values.DirectionValue
local AwardMoneyValue = Values.MoneyValues.AwardMoneyValue
local GradientSpeedValue = Values.GradientSpeedValue
local ShiftingValue = Values.ShiftingValue
local MinTasksValue = Values.MinTasksValue

local CreateTasksValues = Values.CreateTasksValues
local CreateTasksValue = CreateTasksValues.CreateTasksValue
local CreateTasksTimeValue = CreateTasksValues.CreateTasksTimeValue
local CreateTasksNumberValue = CreateTasksValues.CreateTasksNumberValue
local RemoveTasksNumberValue = Values.RemoveTasksNumberValue

local ResponseValue = Player:WaitForChild("leaderstats").Response
local FlowValue = Player:WaitForChild("leaderstats").Flow
local HackValue = Player:WaitForChild("leaderstats").Hack
local HackActiveValue = Values.BonusValues.HackActiveValue
local ProcessorValue = Player:WaitForChild("leaderstats").Processor
--

-- Logic
local TaskStandardShiftScale = 0.05
local BarStandardSize = Bar.Size
local CurrentTaskNumber = 1
local GoldTaskCreated = false
local Shaking = false
local CorrectDirection = ""

local UpGatePos0 = UpGate.Position
local UpGatePos1 = UDim2.new(UpGate.Position.X.Scale, UpGate.Position.X.Offset, UpGate.Position.Y.Scale + 0.045, UpGate.Position.Y.Offset)
local UpGatePos2 = UDim2.new(UpGate.Position.X.Scale, UpGate.Position.X.Offset, UpGate.Position.Y.Scale + 0.09, UpGate.Position.Y.Offset)
local UpGatePos3 = UDim2.new(UpGate.Position.X.Scale, UpGate.Position.X.Offset, UpGate.Position.Y.Scale + 0.135, UpGate.Position.Y.Offset)
local UpGatePos4 = UDim2.new(UpGate.Position.X.Scale, UpGate.Position.X.Offset, UpGate.Position.Y.Scale + 0.16, UpGate.Position.Y.Offset)

local TaskShiftAnimationSettings = TweenInfo.new(
	0.2,
	Enum.EasingStyle.Sine,
	Enum.EasingDirection.InOut,
	0,
	false,
	0
)
local TaskDestroyAnimationSettings = TweenInfo.new(
	0.5,
	Enum.EasingStyle.Sine,
	Enum.EasingDirection.InOut,
	0,
	false,
	0
)

local Headers = {
	"Minecraft",
	"Fortnite",
	"Roblox",
	"Roblox Studio",
	"League of Legends",
	"Call of Duty: Warzone",
	"Counter-Strike: Global Offensive",
	"Among Us",
	"Valorant",
	"Apex Legends",
	"GTA V",
	"Overwatch",
	"Rocket League",
	"Fall Guys",
	"The Witcher 3: Wild Hunt",
	"Cyberpunk 2077",
	"Adobe Photoshop",
	"Microsoft Word",
	"Google Chrome",
	"Mozilla Firefox",
	"Safari",
	"Microsoft Excel",
	"Adobe Illustrator",
	"Discord",
	"Zoom",
	"Steam",
	"Epic Games Launcher",
	"Spotify",
	"Netflix",
	"Twitch",
	"WhatsApp"
}
--

-- Functions
function ShakeTasks(Force)
	if Shaking == false then
		Shaking = true
		TaskWorkspace.Position = UDim2.new(TaskWorkspace.Position.X.Scale - Force, TaskWorkspace.Position.X.Offset, TaskWorkspace.Position.Y.Scale, TaskWorkspace.Position.Y.Offset)
		wait(0.1)
		TaskWorkspace.Position = UDim2.new(TaskWorkspace.Position.X.Scale + Force, TaskWorkspace.Position.X.Offset, TaskWorkspace.Position.Y.Scale, TaskWorkspace.Position.Y.Offset)
		Shaking = false
	end
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

function ShiftTasks(Scale, Direction, SkipTween)
	if Direction == "UP" then
		for _, Task in pairs(TaskWorkspace:GetChildren()) do
			if SkipTween == true then
				Task.Position = UDim2.new(Task.Position.X.Scale, Task.Position.X.Offset, Task.Position.Y.Scale - Scale, Task.Position.Y.Offset)
			elseif SkipTween == false then
				Task:TweenPosition(UDim2.new(Task.Position.X.Scale, Task.Position.X.Offset, Task.Position.Y.Scale - Scale, Task.Position.Y.Offset), Enum.EasingDirection.InOut, Enum.EasingStyle.Sine, 0.2 + SlowMotionValue.Value, false)
			end
		end
	elseif Direction == "DOWN" then
		for _, Task in pairs(TaskWorkspace:GetChildren()) do
			if SkipTween == true then
				Task.Position = UDim2.new(Task.Position.X.Scale, Task.Position.X.Offset, Task.Position.Y.Scale + Scale, Task.Position.Y.Offset)
			elseif SkipTween == false then
				Task:TweenPosition(UDim2.new(Task.Position.X.Scale, Task.Position.X.Offset, Task.Position.Y.Scale + Scale, Task.Position.Y.Offset), Enum.EasingDirection.InOut, Enum.EasingStyle.Sine, 0.2 + SlowMotionValue.Value, false)
			end
		end
	end
end

function CreateTask(Type, Direction, SkipTween)
	if ShiftingValue.Value == false then
		if Type == "STANDARD" or Type == "WHITE" then
			local Task = game.ReplicatedStorage.Task:Clone()
			Task.Name = "Task_"..TaskNumberValue.Value
			Task.Position = UDim2.new(0.5, 0, 0.9, 0)
			Task.Rotation = math.random(-3, 3)
			Task.ZIndex = -TaskNumberValue.Value
			Task.Number.Text = "#"..TaskNumberValue.Value
			if Type == "STANDARD" then
				StandardTaskBackgrounds[(math.random(1, 2) == 1 and "GREEN" or "RED").."_Background"]:Clone().Parent = Task
				StandardTaskArrows[(math.random(1, 2) == 1 and "UP" or "DOWN").."_Arrow_"..math.random(1, 3)]:Clone().Parent = Task
				Task.Header.Text = Headers[math.random(1, #Headers)]
			elseif Type == "WHITE" then
				SpecialTaskBackgrounds.WHITE_Background:Clone().Parent = Task
				local Direction = math.random(1, 4)
				if Direction == 1 then
					Direction = "UP"
				elseif Direction == 2 then
					Direction = "DOWN"
				elseif Direction == 3 then
					Direction = "LEFT"
				elseif Direction == 4 then
					Direction = "RIGHT"
				end
				SpecialTaskArrows[Direction.."_Arrow"]:Clone().Parent = Task
				KeyIcons[Direction.."_KeyIcon"]:Clone().Parent = Task
				Task.Header.Text = "URGENT REPORT"
				Task.Header.TextColor3 = Color3.new(0.498039, 0.317647, 0.356863)
				Task.Number.TextTransparency = 1
			end
			ShiftTasks(TaskStandardShiftScale, Direction, SkipTween)
			Task.Parent = TaskWorkspace
			TaskNumberValue.Value = TaskNumberValue.Value + 1
		elseif Type == "GOLD" then
			local SelectedTask = TaskWorkspace["Task_"..CurrentTaskNumber + 2]
			for _, Item in pairs(SelectedTask:GetChildren()) do
				if Item.Name ~= "Header" and Item.Name ~= "Number" then
					Item:Destroy()
				end
			end
			SelectedTask.Header.Text = "BONUS"
			SpecialTaskBackgrounds.GOLD_Background:Clone().Parent = SelectedTask
		end
	end
end

function SelectTask(Task)
	if CreateTasksValue.Value == true then
		if (Find("Background", Task):split("_")[1] == "GREEN" and Find("Arrow", Task):split("_")[1] == "DOWN") or Find("Background", Task):split("_")[1] == "RED" and Find("Arrow", Task):split("_")[1] == "UP" then
			CorrectDirection = "LEFT"
			AwardMoneyValue.Value = 5 * MultiplierValue.Value
		elseif (Find("Background", Task):split("_")[1] == "GREEN" and Find("Arrow", Task):split("_")[1] == "UP") or Find("Background", Task):split("_")[1] == "RED" and Find("Arrow", Task):split("_")[1] == "DOWN" then
			CorrectDirection = "RIGHT"
			AwardMoneyValue.Value = 5 * MultiplierValue.Value
		elseif Find("Background", Task):split("_")[1] == "WHITE" then
			CorrectDirection = Find("Arrow", Task):split("_")[1]
			AwardMoneyValue.Value = 7 * MultiplierValue.Value
		elseif Find("Background", Task):split("_")[1] == "GOLD" then
			CorrectDirection = "ANY"
			AwardMoneyValue.Value = 60 * MultiplierValue.Value
		end
	end
end

function DestroyTask(Direction)
	if CreateTasksValue.Value == true and #TaskWorkspace:GetChildren() > MinTasksValue.Value then
		local SelectedTask = TaskWorkspace["Task_"..CurrentTaskNumber]
		SelectedTask.Name = "Task_Destroying"
		CurrentTaskNumber = GetFirstTaskIndex()
		DirectionValue.Value = Direction

		local TaskPosition
		if Direction == "UP" then
			TaskPosition = UDim2.new(SelectedTask.Position.X.Scale, SelectedTask.Position.X.Offset, SelectedTask.Position.Y.Scale - 2, SelectedTask.Position.Y.Offset)
		elseif Direction == "DOWN" then
			TaskPosition = UDim2.new(SelectedTask.Position.X.Scale, SelectedTask.Position.X.Offset, SelectedTask.Position.Y.Scale + 2, SelectedTask.Position.Y.Offset)
		elseif Direction == "LEFT" then
			TaskPosition = UDim2.new(SelectedTask.Position.X.Scale - 1, SelectedTask.Position.X.Offset, SelectedTask.Position.Y.Scale, SelectedTask.Position.Y.Offset)
		elseif Direction == "RIGHT" then
			TaskPosition = UDim2.new(SelectedTask.Position.X.Scale + 1, SelectedTask.Position.X.Offset, SelectedTask.Position.Y.Scale, SelectedTask.Position.Y.Offset)
		end
		TweenService:Create(SelectedTask, TaskDestroyAnimationSettings, { Position = TaskPosition }):Play()
		if Find("Background", SelectedTask):split("_")[1] == "GOLD" then
			RemoveTasksNumberValue.Value = math.round(#TaskWorkspace:GetChildren() / 2)
			Bar.Size = BarStandardSize
			GoldTaskCreated = false
		end
		if Direction == CorrectDirection or CorrectDirection == "ANY" then
			AwardValue.Value = true
		elseif Direction ~= CorrectDirection then
			FineValue.Value = true
		end
		wait(0.5)
		SelectedTask:Destroy()
	end
end

function GetLastTaskIndex()
	local Index = 0
	for _, Task in pairs(TaskWorkspace:GetChildren()) do
		local Part = Task.Name:split("_")[2]
		if Part ~= "Destroying" then
			local CurrentIndex = tonumber(Part)
			if CurrentIndex > Index then
				Index = CurrentIndex
			end
		end
	end
	return Index
end
function GetFirstTaskIndex()
	local Index = math.huge
	for _, Task in pairs(TaskWorkspace:GetChildren()) do
		local Part = Task.Name:split("_")[2]
		if Part ~= "Destroying" then
			local CurrentIndex = tonumber(Part)
			if CurrentIndex < Index then
				Index = CurrentIndex
			end
		end
	end
	return Index
end
function RemoveTask(CountToRemove)
	if #TaskWorkspace:GetChildren() - MinTasksValue.Value > CountToRemove then
		ShiftingValue.Value = true
		ShiftTasks(TaskStandardShiftScale * CountToRemove, "DOWN", false)
		wait(0.2)
		for Count = 0, CountToRemove, 1 do
			TaskWorkspace["Task_"..GetLastTaskIndex()]:Destroy()
		end
		ShiftingValue.Value = false
	end
end
--

RemoveTasksNumberValue.Changed:Connect(function()
	if RemoveTasksNumberValue.Value > 0 then
		warn("All Tasks: "..#TaskWorkspace:GetChildren())
		print("Count To Remove: "..RemoveTasksNumberValue.Value)
		local Value = RemoveTasksNumberValue.Value
		RemoveTasksNumberValue.Value = 0
		RemoveTask(Value)
	end
end)

CreateTasksValue.Changed:Connect(function()
	if CreateTasksValue.Value == true then
		repeat
			wait(CreateTasksTimeValue.Value + SlowMotionValue.Value)
			if Bar.Size.X.Scale >= 1 and GoldTaskCreated == false then
				GoldTaskCreated = true
				CreateTask("GOLD", "UP", false)
			elseif Bar.Size.X.Scale < 1 then
				GoldTaskCreated = false
			end
			if math.random(1, 4) == 4 then
				CreateTask("WHITE", "UP", false)
			else
				CreateTask("STANDARD", "UP", false)
			end
		until CreateTasksValue.Value == false
	end
end)

CreateTasksNumberValue.Changed:Connect(function()
	if CreateTasksNumberValue.Value > 0 then
		for Count = 0, CreateTasksNumberValue.Value, 1 do
			if math.random(1, 4) == 4 then
				CreateTask("WHITE", "UP", true)
			else
				CreateTask("STANDARD", "UP", true)
			end
		end
		CreateTasksNumberValue.Value = 0
	end
end)

AwardValue.Changed:Connect(function()
	Bar.Size = UDim2.new(Bar.Size.X.Scale + 0.02, Bar.Size.X.Offset, Bar.Size.Y.Scale, Bar.Size.Y.Offset)
end)

FineValue.Changed:Connect(function()
	Bar.Size = BarStandardSize
end)

DiedValue.Changed:Connect(function()
	if DiedValue.Value == true then
		CreateTasksValue.Value = false
		Bar.Size = BarStandardSize
		wait(1)
		TaskNumberValue.Value = 1
	elseif DiedValue.Value == false then
		for _, Task in pairs(TaskWorkspace:GetChildren()) do
			Task:Destroy()
		end
		UpGate.Position = UpGatePos0
		CurrentTaskNumber = 1
		for Count = 0, MinTasksValue.Value, 1 do
			CreateTask("STANDARD", "UP", true)
		end
	end
end)

UserInputService.InputBegan:Connect(function(Input)
	if (Input.KeyCode == Enum.KeyCode.W or Input.KeyCode == Enum.KeyCode.S or Input.KeyCode == Enum.KeyCode.A or Input.KeyCode == Enum.KeyCode.D) and CreateTasksValue.Value == true then
		SelectTask(TaskWorkspace["Task_"..CurrentTaskNumber])
	end
	if Input.KeyCode == Enum.KeyCode.W then
		DestroyTask("UP")
	end
	if Input.KeyCode == Enum.KeyCode.S then
		DestroyTask("DOWN")
	end
	if Input.KeyCode == Enum.KeyCode.A then
		DestroyTask("LEFT")
	end
	if Input.KeyCode == Enum.KeyCode.D then
		DestroyTask("RIGHT")
	end
end)

HackActiveValue.Changed:Connect(function()
	if HackActiveValue.Value == true then
		GradientSpeedValue.Value = 0.2
		repeat
			if TaskWorkspace:FindFirstChild("Task_"..CurrentTaskNumber) then
				SelectTask(TaskWorkspace["Task_"..CurrentTaskNumber])
				if CorrectDirection == "ANY" then
					local RandomIndex = math.random(1, 4)
					if RandomIndex == 1 then
						DestroyTask("UP")
					elseif RandomIndex == 2 then
						DestroyTask("DOWN")
					elseif RandomIndex == 3 then
						DestroyTask("LEFT")
					elseif RandomIndex == 4 then
						DestroyTask("RIGHT")
					end
				else
					DestroyTask(CorrectDirection)
				end
			end
			wait(0.1)
		until HackActiveValue.Value == false
		GradientSpeedValue.Value = 0.5
	end
end)

while true do
	wait(0.1)
	if CreateTasksValue.Value == true then
		local Pos = TaskWorkspace["Task_"..CurrentTaskNumber].Position.Y.Scale
		if Pos < 0 then
			if ProcessorValue.Value > 0 then
				RemoveTasksNumberValue.Value = math.round(#TaskWorkspace:GetChildren() / 2)
				ProcessorValue.Value = ProcessorValue.Value - 1
				ProcessorAdd:Clone().Parent = EffectsWorkspace
			elseif ProcessorValue.Value == 0 then
				DiedValue.Value = true
			end
		elseif Pos < 0.05 and Pos > 0 then
			UpGate.Position = UpGatePos4
			ShakeTasks(0.015)
		elseif Pos < 0.15 and Pos > 0.05 then
			UpGate.Position = UpGatePos3
			ShakeTasks(0.01)
		elseif Pos < 0.25 and Pos > 0.15 then
			UpGate.Position = UpGatePos2
			ShakeTasks(0.005)
		elseif Pos < 0.35 and Pos > 0.25 then
			UpGate.Position = UpGatePos1
			ShakeTasks(0.001)
		else
			UpGate.Position = UpGatePos0
		end
	end
end