local AbysallHubSettings = {
	Name = "AbysallHub",
	DiscordInvite = "soon",
	Repository = "https://raw.githubusercontent.com/bocaj111004/AbysallHub/refs/heads/main/"
}

local Places = {
	[2440500124] = "Doors"
}

local CurrentPlace = Places[game.GameId] or "Universal"

getgenv().AbysallHubSettings = AbysallHubSettings
getgenv().AbysallHubLoaded = true

loadstring(game:HttpGet(AbysallHubSettings.Repository .. "Places/" .. CurrentPlace .. ".lua"))
