-- Values
local Values = script.Parent.Parent.Values
local DisableMusicValue = Values.DisableMusicValue
local GameInProgressValue = Values.GameInProgressValue
--

-- Sounds
local Music = game.SoundService.Music:GetChildren()
--

-- Functions
function CheckPlayingMusic()
	for _, Track in pairs(Music) do
		if Track.IsPlaying == true then
			return true
		end
	end
	return false
end

function DoMusic(Mode)
	if Mode == "PLAY" then
		if DisableMusicValue.Value == false and CheckPlayingMusic() == false and GameInProgressValue.Value == true then
			Music[math.random(1, #Music)]:Play()
		end
	elseif Mode == "STOP" then
		for _, Track in pairs(Music) do
			Track:Stop()
		end
	end
end
--

GameInProgressValue.Changed:Connect(function()
	if GameInProgressValue.Value == false then
		DoMusic("STOP")
	end
end)

while true do
	wait(1)
	DoMusic("PLAY")
end