local DataStoreService = game:GetService("DataStoreService")
local RecordDataStore = DataStoreService:GetOrderedDataStore("ProcessorPro")

local RefreshRate = 20

function RefreshLeaderboard()
	for i, Player in pairs(game.Players:GetPlayers()) do
		RecordDataStore:SetAsync(Player.UserId, Player.leaderstats.Record.Value)
	end
	
	local Success, Error = pcall(function()
		local Data = RecordDataStore:GetSortedAsync(false, 10)
		local Page = Data:GetCurrentPage()
		
		for Id, SavedData in ipairs(Page) do
			local Username = game.Players:GetNameFromUserIdAsync(tonumber(SavedData.key))
			local Record = SavedData.value
			for _, Player in pairs(game.Players:GetChildren()) do
				local Leaderboard = Player.PlayerGui.ScreenGui.StartScreen.Leaderboard.Frame.Board
				local NewSample = Leaderboard.Sample:Clone()
				NewSample.Visible = true
				NewSample.Parent = Leaderboard
				NewSample.Name = Username
				NewSample.Username.Text = Username
				NewSample.Record.Text = Record
			end
		end
	end)
	
	if Success then
		print("Board successfully updated!")
	else
		print(Error)
	end
end

while true do
	for _, Player in pairs(game.Players:GetPlayers()) do
		for _, Item in pairs(Player.PlayerGui.ScreenGui.StartScreen.Leaderboard.Frame.Board:GetChildren()) do
			if Item.Name ~= "Sample" and Item:IsA("Frame") then
				Item:Destroy()
			end
		end
	end
	RefreshLeaderboard()
	wait(RefreshRate)
end