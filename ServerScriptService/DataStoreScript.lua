-- // Assigning variables //
local DataStoreService = game:GetService("DataStoreService")
local dataStore = DataStoreService:GetDataStore("ProcessorPro")

local function saveData(player) -- The functions that saves data
	local tableToSave = {
		player.leaderstats.Record.Value,
		player.leaderstats.Profit.Value,
		player.leaderstats.Wallet.Value,
		player.leaderstats.Rank.Value,
		player.leaderstats.Response.Value,
		player.leaderstats.Flow.Value,
		player.leaderstats.Hack.Value,
		player.leaderstats.Processor.Value,
	}

	local success, err = pcall(function()
		dataStore:SetAsync(player.UserId, tableToSave) -- Save the data with the player UserId, and the table we wanna save
	end)

	if success then -- If the data has been saved
		print("Data has been saved")
	else -- Else if the save failed
		print("Data hasn't been saved!")
		warn(err)		
	end
end

game.Players.PlayerAdded:Connect(function(player) -- When a player joins the game
	-- // Assigning player stats //
	local leaderstats = Instance.new("Folder")
	leaderstats.Name = "leaderstats"
	leaderstats.Parent = player

	local Record = Instance.new("NumberValue")
	Record.Name = "Record"
	Record.Parent = leaderstats

	local Profit = Instance.new("NumberValue")
	Profit.Name = "Profit"
	Profit.Parent = leaderstats

	local Wallet = Instance.new("NumberValue")
	Wallet.Name = "Wallet"
	Wallet.Parent = leaderstats

	local Rank = Instance.new("NumberValue")
	Rank.Name = "Rank"
	Rank.Value = 1
	Rank.Parent = leaderstats

	local Response = Instance.new("NumberValue")
	Response.Name = "Response"
	Response.Parent = leaderstats

	local Flow = Instance.new("NumberValue")
	Flow.Name = "Flow"
	Flow.Parent = leaderstats

	local Hack = Instance.new("NumberValue")
	Hack.Name = "Hack"
	Hack.Parent = leaderstats

	local Processor = Instance.new("NumberValue")
	Processor.Name = "Processor"
	Processor.Parent = leaderstats

	local data -- We will define the data here so we can use it later, this data is the table we saved
	local success, err = pcall(function()
		data = dataStore:GetAsync(player.UserId) -- Get the data from the datastore
	end)

	if success and data then -- If there were no errors and player loaded the data
		Record.Value = data[1]
		Profit.Value = data[2]
		Wallet.Value = data[3]
		Rank.Value = data[4]
		Response.Value = data[5]
		Flow.Value = data[6]
		Hack.Value = data[7]
		Processor.Value = data[8]
	else -- The player didn't load in the data, and probably is a new player
		print("The player has no data!") -- The default will be set to 0
	end

end)

game.Players.PlayerRemoving:Connect(function(player) -- When a player leaves
	local success, err  = pcall(function()
		saveData(player) -- Save the data
	end)

	if success then
		print("Data has been saved")
	else
		print("Data has not been saved!")
	end
end)

game:BindToClose(function() -- When the server shuts down
	for _, player in pairs(game.Players:GetPlayers()) do -- Loop through all the players
		local success, err  = pcall(function()
			saveData(player) -- Save the data
		end)

		if success then
			print("Data has been saved")
		else
			print("Data has not been saved!")
		end
	end
end)