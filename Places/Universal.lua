




ScriptName = "Abysall Hub"

AbysallHubSettings = getgenv().AbysallHubSettings



-- Variables --




LoadingTime = tick()

Players = game:GetService("Players")
ReplicatedStorage = game:GetService("ReplicatedStorage")
RunService = game:GetService("RunService")
Player = Players.LocalPlayer

Mouse = Player:GetMouse()

Camera = workspace.CurrentCamera

Lighting = game:GetService("Lighting")
TweenService = game:GetService("TweenService")

TeleportService = game:GetService("TeleportService")

UserInputService = game:GetService("UserInputService")

Teams = game:GetService("Teams")

HttpService = game:GetService("HttpService")




repo = 'https://raw.githubusercontent.com/bocaj111004/Obsidian/refs/heads/main/'


Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()

Toggles = Library.Toggles
Options = Library.Options

ESPLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/bocaj111004/ESPLibrary/refs/heads/main/Library.lua"))()


Window = Library:CreateWindow({

	Title = ScriptName,
	Center = true,
	AutoShow = true,
	TabPadding = 4,
	MenuFadeTime = 0,
	Footer = "Universal"
})

Tabs = {
	Main = Window:AddTab('General', "house"),
	Exploits = Window:AddTab('Exploits', "shield"),
	Visuals = Window:AddTab('Visuals', "eye"),
	UISettings = Window:AddTab('Configuration', "settings"),
	
	
	
}


function Sound()



	local sound = Instance.new("Sound")


	sound.Volume = 3

	sound.SoundId = "rbxassetid://4590657391"


	sound:Play()

	sound.Parent = game.ReplicatedStorage

	game:GetService("Debris"):AddItem(sound,15)


end


local Targets = {}


local TouchParts = {}

local NPC = {}
local Tools = {}

for i,Model in pairs(workspace:GetDescendants()) do
	if Model:IsA("BasePart") then
		Model:SetAttribute("OriginalTouch", Model.CanTouch)
		table.insert(TouchParts, Model)

	end
	
	
	
	
	
	
	if Model:IsA("Model") and Model ~= Player.Character and Players:GetPlayerFromCharacter(Model.Parent) then
		table.insert(Targets, Model)
		
		
	end
	if Model:FindFirstChild("HumanoidRootPart") and Model:FindFirstChildOfClass("Humanoid") and not Players:GetPlayerFromCharacter(Model) then
		table.insert(NPC, Model)
	end
	
	
	
	
	
	
	if Model:IsA("Tool") then
		table.insert(Tools, Model)
	end
	
end

local PartProperties = {}

local Character = Player.Character

while Character == nil do
	task.wait()
end

local HumanoidRootPart = Character.HumanoidRootPart
local Humanoid = Character.Humanoid

local fly = {
	enabled = false,
	flyBody = Instance.new("BodyVelocity"),
	flyGyro = Instance.new("BodyGyro"),
}






fly.flyBody.Velocity = Vector3.zero
fly.flyBody.MaxForce = Vector3.one * 9e9

fly.flyGyro.P = 6500
fly.flyGyro.MaxTorque = Vector3.new(4000000,4000000,4000000)
fly.flyGyro.D = 500





WorldTab = Tabs.Main:AddLeftGroupbox('World')

MiscTab = Tabs.Main:AddRightGroupbox('Misc')



MiscTab:AddToggle('DisableAFKKick', {
	Default = false,
	Text = 'Disable AFK Kick',
	Tooltip = 'Prevents roblox from kicking you after 20 minutes.'
})

local VirtualUser = game:GetService("VirtualUser")
Player.Idled:Connect(function()
	if Toggles.DisableAFKKick.Value then
		VirtualUser:CaptureController()
		VirtualUser:ClickButton2(Vector2.new())
	end
end)

MiscTab:AddDivider()

MiscTab:AddButton{
	Text = 'Reset Character',
	DoubleClick = true,
	Tooltip = 'Redeems all currently active codes in the game',
	Func = function()
		if replicatesignal then
			replicatesignal(Player.Kill)
		end
		Humanoid.Health = 0
	end
}

local OldWalkSpeed = Humanoid.WalkSpeed
local OldJumpPower = Humanoid.JumpPower



MiscTab:AddButton({
	Text = 'Rejoin Server',
	DoubleClick = true,
	Tooltip = 'Rejoins your current server.',
	Func = function()
		local PlaceId = game.PlaceId
		local JobId = game.JobId
		if #Players:GetPlayers() <= 1 then
			Player:Kick("\nRejoining...")
			task.wait()
			TeleportService:Teleport(PlaceId, Players.LocalPlayer)
		else
			TeleportService:TeleportToPlaceInstance(PlaceId, JobId, Players.LocalPlayer)
		end
	end
})

MiscTab:AddButton({
	Text = 'Server Hop',
	DoubleClick = true,
	Tooltip = 'Joins a new server.',
	Func = function()
		local PlaceId = game.PlaceId
		local JobId = game.JobId
		local servers = {}
		local req = game:HttpGet("https://games.roblox.com/v1/games/" .. PlaceId .. "/servers/Public?sortOrder=Desc&limit=100&excludeFullGames=true")
		local body = HttpService:JSONDecode(req)

		if body and body.data then
			for i, v in next, body.data do
				if type(v) == "table" and tonumber(v.playing) and tonumber(v.maxPlayers) and v.playing < v.maxPlayers and v.id ~= JobId then
					table.insert(servers, 1, v.id)
				end
			end
		end

		if #servers > 0 then
			TeleportService:TeleportToPlaceInstance(PlaceId, servers[math.random(1, #servers)], Players.LocalPlayer)
		else
			Sound()
			return Library:Notify("Failed to find a serer.", 8)
	end
		
	end
})

MiscTab:AddButton({
	Text = 'Instant Leave',
	DoubleClick = true,
	Tooltip = 'Instantly exits the game.',
	Func = function()
	game:Shutdown()
	end
})




WorldTab:AddSlider('Walkspeed',{
	Text = "Walkspeed",
	Default = OldWalkSpeed,
	Min = 0,
	Max = 250,
	Rounding = 0,
	Compact = false
})

WorldTab:AddToggle('EnableWalkspeed', {
	Text = "Enable Walkspeed",
	Default = false,
	Tooltip = 'Enables the Walkspeed changer.',
	Callback = function(Value)
		if not Value then
			Humanoid.WalkSpeed = OldWalkSpeed
		end
	end,
})

WorldTab:AddSlider('JumpPower',{
	Text = "Jump Power",
	Default = OldJumpPower,
	Min = 0,
	Max = 250,
	Rounding = 0,
	Compact = false
})

WorldTab:AddToggle('EnableJumpPower', {
	Text = "Enable Jump Power",
	Default = false,
	Tooltip = 'Enables the Jump Power changer.',
	Callback = function(Value)
		if not Value then
			Humanoid.JumpPower = OldJumpPower
		end
	end,
})



WorldTab:AddDivider()

WorldTab:AddToggle('Noclip', {
	Text = 'Noclip',
	Default = false, -- Default value (true / false)
	Tooltip = 'Disables collisions, allowing you to walk through objects', -- Information shown when you hover over the toggle

	Callback = function(Value)

	end

}):AddKeyPicker('NoclipKeybind', {


	Default = 'N', -- String as the name of the keybind (MB1, MB2 for mouse buttons)
	SyncToggleState = true,


	-- You can define custom Modes but I have never had a use for it.
	Mode = 'Toggle', -- Modes: Always, Toggle, Hold

	Text = 'Noclip', -- Text to display in the keybind menu
	NoUI = false, -- Set to true if you want to hide from the Keybind menu,

	-- Occurs when the keybind is clicked, Value is `true`/`false`
	Callback = function(Value)



	end,

	-- Occurs when the keybind itself is changed, `New` is a KeyCode Enum OR a UserInputType Enum
	ChangedCallback = function(New)
	end
})

WorldTab:AddToggle('InfiniteJump', {
	Text = 'Infinite Jumps',
	Default = false, -- Default value (true / false)
	Tooltip = 'Allows your character to jump multiple times in mid air.', -- Information shown when you hover over the toggle

})

WorldTab:AddDivider()

WorldTab:AddToggle('Fly', {
	Text = 'Flight',
	Default = false, -- Default value (true / false)
	Tooltip = 'Allows your character to fly.', -- Information shown when you hover over the toggle

	Callback = function(Value)

		fly.enabled = Value

		if Value == true then 
			game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):SetStateEnabled(Enum.HumanoidStateType.Freefall, false)
		else
			game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):SetStateEnabled(Enum.HumanoidStateType.Freefall, true)
		end

	end
}):AddKeyPicker('FlyKeybind', {


	Default = 'F', -- String as the name of the keybind (MB1, MB2 for mouse buttons)
	SyncToggleState = true,


	-- You can define custom Modes but I have never had a use for it.
	Mode = 'Toggle', -- Modes: Always, Toggle, Hold

	Text = 'Flight', -- Text to display in the keybind menu
	NoUI = false, -- Set to true if you want to hide from the Keybind menu,

	-- Occurs when the keybind is clicked, Value is `true`/`false`
	Callback = function(Value)


	end,

	-- Occurs when the keybind itself is changed, `New` is a KeyCode Enum OR a UserInputType Enum
	ChangedCallback = function(New)
	end
})




WorldTab:AddSlider('FlySpeed', {
	Text = 'Flight Speed',
	Default = 50,
	Min = 0,
	Max = 250,
	Rounding = 0,
	Compact = true,

	Callback = function(Value)
		

	end
})



local AimbotCircle

if Drawing and Drawing.new then
AimbotCircle = Drawing.new("Circle")
AimbotCircle.Filled = false
AimbotCircle.Thickness = 1
AimbotCircle.NumSides = 0
AimbotCircle.Color = Color3.fromRGB(255,255,255)
AimbotCircle.Visible = false
end






AimbotGroupbox = Tabs.Exploits:AddLeftGroupbox('Aimbot')

AimbotGroupbox:AddToggle('EnableAimbot', {
	Text = 'Enable Aimbot',
	Default = false,
	Tooltip = 'Moves your camera towards selected targets.'
}):AddKeyPicker('AimbotKeybind', {


	Default = 'MB2',
	SyncToggleState = true,


	
	Mode = (Library.IsMobile and 'Toggle' or 'Hold'),

	Text = 'Aimbot',
	NoUI = false,

	
})





AimbotGroupbox:AddDropdown('AimbotTargetPart', {
	Values = {'HumanoidRootPart', 'Head'},
	Text = "Target Part",
	Default = 1,
	Compact = false,
	Multi = false
})

AimbotGroupbox:AddDropdown('AimbotClosestType', {
	Values = {'Mouse', 'Character'},
	Text = "Distance Type",
	Default = 1,
	Compact = false,
	Multi = false
})

AimbotGroupbox:AddDropdown('AimbotChecks', {
	Values = {'Alive', 'Forcefield', 'Team', 'Wall'},
	Text = "Checks",
	Default = 0,
	Compact = false,
	Multi = true
})

AimbotGroupbox:AddDropdown('AimbotWhitelist', {
	Text = "Whitelist",
	Default = 0,
	Compact = false,
	Multi = true,
	SpecialType = 'Player'
})



AimbotGroupbox:AddDivider()

AimbotGroupbox:AddToggle('AimbotCircle', {
	Text = "Aimbot Circle",
	Default = false,
	Tooltip = 'Visualises the maximum range for aimbot to lock on to someone.',
	Disabled = not (Drawing and Drawing.new),
	DisabledTooltip = "Your executor doesn't support this feature.",
	}):AddColorPicker('AimbotCircleColor', {
		Default = Color3.fromRGB(255,255,255), -- Bright green
		Title = 'Circle Color', -- Optional. Allows you to have a custom color picker title (when you open it)
		Transparency = 0, -- Optional. Enables transparency changing for this color picker (leave as nil to disable)

		Callback = function(Value)

			AimbotCircle.Color = Value
		end
	})
	
	AimbotGroupbox:AddToggle('AimbotCircleRainbow', {
		Text = "Rainbow Circle",
		Default = false,
		Tooltip = 'Mkaes the aimbot circle rainbow.',
	Disabled = not (Drawing and Drawing.new),
	DisabledTooltip = "Your executor doesn't support this feature.",
	})
	
	


AimbotGroupbox:AddSlider('AimbotCircleSize',{
	Text = "Circle Size",
	Default = 100,
	Min = 1,
	Max = 500,
	Rounding = 0,
	Compact = false,
	Disabled = not (Drawing and Drawing.new),
	DisabledTooltip = "Your executor doesn't support this feature.",
})

	AimbotGroupbox:AddSlider('AimbotCircleThickness',{
		Text = "Circle Thickness",
		Default = 1,
		Min = 1,
		Max = 10,
		Rounding = 0,
		Compact = false,
	Disabled = not (Drawing and Drawing.new),
	DisabledTooltip = "Your executor doesn't support this feature.",
	})
	



BypassesGroupbox = Tabs.Exploits:AddRightGroupbox('Bypasses')

BypassesGroupbox:AddToggle('DisableSitting', {
	Text = 'Disable Sitting',
	Defaut = false,
	Tooltip = 'Prevents your character from sitting'
})

BypassesGroupbox:AddToggle('DisableTouching', {
	Text = 'Disable Touching',
	Defaut = false,
	Tooltip = 'Prevents your character from triggering .Touched events.',
	Callback = function(Value)
		for i,Part in pairs(TouchParts) do
			if Part then
				if Value then
				Part.CanTouch = false
				else
					Part.CanTouch = Part:GetAttribute("OriginalTouch")
				end
			end
		end
	end,
})







ESPSelection = Tabs.Visuals:AddLeftGroupbox('ESP Selection')

ESPSelection:AddToggle('PlayerESP', {
	Text = 'Players',
	Default = false,
	Tooltip = 'Highlights other players',
	Callback = function(Value)
		for i,NewPlayer in pairs(Players:GetPlayers()) do
			if NewPlayer ~= Player and NewPlayer.Character then
				if Value then
					ESPLibrary:AddESP({
						Object = NewPlayer.Character,
						Text = NewPlayer.DisplayName,
						Color = (Player.Team and Toggles.UseTeamColor.Value and Player.TeamColor.Color or Options.PlayerESPColor.Value)
					})
				else
					ESPLibrary:RemoveESP(NewPlayer.Character)
				end
			end
		end
	end,
}):AddColorPicker('PlayerESPColor', {
	Default = Color3.fromRGB(255,255,255), -- Bright green
	Title = 'Players', -- Optional. Allows you to have a custom color picker title (when you open it)
	Transparency = 0, -- Optional. Enables transparency changing for this color picker (leave as nil to disable)

	Callback = function(Value)
		
		for i,NewPlayer in pairs(Players:GetPlayers()) do
			if NewPlayer ~= Player and NewPlayer.Character then
				
				ESPLibrary:UpdateObjectColor(NewPlayer.Character, Value)
				
				
			end
		end
	end
})

ESPSelection:AddToggle('NPCESP', {
	Text = 'NPC',
	Default = false,
	Tooltip = 'Highlights all non-player humanoids currently inside of the workspace.',
	Callback = function(Value)
		for i,NewPlayer in pairs(NPC) do
			if NewPlayer ~= nil then
				if Value then
					ESPLibrary:AddESP({
						Object = NewPlayer,
						Text = NewPlayer.Name,
						Color = Options.NPCESPColor.Value
					})
				else
					ESPLibrary:RemoveESP(NewPlayer)
				end
			end
		end
	end,
}):AddColorPicker('NPCESPColor', {
	Default = Color3.fromRGB(255, 0, 0), -- Bright green
	Title = 'NPC', -- Optional. Allows you to have a custom color picker title (when you open it)
	Transparency = 0, -- Optional. Enables transparency changing for this color picker (leave as nil to disable)

	Callback = function(Value)

		for i,NewPlayer in pairs(NPC) do
			if NewPlayer ~= nil then

				ESPLibrary:UpdateObjectColor(NewPlayer, Value)


			end
		end
	end
})



ESPSettings = Tabs.Visuals:AddRightGroupbox('ESP Configuration')

ESPLibrary:SetRainbow(false)
ESPLibrary:SetFillTransparency(0.75)
ESPLibrary:SetTextSize(22)
ESPLibrary:SetOutlineTransparency(0)
ESPLibrary:SetTextTransparency(0)
ESPLibrary:SetTextOutlineTransparency(0.25)
ESPLibrary:SetFadeTime(0.5)

ESPLibrary:SetMatchColors(true)
ESPLibrary:SetShowDistance(true)
ESPLibrary:SetTracers(false)
ESPLibrary:SetTracerOrigin('Bottom')
ESPLibrary:SetFont(Enum.Font.Oswald)
ESPLibrary:SetDistanceSizeRatio(0.8)
ESPLibrary:SetTracerSize(0.75)




ESPSettings:AddToggle('Toggle21', {
	Text = 'Rainbow ESP',
	Default = false, -- Default value (true / false)
	Tooltip = 'Makes all ESP highlights have a rainbow effect.', -- Information shown when you hover over the toggle

	Callback = function(Value)
		ESPLibrary:SetRainbow(Value)
	end
})
ESPSettings:AddToggle('UseTeamColor', {
	Text = 'Use Team Color',
	Default = false, -- Default value (true / false)
	Tooltip = "Uses a player's team color.", -- Information shown when you hover over the toggle

	Callback = function(Value)
		for i,NewPlayer in pairs(Players:GetPlayers()) do
			if NewPlayer ~= Player and NewPlayer.Character then
if Value and Player.Team then
				ESPLibrary:UpdateObjectColor(NewPlayer.Character, NewPlayer.TeamColor.Color)
else
					ESPLibrary:UpdateObjectColor(NewPlayer.Character, Options.PlayerESPColor.Value)
end


			end
		end
	end
})
ESPSettings:AddDivider()
ESPSettings:AddSlider('Slider3', {
	Text = 'Fill Transparency',
	Default = 0.75,
	Min = 0,
	Max = 1,
	Rounding = 2,
	Compact = true,

	Callback = function(Value)
		ESPLibrary:SetFillTransparency(Value)

	end
})
ESPSettings:AddSlider('Slider4', {
	Text = 'Outline Transparency',
	Default = 0,
	Min = 0,
	Max = 1,
	Rounding = 2,
	Compact = true,

	Callback = function(Value)
		ESPLibrary:SetOutlineTransparency(Value)

	end
})
ESPSettings:AddSlider('ESPTextTransparency', {
	Text = 'Text Transparency',
	Default = 0,
	Min = 0,
	Max = 1,
	Rounding = 2,
	Compact = true,

	Callback = function(Value)
		ESPLibrary:SetTextTransparency(Value)

	end
})

ESPSettings:AddSlider('ESPFadeTime', {
	Text = 'Fade Time',
	Default = 0.5,
	Min = 0,
	Max = 2,
	Rounding = 2,
	Compact = true,

	Callback = function(Value)
		ESPLibrary:SetFadeTime(Value)

	end
})
ESPSettings:AddSlider('ESPStrokeTransparency', {
	Text = 'Text Outline Transparency',
	Default = 0.25,
	Min = 0,
	Max = 1,
	Rounding = 2,
	Compact = true,

	Callback = function(Value)
		ESPLibrary:SetTextOutlineTransparency(Value)

	end
})
ESPSettings:AddSlider('ESPTextSize', {
	Text = 'Text Size',
	Default = 22,
	Min = 1,
	Max = 100,
	Rounding = 0,
	Compact = true,

	Callback = function(Value)
		ESPLibrary:SetTextSize(Value)

	end
})


ESPSettings:AddDropdown("ESPFont", { Values = { "Arial", "SourceSans", "Highway", "Fantasy","FredokaOne", "Gotham", "DenkOne", "JosefinSans", "Nunito", "Oswald", "RobotoCondensed", "Sarpanch", "Ubuntu" }, Default = 10, Multi = false, Text = "Text Font", Callback = function(Value) ESPLibrary:SetFont(Enum.Font[Value]) end})
ESPSettings:AddDivider()
ESPSettings:AddToggle('SyncColors', {
	Text = 'Custom Outline Color',
	Default = false, -- Default value (true / false)
	Tooltip = 'Makes all ESP highlights Outline Color set to the selected color.', -- Information shown when you hover over the toggle

	Callback = function(Value)
		ESPLibrary:SetMatchColors(not Value)
	end
}):AddColorPicker('CustomOutlineColorPicker', {
	Default = Color3.fromRGB(255,255,255),
	Title = 'Custom Outline Color',
	Transparency = 0,

	Callback = function(Value)
		ESPLibrary.OutlineColor = Value
	end
})
ESPLibrary:SetFont(Options.ESPFont.Value)
ESPSettings:AddToggle('ShowDistance', {
	Text = 'Show Distance',
	Default = true, -- Default value (true / false)
	Tooltip = 'Shows the distance [in studs] that the object is away from the Player', -- Information shown when you hover over the toggle

	Callback = function(Value)
		ESPLibrary:SetShowDistance(Value)
	end
})
ESPSettings:AddDivider()
ESPSettings:AddToggle('EnableTracers', {
	Text = 'Enable Tracers',
	Default = false, -- Default value (true / false)
	Tooltip = 'Shows a line on screen that points to the object', -- Information shown when you hover over the toggle

	Callback = function(Value)
		ESPLibrary:SetTracers(Value)
	end
})

ESPSettings:AddSlider('TracerSize', {
	Text = 'Tracer Thickness',
	Default = 0.75,
	Min = 0.5,
	Max = 3,
	Rounding = 2,
	Compact = true,

	Callback = function(Value)
		ESPLibrary:SetTracerSize(Value)

	end
})

ESPSettings:AddDropdown("TracerOrigin", {
	Values = {'Bottom','Top','Center','Mouse'},
	Default = 1,
	Multi = false,
	Text = "Tracer Origin",
	Callback = function(Value) 
		ESPLibrary:SetTracerOrigin(Value)
	end
})

local FOVValue = Instance.new("NumberValue")
FOVValue.Value = 70

local OriginalAmbience = Lighting.Ambient

MiscVisuals = Tabs.Visuals:AddLeftGroupbox('Misc')

MiscVisuals:AddToggle('ToggleAmbience', {
	Text = 'Ambience',
	Default = false,
	Tooltip = "Changes the game's ambience to be the selected color.",
}):AddColorPicker('Ambience',{
	Default = Color3.fromRGB(255,255,255),
	Title = "Ambience",
	Transparency = 0,
})

local OriginalFOV = Camera.FieldOfView

MiscVisuals:AddSlider('FieldOfView',{
	Text = "Field Of View",
	Default = OriginalFOV,
	Min = 0,
	Max = 120,
	Rounding = 0,
	Compact = false,
	Callback = function(Value)
		TweenService:Create(FOVValue, TweenInfo.new(1, Enum.EasingStyle.Exponential), {Value = Value}):Play()
	end,
})



MiscVisuals:AddToggle('EnableFOV', {
	Text = "Enable Field of View",
	Default = false,
	Tooltip = 'Enables the Field of View changer.',
	Callback = function(Value)
		if not Value then
			Camera.FieldOfView = OriginalFOV
			TweenService:Create(FOVValue, TweenInfo.new(1, Enum.EasingStyle.Exponential), {Value = OriginalFOV}):Play()
		else
			TweenService:Create(FOVValue, TweenInfo.new(1, Enum.EasingStyle.Exponential), {Value = Options.FieldOfView.Value}):Play()
		end
	end,
})


local WorkspaceDescendantAddedConnection = workspace.DescendantAdded:Connect(function(Model)
	task.wait()
	if not Model:IsA("BasePart") and Model.Name ~= "HumanoidRootPart" and Model.Name ~= "Head" and not Players:GetPlayerFromCharacter(Model) then
		return
	end
	
	

	
	
	if Model:IsA("BasePart") then
		table.insert(TouchParts, Model)
		Model:SetAttribute("OriginalTouch", Model.CanTouch)
		
		if Toggles.DisableTouching.Value then
			Model.CanTouch = false
		end
	end

	
	
	task.wait(1)
	
	

	if Model:IsA("BasePart") then
		table.insert(TouchParts, Model)
		Model:SetAttribute("OriginalTouch", Model.CanTouch)

		if Toggles.DisableTouching.Value then
			Model.CanTouch = false
		end
	end

	
	if Model:IsA("Model") and Model ~= Player.Character and Players:GetPlayerFromCharacter(Model) then
		table.insert(Targets, Model)
		if Toggles.PlayerESP.Value then
			ESPLibrary:AddESP({
				Object = Model,
				Text = Players:GetPlayerFromCharacter(Model).DisplayName,
				Color = (Toggles.UseTeamColor.Value and Players:GetPlayerFromCharacter(Model).Team and Players:GetPlayerFromCharacter(Model).TeamColor.Color or Options.PlayerESPColor.Value)
			})
		end

		



		

	end
	
	if Model:IsA("Tool") then
		table.insert(Tools, Model)
	end
	if Model:FindFirstChild("HumanoidRootPart") and Model:FindFirstChildOfClass("Humanoid") and not Players:GetPlayerFromCharacter(Model) then
		table.insert(NPC, Model)
		if Toggles.NPCESP.Value then
			ESPLibrary:AddESP({
				Object = Model,
				Text = Model.Name,
				Color = Options.NPCESPColor.Value
			})
		end
	end
	
	Model.Destroying:Connect(function()
		
		for i,RemovingInstance in pairs(Targets) do
			if RemovingInstance == Model then
				table.remove(Targets, i)
			end
		end
		for i,RemovingInstance in pairs(TouchParts) do
			if RemovingInstance == Model then
				table.remove(TouchParts, i)
			end
		end
		for i,RemovingInstance in pairs(NPC) do
			if RemovingInstance == Model then
				table.remove(NPC, i)
			end
		end
	end)
end)

local function CheckValidity(NewCharacter)
	local NewPlayer = Players:GetPlayerFromCharacter(NewCharacter)
	
	if not NewCharacter:FindFirstChild("HumanoidRootPart") then
		return false
	end
	
	if NewPlayer.Team and NewPlayer.Team == Player.Team and Options.AimbotChecks.Value["Team"] then
		return false
	end
	
	if NewCharacter:FindFirstChild("Humanoid") and NewCharacter.Humanoid.Health <= 0 and Options.AimbotChecks.Value["Alive"] then
		return false
	end
	
	if NewCharacter:FindFirstChild("ForceField") and Options.AimbotChecks.Value["Forcefield"] then
		return false
	end
	
	if Options.AimbotWhitelist.Value[NewPlayer] then
		return false
	end
	
	
	
	

	if HumanoidRootPart and NewCharacter and NewCharacter:FindFirstChild("HumanoidRootPart") then
		local origin = HumanoidRootPart.Position
		local target = NewCharacter.HumanoidRootPart.Position
		local direction = (target - origin).Unit * (target - origin).Magnitude

		local rayParams = RaycastParams.new()
		rayParams.FilterDescendantsInstances = {Character, NewCharacter}
		rayParams.FilterType = Enum.RaycastFilterType.Blacklist

		local result = workspace:Raycast(origin, direction, rayParams)

		if result and Options.AimbotChecks.Value["Wall"] then
			return false
		end
	end

	
	return true
end

local function GetAimbotTarget()
	local NearestTarget
	local NearestTargetDistance = math.huge
	
	for i,NewPlayer in pairs(Players:GetPlayers()) do
		if Options.AimbotClosestType.Value == 'Character' then
		if NewPlayer ~= Player and NewPlayer.Character and NewPlayer.Character:FindFirstChild(Options.AimbotTargetPart.Value) and Player:DistanceFromCharacter(NewPlayer.Character:FindFirstChild(Options.AimbotTargetPart.Value).Position) < NearestTargetDistance then
			if CheckValidity(NewPlayer.Character) then
			NearestTarget = NewPlayer.Character.Head
			NearestTargetDistance = Player:DistanceFromCharacter(NewPlayer.Character:FindFirstChild(Options.AimbotTargetPart.Value).Position)
			end
			end
		else
				if NewPlayer ~= Player and NewPlayer.Character and NewPlayer.Character:FindFirstChild(Options.AimbotTargetPart.Value) then
					
					local ScreenPosition, OnScreen = Camera:WorldToViewportPoint(NewPlayer.Character:FindFirstChild(Options.AimbotTargetPart.Value).Position)
							if OnScreen then
								local MousePosition = Vector2.new(Mouse.X, Mouse.Y)
						local HeadPosition2D = Vector2.new(ScreenPosition.X, ScreenPosition.Y)
								local Distance = (MousePosition - HeadPosition2D).Magnitude
					if Distance < NearestTargetDistance and Distance < Options.AimbotCircleSize.Value * 1.1 then
						if CheckValidity(NewPlayer.Character) then
									NearestTargetDistance = Distance
							NearestTarget = NewPlayer.Character:FindFirstChild(Options.AimbotTargetPart.Value)
							end
								end
							end
						
					
				
			end
		
		end
	end
	
	
	
	return NearestTarget
end

local InfiniteJumpDebounce = false
local InfiniteJumpConnection = UserInputService.JumpRequest:Connect(function()
	if not InfiniteJumpDebounce and Toggles.InfiniteJump.Value then
		InfiniteJumpDebounce = true


		Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
		task.wait(0.2)
		InfiniteJumpDebounce = false
	end
end)

local MainConnection = RunService.RenderStepped:Connect(function()
	if not Character or not Character:FindFirstChild("HumanoidRootPart") or not Character:FindFirstChild("Humanoid") then
		return
	end

	
	local Target = GetAimbotTarget()
	local TargetPosition
	
	if Target then
		TargetPosition = Target.Position
	end
	
	TweenService:Create(fly.flyGyro, TweenInfo.new(0.25, Enum.EasingStyle.Exponential), {CFrame = game.Workspace.CurrentCamera.CFrame}):Play()

	local function u2()



		if Character:WaitForChild("Humanoid").MoveDirection == Vector3.new(0, 0, 0) then

			local NewVelocity = Character:WaitForChild("Humanoid").MoveDirection



			return Character:WaitForChild("Humanoid").MoveDirection

		else


		end
		local v12 = (game.Workspace.CurrentCamera.CFrame * CFrame.new((CFrame.new(game.Workspace.CurrentCamera.CFrame.p, game.Workspace.CurrentCamera.CFrame.p + Vector3.new(game.Workspace.CurrentCamera.CFrame.lookVector.x, 0, game.Workspace.CurrentCamera.CFrame.lookVector.z)):VectorToObjectSpace(Humanoid.MoveDirection)))).p - game.Workspace.CurrentCamera.CFrame.p;
		if v12 == Vector3.new() then
			return v12
		end
		return v12.unit
	end
	
	if AimbotCircle and Toggles.AimbotCircleRainbow.Value then
		AimbotCircle.Color = ESPLibrary.RainbowColor
	else
		AimbotCircle.Color = Options.AimbotCircleColor.Value
	end
	
	if Toggles.DisableSitting.Value then
		Humanoid.Sit = false
	end
	
	if fly.enabled == true then
		local velocity = Vector3.zero

		velocity = u2()


		TweenService:Create(fly.flyBody, TweenInfo.new(0.25, Enum.EasingStyle.Exponential), {Velocity = velocity * (Options.FlySpeed.Value)}):Play()



		fly.flyBody.Parent = Character.HumanoidRootPart
		fly.flyGyro.Parent = Character.HumanoidRootPart



	else

		fly.flyBody.Parent = ReplicatedStorage
		fly.flyGyro.Parent = ReplicatedStorage



	end
	if Toggles.EnableWalkspeed.Value then
	Character.Humanoid.WalkSpeed = Options.Walkspeed.Value
	end
	
	if Toggles.EnableJumpPower.Value then
		Character.Humanoid.JumpPower = Options.JumpPower.Value
	end


	Character.Humanoid.PlatformStand = (Toggles.Fly.Value and true or Options.FlyKeybind:GetState() == true and true or false)

	for i,part in pairs(Character:GetDescendants()) do
		if part:IsA("BasePart") then
			if part.Name == "UpperTorso" or part.Name == "Torso" then
				part.CanCollide = (not Toggles.Noclip.Value and Options.NoclipKeybind:GetState() ~= true and true or false)
			else
				part.CanCollide = false
			end
		end
	end
	
	
	
	AimbotCircle.Visible = (Toggles.AimbotCircle.Value and Toggles.EnableAimbot.Value and true or Toggles.AimbotCircle.Value and Options.AimbotKeybind:GetState() == true and true or false)
	
	AimbotCircle.Position = Vector2.new(Mouse.X,UserInputService:GetMouseLocation().Y)
	
	
	if Toggles.EnableAimbot.Value or Options.AimbotKeybind:GetState() == true then
		
			
		if TargetPosition then
		
		Camera.CFrame = CFrame.new(Camera.CFrame.Position, TargetPosition)
		
		end
		
		
		
		
		
		AimbotCircle.Thickness = Options.AimbotCircleThickness.Value
		
		AimbotCircle.Radius = Options.AimbotCircleSize.Value
		
	
		
		
		
	end
	
	task.wait()
	
	TweenService:Create(Lighting, TweenInfo.new(0.5, Enum.EasingStyle.Exponential), {Ambient = (Toggles.ToggleAmbience.Value and Options.Ambience.Value or OriginalAmbience)}):Play()
	if Toggles.EnableFOV.Value then
	Camera.FieldOfView = FOVValue.Value
	end
end)

local CharacterAddedConnection = Player.CharacterAdded:Connect(function(NewCharacter)
	task.wait(0.25)
	
	Character = NewCharacter
	HumanoidRootPart = NewCharacter:WaitForChild("HumanoidRootPart", 9e9)
	Humanoid = Character:WaitForChild("Humanoid", 9e9)
	
	if fly.enabled == true then
		fly.flyBody.Parent = HumanoidRootPart
		fly.flyGyro.Parent = HumanoidRootPart
	end
	
	Camera = workspace.CurrentCamera
	
	InfiniteJumpConnection:Disconnect()
	
	InfiniteJumpDebounce = false
	InfiniteJumpConnection = UserInputService.JumpRequest:Connect(function()
		if not InfiniteJumpDebounce and Toggles.InfiniteJump.Value then
			InfiniteJumpDebounce = true
			
			
			Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
			task.wait(0.2)
			InfiniteJumpDebounce = false
		end
	end)
end)






MenuSettings = Tabs.UISettings:AddRightGroupbox("Settings")



-- I set NoUI so it does not show up in the keybinds menu

MenuSettings:AddToggle('KeybindMenu', {
	Text = 'Show Keybinds',
	Default = false, -- Default value (true / false)
	Tooltip = 'Toggles the Keybind Menu, showing all Keybinds and their status.', -- Information shown when you hover over the toggle

	Callback = function(Value)
		Library.KeybindFrame.Visible = Value
	end

})

MenuSettings:AddToggle('CustomCursor', {
	Text = 'Custom Cursor',
	Default = (Library.IsMobile == false and true or false), -- Default value (true / false)
	Tooltip = 'Toggles the custom cursor..', -- Information shown when you hover over the toggle

	Callback = function(Value)
		Library.ShowCustomCursor = Value
	end

})

Library.ShowCustomCursor = (Library.IsMobile == false and true or false)






function Unload()



	Library.ScreenGui.Enabled = false

	for i,Toggle in pairs(Toggles) do
		Toggle:SetValue(false)
	end


	CharacterAddedConnection:Disconnect()
	MainConnection:Disconnect()
	InfiniteJumpConnection:Disconnect()


	

	fly.flyBody:Destroy()
	fly.flyGyro:Destroy()



	Humanoid.PlatformStand = false
	
	if AimbotCircle then
		AimbotCircle:Remove()
	end


	Library:Unload()
	ESPLibrary:Unload()
	Library = nil

	getgenv().AbysallHubLoaded = false
	getgenv().Library = nil


	Player.Character:WaitForChild("Humanoid",9e9).WalkSpeed = 16

	task.wait()

if Character:FindFirstChild("Torso") then
	Character.Torso.CanCollide = true
else
	Character.UpperTorso.CanCollide = true
	end



end



Library:SetWatermarkVisibility(false)








MenuSettings:AddLabel('Toggle Keybind'):AddKeyPicker('MenuKeybind', { Default = 'RightControl', NoUI = true, Text = 'GUI Toggle keybind' })
MenuSettings:AddDivider()
MenuSettings:AddDropdown("DPIDropdown", {
	Values = { "50%", "75%", "100%", "125%", "150%", "175%", "200%" },
	Default = "100%",

	Text = "DPI Scale",

	Callback = function(Value)
		Value = Value:gsub("%%", "")
		local DPI = tonumber(Value)

		Library:SetDPIScale(DPI)
	end,
})
MenuSettings:AddButton({
	Text = "Copy Discord Invite",
	Tooltip = 'Copies the discord server link to your clipboard.',
	DoubleClick = false,
	Disabled = not toclipboard,
	DisabledTooltip = "Your executor doesn't support this feature.",
	Func = function()
		toclipboard(AbysallHubSettings.DiscordInvite)
	end,
})
MenuSettings:AddButton({
	Text = "Unload GUI",
	Tooltip = "Completely unloads the GUI, disabling everything and making the game like it was before execution.",
	DoubleClick = false,
	Func = function()
		Unload()
	end,
})






Library.ToggleKeybind = Options.MenuKeybind

Options.MenuKeybind:OnChanged(function(Value)
	Library.ToggleKeybind = Options.MenuKeybind
end)


SaveManager:SetLibrary(Library)
ThemeManager:SetLibrary(Library)
ThemeManager:SetFolder(ScriptName)
SaveManager:SetFolder(ScriptName .. "/Universal")

SaveManager:IgnoreThemeSettings()



ThemeManager:ApplyToTab(Tabs.UISettings)


SaveManager:BuildConfigSection(Tabs.UISettings)

SaveManager:LoadAutoloadConfig()


Library:Notify("Successfully loaded in " .. math.floor(tonumber(tick() - LoadingTime)*1000)/1000 .. " seconds.", 8)
Sound()
