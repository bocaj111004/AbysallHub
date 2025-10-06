

local ConsoleMessage = [[

  /$$$$$$  /$$$$$$$  /$$     /$$ /$$$$$$   /$$$$$$  /$$       /$$      
 /$$__  $$| $$__  $$|  $$   /$$//$$__  $$ /$$__  $$| $$      | $$      
| $$  \ $$| $$  \ $$ \  $$ /$$/| $$  \__/| $$  \ $$| $$      | $$      
| $$$$$$$$| $$$$$$$   \  $$$$/ |  $$$$$$ | $$$$$$$$| $$      | $$      
| $$__  $$| $$__  $$   \  $$/   \____  $$| $$__  $$| $$      | $$      
| $$  | $$| $$  \ $$    | $$    /$$  \ $$| $$  | $$| $$      | $$      
| $$  | $$| $$$$$$$/    | $$   |  $$$$$$/| $$  | $$| $$$$$$$$| $$$$$$$$
|__/  |__/|_______/     |__/    \______/ |__/  |__/|________/|________/
                                                                       
[✅] - Function is working.
[⚠️] - Function is defined, but might be faulty/faked.
[⛔] - Function does not work.

Starting Executor Test...   

]]


local ExecutorSupport = {
	["getgenv"] = false,
	["identifyexecutor"] = false,
	["writefile"] = false,
	["isfile"] = false,
	["readfile"] = false,
	["listfiles"] = false,
	["delfile"] = false,
	["appendfile"] = false,
	["makefolder"] = false,
	["delfolder"] = false,
	["fireproximityprompt"] = false,
	["require"] = false,
	["hookmetamethod"] = false,
	["isnetworkowner"] = false,
	["cloneref"] = false,
	["gethui"] = false,
	["newcclosure"] = false,
	["firetouchinterest"] = false,
	["replicatesignal"] = false,
	["getnamecallmethod"] = false,
	["hookfunction"] = false,
	["getrawmetatable"] = false,
	["setreadonly"] = false,
	["toclipboard"] = false,
	["Drawing"] = false,
	["queue_on_teleport"] = false,
	["firesignal"] = false,
}

if getgenv then
	if getgenv() ~= nil and getgenv().getgenv then
		ExecutorSupport["getgenv"] = true
	end
end

if identifyexecutor then
	if identifyexecutor() ~= nil and typeof(identifyexecutor()) == "string" then
		ExecutorSupport["identifyexecutor"] = true
	end
end

if getgc  then
	local gctable = getgc(true)

	for i,v in pairs(getgc(true)) do
		if type(v) == 'table' then
			ExecutorSupport["require"] = true
			break
		end
	end
end


if toclipboard then
	ExecutorSupport["toclipboard"] = true
end



local Player = game.Players.LocalPlayer
local NewPart = Instance.new("Part")
NewPart.Transparency = 1
NewPart.Size = Vector3.new(100,100,100)
NewPart.Position = Vector3.new(0,2500,0)
NewPart.Anchored = false
NewPart.Parent = workspace
local NewPart2 = Instance.new("Part")
NewPart2.Transparency = 1
NewPart2.Size = Vector3.new(100,100,100)
NewPart2.Position = Vector3.new(0,2500,0)
NewPart2.Anchored = false
NewPart2.Parent = workspace
local NewPrompt = Instance.new("ProximityPrompt")
NewPrompt.Parent = NewPart
NewPrompt.Enabled = false
NewPrompt.MaxActivationDistance = 999999
NewPrompt.RequiresLineOfSight = false
local TestEvent = Instance.new("RemoteEvent", workspace)


local ClickDetector = Instance.new("ClickDetector")
ClickDetector.Parent = NewPart
ClickDetector.MouseClick:Connect(function()
	ExecutorSupport["fireclickdetector"] = true
end)

NewPart.Touched:Connect(function()
	ExecutorSupport["firetouchinterest"] = true
end)


NewPrompt.Triggered:Connect(function()
	ExecutorSupport["fireproximityprompt"] = true
end)

TestEvent.OnClientEvent:Connect(function()
	ExecutorSupport["firesignal"] = true
end)


function CheckDrawing()
	if Drawing and Drawing.new then
		local Success, Error = pcall(function()
			local t = Drawing.new("Triangle")
		end)

		if Success then
			ExecutorSupport["Drawing"] = true
		end
	end
end

function CheckNewCClosure()
	if newcclosure then

		local function testfunc()
			return false
		end

		local testC = newcclosure(testfunc)
		if testfunc() ~= testC() then return end
		if test == testC then return end
		if not iscclosure(testC) then return end
		ExecutorSupport["newcclosure"] = true
	end
end

function CheckHookMetaMethod()
	if hookmetamethod and ExecutorSupport["newcclosure"] then
		local object = setmetatable({}, { __index = newcclosure(function() return false end), __metatable = "ABYSALL_METATABLE_TEST" })
		local ref
		local Success, Error = pcall(function()
			ref = hookmetamethod(object, "__index", function() return true end)
		end)
		if not Success then ExecutorSupport["hookmetamethod"] = false return end
		if object.test == false then ExecutorSupport["hookmetamethod"] = false hookmetamethod(object, "__index", ref) return end
		if ref() == true then ExecutorSupport["hookmetamethod"] = false hookmetamethod(object, "__index", ref) return end
		if object.test == true then
			ExecutorSupport["hookmetamethod"] = true
		end
		hookmetamethod(object, "__index", ref)

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
		local Success, Error = pcall(function()
			local metatable = { __metatable = "ABYSALL_METATABLE_TEST" }
			local object = setmetatable({}, metatable)
		end)
		if Success and getrawmetatable(object) == metatable then
			ExecutorSupport["getrawmetatable"] = true
		end

	end

end

function CheckSetReadOnly()
	if setreadonly then
		local object = { success = false }
		table.freeze(object)
		setreadonly(object, false)

		local Success, Error = pcall(function()
			object.success = true
		end)
		if Success then
			ExecutorSupport["setreadonly"] = true
		end

	end
end

function CheckQueueTeleport()

	local TestCode = [[
			warn("test")
			]]
	if queue_on_teleport then
		local Success, Error = pcall(function()
			queue_on_teleport(TestCode)
		end)
		if Success then
			ExecutorSupport["queue_on_teleport"] = true
		end

	end

end




if isnetworkowner then

	if isnetworkowner(Instance.new("Part", workspace)) == true then
		ExecutorSupport["isnetworkowner"] = true
	end

	if isnetworkowner(Instance.new("Part")) == true then
		ExecutorSupport["isnetworkowner"] = false
	end


	if isnetworkowner(NewPart) == false then
		ExecutorSupport["isnetworkowner"] = false
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
	local Success, Error = pcall(function()
		hookfunction(TestFunction, TestHook)
	end)

	if Success and TestFunction() == "hooked" then
		ExecutorSupport["hookfunction"] = true
	end

end

if cloneref then
	local Clone
	local Success, Error = pcall(function()
		Clone = cloneref(workspace)
	end)

	if Success and Clone ~= workspace then
		ExecutorSupport["cloneref"] = true
	end
end

if gethui then
	if gethui() ~= nil and typeof(gethui()) == "Instance" and gethui() ~= game.CoreGui then
		ExecutorSupport["gethui"] = true
	end
end












if fireproximityprompt then
	local Success, Error = pcall(function()
		fireproximityprompt(NewPrompt)
	end)
end

if fireclickdetector then
	local Success, Error = pcall(function()
		fireclickdetector(ClickDetector)
	end)
end

if firesignal then
	local Success, Error = pcall(function()
		firesignal(TestEvent.OnClientEvent)
	end)
end





if firetouchinterest then
	local Success, Error = pcall(function()
		task.wait(0.05)
		firetouchinterest(NewPart, NewPart2, 1)
		task.wait(0.05)
		firetouchinterest(NewPart, NewPart2, 0)
	end)
end

if writefile then
	local Success, Error = pcall(function()
		writefile("ABYSALL_TEST_FILE", "ABYSALL_FILE_CONTENTS")
	end)
	if Success then
		ExecutorSupport["writefile"] = true
	end

	if isfile then
		local Success, Error = pcall(function()
			isfile("ABYSALL_TEST_FILE")
		end)
		if Success and isfile("ABYSALL_TEST_FILE") then
			ExecutorSupport["isfile"] = true
		end
	end
end

if readfile then
	local Success, Error = pcall(function()
		readfile("ABYSALL_TEST_FILE")
	end)

	if Success and readfile("ABYSALL_TEST_FILE") == "ABYSALL_FILE_CONTENTS" then
		ExecutorSupport["readfile"] = true
	end
end

if listfiles then
	local Success, Error = pcall(function()
		listfiles("")
	end)

	if Success and typeof(listfiles("")) == "table" and #listfiles("") > 0 then
		ExecutorSupport["listfiles"] = true
	end
end

if makefolder then
	local Success1, Error1 = pcall(function()
		makefolder("ABYSALL_TEST_FOLDER")
	end)

	if Success1 and ExecutorSupport["writefile"] then
		writefile("ABYSALL_TEST_FOLDER/ABYSALL_TEST_FILE", "ABYSALL_FILE_CONTENTS")
	end


	if Success1 then
		local Success2, Error2 = pcall(function()
			readfile("ABYSALL_TEST_FOLDER/ABYSALL_TEST_FILE")
		end)

		if Success1 and Success2 then
			ExecutorSupport["makefolder"] = true
		end
	end
end

if delfolder then
	local Success1, Error1 = pcall(function()
		delfolder("ABYSALL_TEST_FOLDER")
	end)

	if Success1 then


		if Success1 then
			ExecutorSupport["delfolder"] = true
		end
	end
end

if appendfile and ExecutorSupport["readfile"] then
	local Success, Error = pcall(function()
		appendfile("ABYSALL_TEST_FILE", "_2")
	end)

	if Success and readfile("ABYSALL_TEST_FILE") == "ABYSALL_FILE_CONTENTS_2" then
		ExecutorSupport["appendfile"] = true
	end
end


if delfile and ExecutorSupport["readfile"] then
	local Success1, Error1 = pcall(function()
		delfile("ABYSALL_TEST_FILE")
	end)

	if Success1 then
		local Success2, Error2 = pcall(function()
			readfile("ABYSALL_TEST_FILE")
		end)

		if Success1 and not Success2 then
			ExecutorSupport["delfile"] = true
		end
	end
end




CheckNewCClosure()

CheckGetRawMetaTable()
CheckSetReadOnly()
CheckDrawing()
CheckQueueTeleport()
CheckHookMetaMethod()
CheckGetNameCallMethod()

task.wait(0.25)


if ExecutorSupport["getgenv"] then
getgenv().ExecutorSupport = ExecutorSupport
end

NewPart:Destroy()
NewPart2:Destroy()
TestEvent:Destroy()

local Successes = 0
local TotalTests = 0

local ExistingFunctions = {
	["getgenv"] = getgenv,
	["identifyexecutor"] = identifyexecutor,
	["writefile"] = writefile,
	["isfile"] = isfile,
	["readfile"] = readfile,
	["listfiles"] = listfiles,
	["delfile"] = delfile,
	["appendfile"] = appendfile,
	["makefolder"] = makefolder,
	["delfolder"] = delfolder,
	["fireproximityprompt"] = fireproximityprompt,
	["require"] = require,
	["hookmetamethod"] = hookmetamethod,
	["isnetworkowner"] = isnetworkowner,
	["cloneref"] = cloneref,
	["gethui"] = gethui,
	["newcclosure"] = newcclosure,
	["firetouchinterest"] = firetouchinterest,
	["replicatesignal"] = replicatesignal,
	["getnamecallmethod"] = getnamecallmethod,
	["hookfunction"] = hookfunction,
	["getrawmetatable"] = getrawmetatable,
	["setreadonly"] = setreadonly,
	["toclipboard"] = toclipboard,
	["Drawing"] = Drawing,
	["queue_on_teleport"] = queue_on_teleport,
	["firesignal"] = firesignal,
}

for Name, Result in pairs(ExecutorSupport) do
	TotalTests = TotalTests + 1
	if Result == true then
		ConsoleMessage = ConsoleMessage .. "[✅] - " .. Name .. "\n"
	else
		if ExistingFunctions[Name] ~= nil then
			ConsoleMessage = ConsoleMessage .. "[⚠️] - " .. Name .. "\n"

		else
			ConsoleMessage = ConsoleMessage .. "[⛔] - " .. Name .. "\n"
		end
	end
	if Result == true then
		Successes = Successes + 1
	end
end

local FinalScore = math.round((Successes / TotalTests) * 100)
ConsoleMessage = ConsoleMessage .. "\nFinal Score: " .. FinalScore .. "%"
print(ConsoleMessage)
