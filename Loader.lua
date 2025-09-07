if getgenv().AbysallHubLoaded == true then
	warn( "Abysall Hub is already loaded!")
	return
end

loadstring(game:HttpGet("https://raw.githubusercontent.com/bocaj111004/AbysallHub/refs/heads/main/ExecutorTest.lua"))()

local AbysallHubSettings = {
	Name = "Abysall Hub",
	DiscordInvite = "https://discord.gg/DXJNkSwje3",
}

local Places = {
	[2440500124] = "Doors"
}

local CurrentPlace = Places[game.GameId] or "Universal"

getgenv().AbysallHubSettings = AbysallHubSettings
getgenv().AbysallHubLoaded = true

task.wait(0.5)


loadstring(game:HttpGet("https://raw.githubusercontent.com/bocaj111004/AbysallHub/refs/heads/main/Places/" .. CurrentPlace .. ".lua"))()
