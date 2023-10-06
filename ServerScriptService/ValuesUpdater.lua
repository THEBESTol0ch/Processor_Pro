-- Remote Events
local RemoteEvents = game.ReplicatedStorage.RemoteEvents
local UpdateRecordValueEvent = RemoteEvents.UpdateRecordValueEvent
local UpdateProfitValueEvent = RemoteEvents.UpdateProfitValueEvent
local UpdateWalletValueEvent = RemoteEvents.UpdateWalletValueEvent
local UpdateRankValueEvent = RemoteEvents.UpdateRankValueEvent
local UpdateResponseValueEvent = RemoteEvents.UpdateResponseValueEvent
local UpdateFlowValueEvent = RemoteEvents.UpdateFlowValueEvent
local UpdateHackValueEvent = RemoteEvents.UpdateHackValueEvent
local UpdateProcessorValueEvent = RemoteEvents.UpdateProcessorValueEvent
--

UpdateRecordValueEvent.OnServerEvent:Connect(function(Player, Value)
	Player.leaderstats.Record.Value = Value
end)
UpdateProfitValueEvent.OnServerEvent:Connect(function(Player, Value)
	Player.leaderstats.Profit.Value = Value
end)
UpdateWalletValueEvent.OnServerEvent:Connect(function(Player, Value)
	Player.leaderstats.Wallet.Value = Value
end)
UpdateRankValueEvent.OnServerEvent:Connect(function(Player, Value)
	Player.leaderstats.Rank.Value = Value
end)
UpdateResponseValueEvent.OnServerEvent:Connect(function(Player, Value)
	Player.leaderstats.Response.Value = Value
end)
UpdateFlowValueEvent.OnServerEvent:Connect(function(Player, Value)
	Player.leaderstats.Flow.Value = Value
end)
UpdateHackValueEvent.OnServerEvent:Connect(function(Player, Value)
	Player.leaderstats.Hack.Value = Value
end)
UpdateProcessorValueEvent.OnServerEvent:Connect(function(Player, Value)
	Player.leaderstats.Processor.Value = Value
end)