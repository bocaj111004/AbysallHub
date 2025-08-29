local ExecutorSupport = {
	["fireproximityprompt"] = false,
	["require"] = false,
	["hookmetamethod"] = true,
	["isnetworkowner"] = false,
	["newcclosure"] = false,
	["firetouchinterest"] = false,
	["replicatesignal"] = false,
	["getnamecallmethod"] = false,
	["hookfunction"] = false,
	["getrawmetatable"] = false,
	["setreadonly"] = false

}

local Player = game.Players.LocalPlayer
local Character = Player.Character
local y,n = pcall(function()
	require(Player:FindFirstChild("PlayerModule", true))
end)

if y == true then
	ExecutorSupport["require"] = true
end

local NewPart = Instance.new("Part")
NewPart.Transparency = 1
NewPart.Size = Vector3.new(100,100,100)
NewPart.Position = Vector3.new(0,2500,0)
NewPart.Anchored = false
NewPart.Parent = workspace
local NewPrompt = Instance.new("ProximityPrompt")
NewPrompt.Parent = NewPart
NewPrompt.Enabled = false
NewPrompt.MaxActivationDistance = 999999
NewPrompt.RequiresLineOfSight = false

if firetouchinterest then
	firetouchinterest(NewPart, Character:FindFirstChild("HumanoidRootPart"), 1)
	task.wait(0.05)
	firetouchinterest(NewPart, Character:FindFirstChild("HumanoidRootPart"), 0)
end

NewPrompt.Triggered:Connect(function()
	ExecutorSupport["fireproximityprompt"] = true

end)

NewPart.Touched:Connect(function()
	ExecutorSupport["firetouchinterest"] = true
end)

function CheckHookMetaMethod()
	if hookmetamethod then
		local object = setmetatable({}, { __index = newcclosure(function() return false end), __metatable = "Locked!" })
		local ref = hookmetamethod(object, "__index", function() return true end)
		if object.test == false then ExecutorSupport["hookmetamethod"] = false return end
		if ref() == true then ExecutorSupport["hookmetamethod"] = false return end

	end

end

function CheckNewCClosure()
	if newcclosure then

		local function test()
			return true
		end

		local testC = newcclosure(test)
		if test() ~= testC() then return end
		if test == testC then return end
		if not iscclosure(testC) then return end
		ExecutorSupport["newcclosure"] = true
	end
end

function CheckGetNameCallMethod()
	if not ExecutorSupport["hookmetamethod"] or not getnamecallmethod then
		return
	end
	local method
	local ref
	ref = hookmetamethod(game, "__namecall", function(...)
		if not method then
			method = getnamecallmethod()
		end
		return ref(...)
	end)
	game:GetService("Lighting")
	if method == "GetService" then
		ExecutorSupport["getnamecallmethod"] = true
	end

end

function CheckGetRawMetaTable()
	if getrawmetatable then
		local metatable = { __metatable = "Locked!" }
		local object = setmetatable({}, metatable)
		if getrawmetatable(object) == metatable then
			ExecutorSupport["getrawmetatable"] = true
		end

	end

end

function CheckSetReadOnly()
	if setreadonly then
		local object = { success = false }
		table.freeze(object)
		setreadonly(object, false)
		object.success = true
		if object.success then
			ExecutorSupport["setreadonly"] = true
		end
	end
end


CheckHookMetaMethod()
CheckNewCClosure()
CheckGetNameCallMethod()
CheckGetRawMetaTable()
CheckSetReadOnly()

if isnetworkowner then
	if isnetworkowner(workspace:FindFirstChild("Root", true)) then
		ExecutorSupport["isnetworkowner"] = false
	end
	if isnetworkowner(Character:FindFirstChild("HumanoidRootPart")) == false then
		ExecutorSupport["isnetworkowner"] = false
	end

	if isnetworkowner(Character:FindFirstChild("HumanoidRootPart")) == true then
		ExecutorSupport["isnetworkowner"] = true
	end

end

local ClickDetector = Instance.new("ClickDetector")
ClickDetector.Parent = NewPart

if replicatesignal then
	local y,n = pcall(function()
		replicatesignal(ClickDetector.MouseActionReplicated, Player, 0)
	end)
	if y == true then
		ExecutorSupport["replicatesignal"] = true
	end
end

local function TestFunction()
	return "not hooked"
end

local function TestHook()
	return "hooked"
end

if hookfunction then
	hookfunction(TestFunction, TestHook)
	if TestFunction() == "hooked" then
		ExecutorSupport["hookfunction"] = true
	end

end












if fireproximityprompt then
	fireproximityprompt(NewPrompt)
end












getgenv().ExecutorSupport = ExecutorSupport
