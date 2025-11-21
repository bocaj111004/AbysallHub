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

local StarterGui = game:GetService("StarterGui")
local Bindable = Instance.new("BindableFunction")

function Bindable.OnInvoke(Response)
	if Response == "Copy Invite" then
		task.wait(0.5)
		StarterGui:SetCore("SendNotification", {
			Title = "Invite Copied!",
			Text = "The invite has been copied to your clipboard.",
			Duration = 5,
		})
		toclipboard("https://discord.gg/YbvBF8WbfC")
	end
end

loadstring(game:HttpGet("https://raw.githubusercontent.com/bocaj111004/AbysallHub/refs/heads/main/Places/" .. CurrentPlace .. ".lua"))()

StarterGui:SetCore("SendNotification", {
			Title = "Notice",
			Text = "This script is currently being rewritten.",
			Duration = 5,
})
task.wait(3)
StarterGui:SetCore("SendNotification", {
	Title = "Notice",
	Text = "Would you like to join our discord server for updates?",
	Duration = math.huge,
	Callback = Bindable,
	Button1 = "Copy Invite",
	Button2 = "Dismiss"
})
