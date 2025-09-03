local InfoTab = {}

function InfoTab:AddInfoTab(Tab)
local SupportedGames = Tab:AddLeftGroupbox("Supported Games")
SupportedGames:AddLabel("[Doors]: Working", true)
  SupportedGames:AddLabel("[Slap Battles]: In Development", true)
SupportedGames:AddDivider()
SupportedGames:AddLabel("[Universal]: Working", true)

  local Extra = Tab:AddLeftGroupbox("Extra")

  Extra:AddLabel(AbysallHubSettings.Name .. " is currently keyless, but may have a key system in the future depending on how things go", true)
  Extra:AddDivider()
  Extra:AddLabel("Feel free to upload content using " .. AbysallHubSettings.Name .. " or upload it to scriptblox with no credit needed.")

local Socials = Tab:AddRightGroupbox("Socials")
  Socials:AddButton({
	Text = "Copy Discord Link",
	Tooltip = 'Copies the discord server link to your clipboard.',
	DoubleClick = false,
	Disabled = not ExecutorSupport["toclipboard"],
	DisabledTooltip = "Your executor doesn't support this feature.",
	Func = function()
		toclipboard(AbysallHubSettings.DiscordInvite)
		Library:Notify('Discord invite has been copied to your clipboard!')
		Sound()
	end,
})

local Credits = Tab:AddRightGroupbox("Contributors")
  Credits:AddLabel("[bocaj11104]: Owner")
  Credits:AddDivider()
  Credits:AddLabel("[thehuntersolo1]: Helped to script a few things, found exploits for Doors")
  Credits:AddLabel("[feargeorge]: Helped to script a few things, gave me some ideas for features")
  Credits:AddLabel("[mstudio45]: Made the ESP system we previously used (https://github.com/mstudio45/MSESP), before we made our own")
end

return InfoTab
