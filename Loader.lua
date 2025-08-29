if getgenv().AbysallHubLoaded == true then
	warn( "Abysall Hub is already loaded!")
	return
end

local AbysallHubSettings = {
	Name = "AbysallHub",
	DiscordInvite = "https://discord.gg/DXJNkSwje3",
}

local Places = {
	[2440500124] = "Doors"
}

local CurrentPlace = Places[game.GameId] or "Universal"

getgenv().AbysallHubSettings = AbysallHubSettings
getgenv().AbysallHubLoaded = true

loadstring(game:HttpGet("https://raw.githubusercontent.com/bocaj111004/AbysallHub/refs/heads/main/Places/" .. CurrentPlace .. ".lua"))()
