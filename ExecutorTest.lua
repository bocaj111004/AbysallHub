local Time = tick();
local ConsoleMessage = [[

  /$$$$$$  /$$$$$$$  /$$     /$$ /$$$$$$   /$$$$$$  /$$       /$$      
 /$$__  $$| $$__  $$|  $$   /$$//$$__  $$ /$$__  $$| $$      | $$      
| $$  \ $$| $$  \ $$ \  $$ /$$/| $$  \__/| $$  \ $$| $$      | $$      
| $$$$$$$$| $$$$$$$   \  $$$$/ |  $$$$$$ | $$$$$$$$| $$      | $$      
| $$__  $$| $$__  $$   \  $$/   \____  $$| $$__  $$| $$      | $$      
| $$  | $$| $$  \ $$    | $$    /$$  \ $$| $$  | $$| $$      | $$      
| $$  | $$| $$$$$$$/    | $$   |  $$$$$$/| $$  | $$| $$$$$$$$| $$$$$$$$
|__/  |__/|_______/     |__/    \______/ |__/  |__/|________/|________/
                                                                       

Starting Executor Test...   

]];
local ExecutorSupport = {getgenv=false,getsenv=false,getrenv=false,identifyexecutor=false,writefile=false,isfile=false,readfile=false,loadfile=false,listfiles=false,delfile=false,appendfile=false,makefolder=false,isfolder=false,delfolder=false,fireproximityprompt=false,require=false,hookmetamethod=false,isnetworkowner=false,request=false,cloneref=false,gethui=false,newcclosure=false,firetouchinterest=false,replicatesignal=false,getnamecallmethod=false,getrunningscripts=false,getloadedmodules=false,hookfunction=false,isfunctionhooked=false,restorefunction=false,isexecutorclosure=false,getrawmetatable=false,setrawmetatable=false,setreadonly=false,isreadonly=false,toclipboard=false,["Drawing.new"]=false,["Drawing.Fonts"]=false,queue_on_teleport=false,firesignal=false,getconnections=false,getscripthash=false,getscriptbytecode=false,gethiddenproperty=false,sethiddenproperty=false,getgc=false,loadstring=false,fireclickdetector=false,getinstances=false,getnilinstances=false,setfpscap=false,setthreadidentity=false,getthreadidentity=false};
local SkippedFunctions = {};
local Player = game:GetService("Players").LocalPlayer;
if getgenv then
	local Test1 = false;
	local Test2 = false;
	local Success, Error = pcall(function()
		if ((typeof(getgenv()) == "table") and getgenv().getgenv) then
			getgenv().ABYSALL_GENV_TEST = "ABYSALL_GENV_TEST_VALUE";
			if (getgenv().ABYSALL_GENV_TEST == "ABYSALL_GENV_TEST_VALUE") then
				Test1 = true;
			end
			
			if (ABYSALL_GENV_TEST and ABYSALL_GENV_TEST  == "ABYSALL_GENV_TEST_VALUE") then
				Test2 = true;
			end
			getgenv().ABYSALL_GENV_TEST = nil;
		end
	end);
	if (Success and (Test1 == true) and (Test2 == true)) then
		ExecutorSupport['getgenv'] = true;
	end
end
if getsenv then
	local Test = false
	local Success, Error = pcall(function()
		if typeof(getsenv(Player.PlayerScripts.RbxCharacterSounds).error) == "function" then
			Test = true
		end
	end)
	if Success and Test == true then
		ExecutorSupport["getsenv"] = true
	end
end
if getrenv then
	local Test = false
	local Success, Error = pcall(function()
		if getrenv().error then
			Test = true
		end
	end)
	if Success and Test == true then
		ExecutorSupport["getrenv"] = true
	end
end
if identifyexecutor then
	if ((identifyexecutor() ~= nil) and (typeof(identifyexecutor()) == "string")) then
		ExecutorSupport['identifyexecutor'] = true;
	end
end
if toclipboard then
	if (typeof(toclipboard) == "function") then
		ExecutorSupport['toclipboard'] = true;
	end
end
local NewPart = Instance.new("Part");
NewPart.Transparency = 1;
NewPart.Size = Vector3.new(100, 100, 100);
NewPart.Position = Vector3.new(0, 2500, 0);
NewPart.Anchored = false;
NewPart.Parent = workspace;
local NewPart2 = Instance.new("Part");
NewPart2.Transparency = 1;
NewPart2.Size = Vector3.new(100, 100, 100);
NewPart2.Position = Vector3.new(0, 2500, 0);
NewPart2.Anchored = false;
NewPart2.Parent = workspace;
local NewPart3 = Instance.new("Part");
NewPart3.Transparency = 1;
NewPart3.Size = Vector3.new(100, 100, 100);
NewPart3.Position = Vector3.new(0, 2500, 0);
NewPart3.Anchored = true;
NewPart3.Parent = workspace;
local NewPrompt = Instance.new("ProximityPrompt");
NewPrompt.Parent = NewPart;
NewPrompt.Enabled = true;
NewPrompt.MaxActivationDistance = 999999;
NewPrompt.RequiresLineOfSight = false;
local TestEvent = Instance.new("RemoteEvent", workspace);
local ClickDetector = Instance.new("ClickDetector");
ClickDetector.Parent = NewPart3;
ClickDetector.MaxActivationDistance = math.huge;
ClickDetector.MouseClick:Connect(function()
	ExecutorSupport['fireclickdetector'] = true;
end);
NewPart.Touched:Connect(function()
	ExecutorSupport['firetouchinterest'] = true;
end);
NewPrompt.Triggered:Connect(function()
	ExecutorSupport['fireproximityprompt'] = true;
end);
TestEvent.OnClientEvent:Connect(function()
	ExecutorSupport['firesignal'] = true;
end);
function CheckDrawing()
	local DrawingTest = false;
	if (Drawing and Drawing.new) then
		local Success, Error = pcall(function()
			local t = Drawing.new("Triangle");
			if (typeof(t.Visible) == "boolean") then
				DrawingTest = true;
			end
			t:Destroy();
		end);
		if (Success and DrawingTest) then
			ExecutorSupport["Drawing.new"] = true;
		end
	end
	local FontTest1 = false;
	local FontTest2 = false;
	local FontTest3 = false;
	local FontTest4 = false;
	if (Drawing and Drawing.Fonts) then
		local Success, Error = pcall(function()
			if (Drawing.Fonts.UI == 0) then
				FontTest1 = true;
			end
			if (Drawing.Fonts.System == 1) then
				FontTest2 = true;
			end
			if (Drawing.Fonts.Plex == 2) then
				FontTest3 = true;
			end
			if (Drawing.Fonts.Monospace == 3) then
				FontTest4 = true;
			end
		end);
		if (Success and (FontTest1 == true) and (FontTest2 == true) and (FontTest3 == true) and (FontTest4 == true)) then
			ExecutorSupport["Drawing.Fonts"] = true;
		end
	end
end
function CheckNewCClosure()
	if newcclosure then
		local function testfunc()
			return false;
		end
		local testC = newcclosure(testfunc);
		if (testfunc() ~= testC()) then
			return;
		end
		if (test == testC) then
			return;
		end
		if not iscclosure(testC) then
			return;
		end
		ExecutorSupport['newcclosure'] = true;
	end
end
function CheckHookMetaMethod()
	if (hookmetamethod and ExecutorSupport['newcclosure']) then
		local object = setmetatable({}, {__index=newcclosure(function()
			return false;
		end),__metatable="ABYSALL_METATABLE_TEST"});
		local ref;
		local Success, Error = pcall(function()
			ref = hookmetamethod(object, "__index", function()
				return true;
			end);
		end);
		if not Success then
			ExecutorSupport['hookmetamethod'] = false;
			return;
		end
		if (object.test == false) then
			ExecutorSupport['hookmetamethod'] = false;
			hookmetamethod(object, "__index", ref);
			return;
		end
		if (ref() == true) then
			ExecutorSupport['hookmetamethod'] = false;
			hookmetamethod(object, "__index", ref);
			return;
		end
		if (object.test == true) then
			ExecutorSupport['hookmetamethod'] = true;
		end
		hookmetamethod(object, "__index", ref);
	end
end
function CheckGetGC()
	if getgc then
		local Test1 = false;
		local Test2 = false;
		local function DummyFunction()
		end
		local DummyTable = {};
		local Success, Error = pcall(function()
			for i, v in pairs(getgc(true)) do
				if ((v == DummyTable) or (v == DummyFunction)) then
					Test1 = true;
				end
			end
			for i, v in pairs(getgc(false)) do
				if (v == DummyFunction) then
					Test2 = true;
				end
			end
		end);
		if (Success and (Test1 == true) and (Test2 == true)) then
			ExecutorSupport['getgc'] = true;
		end
	end
end
function CheckRequire()
	local Module = Player.PlayerScripts.PlayerModule;
	local Test = false;
	local Success, Error = pcall(function()
		local LoadedModule = require(Module);
		local OldFunction = LoadedModule.GetControls;
		LoadedModule.GetControls = function()
			return "ABYSALL_REQUIRE_TEST";
		end;
		if (LoadedModule:GetControls() == "ABYSALL_REQUIRE_TEST") then
			Test = true;
			LoadedModule.GetControls = OldFunction;
		end
	end);
	if ExecutorSupport['getthreadidentity'] then
		if (Success and (Test == true) and (getthreadidentity() > 3)) then
			ExecutorSupport['require'] = true;
		end
	end
end
function CheckGetNameCallMethod()
	if (not ExecutorSupport['hookmetamethod'] or not getnamecallmethod) then
		return;
	end
	local method;
	local ref;
	ref = hookmetamethod(game, "__namecall", function(...)
		if not method then
			method = getnamecallmethod();
		end
		return ref(...);
	end);
	game:GetService("Lighting");
	if (method == "GetService") then
		ExecutorSupport['getnamecallmethod'] = true;
	end
end
function CheckGetRawMetaTable()
	if getrawmetatable then
		local metatable = {__metatable="ABYSALL_METATABLE_TEST"};
		local object = setmetatable({}, metatable);
		local Success, Error = pcall(function()
			getrawmetatable(object);
		end);
		if (Success and (getrawmetatable(object) == metatable)) then
			ExecutorSupport['getrawmetatable'] = true;
		end
	end
end
function CheckSetRawMetaTable()
	if setrawmetatable and ExecutorSupport["getrawmetatable"] then
		local metatable1 = {__metatable="ABYSALL_METATABLE_TEST_1"};
		local metatable2 = {__metatable="ABYSALL_METATABLE_TEST_2"};
		local object = setmetatable({}, metatable1);
		local Success, Error = pcall(function()
			setrawmetatable(object, metatable2);
		end);
		if (Success and (getrawmetatable(object) == metatable2)) then
			ExecutorSupport['setrawmetatable'] = true;
		end
	end
end
function CheckSetReadOnly()
	if setreadonly then
		local object = {success=false};
		table.freeze(object);
		setreadonly(object, false);
		local Success, Error = pcall(function()
			object.success = true;
		end);
		if Success then
			ExecutorSupport['setreadonly'] = true;
		end
	end
end
function CheckIsReadOnly()
	if isreadonly then
		local Test1 = false;
		local Test2 = false;
		local object = {success=false};
		local Success1, Error1 = pcall(function()
			if (isreadonly(object) == false) then
				Test1 = true;
			end
		end);
		table.freeze(object);
		local Success2, Error2 = pcall(function()
			if (isreadonly(object) == true) then
				Test2 = true;
			end
		end);
		if (Success1 and Success2 and (Test1 == true) and (Test2 == true)) then
			ExecutorSupport['isreadonly'] = true;
		end
	end
end
function CheckQueueTeleport()
	local TestCode = [[
			warn("test")
			]];
	if queue_on_teleport then
		local Success, Error = pcall(function()
			queue_on_teleport(TestCode);
		end);
		if Success then
			ExecutorSupport['queue_on_teleport'] = true;
		end
	end
end
if getinstances then
	local FirstInstance;
	local Success, Error = pcall(function()
		FirstInstance = getinstances()[1];
	end);
	if (Success and FirstInstance and (typeof(FirstInstance) == "Instance")) then
		ExecutorSupport['getinstances'] = true;
	end
end
if getnilinstances then
	local FirstInstance;
	local Success, Error = pcall(function()
		FirstInstance = getnilinstances()[1];
	end);
	if (Success and FirstInstance and (typeof(FirstInstance) == "Instance") and (FirstInstance.Parent == nil)) then
		ExecutorSupport['getnilinstances'] = true;
	end
end
if getscripthash then
	local Test = false
	local Success, Error = pcall(function()
		local TestScript = Player.PlayerScripts.PlayerScriptsLoader
		local Hash = getscripthash(TestScript)
		if typeof(Hash) == "string" then
			Test = true
		end
	end)
	if Success and Test == true then
		ExecutorSupport["getscripthash"] = true
	end
end
if getscriptbytecode then
	local Test = false
	local Success, Error = pcall(function()
		local TestScript = Player.PlayerScripts.PlayerScriptsLoader
		local Bytecode = getscriptbytecode(TestScript)
		if typeof(Bytecode) == "string" then
			Test = true
		end
	end)
	if Success and Test == true then
		ExecutorSupport["getscriptbytecode"] = true
	end
end
if getrunningscripts then
	local Test = false
	local Success, Error = pcall(function()
		local RunningScripts = getrunningscripts()
		local TestScript = RunningScripts[1]
		if typeof(TestScript) == "Instance" and string.find(TestScript.ClassName, "Script") then
			Test = true
		end
	end)
	if Success and Test == true then
		ExecutorSupport["getrunningscripts"] = true
	end
end
if getloadedmodules then
	local Test = false
	local Success, Error = pcall(function()
		local LoadedModules = getloadedmodules()
		local TestModule = LoadedModules[1]
		if typeof(TestModule) == "Instance" and TestModule.ClassName == "ModuleScript" then
			Test = true
		end
	end)
	if Success and Test == true then
		ExecutorSupport["getloadedmodules"] = true
	end
end
	if isnetworkowner then
	local NetworkValue1 = false;
	local NetworkValue2 = false;
	local Success1, Error1 = pcall(function()
		NetworkValue1 = isnetworkowner(NewPart);
	end);
	local Success2, Error2 = pcall(function()
		NetworkValue2 = isnetworkowner(Instance.new("Model"));
	end);
	if (Success1 and (NetworkValue1 == true) and (NetworkValue2 == false)) then
		local Test1 = false;
		local Test2 = false;
		local Test3 = false;
		local Success3, Error3 = pcall(function()
			if (isnetworkowner(Instance.new("Part", workspace)) == true) then
				Test1 = true;
			end
			if (isnetworkowner(Instance.new("Part")) ~= true) then
				Test2 = true;
			end
			if (isnetworkowner(NewPart) == true) then
				Test3 = true;
			end
		end);
		if (Success3 and (Test1 == true) and (Test2 == true) and (Test3 == true)) then
			ExecutorSupport['isnetworkowner'] = true;
		end
	end
end
if request then
	local Test = false
	local Success, Error = pcall(function()
		local response = request({
			Url = "https://raw.githubusercontent.com/bocaj111004/AbysallHub/refs/heads/main/ExecutorTest.lua",
			Method = "GET",
		})
		if type(response) == "table" then
		if type(response.Body) == "string" then
		if response.StatusCode == 200 then
			Test = true
		end
		end
		end
	end)
	if Success and Test == true then
		ExecutorSupport["request"] = true
	end
end
if replicatesignal then
	local Success1, Error1 = pcall(function()
		replicatesignal(Instance.new("Frame").MouseWheelForward, 120, 120);
	end);
	local Success2, Error2 = pcall(function()
		replicatesignal(Instance.new("Frame"));
	end);
	if (Success1 and not Success2) then
		ExecutorSupport['replicatesignal'] = true;
	end
end
local function TestFunction()
	return "not hooked";
end
local function TestHook()
	return "hooked";
end
if hookfunction then
	local Success, Error = pcall(function()
		hookfunction(TestFunction, TestHook);
	end);
	if (Success and (TestFunction() == "hooked")) then
		ExecutorSupport['hookfunction'] = true;
	end
end
if isfunctionhooked then
	local Test1 = false
	local Test2 = false
	local Success, Error = pcall(function()
		if isfunctionhooked(TestFunction) then
			Test1 = true
		end
		if not isfunctionhooked(Player.Kick) then
			Test2 = true
		end
	end);
	if (Success and (TestFunction() == "hooked")) then
		ExecutorSupport['isfunctionhooked'] = true;
	end
end
if restorefunction and ExecutorSupport["hookfunction"] then
	local Success, Error = pcall(function()
		restorefunction(TestFunction);
	end);
	if (Success and (TestFunction() == "not hooked")) then
		ExecutorSupport['restorefunction'] = true;
	end
end
if isexecutorclosure then
	local Test1 = false
	local Test2 = false
	local Success, Error = pcall(function()
		local Testfunction = function() end
		if isexecutorclosure(TestFunction) then
			Test1 = true;
		end
		if not isexecutorclosure(Player.Kick) then
			Test2 = true;
		end
	end);
	if (Success and Test1 == true and Test2 == true) then
		ExecutorSupport['isexecutorclosure'] = true;
	end
end
if setfpscap then
	local function GetFPS()
		return math.floor(1 / game:GetService("RunService").RenderStepped:Wait());
	end
	local Success1, Error1 = pcall(function()
		setfpscap(10);
	end);
	task.wait(0.1)
	if (Success1 and (GetFPS() <= 15)) then
		ExecutorSupport['setfpscap'] = true;
		setfpscap(0);
	end
	if not ExecutorSupport['setfpscap'] then
		local Success2, Error2 = pcall(function()
			setfpscap(0);
		end);
	end
end
if getthreadidentity then
	local ThreadIdentity = 0;
	local Success, Error = pcall(function()
		ThreadIdentity = getthreadidentity();
	end);
	local Test = true;
	if ((getthreadidentity() > 2) and (game:GetService("CoreGui") == nil)) then
		Test = false;
	end
	if (getthreadidentity() >= 8) then
		local Success, Error = pcall(function()
			local OldID = Player.UserId;
			Player.UserId = 1;
			Player.UserId = OldID;
		end);
		if not Success then
			Test = false;
		end
	end
	if (Success and (typeof(ThreadIdentity) == "number") and (ThreadIdentity ~= 0) and (Test == true)) then
		ExecutorSupport['getthreadidentity'] = true;
	end
end
if (setthreadidentity and ExecutorSupport['getthreadidentity']) then
	local ThreadIdentity = getthreadidentity();
	local Success, Error = pcall(function()
		setthreadidentity(1);
	end);
	if (Success and (typeof(ThreadIdentity) == "number") and (getthreadidentity() == 1) and (ThreadIdentity ~= 1)) then
		ExecutorSupport['setthreadidentity'] = true;
	end
	if Success then
		setthreadidentity(ThreadIdentity);
	end
end
if clonefunction then
	local ClonedFunction;
	local TestFunction = function()
		return "ABYSALL_FUNCTION_TEST";
	end;
	local Success, Error = pcall(function()
		ClonedFunction = clonefunction(TestFunction);
	end);
	if (Success and (ClonedFunction() == "ABYSALL_FUNCTION_TEST") and (ClonedFunction ~= TestFunction)) then
		ExecutorSupport['clonefunction'] = true;
	end
end
if cloneref then
	local Clone;
	local Success, Error = pcall(function()
		Clone = cloneref(workspace);
	end);
	if (Success and (Clone ~= workspace)) then
		ExecutorSupport['cloneref'] = true;
	end
end
if gethui then
	if ((gethui() ~= nil) and (typeof(gethui()) == "Instance") and (gethui() ~= game:GetService("CoreGui")) and (gethui().Parent ~= nil)) then
		if (gethui():IsA("CoreGui") or ((game:GetService("CoreGui") ~= nil) and gethui():IsDescendantOf(game:GetService("CoreGui")))) then
			ExecutorSupport['gethui'] = true;
		end
	end
end
if loadstring then
	local OldName = workspace.Name;
	local Success, Error = pcall(function()
		loadstring([[workspace.Name = "ABYSALL_WORKSPACE_TEST"]])();
	end);
	if (Success and (workspace.Name == "ABYSALL_WORKSPACE_TEST")) then
		workspace.Name = OldName;
		ExecutorSupport['loadstring'] = true;
	end
end
if fireproximityprompt then
	local Success, Error = pcall(function()
		fireproximityprompt(NewPrompt);
	end);
end
if fireclickdetector then
	local Success, Error = pcall(function()
		fireclickdetector(ClickDetector);
	end);
end
if firesignal then
	local Success, Error = pcall(function()
		firesignal(TestEvent.OnClientEvent);
	end);
end
if getconnections then
	local Test1 = false
	local Test2 = false
	local Success, Error = pcall(function()
		local TestPart = Instance.new("Part")
		local TestConnection = TestPart.ChildAdded:Connect(function()
			Test2 = true
		end)
        local Connections = getconnections(TestPart.ChildAdded);
		if typeof(Connections) == "table" then
			Test1 = true
		end
		for i,Connection in pairs(Connections) do
			Connection:Fire()
		end
		TestConnection:Disconnect()
	end);
	if Success and Test1 == true and Test2 == true then
		ExecutorSupport["getconnections"] = true
	end
end
if gethiddenproperty then
	local Property;
	local Success, Error = pcall(function()
		Property = gethiddenproperty(NewPart, "NetworkIsSleeping");
	end);
	if (Success and (Property ~= nil)) then
		if (typeof(Property) == "boolean") and Property == false then
			ExecutorSupport['gethiddenproperty'] = true;
		end
	end
end
if sethiddenproperty and ExecutorSupport['gethiddenproperty'] then
	local OldProperty = gethiddenproperty(NewPart, "NetworkIsSleeping");
	local Success, Error = pcall(function()
		sethiddenproperty(NewPart, "NetworkIsSleeping", true);
	end);
	if (Success) then
		local Property = gethiddenproperty(NewPart, "NetworkIsSleeping");
		if ((typeof(Property) == "boolean") and (Property == true)) then
			ExecutorSupport['sethiddenproperty'] = true;
			sethiddenproperty(NewPart, "NetworkIsSleeping", OldProperty);
		end
	end
end
if firetouchinterest then
	local Success, Error = pcall(function()
		task.wait();
		firetouchinterest(NewPart, NewPart2, 1);
		task.wait();
		firetouchinterest(NewPart, NewPart2, 0);
	end);
end
if writefile then
	local Success, Error = pcall(function()
		writefile("ABYSALL_TEST_FILE", "ABYSALL_FILE_CONTENTS");
	end);
	if Success then
		ExecutorSupport['writefile'] = true;
	end
	if isfile then
		local Success, Error = pcall(function()
			isfile("ABYSALL_TEST_FILE");
		end);
		if (Success and isfile("ABYSALL_TEST_FILE")) then
			ExecutorSupport['isfile'] = true;
		end
	end
end
if readfile then
	local Success, Error = pcall(function()
		readfile("ABYSALL_TEST_FILE");
	end);
	if (Success and (readfile("ABYSALL_TEST_FILE") == "ABYSALL_FILE_CONTENTS")) then
		ExecutorSupport['readfile'] = true;
	end
end
if loadfile and ExecutorSupport["writefile"] then
	local Success, Error = pcall(function()
		writefile("ABYSALL_TEST_FILE_3", "game:GetService('CoreGui').Name = 'ABYSALL_LOADFILE_TEST'")
		local Chunk = loadfile("ABYSALL_TEST_FILE_3")
		Chunk()
	end);
	if (Success and (game:GetService("CoreGui").Name == "ABYSALL_LOADFILE_TEST")) then
		ExecutorSupport['loadfile'] = true;
		game:GetService("CoreGui").Name = "CoreGui"
	end
end
if listfiles then
	local Success, Error = pcall(function()
		listfiles("");
	end);
	if (Success and (typeof(listfiles("")) == "table") and (#listfiles("") > 0)) then
		ExecutorSupport['listfiles'] = true;
	end
end
if makefolder then
	local Success1, Error1 = pcall(function()
		makefolder("ABYSALL_TEST_FOLDER");
	end);
	if (Success1 and ExecutorSupport['writefile']) then
		writefile("ABYSALL_TEST_FOLDER/ABYSALL_TEST_FILE", "ABYSALL_FILE_CONTENTS");
	end
	if Success1 then
		local Success2, Error2 = pcall(function()
			readfile("ABYSALL_TEST_FOLDER/ABYSALL_TEST_FILE");
		end);
		if (Success1 and Success2) then
			ExecutorSupport['makefolder'] = true;
		end
	end
end
if isfolder then
	local FolderValue = false
	local Success1, Error1 = pcall(function()
		FolderValue = isfolder("ABYSALL_TEST_FOLDER");
	end);
	if Success1 then
		if isfolder("ABYSALL_TEST_FILE") == false then
			ExecutorSupport['isfolder'] = true;
		end
	end
end
if delfolder then
	local Success1, Error1 = pcall(function()
		delfolder("ABYSALL_TEST_FOLDER");
	end);
	if Success1 then
		if Success1 then
			ExecutorSupport['delfolder'] = true;
		end
	end
end
if (appendfile and ExecutorSupport['readfile']) then
	local Success, Error = pcall(function()
		appendfile("ABYSALL_TEST_FILE", "_2");
	end);
	if (Success and (readfile("ABYSALL_TEST_FILE") == "ABYSALL_FILE_CONTENTS_2")) then
		ExecutorSupport['appendfile'] = true;
	end
end
if (delfile and ExecutorSupport['readfile']) then
	local Success1, Error1 = pcall(function()
		delfile("ABYSALL_TEST_FILE");
	end);
	if Success1 then
		local Success2, Error2 = pcall(function()
			readfile("ABYSALL_TEST_FILE");
		end);
		if (Success1 and not Success2) then
			ExecutorSupport['delfile'] = true;
		end
	end
end
CheckNewCClosure();
CheckGetGC();
CheckGetRawMetaTable();
CheckSetRawMetaTable();
CheckSetReadOnly();
CheckIsReadOnly();
CheckDrawing();
CheckQueueTeleport();
CheckHookMetaMethod();
CheckGetNameCallMethod();
CheckRequire();
task.wait();
if ExecutorSupport['getgenv'] then
	getgenv().ExecutorSupport = ExecutorSupport;
end
NewPart:Destroy();
NewPart2:Destroy();
NewPart3:Destroy();
TestEvent:Destroy();
local Successes = 0;
local TotalTests = 0;
local ExistingFunctions = {getgenv=getgenv,getsenv=getsenv,getrenv=getrenv,identifyexecutor=identifyexecutor,writefile=writefile,isfile=isfile,readfile=readfile,loadfile=loadfile,listfiles=listfiles,delfile=delfile,appendfile=appendfile,makefolder=makefolder,isfolder=isfolder,delfolder=delfolder,fireproximityprompt=fireproximityprompt,require=require,hookmetamethod=hookmetamethod,isnetworkowner=isnetworkowner,request=request,cloneref=cloneref,gethui=gethui,newcclosure=newcclosure,firetouchinterest=firetouchinterest,replicatesignal=replicatesignal,getnamecallmethod=getnamecallmethod,getrunningscripts=getrunningscripts,getloadedmodules=getloadedmodules,hookfunction=hookfunction,isfunctionhooked=isfunctionhooked,restorefunction=restorefunction,isexecutorclosure=isexecutorclosure,getrawmetatable=getrawmetatable,setrawmetatable=setrawmetatable,setreadonly=setreadonly,isreadonly=isreadonly,toclipboard=toclipboard,["Drawing.new"]=(Drawing and Drawing.new),["Drawing.Fonts"]=(Drawing and Drawing.Fonts),queue_on_teleport=queue_on_teleport,firesignal=firesignal,getconnections=getconnections,getscripthash=getscripthash,getscriptbytecode=getscriptbytecode,gethiddenproperty=gethiddenproperty,sethiddenproperty=sethiddenproperty,getgc=getgc,loadstring=loadstring,fireclickdetector=fireclickdetector,getinstances=getinstances,getnilinstances=getnilinstances,setfpscap=setfpscap,getthreadidentity=getthreadidentity,setthreadidentity=setthreadidentity};
for Name, Result in pairs(ExecutorSupport) do
	TotalTests = TotalTests + 1;
	if (Result == true) then
		ConsoleMessage = ConsoleMessage .. "[✅] " .. Name .. "\n";
	elseif table.find(SkippedFunctions, Name) then
		ConsoleMessage = ConsoleMessage .. "[⏺️] " .. Name .. "\n";
	else
		ConsoleMessage = ConsoleMessage .. "[⛔] " .. Name .. "\n";
	end
	if (Result == true) then
		Successes = Successes + 1;
	end
end
ConsoleMessage = ConsoleMessage .. "\nExecutor: " .. ((ExecutorSupport['identifyexecutor'] and identifyexecutor()) or "nil [failed identifyexecutor]");
ConsoleMessage = ConsoleMessage .. "\nTests passed: " .. Successes .. "/" .. TotalTests
ConsoleMessage = ConsoleMessage .. "\nTime taken: " .. (math.floor(tonumber(tick() - Time) * 1000) / 1000) .. " seconds";
local FinalScore = math.round((Successes / TotalTests) * 100);
ConsoleMessage = ConsoleMessage .. "\nScore: " .. FinalScore .. "%";
print(ConsoleMessage);
