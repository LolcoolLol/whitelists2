loadstring(game:HttpGet("https://raw.githubusercontent.com/7GrandDadPGN/VapeV4ForRoblox/"..readfile("vape/commithash.txt").."/CustomModules/6872274481.lua", true))()--Dnut Private
repeat task.wait() until game:IsLoaded()
repeat task.wait() until shared.GuiLibrary
local GuiLibrary = shared.GuiLibrary
local ScriptSettings = {}
local UIS = game:GetService("UserInputService")
local GuiLibrary = shared.GuiLibrary
local playersService = game:GetService("Players")
local textService = game:GetService("TextService")
local lightingService = game:GetService("Lighting")
local textChatService = game:GetService("TextChatService")
local inputService = game:GetService("UserInputService")
local runService = game:GetService("RunService")
local tweenService = game:GetService("TweenService")
local collectionService = game:GetService("CollectionService")
local replicatedStorageService = game:GetService("ReplicatedStorage")
local tppos2
local lplr = game.Players.LocalPlayer
local function isVulnerable(plr)
	return plr.Humanoid.Health > 0 and not plr.Character.FindFirstChildWhichIsA(plr.Character, "ForceField")
end
local entityLibrary = shared.vapeentity
task.wait() --just cuz fluxus sucks.
local function AllNearPosition(distance, amount, sortfunction, prediction, bot)
	local returnedplayer = {}
	local currentamount = 0
	if entityLibrary.isAlive then
		local sortedentities = {}
		for i, v in pairs(entityLibrary.entityList) do
			if not v.Targetable then
			else
				if isVulnerable(v) then
					local playerPosition = v.RootPart.Position
					local mag = (entityLibrary.character.HumanoidRootPart.Position - playerPosition).magnitude
					if prediction and mag > distance then
						mag = (entityLibrary.LocalPosition - playerPosition).magnitude
					end
					if mag <= distance then
						table.insert(sortedentities, v)
					end
				end
			end
		end
		for i, v in pairs(collectionService:GetTagged("Monster")) do
			if v.PrimaryPart and bot then
				local mag = (entityLibrary.character.HumanoidRootPart.Position - v.PrimaryPart.Position).magnitude
				if prediction and mag > distance then
					mag = (entityLibrary.LocalPosition - v.PrimaryPart.Position).magnitude
				end
				if mag <= distance then
					if v:GetAttribute("Team") == lplr:GetAttribute("Team") then else
						table.insert(sortedentities, {Player = {Name = v.Name, UserId = (v.Name == "Duck" and 2020831224 or 1443379645), GetAttribute = function() return "none" end}, Character = v, RootPart = v.PrimaryPart, Humanoid = v.Humanoid})
					end
				end
			end
		end
		for i, v in pairs(collectionService:GetTagged("DiamondGuardian")) do
			if v.PrimaryPart and bot then
				local mag = (entityLibrary.character.HumanoidRootPart.Position - v.PrimaryPart.Position).magnitude
				if prediction and mag > distance then
					mag = (entityLibrary.LocalPosition - v.PrimaryPart.Position).magnitude
				end
				if mag <= distance then
					table.insert(sortedentities, {Player = {Name = "DiamondGuardian", UserId = 1443379645, GetAttribute = function() return "none" end}, Character = v, RootPart = v.PrimaryPart, Humanoid = v.Humanoid})
				end
			end
		end
		for i, v in pairs(collectionService:GetTagged("GolemBoss")) do
			if v.PrimaryPart and bot then
				local mag = (entityLibrary.character.HumanoidRootPart.Position - v.PrimaryPart.Position).magnitude
				if prediction and mag > distance then
					mag = (entityLibrary.LocalPosition - v.PrimaryPart.Position).magnitude
				end
				if mag <= distance then
					table.insert(sortedentities, {Player = {Name = "GolemBoss", UserId = 1443379645, GetAttribute = function() return "none" end}, Character = v, RootPart = v.PrimaryPart, Humanoid = v.Humanoid})
				end
			end
		end
		for i, v in pairs(collectionService:GetTagged("Drone")) do
			if v.PrimaryPart then
				local mag = (entityLibrary.character.HumanoidRootPart.Position - v.PrimaryPart.Position).magnitude
				if prediction and mag > distance then
					mag = (entityLibrary.LocalPosition - v.PrimaryPart.Position).magnitude
				end
				if mag <= distance then
					if tonumber(v:GetAttribute("PlayerUserId")) == lplr.UserId then 
					else
						local droneplr = playersService:GetPlayerByUserId(v:GetAttribute("PlayerUserId"))
						if droneplr and droneplr.Team == lplr.Team then 
						else
							table.insert(sortedentities, {Player = {Name = "Drone", UserId = 1443379645}, GetAttribute = function() return "none" end, Character = v, RootPart = v.PrimaryPart, Humanoid = v.Humanoid})

						end
					end
				end
			end
		end
		table.sort(sortedentities, sortfunction)
		for i,v in pairs(sortedentities) do 
			table.insert(returnedplayer, v)
			currentamount = currentamount + 1
			if currentamount >= amount then break end
		end
	end
	return returnedplayer
end
local function getShieldAttribute(char)
	local returnedShield = 0
	for attributeName, attributeValue in pairs(char:GetAttributes()) do 
		if attributeName:find("Shield") and type(attributeValue) == "number" then 
			returnedShield = returnedShield + attributeValue
		end
	end
	return returnedShield
end
local function attackValue(vec)
	return {value = vec}
end
local vapeTargetInfo = shared.VapeTargetInfo
local gameCamera = workspace.CurrentCamera
workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
	gameCamera = workspace.CurrentCamera or workspace:FindFirstChildWhichIsA("Camera")
end)
task.wait(0.05)--fluxus sucks.
local deathtpmod = {["Enabled"] = false}
local lplr = game.Players.LocalPlayer
local entityLibrary = shared.vapeentity
local connectionstodisconnect = {}
local RunLoops = {RenderStepTable = {}, StepTable = {}, HeartTable = {}}
local runService = game:GetService("RunService")
do
	function RunLoops:BindToRenderStep(name, func)
		if RunLoops.RenderStepTable[name] == nil then
			RunLoops.RenderStepTable[name] = runService.RenderStepped:Connect(func)
		end
	end

	function RunLoops:UnbindFromRenderStep(name)
		if RunLoops.RenderStepTable[name] then
			RunLoops.RenderStepTable[name]:Disconnect()
			RunLoops.RenderStepTable[name] = nil
		end
	end

	function RunLoops:BindToStepped(name, func)
		if RunLoops.StepTable[name] == nil then
			RunLoops.StepTable[name] = runService.Stepped:Connect(func)
		end
	end

	function RunLoops:UnbindFromStepped(name)
		if RunLoops.StepTable[name] then
			RunLoops.StepTable[name]:Disconnect()
			RunLoops.StepTable[name] = nil
		end
	end

	function RunLoops:BindToHeartbeat(name, func)
		if RunLoops.HeartTable[name] == nil then
			RunLoops.HeartTable[name] = runService.Heartbeat:Connect(func)
		end
	end

	function RunLoops:UnbindFromHeartbeat(name)
		if RunLoops.HeartTable[name] then
			RunLoops.HeartTable[name]:Disconnect()
			RunLoops.HeartTable[name] = nil
		end
	end
end
local GuiLibrary = shared.GuiLibrary
local function createwarning(title, text, delay)
	local suc, res = pcall(function()
		local frame = GuiLibrary["CreateNotification"](title, text, delay, "assets/WarningNotification.png")
		frame.Frame.Frame.ImageColor3 = Color3.fromRGB(236, 129, 44)
		return frame
	end)
	return (suc and res)
end
shared.DNutPrivateLoaded = true;
local timer_players = os.clock()
local oldcreate = GuiLibrary.ObjectsThatCanBeSaved.WorldWindow.Api.CreateOptionsButton
GuiLibrary.ObjectsThatCanBeSaved.WorldWindow.Api.CreateOptionsButton = function (...)
	task.wait(0.005)
	return oldcreate(...)
end
deathtpmod = GuiLibrary.ObjectsThatCanBeSaved.BlatantWindow.Api.CreateOptionsButton({
	Name = "BedTPRedirection",
	Function = function(callback)
		if callback then
			if callback then 
				local i_ = 0
				if os.clock() - timer_players < 1 then
					deathtpmod.ToggleButton(false)
					return print('its auto load btw')
				end 
				for i,bed in pairs(workspace:GetChildren()) do
					if bed.Name == "bed" then
						i_ = i_ + 1
					end
					if not entityLibrary.isAlive then
						createwarning("Star Developer","Waiting...",5)
						repeat task.wait() until entityLibrary.isAlive
					end
					if bed.Name == "bed" and bed.Covers.BrickColor ~= lplr.Team.TeamColor then
						if lplr.leaderstats.Bed.Value == "❌" then
							break
						end
						pcall(function ()
							if lplr.leaderstats.Bed.Value == "❌" then
								return
							end
							repeat task.wait() until entityLibrary.isAlive
							tppos2 = bed:GetChildren()[1].Position + Vector3.new(0,5,0)
							-- if not entityLibrary.isAlive then
							-- 	createwarning("DNut Private","Waiting...",5)
							-- 	repeat task.wait() until entityLibrary.isAlive
							-- end
							task.wait()
							game.Players.LocalPlayer.Character.Humanoid.Health = 0
							repeat task.wait() until tppos2 == nil
							repeat task.wait() until not bed.Parent
						end)
					end
				end
				--local warning = createwarning("TPRedirection", "Set TP Position", 3)
			end
			deathtpmod.ToggleButton(false)
		end
	end
})
connectionstodisconnect[#connectionstodisconnect + 1] = lplr:GetAttributeChangedSignal("LastTeleported"):Connect(function(char)
	if tppos2 then
		task.spawn(function()
			repeat task.wait() until entityLibrary.isAlive
			local root = entityLibrary.isAlive and entityLibrary.character.Humanoid.Health > 0 and entityLibrary.character.HumanoidRootPart
			if root and tppos2 then 
				if (workspace:GetServerTimeNow() - lplr:GetAttribute("LastTeleported")) > 1 then
					createwarning("Star Developer", "ur kinda laggy fr", 5)
					--deathtpmod.ToggleButton(false)
				end
				RunLoops:BindToHeartbeat("TPRedirection", function(dt)
					if root and tppos2 then
						local dist = (1000 * dt)
						if (tppos2 - root.CFrame.p).Magnitude > dist then
							root.CFrame = root.CFrame + (tppos2 - root.CFrame.p).Unit * dist
							root.Velocity = (tppos2 - root.CFrame.p).Unit * 20
						else
							root.CFrame = root.CFrame + (tppos2 - root.CFrame.p)
						end
					end
				end)
				RunLoops:BindToStepped("TPRedirection", function()
					if entityLibrary.isAlive then 
						for i,v in pairs(lplr.Character:GetChildren()) do 
							if v:IsA("BasePart") then v.CanCollide = false end
						end
					end
				end)
				local newtpos = tppos2
				repeat
					task.wait()
				until tppos2 == nil or (tppos2 - root.CFrame.p).Magnitude < 1
				RunLoops:UnbindFromHeartbeat("TPRedirection")
				RunLoops:UnbindFromStepped("TPRedirection")
				tppos2 = nil
				pcall(function()
					task.wait(.5)
					if (newtpos - root.CFrame.p).Magnitude > 10 then
						tppos2 = newtpos
						pcall(function ()
							game.Players.LocalPlayer.Character.Humanoid.Health = 0
						end)
						createwarning("Star Developer", "Redoing..", 5)
						return
					end
				end)
			end
		end)
	end
end)
local tppos2
local deathtpmod = {["Enabled"] = false}
local lplr = game.Players.LocalPlayer
local timer_players = os.clock()
local GuiLibrary = shared.GuiLibrary
deathtpmod = GuiLibrary.ObjectsThatCanBeSaved.BlatantWindow.Api.CreateOptionsButton({
	Name = "PlayersTPRedirection",
	Function = function(callback)
		if callback then
			if callback then 
				if os.clock() - timer_players < 1 then
					deathtpmod.ToggleButton(false)
					return print('its auto load btw')
				end 
				local i_ = 0
				local tpos2backup
				for i,plr in pairs(game.Players:GetPlayers()) do
					task.wait(0.1)
					if plr.Character and plr ~= lplr and lplr.Team.TeamColor ~= plr.Team.TeamColor then
						if lplr.leaderstats.Bed.Value == "❌" then
							break
						end
						if not entityLibrary.isAlive then
							return createwarning("Star Developer","Unable to find humanoid.",5)
						end
						pcall(function ()
							tpos2backup = plr.Character.HumanoidRootPart.Position + Vector3.new(0,5,0)
							tppos2 = plr.Character.HumanoidRootPart.Position + Vector3.new(0,5,0)
							if lplr.leaderstats.Bed.Value == "❌" then
								return
							end
							game.Players.LocalPlayer.Character.Humanoid.Health = 0
							task.wait(1)
							pcall(function ()
								tppos2 = plr.Character.HumanoidRootPart.Position + Vector3.new(0,5,0)
							end)
							if not tppos2 then
								tppos2 = tpos2backup
							end
							task.wait(1)
							pcall(function ()
								tppos2 = plr.Character.HumanoidRootPart.Position + Vector3.new(0,5,0)
							end)
							-- pcall(function ()
							-- 	entityLibrary.fullEntityRefresh()
							-- end)
							if not tppos2 then
								tppos2 = tpos2backup
							end
							repeat task.wait() until tppos2 == nil
							pcall(function ()
								repeat task.wait() until not plr.Character:FindFirstChild("HumanoidRootPart")
							end)
						end)
					end
				end
			end
			deathtpmod.ToggleButton(false)
		end
	end
})
connectionstodisconnect[#connectionstodisconnect + 1] = lplr:GetAttributeChangedSignal("LastTeleported"):Connect(function(char)
	if tppos2 then 	
		task.spawn(function()
			repeat task.wait() until entityLibrary.isAlive
			local root = entityLibrary.isAlive and entityLibrary.character.Humanoid.Health > 0 and entityLibrary.character.HumanoidRootPart
			if root and tppos2 then 
				if (workspace:GetServerTimeNow() - lplr:GetAttribute("LastTeleported")) > 1 then
					createwarning("Star Developer", "Anticheat will interfere cuz of ur lag.", 5)
					deathtpmod.ToggleButton(false)
				end
				RunLoops:BindToHeartbeat("TPRedirection", function(dt)
					if root and tppos2 then 
						local dist = (1000 * dt)
						if (tppos2 - root.CFrame.p).Magnitude > dist then
							root.CFrame = root.CFrame + (tppos2 - root.CFrame.p).Unit * dist
							root.Velocity = (tppos2 - root.CFrame.p).Unit * 20
						else
							root.CFrame = root.CFrame + (tppos2 - root.CFrame.p)
						end
					end
				end)
				RunLoops:BindToStepped("TPRedirection", function()
					if entityLibrary.isAlive then 
						for i,v in pairs(lplr.Character:GetChildren()) do 
							if v:IsA("BasePart") then v.CanCollide = false end
						end
					end
				end)
				local newtpos = tppos2
				repeat
					task.wait()
				until tppos2 == nil or (tppos2 - root.CFrame.p).Magnitude < 1
				RunLoops:UnbindFromHeartbeat("TPRedirection")
				RunLoops:UnbindFromStepped("TPRedirection")
				tppos2 = nil
				pcall(function()
					task.wait(.5)
					if (newtpos - root.CFrame.p).Magnitude > 10 then
						tppos2 = newtpos
						pcall(function ()
							game.Players.LocalPlayer.Character.Humanoid.Health = 0
						end)
						createwarning("Star Developer", "Redoing..", 5)
						return
					end
				end)
			end
		end)
	end
end)
local entityLibrary = shared.vapeentity
local GuiLibrary = shared.GuiLibrary
local disabledproper = true
local flyup = false
local flydown = false
local flypress
local flyendpress
local flyupanddown = {Enabled = true}
local uis = game:GetService("UserInputService")
local cloned
local players = game:GetService("Players")
local textservice = game:GetService("TextService")
local repstorage = game:GetService("ReplicatedStorage")
local lplr = players.LocalPlayer
local clonesuccess = false
local networkownertick = tick()
local isnetworkowner = isnetworkowner or function(part)
	if gethiddenproperty(part, "NetworkOwnershipRule") == Enum.NetworkOwnership.Manual then 
		sethiddenproperty(part, "NetworkOwnershipRule", Enum.NetworkOwnership.Automatic)
		networkownertick = tick() + 8
	end
	return networkownertick <= tick()
end
local function runcode(func)
	func()
end
local function getremote(tab)
	for i,v in pairs(tab) do
		if v == "Client" then
			return tab[i + 1]
		end
	end
	return ""
end






local GuiLibrary = shared.GuiLibrary
local BuyWoolStacks = {["Enabled"] = false}
local Wool
BuyWoolStacks = GuiLibrary.ObjectsThatCanBeSaved.WorldWindow.Api.CreateOptionsButton({
	["Name"] = "BuyWoolInStacks",
	["Function"] = function(callback)
		if callback then
			if Wool.Value <= 0 then
				createwarning("Sunnyz Co-Owner","Please change wool amount.",2.5)
				task.wait(2.55)
				createwarning("Sunnyz Co-Owner","(The 3 dots by BuyWoolInStacks)",2.5)
				return
			end
			local a = 0
			local value = Wool.Value
			if value > 1000 then
				value = 1000
				Wool.Value = value
				createwarning("Sunnyz Co-Owner","Changed wool amount to 1000.",1.5)
			end
			for i = 1,value do
				a = a + 1
				if a == 125 and value ~= i then
					createwarning("Sunnyz Co-Owner","Slowing down a lil..",1.5)
					task.wait(0.1)
					a = 0
				end
				task.spawn(function()

					local args = {
						[1] = {
							["shopItem"] = {
								["currency"] = "iron",
								["itemType"] = "wool_white",
								["amount"] = 16,
								["price"] = 8,
								["category"] = "Blocks"
							}
						}
					}

					game:GetService("ReplicatedStorage").rbxts_include.node_modules:FindFirstChild("@rbxts").net.out._NetManaged.BedwarsPurchaseItem:InvokeServer(unpack(args))

				end)
			end
			createwarning("Sunnyz Co-Owner","Finished!",1.5)
		end
	end
})
Wool = BuyWoolStacks.CreateSlider({
	Name = "Wool amount.",
	Min = 0,
	Max = 1000,
	Default = 0,
	Function = function() end,
	HoverText = "Amount of wool (*16) that you want to buy."
})   

local Nuker = {Enabled = false}
local nukerrange = {Value = 1}
local nukereffects = {Enabled = false}
local nukeranimation = {Enabled = false}
local nukernofly = {Enabled = false}
local nukerlegit = {Enabled = false}
local nukerown = {Enabled = false}
local nukerluckyblock = {Enabled = false}
local nukerironore = {Enabled = false}
local nukerbeds = {Enabled = false}
local nukercustom = {RefreshValues = function() end, ObjectList = {}}
local luckyblocktable = {}
local bedwarsStore = {
	blocks = {},
	blockPlacer = {},
	blockRaycast = RaycastParams.new(),
	equippedKit = "none",
	inventories = {},
	localInventory = {
		inventory = {
			items = {},
			armor = {}
		},
		hotbar = {}
	},
	localHand = {},
	matchState = 0,
	matchStateChanged = tick(),
	queueType = "bedwars_test",
	statistics = {
		beds = 0,
		kills = 0,
		lagbacks = 0,
		lagbackEvent = Instance.new("BindableEvent"),
		reported = 0,
		universalLagbacks = 0
	},
	whitelist = {
		chatStrings1 = {KVOP25KYFPPP4 = "vape"},
		chatStrings2 = {vape = "KVOP25KYFPPP4"},
		clientUsers = {},
		oldChatFunctions = {}
	},
	zephyrOrb = 0
}
local groundtime = tick()
local onground = false
local lastonground = false
local flyAllowed

local megacheck = bedwarsStore.queueType:find("mega") or bedwarsStore.queueType == "winter_event"

local collectionService = game:GetService("CollectionService")
bedwarsStore.blockRaycast.FilterType = Enum.RaycastFilterType.Include
local GuiLibrary = shared.GuiLibrary

local entityLibrary = shared.vapeentity
local cachedNormalSides = {}
for i,v in pairs(Enum.NormalId:GetEnumItems()) do if v.Name ~= "Bottom" then table.insert(cachedNormalSides, v) end end
local repstorage = game:GetService("ReplicatedStorage")
local cam = workspace.CurrentCamera
local Flamework = require(repstorage["rbxts_include"]["node_modules"]["@flamework"].core.out).Flamework
local KnitGotten, KnitClient
local bedwars = {}
local blockraycast = RaycastParams.new()
blockraycast.FilterType = Enum.RaycastFilterType.Whitelist
local lplr = game.Players.LocalPlayer
repeat
	task.wait()
	KnitGotten, KnitClient = pcall(function()
		return debug.getupvalue(require(lplr.PlayerScripts.TS.knit).setup, 6)
	end)
until KnitGotten
repeat task.wait() until debug.getupvalue(KnitClient.Start, 1) == true
local InventoryUtil = require(repstorage.TS.inventory["inventory-util"]).InventoryUtil
bedwars = {
	AnimationType = require(repstorage.TS.animation["animation-type"]).AnimationType,
	AnimationUtil = require(repstorage["rbxts_include"]["node_modules"]["@easy-games"]["game-core"].out["shared"].util["animation-util"]).AnimationUtil,
	AppController = require(repstorage["rbxts_include"]["node_modules"]["@easy-games"]["game-core"].out.client.controllers["app-controller"]).AppController,
	AbilityController = Flamework.resolveDependency("@easy-games/game-core:client/controllers/ability/ability-controller@AbilityController"),
	AttackRemote = getremote(debug.getconstants(getmetatable(KnitClient.Controllers.SwordController)["attackEntity"])),
	BalloonController = KnitClient.Controllers.BalloonController,
	BalanceFile = require(repstorage.TS.balance["balance-file"]).BalanceFile,
	BatteryEffectController = KnitClient.Controllers.BatteryEffectsController,
	BatteryRemote = getremote(debug.getconstants(debug.getproto(debug.getproto(KnitClient.Controllers.BatteryController.KnitStart, 1), 1))),
	BlockBreaker = KnitClient.Controllers.BlockBreakController.blockBreaker,
	BlockController = require(repstorage["rbxts_include"]["node_modules"]["@easy-games"]["block-engine"].out).BlockEngine,
	BlockPlacer = require(repstorage["rbxts_include"]["node_modules"]["@easy-games"]["block-engine"].out.client.placement["block-placer"]).BlockPlacer,
	BlockEngine = require(lplr.PlayerScripts.TS.lib["block-engine"]["client-block-engine"]).ClientBlockEngine,
	BlockEngineClientEvents = require(repstorage["rbxts_include"]["node_modules"]["@easy-games"]["block-engine"].out.client["block-engine-client-events"]).BlockEngineClientEvents,
	BlockPlacementController = KnitClient.Controllers.BlockPlacementController,
	BowConstantsTable = debug.getupvalue(KnitClient.Controllers.ProjectileController.enableBeam, 5),
	ProjectileController = KnitClient.Controllers.ProjectileController,
	ChestController = KnitClient.Controllers.ChestController,
	CannonHandController = KnitClient.Controllers.CannonHandController,
	CannonAimRemote = getremote(debug.getconstants(debug.getproto(KnitClient.Controllers.CannonController.startAiming, 5))),
	ClickHold = require(repstorage["rbxts_include"]["node_modules"]["@easy-games"]["game-core"].out.client.ui.lib.util["click-hold"]).ClickHold,
	ClientHandler = require(repstorage.TS.remotes).default.Client,
	ClientHandlerDamageBlock = require(repstorage["rbxts_include"]["node_modules"]["@easy-games"]["block-engine"].out.shared.remotes).BlockEngineRemotes.Client,
	ClientStoreHandler = require(lplr.PlayerScripts.TS.ui.store).ClientStore,
	CombatConstant = require(repstorage.TS.combat["combat-constant"]).CombatConstant,
	CombatController = KnitClient.Controllers.CombatController,
	ConstantManager = require(repstorage["rbxts_include"]["node_modules"]["@easy-games"]["game-core"].out["shared"].constant["constant-manager"]).ConstantManager,
	ConsumeSoulRemote = getremote(debug.getconstants(KnitClient.Controllers.GrimReaperController.consumeSoul)),
	DamageIndicator = KnitClient.Controllers.DamageIndicatorController.spawnDamageIndicator,
	DamageIndicatorController = KnitClient.Controllers.DamageIndicatorController,
	DefaultKillEffect = require(lplr.PlayerScripts.TS.controllers.game.locker["kill-effect"].effects["default-kill-effect"]),
	DropItem = getmetatable(KnitClient.Controllers.ItemDropController).dropItemInHand,
	DropItemRemote = getremote(debug.getconstants(getmetatable(KnitClient.Controllers.ItemDropController).dropItemInHand)),
	DragonSlayerController = KnitClient.Controllers.DragonSlayerController,
	DragonRemote = getremote(debug.getconstants(debug.getproto(debug.getproto(KnitClient.Controllers.DragonSlayerController.KnitStart, 2), 1))),
	EatRemote = getremote(debug.getconstants(debug.getproto(getmetatable(KnitClient.Controllers.ConsumeController).onEnable, 1))),
	EquipItemRemote = getremote(debug.getconstants(debug.getprotos(shared.oldequipitem or require(repstorage.TS.entity.entities["inventory-entity"]).InventoryEntity.equipItem)[3])),
	EmoteMeta = require(repstorage.TS.locker.emote["emote-meta"]).EmoteMeta,
	FishermanTable = KnitClient.Controllers.FishermanController,
	FovController = KnitClient.Controllers.FovController,
	GameAnimationUtil = require(repstorage.TS.animation["animation-util"]).GameAnimationUtil,
	EntityUtil = require(repstorage.TS.entity["entity-util"]).EntityUtil,
	getIcon = function(item, showinv)
		local itemmeta = bedwars.ItemTable[item.itemType]
		if itemmeta and showinv then
			return itemmeta.image
		end
		return ""
	end,
	getInventory = function(plr)
		local suc, result = pcall(function() 
			return InventoryUtil.getInventory(plr) 
		end)
		return (suc and result or {
			items = {},
			armor = {},
			hand = nil
		})
	end,
	GrimReaperController = KnitClient.Controllers.GrimReaperController,
	GuitarHealRemote = getremote(debug.getconstants(KnitClient.Controllers.GuitarController.performHeal)),
	HangGliderController = KnitClient.Controllers.HangGliderController,
	HighlightController = KnitClient.Controllers.EntityHighlightController,
	ItemTable = debug.getupvalue(require(repstorage.TS.item["item-meta"]).getItemMeta, 1),
	KatanaController = KnitClient.Controllers.DaoController,
	KnockbackUtil = require(repstorage.TS.damage["knockback-util"]).KnockbackUtil,
	LobbyClientEvents = KnitClient.Controllers.QueueController,
	MapController = KnitClient.Controllers.MapController,
	MinerRemote = getremote(debug.getconstants(debug.getproto(getmetatable(KnitClient.Controllers.MinerController).onKitEnabled, 1))),
	MageRemote = getremote(debug.getconstants(debug.getproto(KnitClient.Controllers.MageController.registerTomeInteraction, 1))),
	MageKitUtil = require(repstorage.TS.games.bedwars.kit.kits.mage["mage-kit-util"]).MageKitUtil,
	MageController = KnitClient.Controllers.MageController,
	MissileController = KnitClient.Controllers.GuidedProjectileController,
	PickupMetalRemote = getremote(debug.getconstants(debug.getproto(KnitClient.Controllers.MetalDetectorController.KnitStart, 1))),
	PickupRemote = getremote(debug.getconstants(getmetatable(KnitClient.Controllers.ItemDropController).checkForPickup)),
	ProjectileMeta = require(repstorage.TS.projectile["projectile-meta"]).ProjectileMeta,
	ProjectileRemote = getremote(debug.getconstants(debug.getupvalues(getmetatable(KnitClient.Controllers.ProjectileController)["launchProjectileWithValues"])[2])),
	QueryUtil = require(repstorage["rbxts_include"]["node_modules"]["@easy-games"]["game-core"].out).GameQueryUtil,
	QueueCard = require(lplr.PlayerScripts.TS.controllers.global.queue.ui["queue-card"]).QueueCard,
	QueueMeta = require(repstorage.TS.game["queue-meta"]).QueueMeta,
	RavenTable = KnitClient.Controllers.RavenController,
	RelicController = KnitClient.Controllers.RelicVotingController,
	ReportRemote = getremote(debug.getconstants(require(lplr.PlayerScripts.TS.controllers.global.report["report-controller"]).default.reportPlayer)),
	ResetRemote = getremote(debug.getconstants(debug.getproto(KnitClient.Controllers.ResetController.createBindable, 1))),
	Roact = require(repstorage["rbxts_include"]["node_modules"]["@rbxts"]["roact"].src),
	RuntimeLib = require(repstorage["rbxts_include"].RuntimeLib),
	Shop = require(repstorage.TS.games.bedwars.shop["bedwars-shop"]).BedwarsShop,
	ShopItems = debug.getupvalue(debug.getupvalue(require(repstorage.TS.games.bedwars.shop["bedwars-shop"]).BedwarsShop.getShopItem, 1), 2),
	SoundList = require(repstorage.TS.sound["game-sound"]).GameSound,
	SoundManager = require(repstorage["rbxts_include"]["node_modules"]["@easy-games"]["game-core"].out).SoundManager,
	SpawnRavenRemote = getremote(debug.getconstants(getmetatable(KnitClient.Controllers.RavenController).spawnRaven)),
	SprintController = KnitClient.Controllers.SprintController,
	StopwatchController = KnitClient.Controllers.StopwatchController,
	SwordController = KnitClient.Controllers.SwordController,
	TreeRemote = getremote(debug.getconstants(debug.getprotos(debug.getprotos(KnitClient.Controllers.BigmanController.KnitStart)[3])[1])),
	TrinityRemote = getremote(debug.getconstants(debug.getproto(getmetatable(KnitClient.Controllers.AngelController).onKitEnabled, 1))),
	ViewmodelController = KnitClient.Controllers.ViewmodelController,
	WeldTable = require(repstorage.TS.util["weld-util"]).WeldUtil,
	ZephyrController = KnitClient.Controllers.WindWalkerController
}
local networkownertick = tick()
local matchState = 0
local connectionstodisconnect = {}
local queueType = "bedwars_test"
local currentinventory = {
	inventory = {
		items = {},
		armor = {},
		hand = nil
	}
}


local function getSpeedMultiplier(reduce)
	local speed = 1
	if lplr.Character then 
		local SpeedDamageBoost = lplr.Character:GetAttribute("SpeedBoost")
		if SpeedDamageBoost and SpeedDamageBoost > 1 then 
			speed = speed + (SpeedDamageBoost - 1)
		end
		if lplr.Character:GetAttribute("GrimReaperChannel") then 
			speed = speed + 0.6
		end
		if lplr.Character:GetAttribute("SpeedPieBuff") then 
			speed = speed + (bedwarsStore.queueType == "SURVIVAL" and 0.15 or 0.24)
		end
		local armor = bedwarsStore.localInventory.inventory.armor[3]
		if type(armor) ~= "table" then armor = {itemType = ""} end
		if armor.itemType == "speed_boots" then 
			speed = speed + 1
		end
		if bedwarsStore.zephyrOrb ~= 0 then 
			speed = speed + 1
		end
	end
	return reduce and speed ~= 1 and math.max(speed * (0.8 - (0.3 * math.floor(speed))), 1) or speed
end

local FlyAnywayProgressBarFrame = Instance.new("Frame")
FlyAnywayProgressBarFrame.AnchorPoint = Vector2.new(0.5, 0)
FlyAnywayProgressBarFrame.Position = UDim2.new(0.5, 0, 1, -200)
FlyAnywayProgressBarFrame.Size = UDim2.new(0.2, 0, 0, 20)
FlyAnywayProgressBarFrame.BackgroundTransparency = 0.5
FlyAnywayProgressBarFrame.BorderSizePixel = 0
FlyAnywayProgressBarFrame.BackgroundColor3 = Color3.new(0, 0, 0)
FlyAnywayProgressBarFrame.Visible = false
FlyAnywayProgressBarFrame.Parent = GuiLibrary.MainGui
local FlyAnywayProgressBarFrame2 = FlyAnywayProgressBarFrame:Clone()
FlyAnywayProgressBarFrame2.AnchorPoint = Vector2.new(0, 0)
FlyAnywayProgressBarFrame2.Position = UDim2.new(0, 0, 0, 0)
FlyAnywayProgressBarFrame2.Size = UDim2.new(1, 0, 0, 20)
FlyAnywayProgressBarFrame2.BackgroundTransparency = 0
FlyAnywayProgressBarFrame2.Visible = true
FlyAnywayProgressBarFrame2.Parent = FlyAnywayProgressBarFrame
local FlyAnywayProgressBartext = Instance.new("TextLabel")
FlyAnywayProgressBartext.Text = "2s"
FlyAnywayProgressBartext.Font = Enum.Font.Gotham
FlyAnywayProgressBartext.TextStrokeTransparency = 0
FlyAnywayProgressBartext.TextColor3 =  Color3.new(0.9, 0.9, 0.9)
FlyAnywayProgressBartext.TextSize = 20
FlyAnywayProgressBartext.Size = UDim2.new(1, 0, 1, 0)
FlyAnywayProgressBartext.BackgroundTransparency = 1
FlyAnywayProgressBartext.Position = UDim2.new(0, 0, -1, 0)
FlyAnywayProgressBartext.Parent = FlyAnywayProgressBarFrame
local currenthand = {}
local kit = ""
connectionstodisconnect[#connectionstodisconnect + 1] = bedwars.ClientStoreHandler.changed:connect(function(p3, p4)
	if p3.Game ~= p4.Game then 
		matchState = p3.Game.matchState
		queueType = p3.Game.queueType or "bedwars_test"
	end
	if p3.Kit ~= p4.Kit then 	
		bedwars.BountyHunterTarget = p3.Kit.bountyHunterTarget
	end
	if p3.Bedwars ~= p4.Bedwars then 
		kit = p3.Bedwars.kit ~= "none" and p3.Bedwars.kit or ""
	end
	if p3.Inventory ~= p4.Inventory then
		currentinventory = p3.Inventory.observedInventory
		local obj = p3.Inventory.observedInventory.inventory.hand
		local typetext = ""
		if obj then
			local metatab = bedwars.ItemTable[obj.itemType]
			typetext = metatab.sword and "sword" or metatab.block and "block" or obj.itemType:find("bow") and "bow"
		end
		currenthand = {tool = obj and obj.tool, Type = typetext, amount = obj and obj.amount or 0}
	end
end)
local uis = game:GetService("UserInputService")
local entityLibrary = shared.vapeentity
local flyvelo;local allowed
local OldNoFallFunction
local flymode = {Value = "Normal"}
local flyverticalspeed = {Value = 40}
local flypop = {Enabled = true}
local flyautodamage = {Enabled = true}
local flyac = {Enabled = false}
local flyacprogressbar = {Enabled = false}
local flydamageanim = {Enabled = false}
local flyspeedboost = {Enabled = false}
local flyhighjump = {Enabled = false}
local flydelay = {Value = 125}
local flyacprogressbarframe
local olddeflate
local flyrequests = 0
local flytime = 60
local flylimit = false
local flyup = false
local flydown = false
local flypress
local flyendpress
local flycorountine
local flytog = false
local flytogtick = tick()
local groundtime = tick()
local onground = false
local lastonground = false
local clonesuccess = false
local disabledproper = true
local alternatelist = {"Normal", "AntiCheat A", "AntiCheat B"}
local cloned
local function disablefunc(part, cframe)
	RunLoops:UnbindFromHeartbeat("PrivateDNutFlyOff")
	disabledproper = true
	part:Destroy()
	local a;
	repeat task.wait()
		a = pcall(function()
			oldcloneroot.Anchored = true;
			task.wait()
			oldcloneroot.Anchored = false;
			task.wait(.1)
			oldcloneroot.Anchored = false;
			task.wait()
			oldcloneroot.CFrame = (cframe or oldcloneroot.CFrame)
			lplr.Character.Parent = game
			oldcloneroot.Parent = lplr.Character
			lplr.Character.PrimaryPart = oldcloneroot
			lplr.Character.Parent = workspace
			oldcloneroot.CanCollide = true
			oldcloneroot.Transparency = 1
		end)
	until a
	for i,v in pairs(lplr.Character:GetDescendants()) do 
		if v:IsA("Weld") or v:IsA("Motor6D") then 
			if v.Part0 == clone then v.Part0 = oldcloneroot end
			if v.Part1 == clone then v.Part1 = oldcloneroot end
		end
		if v:IsA("BodyVelocity") then 
			v:Destroy()
		end
	end
	for i,v in pairs(oldcloneroot:GetChildren()) do 
		if v:IsA("BodyVelocity") then 
			v:Destroy()
		end
	end
	if clone then 
		clone:Destroy()
		clone = nil
	end
	lplr.Character.Humanoid.HipHeight = hip or 2
	oldcloneroot = nil
end
local function getPlacedBlock(pos)
	local roundedPosition = bedwars.BlockController:getBlockPosition(pos)
	return bedwars.BlockController:getStore():getBlockAt(roundedPosition), roundedPosition
end
--repeat task.wait() until matchState ~= 0
local groundtick
task.spawn(function()
	repeat
		task.wait()
		if entityLibrary.isAlive then
			groundtick = entityLibrary.character.Humanoid.FloorMaterial ~= Enum.Material.Air and tick() or groundtick
		end
		for i,v in pairs(entityLibrary.entityList) do 
			local state = v.Humanoid:GetState()
			v.JumpTick = (state ~= Enum.HumanoidStateType.Running and state ~= Enum.HumanoidStateType.Landed) and tick() or v.JumpTick
			v.Jumping = (tick() - v.JumpTick) < 0.2 and v.Jumps > 1
			if (tick() - v.JumpTick) > 0.2 then 
				v.Jumps = 0
			end
		end
	until false;
end)
fly = GuiLibrary.ObjectsThatCanBeSaved.BlatantWindow.Api.CreateOptionsButton({
	Name = "DNutPrivateFly | skidded",
	Function = function(callback)
		if callback then
			if not disabledproper then 
				createwarning("Sunnyz Co-Owner", "Waiting for last tp to finish.", 3)
				fly.ToggleButton(false)
				return 
			end
			flypress = uis.InputBegan:Connect(function(input1)
				if game:GetService("UserInputService"):GetFocusedTextBox() == nil then
					if input1.KeyCode == Enum.KeyCode.Space or input1.KeyCode == Enum.KeyCode.ButtonA then
						flyup = true
					end
					if input1.KeyCode == Enum.KeyCode.LeftShift or input1.KeyCode == Enum.KeyCode.ButtonL2 then
						flydown = true
					end
				end
			end)
			flyendpress = uis.InputEnded:Connect(function(input1)
				if input1.KeyCode == Enum.KeyCode.Space or input1.KeyCode == Enum.KeyCode.ButtonA then
					flyup = false
				end
				if input1.KeyCode == Enum.KeyCode.LeftShift or input1.KeyCode == Enum.KeyCode.ButtonL2 then
					flydown = false
				end
			end)
			clonesuccess = false
			if entityLibrary.isAlive and entityLibrary.character.Humanoid.Health > 0 and isnetworkowner(entityLibrary.character.HumanoidRootPart) then
				cloned = lplr.Character
				oldcloneroot = entityLibrary.character.HumanoidRootPart
				lplr.Character.Parent = game
				clone = oldcloneroot:Clone()
				clone.Parent = lplr.Character
				oldcloneroot.Parent = cam
				bedwars["QueryUtil"]:setQueryIgnored(oldcloneroot, true)
				clone.CFrame = oldcloneroot.CFrame
				lplr.Character.PrimaryPart = clone
				lplr.Character.Parent = workspace
				for i,v in pairs(lplr.Character:GetDescendants()) do 
					if v:IsA("Weld") or v:IsA("Motor6D") then 
						if v.Part0 == oldcloneroot then v.Part0 = clone end
						if v.Part1 == oldcloneroot then v.Part1 = clone end
					end
					if v:IsA("BodyVelocity") then 
						v:Destroy()
					end
				end
				for i,v in pairs(oldcloneroot:GetChildren()) do 
					if v:IsA("BodyVelocity") then 
						v:Destroy()
					end
				end
				if hip then 
					lplr.Character.Humanoid.HipHeight = hip
				end
				hip = lplr.Character.Humanoid.HipHeight
				clonesuccess = true
			end
			if not clonesuccess then 
				createwarning("Sunnyz Co-Owner", "Character missing", 3)
				fly.ToggleButton(false)
				return 
			end
			local goneup = false
			RunLoops:BindToHeartbeat("DNutPrivateFly", function(delta) 
				if entityLibrary.isAlive and (GuiLibrary.ObjectsThatCanBeSaved["Lobby CheckToggle"]["Api"].Enabled == false or matchState ~= 0) then
					-- repeat task.wait() until groundtime
					-- if (groundtime - tick()) < 0.6 and not onground then
					-- 	local a = 0
					-- 	repeat task.wait(0.1) a = a + 0.1 until not ((groundtime - tick()) < 0.6 and not onground) or a == 0.2;
					-- end

					if isnetworkowner(oldcloneroot) then 
						local newpos = {oldcloneroot.CFrame:GetComponents()}
						newpos[1] = clone.CFrame.X
						if newpos[2] < 1000 or (not goneup) then 
							createwarning("Sunnyz Co-Owner", "Went up to 5000. (Safe to untoggle)", 1)
							newpos[2] = 5000
							goneup = true
						end
						clone.Parent.Humanoid.WalkSpeed = 18;
						newpos[3] = clone.CFrame.Z
						oldcloneroot.CFrame = CFrame.new(unpack(newpos))
						oldcloneroot.Velocity = Vector3.new(clone.Velocity.X, oldcloneroot.Velocity.Y, clone.Velocity.Z)
					else
						local newpos2 = {oldcloneroot.CFrame:GetComponents()}
						newpos2[2] = clone.CFrame.Y
						clone.Parent.Humanoid.WalkSpeed = 10.5;
						clone.CFrame = CFrame.new(unpack(newpos2))
						createwarning("Sunnyz Co-Owner","Please wait.. (Anticheated)",3.5)
					end
					allowed = 1
					local mass = (entityLibrary.character.HumanoidRootPart:GetMass() - 1.4) * (delta * 75)
					local flypos = entityLibrary.character.Humanoid.MoveDirection * 20
					entityLibrary.character.HumanoidRootPart.Transparency = 1
					entityLibrary.character.HumanoidRootPart.Velocity = flypos + (Vector3.new(0, mass + (flyup and flyverticalspeed.Value or 0) + (flydown and -flyverticalspeed.Value or 0), 0) * allowed)
					flyvelo = flypos + Vector3.new(0, mass + (flyup and flyverticalspeed.Value or 0) + (flydown and -flyverticalspeed.Value or 0), 0)
				end
			end)
			task.spawn(function()
				repeat task.wait() until queueType ~= "bedwars_test" or (not fly.Enabled)
				megacheck = bedwarsStore.queueType:find("mega") or bedwarsStore.queueType == "winter_event"
				repeat task.wait()

					FlyAnywayProgressBarFrame.Visible = true
					FlyAnywayProgressBarFrame.Frame:TweenSize(UDim2.new(1, 0, 0, 20), Enum.EasingDirection.InOut, Enum.EasingStyle.Linear, 0, true)
					if FlyAnywayProgressBarFrame then
						FlyAnywayProgressBarFrame.Visible = true
						FlyAnywayProgressBarFrame.BackgroundColor3 = Color3.fromHSV(GuiLibrary.ObjectsThatCanBeSaved["Gui ColorSliderColor"].Api.Hue, GuiLibrary.ObjectsThatCanBeSaved["Gui ColorSliderColor"].Api.Sat, GuiLibrary.ObjectsThatCanBeSaved["Gui ColorSliderColor"].Api.Value)
						FlyAnywayProgressBarFrame.Frame.BackgroundColor3 = Color3.fromHSV(GuiLibrary.ObjectsThatCanBeSaved["Gui ColorSliderColor"].Api.Hue, GuiLibrary.ObjectsThatCanBeSaved["Gui ColorSliderColor"].Api.Sat, GuiLibrary.ObjectsThatCanBeSaved["Gui ColorSliderColor"].Api.Value)
					end
				until not fly.Enabled
			end)
			FlyAnywayProgressBarFrame.Visible = true
			FlyAnywayProgressBarFrame.Frame:TweenSize(UDim2.new(1, 0, 0, 20), Enum.EasingDirection.InOut, Enum.EasingStyle.Linear, 0, true)
			task.spawn(function()
				repeat task.wait()
					local newray = getPlacedBlock(entityLibrary.character.HumanoidRootPart.Position + Vector3.new(0, (entityLibrary.character.Humanoid.HipHeight * -2) - 1, 0))
					onground = newray and true or false
					if lastonground ~= onground then 
						if (not onground) then 
							groundtime = tick() + (5.1 + (groundtick - tick()))
							if FlyAnywayProgressBarFrame then 
								FlyAnywayProgressBarFrame.Frame:TweenSize(UDim2.new(0, 0, 0, 20), Enum.EasingDirection.InOut, Enum.EasingStyle.Linear, groundtime - tick(), true)
							end
						else
							if FlyAnywayProgressBarFrame then 
								FlyAnywayProgressBarFrame.Frame:TweenSize(UDim2.new(1, 0, 0, 20), Enum.EasingDirection.InOut, Enum.EasingStyle.Linear, 0, true)
							end
						end
					end
					if FlyAnywayProgressBarFrame then 
						FlyAnywayProgressBarFrame.TextLabel.Text = math.max(onground and 5 or math.floor((groundtime - tick()) * 10) / 10, 0).."s"
					end
					lastonground = onground
				until not fly.Enabled
			end)
			--FlyAnywayProgressBarFrame.Visible = true;
			groundtime = 3
			local func = coroutine.create(function()
				repeat
					repeat task.wait() until (groundtime - tick()) < 0.6 and not onground
					--flyAllowed = ((lplr.Character and lplr.Character:GetAttribute("InflatedBalloons") and lplr.Character:GetAttribute("InflatedBalloons") > 0) or bedwarsStore.matchState == 2 or megacheck) and 1 or 0
					--if (not fly.Enabled) then break end
					--local Flytppos = false
					--if entityLibrary.isAlive then 
					--	clone.CFrame = CFrame.new(oldcloneroot.Position.X, ray and ray.Position.Y + (entityLibrary.character.Humanoid.HipHeight + (oldcloneroot.Size.Y / 2)) or clone.CFrame.p.Y, oldcloneroot.Position.Z)
					--	local clonecrap = clone:Clone()
					--	clonecrap.Parent = workspace
					--	local t = game.TweenService:Create(clonecrap,TweenInfo.new(2,Enum.EasingStyle.Quad,Enum.EasingDirection.In),
					--		{["CFrame"] = CFrame.new(Vector3.new(0,0,0))})
					--	t:Play()
					--	local tp
					--	clonecrap.Touched:Connect(function(a)
					--		if a.Parent ~= clonecrap then
					--			tp = clonecrap.Position.Y + (clone.Size.Y / 2) + entityLibrary.character.Humanoid.HipHeight + clonecrap.Position.Y * .8;
					--		end
					--	end)
					--	t.Completed:Wait()
					--	if tp and tp ~= 0 then
					--		Flytppos = clone.Position.Y
					--		local args = {entityLibrary.character.HumanoidRootPart.CFrame:GetComponents()}
					--		args[2] = tp + (clone.Size.Y / 2) + entityLibrary.character.Humanoid.HipHeight
					--		clone.CFrame = CFrame.new(unpack(args))
					--	end
					--	clonecrap:Destroy()
					--end
					--task.wait(0.15)
					--if (not fly.Enabled) then break end
					--if Flytppos ~= false and entityLibrary.isAlive then 
					--	local args = {clone.CFrame:GetComponents()}
					--	args[2] = Flytppos
					--	clone.CFrame = CFrame.new(unpack(args))
					--end
					createwarning("Sunnyz Co-Owner","Find a place to go down!",1.9)
					task.wait(2)
				until (not fly.Enabled)
			end)
			coroutine.resume(func)
		else
			RunLoops:UnbindFromHeartbeat("DNutPrivateFly")
			task.spawn(function()
				repeat task.wait(0.1)
					FlyAnywayProgressBarFrame.Visible = false;
				until not FlyAnywayProgressBarFrame.Visible
			end)
			if clonesuccess and oldcloneroot and clone and lplr.Character.Parent == workspace and oldcloneroot.Parent ~= nil and disabledproper and cloned == lplr.Character then 
				local ray = workspace:Raycast(Vector3.new(oldcloneroot.Position.X, clone.CFrame.p.Y, oldcloneroot.Position.Z), Vector3.new(0, -1000, 0), blockraycast)
				clone.CFrame = CFrame.new(oldcloneroot.Position.X, ray and ray.Position.Y + (entityLibrary.character.Humanoid.HipHeight + (oldcloneroot.Size.Y / 2)) or clone.CFrame.p.Y, oldcloneroot.Position.Z)
				oldcloneroot.CanCollide = true
				oldcloneroot.Velocity = Vector3.new(0, -1, 0)
				RunLoops:BindToHeartbeat("DNutPrivateFlyOff", function()
					if oldcloneroot then 
						oldcloneroot.Velocity = Vector3.new(0, -1, 0)
					end
				end)
				task.wait(.1)
				oldcloneroot.CFrame = clone.CFrame
				entityLibrary.character.Humanoid:ChangeState(Enum.HumanoidStateType.Landed)
				local part = Instance.new("Part")
				part.Anchored = true
				part.CanCollide = false
				part.Size = Vector3.new(1, 1, 1)
				part.Color = Color3.new(0.5, 0.5, 1)
				part.Transparency = 0.5
				part.Shape = Enum.PartType.Ball
				part.TopSurface = Enum.SurfaceType.Smooth
				part.BottomSurface = Enum.SurfaceType.Smooth
				part.Parent = workspace.GameSounds
				part.Position = oldcloneroot.Position
				disabledproper = false
				if isnetworkowner(oldcloneroot) then 
					oldcloneroot.Anchored = true;
					createwarning("Sunnyz Co-Owner", "Waiting "..(0.3).."s to not flag", 3)
					task.delay(0.3, disablefunc, part, CFrame.new(oldcloneroot.Position.X, ray and ray.Position.Y + (entityLibrary.character.Humanoid.HipHeight + (oldcloneroot.Size.Y / 2)) or clone.CFrame.p.Y, oldcloneroot.Position.Z))
				else
					createwarning("Sunnyz Co-Owner", "Waiting until not flagged", 10)
					task.spawn(function()
						repeat task.wait() until oldcloneroot and isnetworkowner(oldcloneroot) or oldcloneroot == nil
						task.wait(0.1)
						local ray = workspace:Raycast(Vector3.new(oldcloneroot.Position.X, clone.CFrame.p.Y, oldcloneroot.Position.Z), Vector3.new(0, -1000, 0), blockraycast)
						oldcloneroot.Velocity = Vector3.new(0, -1, 0)
						oldcloneroot.CFrame = CFrame.new(oldcloneroot.Position.X, ray and ray.Position.Y + (entityLibrary.character.Humanoid.HipHeight + (oldcloneroot.Size.Y / 2)) or clone.CFrame.p.Y, oldcloneroot.Position.Z)
						entityLibrary.character.Humanoid:ChangeState(Enum.HumanoidStateType.Landed)
						createwarning("Sunnyz Co-Owner", "Waiting 0.1s to not flag", 3)
						oldcloneroot.Anchored = true;
						clone.Anchored = true;
						task.wait(0.25)
						disablefunc(part, CFrame.new(oldcloneroot.Position.X, ray and ray.Position.Y + (entityLibrary.character.Humanoid.HipHeight + (oldcloneroot.Size.Y / 2)) or clone.CFrame.p.Y, oldcloneroot.Position.Z))
					end)
				end
			end
			flyup = false
			flydown = false
			if flypress then flypress:Disconnect() end
			if flyendpress then flyendpress:Disconnect() end
		end
	end,
	HoverText = "Better inf fly"
})
flyverticalspeed = fly.CreateSlider({
	Name = "Vertical Speed",
	Min = 1,
	Max = 100,
	Function = function(val) end, 
	Default = 44
})
local top = function (a)
	return debug.getconstants(bedwars.DamageIndicator)[a]
end
local enabled = {}
local hithithit = {"Hit!","Whomp!","Slam!","Crash!","Slice!","Boom!","Pow!","Bam!","Smash!","Zap!","Poof!"}
damageispog = GuiLibrary.ObjectsThatCanBeSaved.WorldWindow.Api.CreateOptionsButton({
	Name = "FunnyIndicator",
	Function = function(callback)
		if callback then
			task.spawn(function()
				if bedwarsStore.matchState == 0 then
					repeat task.wait() until bedwarsStore.matchState ~= 0
					damageispog.ToggleButton(false)
					task.wait(0.1)
					damageispog.ToggleButton(true)
					return;
				end
				enabled[1] = debug.getupvalue(bedwars["DamageIndicator"],10)
				debug.setupvalue(bedwars["DamageIndicator"],10,{
					Create = function(self,coolhitthing,...)
						pcall(function()
							local a = coolhitthing.Parent
							for i,v in pairs(a.Parent.Parent.Parent:GetChildren()) do print(i,v ) end
							a.Text = hithithit[math.random(1,#hithithit)]
							a.TextColor3 =  Color3.fromHSV(tick()%5/5,1,1)
							a.FontFace = Font.new([[rbxasset://fonts/families/LuckiestGuy.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal)
						end)
						return game:GetService("TweenService"):Create(coolhitthing,...)
					end
				})
			end)
		else
			debug.setupvalue(bedwars["DamageIndicator"],10,enabled[1])
		end
	end,
	HoverText = "pog thing"
})

local oldchanneltabs = {}
local CheckMagnitude = {["Enabled"] = false}
CheckMagnitude = GuiLibrary["ObjectsThatCanBeSaved"]["WorldWindow"]["Api"].CreateOptionsButton({
	["Name"] = "CheckMagnitude",
	["Function"] = function(Enabled)
		if Enabled then
			local mousepos = lplr:GetMouse().UnitRay
			local rayparams = RaycastParams.new()
			rayparams.FilterDescendantsInstances = {workspace.Map, workspace:FindFirstChild("SpectatorPlatform")}
			rayparams.FilterType = Enum.RaycastFilterType.Whitelist
			local ray = workspace:Raycast(mousepos.Origin, mousepos.Direction * 10000, rayparams)
			if not ray then
				createwarning("Sunnyz Co-Owner","Unable to find position.",5)
				return CheckMagnitude.ToggleButton(false)
			else
				ray = ray.Position
			end
			local magnitude = (lplr.Character.HumanoidRootPart.Position - ray).magnitude
			if magnitude > 70 then
				createwarning("Sunnyz Co-Owner","will get anticheated.(if no ground in path)",5)
			else
				createwarning("Sunnyz Co-Owner","will NOT get anticheated!",5)	
			end
			CheckMagnitude.ToggleButton(false)
		end
	end
})

local HealthWarn = {["Enabled"] = false}
HealthWarn = GuiLibrary["ObjectsThatCanBeSaved"]["UtilityWindow"]["Api"].CreateOptionsButton({
	["Name"] = "HealthWarn",
	["Function"] = function(callback)
		if callback then
			local hum = game.Players.LocalPlayer.Character.Humanoid
			local he = hum.Health
			if he < 45 then
				createwarning("Vape", "Health is lower than 45!")
			end
		end
	end
})

local longjumpold = {["Enabled"] = false}
local stored = {}
local StabPos
local player = game:GetService("Players").LocalPlayer
local entity = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
local longjumpfuny
shared.did = shared.did or {}
shared.did2 = shared.did2 or {}
longjumpold = GuiLibrary["ObjectsThatCanBeSaved"]["BlatantWindow"]["Api"].CreateOptionsButton({
	["Name"] = "LongJumpOld",
	["Function"] = function(Enabled)
		if Enabled then
			createwarning("LongJump", "waiting 0.1s to jump", 2)
			game.workspace.Gravity = 7
			if entity then
				entity:ChangeState(Enum.HumanoidStateType.Jumping)
			end
		else
			game.workspace.Gravity = 196.2
			longjumpfuny = false
		end
	end
})
local function getItem(itemName, inv)
	for slot, item in pairs(inv or bedwarsStore.localInventory.inventory.items) do
		if item.itemType == itemName then
			return item, slot
		end
	end
	return nil
end
local function updateStore(newStore, oldStore)
	if newStore.Game ~= oldStore.Game then 
		bedwarsStore.matchState = newStore.Game.matchState
		if bedwarsStore.matchState == 0 and newStore.Game.matchState ~= 0 then
			bedwarsStore.secs = 1
		else
			task.spawn(function()
				task.wait(1)
				bedwarsStore.secs = nil
			end)
		end
		local customqueue = newStore.Game.queueType or "bedwars_test"
		customqueue = (string.find(customqueue,"skywars") and "Skywars" or string.find(customqueue,"30v30") and "30V30" or
			string.find(customqueue,"2v2") and "2v2" or "")
		bedwarsStore.queueType = newStore.Game.queueType or "bedwars_test"
		bedwarsStore.customDnutqueue = customqueue
	end
	if newStore.Bedwars ~= oldStore.Bedwars then 
		bedwarsStore.equippedKit = newStore.Bedwars.kit ~= "none" and newStore.Bedwars.kit or ""
	end
	if newStore.Inventory ~= oldStore.Inventory then
		local newInventory = (newStore.Inventory and newStore.Inventory.observedInventory or {inventory = {}})
		local oldInventory = (oldStore.Inventory and oldStore.Inventory.observedInventory or {inventory = {}})
		bedwarsStore.localInventory = newStore.Inventory.observedInventory
		if newInventory ~= oldInventory then
			--vapeEvents.InventoryChanged:Fire()
		end
		if newInventory.inventory.items ~= oldInventory.inventory.items then
			--vapeEvents.InventoryAmountChanged:Fire()
		end
		if newInventory.inventory.hand ~= oldInventory.inventory.hand then 
			local currentHand = newStore.Inventory.observedInventory.inventory.hand
			local handType = ""
			if currentHand then
				local handData = bedwars.ItemTable[currentHand.itemType]
				handType = handData.sword and "sword" or handData.block and "block" or currentHand.itemType:find("bow") and "bow"
			end
			bedwarsStore.localHand = {tool = currentHand and currentHand.tool, Type = handType, amount = currentHand and currentHand.amount or 0}
		end
	end
end
updateStore(bedwars.ClientStoreHandler:getState(), {})
table.insert({}, bedwars.ClientStoreHandler.changed:connect(updateStore))
local DamageTp,thing = {},{}
DamageTp = GuiLibrary.ObjectsThatCanBeSaved.BlatantWindow.Api.CreateOptionsButton({
	Name = "DamageTP",
	Function = function (callback)
		if callback then
			local mousepos = lplr:GetMouse().UnitRay
			local rayparams = RaycastParams.new()
			rayparams.FilterDescendantsInstances = {workspace.Map, workspace:FindFirstChild("SpectatorPlatform")}
			rayparams.FilterType = Enum.RaycastFilterType.Whitelist
			local ray = workspace:Raycast(mousepos.Origin, mousepos.Direction * 10000, rayparams)
			DamageTp.ToggleButton(false)
			if ray then
				createwarning("fireballtp","tpset",5)
				ray = Vector3.new(ray.Position.X, ray.Position.Y, ray.Position.Z)
				local a = game.Players.LocalPlayer.Character.Humanoid
				local oldhp = a.Health;local c
				local doing
				local item = getItem("fireball")
				if item and thing.Enabled then
					game.Players.LocalPlayer.Character.Humanoid.Jump = true
					bedwars.ProjectileController:createLocalProjectile(bedwars.ProjectileMeta["fireball"], "fireball", "fireball", game.Players.LocalPlayer.Character.HumanoidRootPart.Position, "", Vector3.new(0, -60, 0), {drawDurationSeconds = 1})
					bedwars.ClientHandler:Get(bedwars.ProjectileRemote):CallServerAsync(item["tool"], "fireball", "fireball", game.Players.LocalPlayer.Character.HumanoidRootPart.Position, game.Players.LocalPlayer.Character.HumanoidRootPart.Position, Vector3.new(0, -60, 0), game:GetService("HttpService"):GenerateGUID(true), {drawDurationSeconds = 1}, workspace:GetServerTimeNow() - 0.045)
				end
				ray = ray + Vector3.new(0,5,0)
				c = a.Changed:Connect(function()
					if oldhp > a.Health and not doing then
						doing = true
						local magin = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - CFrame.new(ray).Position).Magnitude
						RunLoops:BindToHeartbeat("DNutPrivateDmgTp",function ()
							local a,b = pcall(function()
								game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(0,-1,0)
							end)
							if not a then RunLoops:UnbindToHeartbeat("DNutPrivateDmgTp") end
						end)
						if magin > 100 then
							local TweenInfo_1
							TweenInfo_1 = TweenInfo.new(
								1.75,
								Enum.EasingStyle.Linear,
								Enum.EasingDirection.Out,
								0,
								false,
								0
							)
							local Goal = {
								CFrame = CFrame.new(ray)
							}
							if game.Players.LocalPlayer.Character.HumanoidRootPart.Position.Y + 30 > ray.Y then
								local Goal = {
									CFrame = CFrame.new(ray.X,game.Players.LocalPlayer.Character.HumanoidRootPart.Position.Y,ray.Z)
								}
								local Tween = game.TweenService:Create(game.Players.LocalPlayer.Character.HumanoidRootPart, TweenInfo_1, Goal)
								Tween:Play()
								Tween.Completed:Wait()
								local Goal = {
									CFrame = CFrame.new(ray)
								}
								local TweenInfo = TweenInfo.new(
									0.1,
									Enum.EasingStyle.Linear,
									Enum.EasingDirection.In,
									0,
									false,
									0
								)
								local Tween = game.TweenService:Create(game.Players.LocalPlayer.Character.HumanoidRootPart, TweenInfo, Goal)
								Tween:Play()
								Tween.Completed:Wait()
							else
								local TweenInfo = TweenInfo.new(
									1.75,
									Enum.EasingStyle.Linear,
									Enum.EasingDirection.In,
									0,
									false,
									0
								)
								local Tween = game.TweenService:Create(game.Players.LocalPlayer.Character.HumanoidRootPart, TweenInfo, Goal)
								Tween:Play()
								Tween.Completed:Wait()
							end
							game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(CFrame.new(ray) * Vector3.new(1,-1,1))
						else
							if item then task.wait(0.3) else task.wait(0.325) end
							game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(ray)	
						end
						repeat task.wait()
							game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(ray)
						until game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame == CFrame.new(ray)
						if (game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.Position - ray).Magnitude > 30 then
							game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(ray)
							createwarning("Star Developer","TP FAILED!",5)
						else
							RunLoops:UnbindFromHeartbeat("DNutPrivateDmgTp")
							game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(ray)
							c:Disconnect()
						end
						doing = false
					end
					oldhp = a.Health
				end)
			end
		end
	end
})
thing = DamageTp.CreateToggle({
	Name = "firebal tp",
	Default = true,
	Function = function () end,
})
local Fireball_Aura,Fireball_range = {},{}
Fireball_Aura = GuiLibrary.ObjectsThatCanBeSaved.BlatantWindow.Api.CreateOptionsButton({
	Name = "TPAura",
	Function = function (enabled)
		if enabled then
			task.spawn(function()
				while Fireball_Aura.Enabled and task.wait(0.1) do
					local ClosestDistance = math.huge
					local ClosestPlayer
					local TeleportDistance = Fireball_range.Value
					for _, Player in pairs(Players:GetPlayers()) do
						if Player ~= LocalPlayer and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
							if Player.TeamColor ~= LocalPlayer.TeamColor and Player.Character:FindFirstChild("Humanoid") and Player.Character.Humanoid.Health > 0 then
								local Distance = (Player.Character.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).magnitude

								if Distance < TeleportDistance and Distance < ClosestDistance then
									ClosestDistance = Distance
									ClosestPlayer = Player
								end
							end
						end
					end

					if ClosestPlayer and ClosestPlayer.Character and ClosestPlayer.Character:FindFirstChild("HumanoidRootPart") then
						local pos = ClosestPlayer.Character.HumanoidRootPart.Position
						local item = getItem("fireball")
						if item then
							bedwars.ProjectileController:createLocalProjectile(bedwars.ProjectileMeta["fireball"], "fireball", "fireball", pos, "", Vector3.new(0, -60, 0), {drawDurationSeconds = 1})
							bedwars.ClientHandler:Get(bedwars.ProjectileRemote):CallServerAsync(item["tool"], "fireball", "fireball", pos, pos, Vector3.new(0, -60, 0), game:GetService("HttpService"):GenerateGUID(true), {drawDurationSeconds = 1}, workspace:GetServerTimeNow() - 0.045)
						else
							task.wait(0.25)
						end
					end
				end
			end)
		end
	end,
})
Fireball_range = Fireball_Aura.CreateSlider({
	Name = "fireball range",
	Min = 1,
	Max = 1000,
	Function = function(val) end, 
	Default = 1000,
})
local GuiLibrary = shared.GuiLibrary
local plrs = game.Players:GetPlayers()
local hps_detected = {}
local detected = {}
local lplr = game.Players.LocalPlayer
local setcallback = {}
local hpsset = {}
local InfFlyD = {["Enabled"] = false,}
function char(v)
	repeat task.wait() until v.Character
	v.Character:WaitForChild("Humanoid").Changed:Connect(function ()
		if v.Character:WaitForChild("Humanoid").Health ~= 100 then
			if not hpsset[v.Name] then
				hpsset[v.Name] = v.Character.Humanoid.Health
			end
			if hps_detected[v.Name] then
				if not setcallback[v.Name] then setcallback[v.Name] = {} end
				if hpsset[v.Name] >= v.Character.Humanoid.Health then
					setcallback[v.Name][#setcallback[v.Name] + 1] = true;
					hpsset[v.Name] = v.Character.Humanoid.Health
				end
				return
			end
			hps_detected[v.Name] = true;
			task.wait(0.25)
			local number = # (setcallback[v.Name] or {})
			repeat task.wait()
				for i,z in pairs(setcallback[v.Name] or {}) do
					task.wait(0.25)
					table.remove(setcallback[v.Name],i)
				end
			until # (setcallback[v.Name] or {}) == 0
			task.wait(0.1)
			hps_detected[v.Name] = false;
		end
	end)
	local old
	local my;
	my = v.Character.Humanoid.Died:Connect(function()
		repeat task.wait()
			old = nil
			task.wait()
		until old == nil
		my:Disconnect()
	end)
	local check;--,check2
	local telepearlon = false
	-- check = v.Character.DescendantAdded:Connect(function(telepearl)
	--     if telepearl.Name == "telepearl" then
	--         telepearlon = true;
	--     end
	-- end)
	-- check2 = v.Character.DescendantRemoving:Connect(function(telepearl)
	--     if telepearl.Name == "telepearl" then
	--         telepearlon = false;
	--     end
	-- end)
	v:GetAttributeChangedSignal("LastTeleported"):Connect(function()
		if (workspace:GetServerTimeNow() - lplr:GetAttribute("LastTeleported")) < 3 then
			telepearlon = true
			task.wait(2)
			telepearlon = false;
		end
	end)
	while task.wait(0.1) do
		repeat task.wait() until v.Character
		-- local root = v.Character:WaitForChild("HumanoidRootPart")
		-- local total = (root.Velocity.X < 0 and -root.Velocity.X or root.Velocity.X) + (root.Velocity.Z < 0 and -root.Velocity.Z or root.Velocity.Z)
		-- local a = (root.Position.Y < 0 and -root.Position.Y or root.Position.Y) * (root.Parent.Humanoid.MoveDirection.Y == 0 and 1 or root.Parent.Humanoid.MoveDirection.Y + 1)
		-- if (total > (a + ((total * .5)) or root:FindFirstChild("BodyVelocity"))
		-- 	and (detected[v.Name] == false or detected[v.Name] == nil) and (not hps_detected[v.Name])-- and v ~= lplr
		-- 	and root.Position.Y <= 300) then
		-- 	detected[v.Name] = true;
		-- 	createwarning("DNut Private","Vxpe User Detected : (Fly/Speed) "..v.Name,60)
		-- 	shared.clients.ClientUsers[v.Name] = "VAPE USER"
		-- 	break
		-- end
		local root = v.Character:WaitForChild("HumanoidRootPart")
		if old then
			local pos = root.Position
			local x,y,z = (pos.X < 0 and -pos.X or pos.X),(pos.Y < 0 and -pos.Y or pos.Y),(pos.Z < 0 and -pos.Z or pos.Z)
			local ox,oy,oz = (old.X < 0 and -old.X or old.X),(old.Y < 0 and -old.Y or old.Y),(old.Z < 0 and -old.Z or old.Z)
			local hecker
			if ox + (v.Character.Humanoid.WalkSpeed * 0.8) < x then
				hecker = true
				-- elseif oy + (v.Character.Humanoid.WalkSpeed * 0.625) < y then
				-- 	hecker = true
			elseif oz + (v.Character.Humanoid.WalkSpeed * 0.8) < z then
				hecker = true
			end
			if hecker and not detected[v.Name] and v ~= game.Players.LocalPlayer
				and bedwarsStore.matchState ~= 0 and not bedwarsStore.secs and not telepearlon
				and not hps_detected[v.Name]  then
				detected[v.Name] = true;
				task.wait(0.1)
				--if telepearlon then continue end
				if telepearlon or not (game.Players.LocalPlayer.Character and game.Players.LocalPlayer:FindFirstChild("HumanoidRootPart")) then
				else
					createwarning("Vape", v.Name.." is using vape!",60)
					shared.clients.ClientUsers[v.Name] = "VAPE USER"
					break
				end
			end
			if InfFlyD.Enabled and y > 2000 then
				createwarning("Vape", v.Name.." is using vape!",60)
				shared.clients.ClientUsers[v.Name] = "VAPE USER"
				break
			end 
			if v == game.Players.LocalPlayer then break end
		end
		old = root.Position
	end
end
local Detection;Detection = GuiLibrary.ObjectsThatCanBeSaved.WorldWindow.Api.CreateOptionsButton({
	Name = "VapeUserDetector",
	Function = function (enabled)
		if enabled then
			task.spawn(function()
				for i,v in pairs(plrs) do
					task.spawn(function ()
						char(v)
					end)
					task.spawn(function ()
						v.CharacterAdded:Connect(function ()
							task.wait(5)
							char(v)
						end)
					end)
				end
				game.Players.PlayerAdded:Connect(function(v)
					task.wait(5)
					char(v)
				end)
			end)
		end
	end,
})
InfFlyD = Detection.CreateToggle({
	Name = "inf fly check hhahhhahahahahfuaah",
	Function = function() end,
})
local function getSword()
	local bestSword, bestSwordSlot, bestSwordDamage = nil, nil, 0
	for slot, item in pairs(bedwarsStore.localInventory.inventory.items) do
		local swordMeta = bedwars.ItemTable[item.itemType].sword
		if swordMeta then
			local swordDamage = swordMeta.damage or 0
			if swordDamage > bestSwordDamage then
				bestSword, bestSwordSlot, bestSwordDamage = item, slot, swordDamage
			end
		end
	end
	return bestSword, bestSwordSlot
end
runcode(function()
	local killauramonstertoggle = {["Enabled"] = false,}
	local killauraboxes = {}
	local killauratargetframe = {Players = {Enabled = false}}
	local killaurasortmethod = {Value = "Distance"}
	local killaurarealremote = bedwars.ClientHandler:Get(bedwars.AttackRemote).instance
	local killauramethod = {Value = "Normal"}
	local killauraothermethod = {Value = "Normal"}
	local killauraanimmethod = {Value = "Normal"}
	local killaurarange = {Value = 14}
	local killauraangle = {Value = 360}
	local killauratargets = {Value = 10}
	local killauramouse = {Enabled = false}
	local killauracframe = {Enabled = false}
	local killauragui = {Enabled = false}
	local killauratarget = {Enabled = false}
	local killaurasound = {Enabled = false}
	local killauraswing = {Enabled = false}
	local killaurasync = {Enabled = false}
	local killaurahandcheck = {Enabled = false}
	local killaurabaguette = {Enabled = false}
	local killauraanimation = {Enabled = false}
	local killauracolor = {Value = 0.44}
	local killauranovape = {Enabled = false}
	local killauratargethighlight = {Enabled = false}
	local killaurarangecircle = {Enabled = false}
	local killaurarangecirclepart
	local killauraaimcircle = {Enabled = false}
	local killauraaimcirclepart
	local killauraparticle = {Enabled = false}
	local killauraprediction = {Enabled = false}
	local killauraparticlepart
	local Killauranear = false
	local killauraplaying = false
	local oldViewmodelAnimation = function() end
	local oldPlaySound = function() end
	local originalArmC0 = nil
	local killauracurrentanim
	local animationdelay = tick()

	local function getStrength(plr)
		local inv = bedwarsStore.inventories[plr.Player]
		local strength = 0
		local strongestsword = 0
		if inv then
			for i,v in pairs(inv.items) do 
				local itemmeta = bedwars.ItemTable[v.itemType]
				if itemmeta and itemmeta.sword and itemmeta.sword.damage > strongestsword then 
					strongestsword = itemmeta.sword.damage / 100
				end	
			end
			strength = strength + strongestsword
			for i,v in pairs(inv.armor) do 
				local itemmeta = bedwars.ItemTable[v.itemType]
				if itemmeta and itemmeta.armor then 
					strength = strength + (itemmeta.armor.damageReductionMultiplier or 0)
				end
			end
			strength = strength
		end
		return strength
	end

	local killaurasortmethods = {
		Distance = function(a, b)
			return (a.RootPart.Position - entityLibrary.character.HumanoidRootPart.Position).Magnitude < (b.RootPart.Position - entityLibrary.character.HumanoidRootPart.Position).Magnitude
		end,
		Health = function(a, b) 
			return a.Humanoid.Health < b.Humanoid.Health
		end,
		Threat = function(a, b) 
			return getStrength(a) > getStrength(b)
		end,
	}

	local originalNeckC0
	local originalRootC0
	local anims = {
		Normal = {
			{CFrame = CFrame.new(0.69, -0.7, 0.6) * CFrame.Angles(math.rad(295), math.rad(55), math.rad(290)), Time = 0.05},
			{CFrame = CFrame.new(0.69, -0.71, 0.6) * CFrame.Angles(math.rad(200), math.rad(60), math.rad(1)), Time = 0.05}
		},
		["fdp slow"] = {
			{CFrame = CFrame.new(0.69, -0.7, 0.6) * CFrame.Angles(math.rad(295), math.rad(55), math.rad(290)), Time = 0.90},
			{CFrame = CFrame.new(0.69, -0.71, 0.6) * CFrame.Angles(math.rad(200), math.rad(60), math.rad(1)), Time = 0.50}
		},
		["swong"] = {
			{CFrame = CFrame.new(0, 0, -0.6) * CFrame.Angles(math.rad(-60), math.rad(50), math.rad(-70)), Time = 0.1, RealDelay = 0.1},
			{CFrame = CFrame.new(0, -0.3, -0.6) * CFrame.Angles(math.rad(-160), math.rad(60), math.rad(10)), Time = 0.2, RealDelay = 0.2}
		},
		["Blochit"] = {
			{CFrame = CFrame.new(0.7, -0.7, 0.6) * CFrame.Angles(math.rad(-60), math.rad(60), math.rad(-70)), Time = 0.15, RealDelay = 0.15},
			{CFrame = CFrame.new(0.5, -0.7, -0.2) * CFrame.Angles(math.rad(-120), math.rad(60), math.rad(-50)), Time = 0.15, RealDelay = 0.15}
		},
		["push"] = {
			{CFrame = CFrame.new(0.2, -0.7, 0) * CFrame.Angles(math.rad(-16), math.rad(60), math.rad(-80)), Time = 0.2, RealDelay = 0.2},
			{CFrame = CFrame.new(0.2, -1, 0) * CFrame.Angles(math.rad(23), math.rad(67), math.rad(-111)), Time = 0.35, RealDelay = 0.35}
		},
		["rise"] = {
			{CFrame = CFrame.new(0.9, 0, 0) * CFrame.Angles(math.rad(-80), math.rad(60), math.rad(-40)), Time = 0.14, RealDelay = 0.14},
			{CFrame = CFrame.new(0.5, -0.2, -0.7) * CFrame.Angles(math.rad(-150), math.rad(55), math.rad(20)), Time = 0.14, RealDelay = 0.14}			
		},
		["mine (rel)"] = {
			{CFrame = CFrame.new(0.8, -0.7, 0.6) * CFrame.Angles(math.rad(-40), math.rad(65), math.rad(-90)), Time = 0.15},
			{CFrame = CFrame.new(0.8, -0.92, 0.9) * CFrame.Angles(math.rad(-40), math.rad(65), math.rad(-90)), Time = 0.3},
			{CFrame = CFrame.new(0.8, -0.7, 0.6) * CFrame.Angles(math.rad(-40), math.rad(65), math.rad(-90)), Time = 0.15}
			
		},
		["jab"] = {
			{CFrame = CFrame.new(0.8, -0.7, 0.6) * CFrame.Angles(math.rad(-40), math.rad(65), math.rad(-90)), Time = 0.15},
			{CFrame = CFrame.new(0.6, -0.6, 0.5) * CFrame.Angles(math.rad(-45), math.rad(50), math.rad(-105)), Time = 0.1},	
		},
		["drop2"] = {
			{CFrame = CFrame.new(0.8, -0.7, 0.6) * CFrame.Angles(math.rad(-40), math.rad(65), math.rad(-90)), Time = 0.15},
			{CFrame = CFrame.new(0.6, -0.6, 0.5) * CFrame.Angles(math.rad(-45), math.rad(50), math.rad(-105)), Time = 0.1},	
		},
		["odd"] = {
			{CFrame = CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0)), Time = 0.15},
			{CFrame = CFrame.new(0.03, 0.07, -0.07) * CFrame.Angles(math.rad(-20), math.rad(-2), math.rad(-8)), Time = 0.15},
		},
		["lqbounce"] = {
			{CFrame = CFrame.new(0, 0, -1) * CFrame.Angles(math.rad(-40), math.rad(60), math.rad(-80)), Time = 0.17},
			{CFrame = CFrame.new(0, 0, -1) * CFrame.Angles(math.rad(-60), math.rad(60), math.rad(-80)), Time = 0.17},
		},
		["sigma2"] = {
			{CFrame = CFrame.new(0.2, 0, -1.3) * CFrame.Angles(math.rad(111), math.rad(111), math.rad(130)), Time = 0.18},
			{CFrame = CFrame.new(0, -0.2, -1.7) * CFrame.Angles(math.rad(30), math.rad(111), math.rad(190)), Time = 0.18},	
		},
		["sigma"] = {
			{CFrame = CFrame.new(0.3, -0.8, -1.3) * CFrame.Angles(math.rad(160), math.rad(84), math.rad(90)), Time = 0.18},
			{CFrame = CFrame.new(0.3, -0.9, -1.17) * CFrame.Angles(math.rad(160), math.rad(70), math.rad(90)), Time = 0.18},
			{CFrame = CFrame.new(0.4, -0.65, -0.8) * CFrame.Angles(math.rad(160), math.rad(111), math.rad(90)), Time = 0.18},
		},
		["sus"] = {
			{CFrame = CFrame.new(2, -2.5, 0.2) * CFrame.Angles(math.rad(268), math.rad(54), math.rad(327)), Time = 0.17},
			{CFrame = CFrame.new(1.6, -2.5, 0.2) * CFrame.Angles(math.rad(189), math.rad(52), math.rad(347)), Time = 0.16}															
		},
		["VAPE OLD"] = {
			{CFrame = CFrame.new(0.69, -0.77, 1.47) * CFrame.Angles(math.rad(-33), math.rad(57), math.rad(-81)), Time = 0.07, Size = 2},
			{CFrame = CFrame.new(0.69, -0.77, 1.47) * CFrame.Angles(math.rad(-33), math.rad(90), math.rad(-81)), Time = 0.06, Size = 5},
		}
	}

	local listautohehe = {}
	for i,_ in pairs(anims) do
		table.insert(listautohehe,i)
	end
	local function closestpos(block, pos)
		local blockpos = block:GetRenderCFrame()
		local startpos = (blockpos * CFrame.new(-(block.Size / 2))).p
		local endpos = (blockpos * CFrame.new((block.Size / 2))).p
		local speedCFrame = block.Position + (pos - block.Position)
		local x = startpos.X > endpos.X and endpos.X or startpos.X
		local y = startpos.Y > endpos.Y and endpos.Y or startpos.Y
		local z = startpos.Z > endpos.Z and endpos.Z or startpos.Z
		local x2 = startpos.X < endpos.X and endpos.X or startpos.X
		local y2 = startpos.Y < endpos.Y and endpos.Y or startpos.Y
		local z2 = startpos.Z < endpos.Z and endpos.Z or startpos.Z
		return Vector3.new(math.clamp(speedCFrame.X, x, x2), math.clamp(speedCFrame.Y, y, y2), math.clamp(speedCFrame.Z, z, z2))
	end

	local function getAttackData()
		if GuiLibrary.ObjectsThatCanBeSaved["Lobby CheckToggle"].Api.Enabled then 
			if bedwarsStore.matchState == 0 then return false end
		end
		if killauramouse.Enabled then
			if not inputService:IsMouseButtonPressed(0) then return false end
		end
		if killauragui.Enabled then
			if #bedwars.AppController:getOpenApps() > (bedwarsStore.equippedKit == "hannah" and 4 or 3) then return false end
		end
		local sword = killaurahandcheck.Enabled and bedwarsStore.localHand or getSword()
		if not sword or not sword.tool then return false end
		local swordmeta = bedwars.ItemTable[sword.tool.Name]
		if killaurahandcheck.Enabled then
			if bedwarsStore.localHand.Type ~= "sword" or bedwars.KatanaController.chargingMaid then return false end
		end
		return sword, swordmeta
	end
	local killauraNearPlayer
	local Killaura;
	Killaura = GuiLibrary.ObjectsThatCanBeSaved.BlatantWindow.Api.CreateOptionsButton({
		Name = "KillAuraV2",
		Function = function(callback)
			if callback then
				if killauraaimcirclepart then killauraaimcirclepart.Parent = gameCamera end
				if killaurarangecirclepart then killaurarangecirclepart.Parent = gameCamera end
				if killauraparticlepart then killauraparticlepart.Parent = gameCamera end

				task.spawn(function()
					repeat
						task.wait()
						if (killauraanimation.Enabled and not killauraswing.Enabled) then
							if killauraNearPlayer then
								pcall(function()
									if originalArmC0 == nil then
										originalArmC0 = gameCamera.Viewmodel.RightHand.RightWrist.C0
									end
									if killauraplaying == false then
										killauraplaying = true
										for i,v in pairs(anims[killauraanimmethod.Value]) do 
											if (not Killaura.Enabled) or (not killauraNearPlayer) then break end
											killauracurrentanim = tweenService:Create(gameCamera.Viewmodel.RightHand.RightWrist, TweenInfo.new(v.Time), {C0 = originalArmC0 * v.CFrame})
											killauracurrentanim:Play()
											task.wait(v.Time - 0.01)
										end
										killauraplaying = false
									end
								end)	
							end
						end
					until Killaura.Enabled == false
				end)

				oldViewmodelAnimation = bedwars.ViewmodelController.playAnimation
				oldPlaySound = bedwars.SoundManager.playSound
				bedwars.SoundManager.playSound = function(tab, soundid, ...)
					if (soundid == bedwars.SoundList.SWORD_SWING_1 or soundid == bedwars.SoundList.SWORD_SWING_2) and Killaura.Enabled and killaurasound.Enabled and killauraNearPlayer then
						return nil
					end
					return oldPlaySound(tab, soundid, ...)
				end
				bedwars.ViewmodelController.playAnimation = function(Self, id, ...)
					if id == 15 and killauraNearPlayer and killauraswing.Enabled and entityLibrary.isAlive then
						return nil
					end
					if id == 15 and killauraNearPlayer and killauraanimation.Enabled and entityLibrary.isAlive then
						return nil
					end
					return oldViewmodelAnimation(Self, id, ...)
				end

				local targetedPlayer
				RunLoops:BindToHeartbeat("CustomKillauraDNutPrivate", function()
					for i,v in pairs(killauraboxes) do 
						if v:IsA("BoxHandleAdornment") and v.Adornee then
							local cf = v.Adornee and v.Adornee.CFrame
							local onex, oney, onez = cf:ToEulerAnglesXYZ() 
							v.CFrame = CFrame.new() * CFrame.Angles(-onex, -oney, -onez)
						end
					end
					if entityLibrary.isAlive then
						if killauraaimcirclepart then 
							killauraaimcirclepart.Position = targetedPlayer and closestpos(targetedPlayer.RootPart, entityLibrary.character.HumanoidRootPart.Position) or Vector3.new(99999, 99999, 99999)
						end
						if killauraparticlepart then 
							killauraparticlepart.Position = targetedPlayer and targetedPlayer.RootPart.Position or Vector3.new(99999, 99999, 99999)
						end
						local Root = entityLibrary.character.HumanoidRootPart
						if Root then
							if killaurarangecirclepart then 
								killaurarangecirclepart.Position = Root.Position - Vector3.new(0, entityLibrary.character.Humanoid.HipHeight, 0)
							end
							local Neck = entityLibrary.character.Head:FindFirstChild("Neck")
							local LowerTorso = Root.Parent and Root.Parent:FindFirstChild("LowerTorso")
							local RootC0 = LowerTorso and LowerTorso:FindFirstChild("Root")
							if Neck and RootC0 then
								if originalNeckC0 == nil then
									originalNeckC0 = Neck.C0.p
								end
								if originalRootC0 == nil then
									originalRootC0 = RootC0.C0.p
								end
								if originalRootC0 and killauracframe.Enabled then
									if targetedPlayer ~= nil then
										local targetPos = targetedPlayer.RootPart.Position + Vector3.new(0, 2, 0)
										local direction = (Vector3.new(targetPos.X, targetPos.Y, targetPos.Z) - entityLibrary.character.Head.Position).Unit
										local direction2 = (Vector3.new(targetPos.X, Root.Position.Y, targetPos.Z) - Root.Position).Unit
										local lookCFrame = (CFrame.new(Vector3.zero, (Root.CFrame):VectorToObjectSpace(direction)))
										local lookCFrame2 = (CFrame.new(Vector3.zero, (Root.CFrame):VectorToObjectSpace(direction2)))
										Neck.C0 = CFrame.new(originalNeckC0) * CFrame.Angles(lookCFrame.LookVector.Unit.y, 0, 0)
										RootC0.C0 = lookCFrame2 + originalRootC0
									else
										Neck.C0 = CFrame.new(originalNeckC0)
										RootC0.C0 = CFrame.new(originalRootC0)
									end
								end
							end
						end
					end
				end)

				task.spawn(function()
					repeat
						task.wait()
						if not Killaura.Enabled then break end
						vapeTargetInfo.Targets.Killaura = nil
						local plrs = AllNearPosition(killaurarange.Value, 1, killaurasortmethods[killaurasortmethod.Value], killauraprediction.Enabled,(killauramonstertoggle or {["Enabled"] = true,}).Enabled)
						local attackedplayers = {}
						local firstPlayerNear
						if #plrs > 0 then
							local sword, swordmeta = getAttackData()
							if sword then
								for i, plr in pairs(plrs) do
									local root = plr.RootPart
									if not root then 
									else
										local localfacing = entityLibrary.character.HumanoidRootPart.CFrame.lookVector
										local vec = (plr.RootPart.Position - entityLibrary.character.HumanoidRootPart.Position).unit
										local angle = math.acos(localfacing:Dot(vec))
										if angle >= (math.rad(killauraangle.Value) / 2) then
										else
											local selfrootpos = entityLibrary.character.HumanoidRootPart.Position
											local selfcheck = entityLibrary.LocalPosition or selfrootpos
											if killauratargetframe.Walls.Enabled then
												if not bedwars.SwordController:canSee({player = plr.Player, getInstance = function() return plr.Character end}) then 
												else
													if not firstPlayerNear then 
														firstPlayerNear = true 
														killauraNearPlayer = true
														targetedPlayer = plr
														vapeTargetInfo.Targets.Killaura = {
															Humanoid = {
																Health = (plr.Character:GetAttribute("Health") or plr.Humanoid.Health) + getShieldAttribute(plr.Character),
																MaxHealth = plr.Character:GetAttribute("MaxHealth") or plr.Humanoid.MaxHealth
															},
															Player = plr.Player
														}
														if not killaurasync.Enabled then 
															if animationdelay <= tick() then
																animationdelay = tick() + 0.19
																if not killauraswing.Enabled then 
																	bedwars.SwordController:playSwordEffect(swordmeta)
																end
															end
														end
													end
													if killauratarget.Enabled then
														table.insert(attackedplayers, plr)
													end
													-- if (selfcheck - (entityLibrary.OtherPosition[plr.Player] or root.Position)).Magnitude >= 18 then 
													-- 	continue
													-- end
													if (workspace:GetServerTimeNow() - bedwars.SwordController.lastAttack) < swordmeta.sword.attackSpeed then 
													else
														local selfpos = selfrootpos + (killaurarange.Value > 14 and (selfrootpos - root.Position).magnitude > 14 and (CFrame.lookAt(selfrootpos, root.Position).lookVector * 4) or Vector3.zero)
														bedwars.SwordController.lastAttack = workspace:GetServerTimeNow() + (bedwarsStore.zephyrOrb ~= 0 and 0.2 or (killaurasync.Enabled and 0.11 or -0.11))
														if killaurasync.Enabled then 
															if animationdelay <= tick() then
																animationdelay = tick() + 0.19
																if not killauraswing.Enabled then 
																	bedwars.SwordController:playSwordEffect(swordmeta)
																end
															end
														end
														killaurarealremote:FireServer({
															weapon = sword.tool,
															chargedAttack = {chargeRatio = swordmeta.sword and swordmeta.sword.chargedAttack and swordmeta.sword.chargedAttack.maxChargeTimeSec or 0},
															entityInstance = plr.Character,
															validate = {
																raycast = {
																	cameraPosition = attackValue(gameCamera.CFrame.p), 
																	cursorDirection = attackValue(Ray.new(gameCamera.CFrame.p, root.Position).Unit.Direction)
																},
																targetPosition = attackValue(root.Position),
																selfPosition = attackValue(selfpos)
															}
														})
														break
													end
												end
											else
												if not firstPlayerNear then 
													firstPlayerNear = true 
													killauraNearPlayer = true
													targetedPlayer = plr
													vapeTargetInfo.Targets.Killaura = {
														Humanoid = {
															Health = (plr.Character:GetAttribute("Health") or plr.Humanoid.Health) + getShieldAttribute(plr.Character),
															MaxHealth = plr.Character:GetAttribute("MaxHealth") or plr.Humanoid.MaxHealth
														},
														Player = plr.Player
													}
													if not killaurasync.Enabled then 
														if animationdelay <= tick() then
															animationdelay = tick() + 0.19
															if not killauraswing.Enabled then 
																bedwars.SwordController:playSwordEffect(swordmeta)
															end
														end
													end
												end
												if killauratarget.Enabled then
													table.insert(attackedplayers, plr)
												end
												-- if (selfcheck - (entityLibrary.OtherPosition[plr.Player] or root.Position)).Magnitude >= 18 then 
												-- 	continue
												-- end
												if (workspace:GetServerTimeNow() - bedwars.SwordController.lastAttack) < swordmeta.sword.attackSpeed then 
												else
													local selfpos = selfrootpos + (killaurarange.Value > 14 and (selfrootpos - root.Position).magnitude > 14 and (CFrame.lookAt(selfrootpos, root.Position).lookVector * 4) or Vector3.zero)
													bedwars.SwordController.lastAttack = workspace:GetServerTimeNow() + (bedwarsStore.zephyrOrb ~= 0 and 0.2 or (killaurasync.Enabled and 0.11 or -0.11))
													if killaurasync.Enabled then 
														if animationdelay <= tick() then
															animationdelay = tick() + 0.19
															if not killauraswing.Enabled then 
																bedwars.SwordController:playSwordEffect(swordmeta)
															end
														end
													end
													killaurarealremote:FireServer({
														weapon = sword.tool,
														chargedAttack = {chargeRatio = swordmeta.sword and swordmeta.sword.chargedAttack and swordmeta.sword.chargedAttack.maxChargeTimeSec or 0},
														entityInstance = plr.Character,
														validate = {
															raycast = {
																cameraPosition = attackValue(gameCamera.CFrame.p), 
																cursorDirection = attackValue(Ray.new(gameCamera.CFrame.p, root.Position).Unit.Direction)
															},
															targetPosition = attackValue(root.Position),
															selfPosition = attackValue(selfpos)
														}
													})
													break
												end
											end
										end
									end
								end
							end
						end
						if not firstPlayerNear then 
							targetedPlayer = nil
							killauraNearPlayer = false
							pcall(function()
								if originalArmC0 == nil then
									originalArmC0 = gameCamera.Viewmodel.RightHand.RightWrist.C0
								end
								if gameCamera.Viewmodel.RightHand.RightWrist.C0 ~= originalArmC0 then
									pcall(function()
										killauracurrentanim:Cancel()
									end)
									killauracurrentanim = tweenService:Create(gameCamera.Viewmodel.RightHand.RightWrist, TweenInfo.new(0.1), {C0 = originalArmC0})
									killauracurrentanim:Play()
								end
							end)
						end
						for i,v in pairs(killauraboxes) do 
							local attacked = attackedplayers[i]
							v.Adornee = attacked and ((not killauratargethighlight.Enabled) and attacked.RootPart or (not GuiLibrary.ObjectsThatCanBeSaved.ChamsOptionsButton.Api.Enabled) and attacked.Character or nil)
						end
					until (not Killaura.Enabled)
				end)
			else
				vapeTargetInfo.Targets.Killaura = nil
				RunLoops:UnbindFromHeartbeat("CustomKillauraDNutPrivate") 
				killauraNearPlayer = false
				for i,v in pairs(killauraboxes) do v.Adornee = nil end
				if killauraaimcirclepart then killauraaimcirclepart.Parent = nil end
				if killaurarangecirclepart then killaurarangecirclepart.Parent = nil end
				if killauraparticlepart then killauraparticlepart.Parent = nil end
				bedwars.ViewmodelController.playAnimation = oldViewmodelAnimation
				bedwars.SoundManager.playSound = oldPlaySound
				oldViewmodelAnimation = nil
				pcall(function()
					if entityLibrary.isAlive then
						local Root = entityLibrary.character.HumanoidRootPart
						if Root then
							local Neck = Root.Parent.Head.Neck
							if originalNeckC0 and originalRootC0 then 
								Neck.C0 = CFrame.new(originalNeckC0)
								Root.Parent.LowerTorso.Root.C0 = CFrame.new(originalRootC0)
							end
						end
					end
					if originalArmC0 == nil then
						originalArmC0 = gameCamera.Viewmodel.RightHand.RightWrist.C0
					end
					if gameCamera.Viewmodel.RightHand.RightWrist.C0 ~= originalArmC0 then
						pcall(function()
							killauracurrentanim:Cancel()
						end)
						killauracurrentanim = tweenService:Create(gameCamera.Viewmodel.RightHand.RightWrist, TweenInfo.new(0.1), {C0 = originalArmC0})
						killauracurrentanim:Play()
					end
				end)
			end
		end,
		HoverText = "best aura"
	})
	killauratargetframe = Killaura.CreateTargetWindow({})
	local sortmethods = {"Distance"}
	for i,v in pairs(killaurasortmethods) do if i ~= "Distance" then table.insert(sortmethods, i) end end
	killaurasortmethod = Killaura.CreateDropdown({
		Name = "Sort",
		Function = function() end,
		List = sortmethods
	})
	killaurarange = Killaura.CreateSlider({
		Name = "Attack range",
		Min = 1,
		Max = 18,
		Function = function(val) 
			if killaurarangecirclepart then 
				killaurarangecirclepart.Size = Vector3.new(val * 0.7, 0.01, val * 0.7)
			end
		end, 
		Default = 18
	})
	killauraangle = Killaura.CreateSlider({
		Name = "Max angle",
		Min = 1,
		Max = 360,
		Function = function(val) end,
		Default = 360
	})
	killauraanimmethod = Killaura.CreateDropdown({
		Name = "Animation", 
		List = listautohehe,
		Function = function(val)
			if val == "Stab" then
				StabPos.Object.Visible = true
			else
				StabPos.Enabled = false;
				StabPos.Object.Visible = false;
			end
		end
	})
	StabPos = Killaura.CreateToggle({
		Name = "Stab Position",
		Function = function() end,
		HoverText = "Stab position(only for stab anim)",
		Default = false
	})
	StabPos.Object.Visible = false
	killauramouse = Killaura.CreateToggle({
		Name = "Require mouse down",
		Function = function() end,
		HoverText = "Only attacks when left click is held.",
		Default = false
	})
	killauramonstertoggle = Killaura.CreateToggle({
		Name = "Toggle bots to be attacked",
		Function = function() end,
		HoverText = "It explains itself.",
		Default = true
	})
	killauragui = Killaura.CreateToggle({
		Name = "GUI Check",
		Function = function() end,
		HoverText = "Attacks when you are not in a GUI."
	})
	killauratarget = Killaura.CreateToggle({
		Name = "Show target",
		Function = function(callback) 
			if killauratargethighlight.Object then 
				killauratargethighlight.Object.Visible = callback
			end
		end,
		HoverText = "Shows a red box over the opponent."
	})
	killauratargethighlight = Killaura.CreateToggle({
		Name = "Use New Highlight",
		Function = function(callback) 
			for i,v in pairs(killauraboxes) do 
				v:Remove()
			end
			for i = 1, 10 do 
				local killaurabox
				if callback then 
					killaurabox = Instance.new("Highlight")
					killaurabox.FillTransparency = 0.5
					killaurabox.FillColor = Color3.fromHSV(killauracolor["Hue"], killauracolor["Sat"], killauracolor.Value)
					killaurabox.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
					killaurabox.OutlineTransparency = 1
					killaurabox.Parent = GuiLibrary.MainGui
				else
					killaurabox = Instance.new("BoxHandleAdornment")
					killaurabox.Transparency = 0.5
					killaurabox.Color3 = Color3.fromHSV(killauracolor["Hue"], killauracolor["Sat"], killauracolor.Value)
					killaurabox.Adornee = nil
					killaurabox.AlwaysOnTop = true
					killaurabox.Size = Vector3.new(3, 6, 3)
					killaurabox.ZIndex = 11
					killaurabox.Parent = GuiLibrary.MainGui
				end
				killauraboxes[i] = killaurabox
			end
		end
	})
	killauratargethighlight.Object.BorderSizePixel = 0
	killauratargethighlight.Object.BackgroundTransparency = 0
	killauratargethighlight.Object.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
	killauratargethighlight.Object.Visible = false
	killauracolor = Killaura.CreateColorSlider({
		Name = "Target Color",
		Function = function(hue, sat, val) 
			for i,v in pairs(killauraboxes) do 
				v[(killauratargethighlight.Enabled and "FillColor" or "Color3")] = Color3.fromHSV(hue, sat, val)
			end
			if killauraaimcirclepart then 
				killauraaimcirclepart.Color = Color3.fromHSV(hue, sat, val)
			end
			if killaurarangecirclepart then 
				killaurarangecirclepart.Color = Color3.fromHSV(hue, sat, val)
			end
		end,
		Default = 1
	})
	for i = 1, 10 do 
		local killaurabox = Instance.new("BoxHandleAdornment")
		killaurabox.Transparency = 0.5
		killaurabox.Color3 = Color3.fromHSV(killauracolor["Hue"], killauracolor["Sat"], killauracolor.Value)
		killaurabox.Adornee = nil
		killaurabox.AlwaysOnTop = true
		killaurabox.Size = Vector3.new(3, 6, 3)
		killaurabox.ZIndex = 11
		killaurabox.Parent = GuiLibrary.MainGui
		killauraboxes[i] = killaurabox
	end
	killauracframe = Killaura.CreateToggle({
		Name = "Face target",
		Function = function() end,
		HoverText = "Makes your character face the opponent."
	})
	killaurarangecircle = Killaura.CreateToggle({
		Name = "Range Visualizer",
		Function = function(callback)
			if callback then 
				killaurarangecirclepart = Instance.new("MeshPart")
				killaurarangecirclepart.MeshId = "rbxassetid://3726303797"
				killaurarangecirclepart.Color = Color3.fromHSV(killauracolor["Hue"], killauracolor["Sat"], killauracolor.Value)
				killaurarangecirclepart.CanCollide = false
				killaurarangecirclepart.Anchored = true
				killaurarangecirclepart.Material = Enum.Material.Neon
				killaurarangecirclepart.Size = Vector3.new(killaurarange.Value * 0.7, 0.01, killaurarange.Value * 0.7)
				killaurarangecirclepart.Parent = cam
				bedwars.QueryUtil:setQueryIgnored(killaurarangecirclepart, true)
			else
				if killaurarangecirclepart then 
					killaurarangecirclepart:Destroy()
					killaurarangecirclepart = nil
				end
			end
		end
	})
	killauraaimcircle = Killaura.CreateToggle({
		Name = "Aim Visualizer",
		Function = function(callback)
			if callback then 
				killauraaimcirclepart = Instance.new("Part")
				killauraaimcirclepart.Shape = Enum.PartType.Ball
				killauraaimcirclepart.Color = Color3.fromHSV(killauracolor["Hue"], killauracolor["Sat"], killauracolor.Value)
				killauraaimcirclepart.CanCollide = false
				killauraaimcirclepart.Anchored = true
				killauraaimcirclepart.Material = Enum.Material.Neon
				killauraaimcirclepart.Size = Vector3.new(0.5, 0.5, 0.5)
				killauraaimcirclepart.Parent = cam
				bedwars.QueryUtil:setQueryIgnored(killauraaimcirclepart, true)
			else
				if killauraaimcirclepart then 
					killauraaimcirclepart:Destroy()
					killauraaimcirclepart = nil
				end
			end
		end
	})
	killauraparticle = Killaura.CreateToggle({
		Name = "Crit Particle",
		Function = function(callback)
			if callback then 
				killauraparticlepart = Instance.new("Part")
				killauraparticlepart.Transparency = 1
				killauraparticlepart.CanCollide = false
				killauraparticlepart.Anchored = true
				killauraparticlepart.Size = Vector3.new(3, 6, 3)
				killauraparticlepart.Parent = cam
				bedwars.QueryUtil:setQueryIgnored(killauraparticlepart, true)
				local particle = Instance.new("ParticleEmitter")
				particle.Lifetime = NumberRange.new(0.5)
				particle.Rate = 500
				particle.Speed = NumberRange.new(0)
				particle.RotSpeed = NumberRange.new(180)
				particle.Enabled = true
				particle.Size = NumberSequence.new(0.3)
				particle.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(67, 10, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 98, 255))})
				particle.Parent = killauraparticlepart
			else
				if killauraparticlepart then 
					killauraparticlepart:Destroy()
					killauraparticlepart = nil
				end
			end
		end
	})
	killaurasound = Killaura.CreateToggle({
		Name = "No Swing Sound",
		Function = function() end,
		HoverText = "Removes the swinging sound."
	})
	killauraswing = Killaura.CreateToggle({
		Name = "No Swing",
		Function = function() end,
		HoverText = "Removes the swinging animation."
	})
	killaurahandcheck = Killaura.CreateToggle({
		Name = "Limit to items",
		Function = function() end,
		HoverText = "Only attacks when your sword is held."
	})
	killaurabaguette = Killaura.CreateToggle({
		Name = "Baguette Aura",
		Function = function() end,
		HoverText = "Uses the baguette instead of the sword."
	})
	killauraanimation = Killaura.CreateToggle({
		Name = "Custom Animation",
		Function = function() end,
		HoverText = "Uses a custom animation for swinging"
	})
	killaurasync = Killaura.CreateToggle({
		Name = "Synced Animation",
		Function = function() end,
		HoverText = "Times animation with hit attempt"
	})
	killauraprediction = Killaura.CreateToggle({
		Name = "Prediction",
		Function = function() end,
		HoverText = "Cool prediction. op idk.",
	})
end)
local function cango(pos)
	if not getPlacedBlock(pos) then
		return true
	else
		return false
	end
end
local getnext = 0;
local function arrowisnear()
	local poses = {Vector3.new(3,0,0),Vector3.new(0,0,3)}
	local upposes = {Vector3.new(0,3,0),Vector3.new(0,1,0)}
	local pos = poses[getnext + 1] + upposes[getnext + 1]
	if getnext + 1 == #poses then
		getnext = 0
	else
		getnext = getnext + 1
	end
	if cango(lplr.Character.HumanoidRootPart.Position + pos) then
		lplr.Character.HumanoidRootPart.CFrame = (lplr.Character.HumanoidRootPart.CFrame
			+ pos)
	end
end
local function tweenPlay(part,time,cframe,onFinish)
	local Goal = {
		CFrame = cframe
	}
	local TweenInfo = TweenInfo.new(
		time,
		Enum.EasingStyle.Linear,
		Enum.EasingDirection.In,
		0,
		false,
		0
	)
	local Tween = game.TweenService:Create(game.Players.LocalPlayer.Character.HumanoidRootPart, TweenInfo, Goal)
	Tween:Play()
	if onFinish then
		Tween.Completed:Wait()
	end
end
runcode(function()
	bedwarsStore.blocks = collectionService:GetTagged("block")
	bedwarsStore.blockRaycast.FilterDescendantsInstances = {bedwarsStore.blocks}
	collectionService:GetInstanceAddedSignal("block"):Connect(function(block)
		table.insert(bedwarsStore.blocks, block)
		bedwarsStore.blockRaycast.FilterDescendantsInstances = {bedwarsStore.blocks}
	end)
	collectionService:GetInstanceRemovedSignal("block"):Connect(function(block)
		block = table.find(bedwarsStore.blocks, block)
		if block then 
			table.remove(bedwarsStore.blocks, block)
			bedwarsStore.blockRaycast.FilterDescendantsInstances = {bedwarsStore.blocks}
		end
	end)
end)

local OrangeHealthBar = {["Enabled"] = false}
OrangeHealthBar = GuiLibrary["ObjectsThatCanBeSaved"]["UtilityWindow"]["Api"].CreateOptionsButton({
	["Name"] = "orangehealthbar",
	["Function"] = function(callback)
		if callback then
			debug.setconstant(require(lplr.PlayerScripts.TS.controllers.global.hotbar.ui.healthbar["hotbar-healthbar"]).HotbarHealthbar.render, 16, 16753920)
		end
	end
})



local RedTexturePack = {["Enabled"] = false}
RedTexturePack = GuiLibrary["ObjectsThatCanBeSaved"]["RenderWindow"]["Api"].CreateOptionsButton({
	["Name"] = "BlackSword",
	   ["Function"] = function(Callback)
			Enabled = Callback
			if Enabled then

local function createwarning(title, text, delay)
local suc, res = pcall(function()
local frame = GuiLibrary["CreateNotification"](title, text, delay, "assets/WarningNotification.png")
frame.Frame.Frame.ImageColor3 = Color3.fromRGB(201, 126, 14)
return frame
end)
return (suc and res)
end

				Connection = cam.Viewmodel.ChildAdded:Connect(function(v)
					if v:FindFirstChild("Handle") then
						pcall(function()
							v:FindFirstChild("Handle").Size = v:FindFirstChild("Handle").Size / 1.5
							v:FindFirstChild("Handle").Material = Enum.Material.Neon
							v:FindFirstChild("Handle").TextureID = ""
							v:FindFirstChild("Handle").Color = Color3.fromRGB(Color3.fromRGB(255, 165, 0))
						end)
						local vname = string.lower(v.Name)
						if vname:find("sword") or vname:find("blade") then
							v:FindFirstChild("Handle").MeshId = "rbxassetid://11216117592"
						elseif vname:find("snowball") then
							v:FindFirstChild("Handle").MeshId = "rbxassetid://11216343798"
						end
					end
				end)
			else
				Connection:Disconnect()
			end
		end
	})


local CustomSky = {["Enabled"] = false}
CustomSky = GuiLibrary["ObjectsThatCanBeSaved"]["RenderWindow"]["Api"].CreateOptionsButton({
	["Name"] = "CustomSky",
	["Function"] = function(callback)
		if callback then
		local Lighting = game:GetService("Lighting")
Lighting.Ambient = Color3.fromRGB(111, 43, 150)
Lighting.ColorShift_Bottom = Color3.fromRGB(111, 43, 150)
Lighting.ColorShift_Top = Color3.fromRGB(111, 43, 150)
Lighting.OutdoorAmbient = Color3.fromRGB(111, 43, 150)
Lighting.ColorShift_Bottom = Color3.fromRGB(111, 43, 150)
Lighting.ColorShift_Top = Color3.fromRGB(111, 43, 150)

local s = Instance.new("Sky")
s.Name = "loltroll"
s.SkyboxBk = "http://www.roblox.com/asset/?id=627331893"
s.SkyboxDn = "http://www.roblox.com/asset/?id=627331733"
s.SkyboxFt = "http://www.roblox.com/asset/?id=627331981"
s.SkyboxLf = "http://www.roblox.com/asset/?id=627331549"
s.SkyboxRt = "http://www.roblox.com/asset/?id=627331779"
s.SkyboxUp = "http://www.roblox.com/asset/?id=627332635"
s.Parent = Lighting

			else
		createwarning("Vape", "Rejoin to reset sky.", 3)
		end
	end
})

local jumpfly = {Enabled = false}
jumpfly = GuiLibrary.ObjectsThatCanBeSaved.BlatantWindow.Api.CreateOptionsButton({
	["Name"] = "FunnyFly",
	["Function"] = function(callback)
		if callback then 
			task.spawn(function()
game.Workspace.Gravity = 24.025
repeat
lplr.Character.HumanoidRootPart.Velocity = Vector3.new(0, 5, 0)
task.wait(0.4)
until (not jumpfly.Enabled)
game.Workspace.Gravity = 196.2
			end)
		end
	end,
})

local fpsunlocker = {Enabled = false}
fpsunlocker = GuiLibrary["ObjectsThatCanBeSaved"]["WorldWindow"]["Api"].CreateOptionsButton({
   Name = "FPS Unlocker",
   Function = function(callback)
   if callback then
      setfpscap(9e9)
   else
      setfpscap(60)
   end
end
})

local PartyPopper = {Enabled = false}
PartyPopper = GuiLibrary["ObjectsThatCanBeSaved"]["RenderWindow"]["Api"].CreateOptionsButton({
	Name = "PartyPopper",
	Function = function(callback)
		if callback then 
			task.spawn(function()	
				repeat task.wait(0.3) 
				repstorage["events-@easy-games/game-core:shared/game-core-networking@getEvents.Events"].useAbility:FireServer("PARTY_POPPER")
				until (not PartyPopper.Enabled)
			end)
		end
	end
})

local DragonBreath = {Enabled = false}
DragonBreath = GuiLibrary["ObjectsThatCanBeSaved"]["RenderWindow"]["Api"].CreateOptionsButton({
	Name = "DragonBreath",
	Function = function(callback)
		if callback then 
			task.spawn(function()	
				repeat task.wait(0.3) 
repstorage:WaitForChild("rbxts_include"):WaitForChild("node_modules"):WaitForChild("@rbxts"):WaitForChild("net"):WaitForChild("out"):WaitForChild("_NetManaged"):WaitForChild("DragonBreath"):FireServer({player = lplr})
				until (not DragonBreath.Enabled)
			end)
		end
	end
})

local KillFeed = {["Enabled"] = false}
local container

KillFeed = GuiLibrary["ObjectsThatCanBeSaved"]["RenderWindow"]["Api"].CreateOptionsButton({
	["Name"] = "KillFeed",
	["HoverText"] = "Destroys the KillFeed",
	["Function"] = function(callback)
		if callback then
			task.spawn(function()
				if container == nil then
					repeat
						local suc, res = pcall(function() return lplr.PlayerGui.KillFeedGui.KillFeedContainer end)
						if suc then
							container = res
						end
						task.wait()
					until container ~= nil
				end
				container.Visible = false
			end)
		else
			if container then
				container.Visible = true
			end
		end
	end
})


local SwordHighlight = {["Enabled"] = false}
local cam = workspace.CurrentCamera
SwordHighlight = GuiLibrary["ObjectsThatCanBeSaved"]["RenderWindow"]["Api"].CreateOptionsButton({
	["Name"] = "SwordHighlight",
	["Function"] = function(callback)
		if callback then
			local TweenService = game:GetService("TweenService")
			local cam = game.Workspace.CurrentCamera -- Assuming cam is the Workspace's camera
			
			local function addHandleHighlight(handle)
				handle.Size = handle.Size / 1.5
				handle.Material = Enum.Material.Neon
				handle.TextureID = ""
				handle.Color = Color3.fromRGB(255, 165, 0)
			
				local highlight = Instance.new("Highlight")
				highlight.OutlineTransparency = 0
				highlight.Enabled = true
				highlight.Parent = handle
			
				-- Create a rainbow color sequence
				local rainbowColors = {
					Color3.fromRGB(255, 0, 0), -- Red
					Color3.fromRGB(255, 127, 0), -- Orange
					Color3.fromRGB(255, 255, 0), -- Yellow
					Color3.fromRGB(0, 255, 0), -- Green
					Color3.fromRGB(0, 0, 255), -- Blue
					Color3.fromRGB(75, 0, 130), -- Indigo
					Color3.fromRGB(148, 0, 211) -- Violet
				}
			
				local tweenInfo = TweenInfo.new(2, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, -1)
			
				local function animateRainbowColor()
					local tween = TweenService:Create(highlight, tweenInfo, {OutlineColor3 = rainbowColors})
					tween:Play()
				end
			
				animateRainbowColor()
			end
			
			local Connection
			
			local function enableHandleHighlights()
				Connection = cam.Viewmodel.ChildAdded:Connect(function(v)
					if v:FindFirstChild("Handle") then
						local handle = v:FindFirstChild("Handle")
						addHandleHighlight(handle)
					end
				end)
			end
			
			enableHandleHighlights() -- Enable handle highlights
								
			
		end
	end
})


local NoKillauraDelay = {Enabled = false}
NoKillauraDelay = GuiLibrary.ObjectsThatCanBeSaved.BlatantWindow.Api.CreateOptionsButton({
	["Name"] = "NoKillauraDelay",
	["Function"] = function(callback)
		if callback then 
			task.spawn(function()
				repeat
					task.wait(.1)
					game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("node_modules"):WaitForChild("@rbxts"):WaitForChild("net"):WaitForChild("out"):WaitForChild("_NetManaged"):WaitForChild("SwordSwingMiss"):FireServer({
						["weapon"] = game:GetService("ReplicatedStorage").Items.stone_scythe,
						["chargeRatio"] = 0.99
					})
				until not NoKillauraDelay.Enabled
			end)
		end
	end
})

local FourBigballs = {Enabled = false}
FourBigballs = GuiLibrary["ObjectsThatCanBeSaved"]["UtilityWindow"]["Api"].CreateOptionsButton({
	["Name"] = "AnticheatDisabler",
	["Function"] = function(callback)
		if callback then 
			task.spawn(function()
				repeat
					task.wait()
					game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("node_modules"):WaitForChild("@rbxts"):WaitForChild("net"):WaitForChild("out"):WaitForChild("_NetManaged"):WaitForChild("SpiritBridgeEnter"):InvokeServer({
						["partPositions"] = {},
						["partSize"] = Vector3.new(999999, .5, 9999.99999999999999999999)
					})
				until FourBigballs.Enabled
			end)
		end
	end
})
local RGBSwordOutline = {["Enabled"] = false}
local Connection
RGBSwordOutline = GuiLibrary.ObjectsThatCanBeSaved.RenderWindow.Api.CreateOptionsButton({
	Name = "SwordHighlight",
	Function = function(callback)
		if callback then 
			spawn(function()
				local cam = game.Workspace.CurrentCamera
				Connection = cam.Viewmodel.ChildAdded:Connect(function(v)
					highlight2 = Instance.new('Highlight')
					highlight2.Parent = v.Handle
					if v:FindFirstChild("Handle") then
						pcall(function()
							highlight2.FillTransparency = 1
							while wait() do
								highlight2.OutlineColor = Color3.fromHSV(tick()%5/5,1,1)
							end
						end)
					end
				end)
				spawn(function()
					repeat task.wait() until unejected == true 
					EnabledOutlines = false
					if Connection ~= nil then
						if type(Connection) == "userdata" then
							Connection:Disconnect()
							Connection = nil
						end
					end
				end)
			end)
		else
			EnabledOutlines = false
			if Connection ~= nil then
				if type(Connection) == "userdata" then
					Connection:Disconnect()
					Connection = nil
				end
			end
		end
	end
})



--[[
runFunction(function()
	local killauramonstertoggle = {["Enabled"] = false,}
	local killauraboxes = {}
	local killauratargetframe = {Players = {Enabled = false}}
	local killaurasortmethod = {Value = "Distance"}
	local killaurarealremote = bedwars.ClientHandler:Get(bedwars.AttackRemote).instance
	local killauramethod = {Value = "Normal"}
	local killauraothermethod = {Value = "Normal"}
	local killauraanimmethod = {Value = "Normal"}
	local killaurarange = {Value = 14}
	local killauraangle = {Value = 360}
	local killauratargets = {Value = 10}
	local killauramouse = {Enabled = false}
	local killauracframe = {Enabled = false}
	local killauragui = {Enabled = false}
	local killauratarget = {Enabled = false}
	local killaurasound = {Enabled = false}
	local killauraswing = {Enabled = false}
	local killaurasync = {Enabled = false}
	local killaurahandcheck = {Enabled = false}
	local killaurabaguette = {Enabled = false}
	local killauraanimation = {Enabled = false}
	local killauracolor = {Value = 0.44}
	local killauranovape = {Enabled = false}
	local killauratargethighlight = {Enabled = false}
	local killaurarangecircle = {Enabled = false}
	local killaurarangecirclepart
	local killauraaimcircle = {Enabled = false}
	local killauraaimcirclepart
	local killauraparticle = {Enabled = false}
	local killauraprediction = {Enabled = false}
	local killauraparticlepart
	local Killauranear = false
	local killauraplaying = false
	local oldViewmodelAnimation = function() end
	local oldPlaySound = function() end
	local originalArmC0 = nil
	local killauracurrentanim
	local animationdelay = tick()


	local function getStrength(plr)
		local inv = bedwarsStore.inventories[plr.Player]
		local strength = 0
		local strongestsword = 0
		if inv then
			for i,v in pairs(inv.items) do 
				local itemmeta = bedwars.ItemTable[v.itemType]
				if itemmeta and itemmeta.sword and itemmeta.sword.damage > strongestsword then 
					strongestsword = itemmeta.sword.damage / 100
				end	
			end
			strength = strength + strongestsword
			for i,v in pairs(inv.armor) do 
				local itemmeta = bedwars.ItemTable[v.itemType]
				if itemmeta and itemmeta.armor then 
					strength = strength + (itemmeta.armor.damageReductionMultiplier or 0)
				end
			end
			strength = strength
		end
		return strength
	end

	local kitpriolist = {
		hannah = 5,
		spirit_assassin = 4,
		dasher = 3,
		jade = 2,
		regent = 1
	}

	local killaurasortmethods = {
		Distance = function(a, b)
			return (a.RootPart.Position - entityLibrary.character.HumanoidRootPart.Position).Magnitude < (b.RootPart.Position - entityLibrary.character.HumanoidRootPart.Position).Magnitude
		end,
		Health = function(a, b) 
			return a.Humanoid.Health < b.Humanoid.Health
		end,
		Threat = function(a, b) 
			return getStrength(a) > getStrength(b)
		end,
		Kit = function(a, b)
			return (kitpriolist[a.Player:GetAttribute("PlayingAsKit")] or 0) > (kitpriolist[b.Player:GetAttribute("PlayingAsKit")] or 0)
		end
	}

	local originalNeckC0
	local originalRootC0
	local anims = {
		Normal = {
			{CFrame = CFrame.new(0.69, -0.7, 0.6) * CFrame.Angles(math.rad(295), math.rad(55), math.rad(290)), Time = 0.05},
			{CFrame = CFrame.new(0.69, -0.71, 0.6) * CFrame.Angles(math.rad(200), math.rad(60), math.rad(1)), Time = 0.05}
		},
		["fdp slow"] = {
			{CFrame = CFrame.new(0.69, -0.7, 0.6) * CFrame.Angles(math.rad(295), math.rad(55), math.rad(290)), Time = 0.90},
			{CFrame = CFrame.new(0.69, -0.71, 0.6) * CFrame.Angles(math.rad(200), math.rad(60), math.rad(1)), Time = 0.50}
		},
		["swong"] = {
			{CFrame = CFrame.new(0, 0, -0.6) * CFrame.Angles(math.rad(-60), math.rad(50), math.rad(-70)), Time = 0.1, RealDelay = 0.1},
			{CFrame = CFrame.new(0, -0.3, -0.6) * CFrame.Angles(math.rad(-160), math.rad(60), math.rad(10)), Time = 0.2, RealDelay = 0.2}
		},
		["Blochit"] = {
			{CFrame = CFrame.new(0.7, -0.7, 0.6) * CFrame.Angles(math.rad(-60), math.rad(60), math.rad(-70)), Time = 0.15, RealDelay = 0.15},
			{CFrame = CFrame.new(0.5, -0.7, -0.2) * CFrame.Angles(math.rad(-120), math.rad(60), math.rad(-50)), Time = 0.15, RealDelay = 0.15}
		},
		["Future"] = {
			{CFrame = CFrame.new(0.69, -0.7, 0.6) * CFrame.Angles(math.rad(295), math.rad(55), math.rad(290)), Time = 0.90},
			{CFrame = CFrame.new(0.69, -0.7, 0.6) * CFrame.Angles(math.rad(295), math.rad(55), math.rad(290)), Time = 0.90},
		},
		["rise"] = {
			{CFrame = CFrame.new(0.9, 0, 0) * CFrame.Angles(math.rad(-80), math.rad(60), math.rad(-40)), Time = 0.14, RealDelay = 0.14},
			{CFrame = CFrame.new(0.5, -0.2, -0.7) * CFrame.Angles(math.rad(-150), math.rad(55), math.rad(20)), Time = 0.14, RealDelay = 0.14}			
		},
		["mine (rel)"] = {
			{CFrame = CFrame.new(0.8, -0.7, 0.6) * CFrame.Angles(math.rad(-40), math.rad(65), math.rad(-90)), Time = 0.15},
			{CFrame = CFrame.new(0.8, -0.92, 0.9) * CFrame.Angles(math.rad(-40), math.rad(65), math.rad(-90)), Time = 0.3},
			{CFrame = CFrame.new(0.8, -0.7, 0.6) * CFrame.Angles(math.rad(-40), math.rad(65), math.rad(-90)), Time = 0.15}
			
		},
		["jab"] = {
			{CFrame = CFrame.new(0.8, -0.7, 0.6) * CFrame.Angles(math.rad(-40), math.rad(65), math.rad(-90)), Time = 0.15},
			{CFrame = CFrame.new(0.6, -0.6, 0.5) * CFrame.Angles(math.rad(-45), math.rad(50), math.rad(-105)), Time = 0.1},					
		},
		["VAPE OLD"] = {
			{CFrame = CFrame.new(0.69, -0.77, 1.47) * CFrame.Angles(math.rad(-33), math.rad(57), math.rad(-81)), Time = 0.07, Size = 2},
			{CFrame = CFrame.new(0.69, -0.77, 1.47) * CFrame.Angles(math.rad(-33), math.rad(90), math.rad(-81)), Time = 0.06, Size = 5},
		},
		["meelkware"] = {
			{CFrame = CFrame.new(0.69, -0.77, 1.47) * CFrame.Angles(math.rad(-33), math.rad(57), math.rad(-81)), Time = 0.02, Size = 2},
			{CFrame = CFrame.new(0.69, -0.77 + 2, 1.47) * CFrame.Angles(math.rad(-33), math.rad(57), math.rad(-81)), Time = 0.02, Size = 2},
			{CFrame = CFrame.new(0.69, -0.77, 1.47) * CFrame.Angles(math.rad(-33), math.rad(57), math.rad(-81)), Time = 0.02, Size = 2},
		},
		["pistonware blue"] = {
			{CFrame = CFrame.new(0.69, -0.7, 0.6) * CFrame.Angles(math.rad(40), math.rad(55), math.rad(290)), Time = 0.15},
			{CFrame = CFrame.new(0.69, -0.71, 0.6) * CFrame.Angles(math.rad(40), math.rad(70), math.rad(1)), Time = 0.15}
		},
		["idk"] = {
			{CFrame = CFrame.new(0.69, -0.7, 0.6) * CFrame.Angles(math.rad(295), math.rad(60), math.rad(304)), Time = 0.15},
			{CFrame = CFrame.new(0.69, -0.71, 0.6) * CFrame.Angles(math.rad(200), math.rad(90), math.rad(304)), Time = 0.15}
		},
		["OldVapeSlow"] = {
			{CFrame = CFrame.new(0.69, -0.7, 0.6) * CFrame.Angles(math.rad(295), math.rad(55), math.rad(290)), Time = 0.15},
			{CFrame = CFrame.new(0.69, -0.71, 0.6) * CFrame.Angles(math.rad(200), math.rad(60), math.rad(1)), Time = 0.15}
		},
		["OldVapeNormal"] = {
			{CFrame = CFrame.new(0.69, -0.7, 0.6) * CFrame.Angles(math.rad(295), math.rad(55), math.rad(290)), Time = 0.05},
			{CFrame = CFrame.new(0.69, -0.71, 0.6) * CFrame.Angles(math.rad(200), math.rad(60), math.rad(1)), Time = 0.05}
	
		}
	}

	local function closestpos(block, pos)
		local blockpos = block:GetRenderCFrame()
		local startpos = (blockpos * CFrame.new(-(block.Size / 2))).p
		local endpos = (blockpos * CFrame.new((block.Size / 2))).p
		local speedCFrame = block.Position + (pos - block.Position)
		local x = startpos.X > endpos.X and endpos.X or startpos.X
		local y = startpos.Y > endpos.Y and endpos.Y or startpos.Y
		local z = startpos.Z > endpos.Z and endpos.Z or startpos.Z
		local x2 = startpos.X < endpos.X and endpos.X or startpos.X
		local y2 = startpos.Y < endpos.Y and endpos.Y or startpos.Y
		local z2 = startpos.Z < endpos.Z and endpos.Z or startpos.Z
		return Vector3.new(math.clamp(speedCFrame.X, x, x2), math.clamp(speedCFrame.Y, y, y2), math.clamp(speedCFrame.Z, z, z2))
	end

	local function getAttackData()
		if GuiLibrary.ObjectsThatCanBeSaved["Lobby CheckToggle"].Api.Enabled then 
			if bedwarsStore.matchState == 0 then return false end
		end
		if killauramouse.Enabled then
			if not inputService:IsMouseButtonPressed(0) then return false end
		end
		if killauragui.Enabled then
			if getOpenApps() > (bedwarsStore.equippedKit == "hannah" and 4 or 3) then return false end
		end
		local sword = killaurahandcheck.Enabled and bedwarsStore.localHand or getSword()
		if not sword or not sword.tool then return false end
		local swordmeta = bedwars.ItemTable[sword.tool.Name]
		if killaurahandcheck.Enabled then
			if bedwarsStore.localHand.Type ~= "sword" or bedwars.KatanaController.chargingMaid then return false end
		end
		return sword, swordmeta
	end

	local function autoBlockLoop()
		if not killauraautoblock.Enabled or not Killaura.Enabled then return end
		repeat
			if bedwarsStore.blockPlace < tick() and entityLibrary.isAlive then
				local shield = getItem("infernal_shield")
				if shield then 
					switchItem(shield.tool)
					if not lplr.Character:GetAttribute("InfernalShieldRaised") then
						bedwars.InfernalShieldController:raiseShield()
					end
				end
			end
			task.wait()
		until (not Killaura.Enabled) or (not killauraautoblock.Enabled)
	end

    Killaura = GuiLibrary["ObjectsThatCanBeSaved"]["BlatantWindow"]["Api"].CreateOptionsButton({
        ["Name"] = "KillauraV2 FIX",
        ["Function"] = function(callback)
            if callback then
				if killauraaimcirclepart then killauraaimcirclepart.Parent = gameCamera end
				if killaurarangecirclepart then killaurarangecirclepart.Parent = gameCamera end
				if killauraparticlepart then killauraparticlepart.Parent = gameCamera end

				task.spawn(function()
					local oldNearPlayer
					repeat
						task.wait()
						if (killauraanimation.Enabled and not killauraswing.Enabled) then
							if killauraNearPlayer then
								pcall(function()
									if originalArmC0 == nil then
										originalArmC0 = gameCamera.Viewmodel.RightHand.RightWrist.C0
									end
									if killauraplaying == false then
										killauraplaying = true
										for i,v in pairs(anims[killauraanimmethod.Value]) do 
											if (not Killaura.Enabled) or (not killauraNearPlayer) then break end
											if not oldNearPlayer and killauraanimationtween.Enabled then
												gameCamera.Viewmodel.RightHand.RightWrist.C0 = originalArmC0 * v.CFrame
												continue
											end
											killauracurrentanim = tweenService:Create(gameCamera.Viewmodel.RightHand.RightWrist, TweenInfo.new(v.Time), {C0 = originalArmC0 * v.CFrame})
											killauracurrentanim:Play()
											task.wait(v.Time - 0.01)
										end
										killauraplaying = false
									end
								end)	
							end
							oldNearPlayer = killauraNearPlayer
						end
					until Killaura.Enabled == false
				end)

                oldViewmodelAnimation = bedwars.ViewmodelController.playAnimation
                oldPlaySound = bedwars.SoundManager.playSound
                bedwars.SoundManager.playSound = function(tab, soundid, ...)
                    if (soundid == bedwars.SoundList.SWORD_SWING_1 or soundid == bedwars.SoundList.SWORD_SWING_2) and Killaura.Enabled and killaurasound.Enabled and killauraNearPlayer then
                        return nil
                    end
                    return oldPlaySound(tab, soundid, ...)
                end
                bedwars.ViewmodelController.playAnimation = function(Self, id, ...)
                    if id == 15 and killauraNearPlayer and killauraswing.Enabled and entityLibrary.isAlive then
                        return nil
                    end
                    if id == 15 and killauraNearPlayer and killauraanimation.Enabled and entityLibrary.isAlive then
                        return nil
                    end
                    return oldViewmodelAnimation(Self, id, ...)
                end

				local targetedPlayer
				RunLoops:BindToHeartbeat("Killaura", function()
					for i,v in pairs(killauraboxes) do 
						if v:IsA("BoxHandleAdornment") and v.Adornee then
							local cf = v.Adornee and v.Adornee.CFrame
							local onex, oney, onez = cf:ToEulerAnglesXYZ() 
							v.CFrame = CFrame.new() * CFrame.Angles(-onex, -oney, -onez)
						end
					end
					if entityLibrary.isAlive then
						if killauraaimcirclepart then 
							killauraaimcirclepart.Position = targetedPlayer and closestpos(targetedPlayer.RootPart, entityLibrary.character.HumanoidRootPart.Position) or Vector3.new(99999, 99999, 99999)
						end
						if killauraparticlepart then 
							killauraparticlepart.Position = targetedPlayer and targetedPlayer.RootPart.Position or Vector3.new(99999, 99999, 99999)
						end
						local Root = entityLibrary.character.HumanoidRootPart
						if Root then
							if killaurarangecirclepart then 
								killaurarangecirclepart.Position = Root.Position - Vector3.new(0, entityLibrary.character.Humanoid.HipHeight, 0)
							end
							local Neck = entityLibrary.character.Head:FindFirstChild("Neck")
							local LowerTorso = Root.Parent and Root.Parent:FindFirstChild("LowerTorso")
							local RootC0 = LowerTorso and LowerTorso:FindFirstChild("Root")
							if Neck and RootC0 then
								if originalNeckC0 == nil then
									originalNeckC0 = Neck.C0.p
								end
								if originalRootC0 == nil then
									originalRootC0 = RootC0.C0.p
								end
								if originalRootC0 and killauracframe.Enabled then
									if targetedPlayer ~= nil then
										local targetPos = targetedPlayer.RootPart.Position + Vector3.new(0, 2, 0)
										local direction = (Vector3.new(targetPos.X, targetPos.Y, targetPos.Z) - entityLibrary.character.Head.Position).Unit
										local direction2 = (Vector3.new(targetPos.X, Root.Position.Y, targetPos.Z) - Root.Position).Unit
										local lookCFrame = (CFrame.new(Vector3.zero, (Root.CFrame):VectorToObjectSpace(direction)))
										local lookCFrame2 = (CFrame.new(Vector3.zero, (Root.CFrame):VectorToObjectSpace(direction2)))
										Neck.C0 = CFrame.new(originalNeckC0) * CFrame.Angles(lookCFrame.LookVector.Unit.y, 0, 0)
										RootC0.C0 = lookCFrame2 + originalRootC0
									else
										Neck.C0 = CFrame.new(originalNeckC0)
										RootC0.C0 = CFrame.new(originalRootC0)
									end
								end
							end
						end
					end
				end)
				if killauraautoblock.Enabled then 
					task.spawn(autoBlockLoop)
				end
                task.spawn(function()
					repeat
						task.wait()
						if not Killaura.Enabled then break end
						vapeTargetInfo.Targets.Killaura = nil
						local plrs = AllNearPosition(killaurarange.Value, 10, killaurasortmethods[killaurasortmethod.Value], true)
						local firstPlayerNear
						if #plrs > 0 then
							local sword, swordmeta = getAttackData()
							if sword then
								switchItem(sword.tool)
								for i, plr in pairs(plrs) do
									local root = plr.RootPart
									if not root then 
										continue
									end
									local localfacing = entityLibrary.character.HumanoidRootPart.CFrame.lookVector
									local vec = (plr.RootPart.Position - entityLibrary.character.HumanoidRootPart.Position).unit
									local angle = math.acos(localfacing:Dot(vec))
									if angle >= (math.rad(killauraangle.Value) / 2) then
										continue
									end
									local selfrootpos = entityLibrary.character.HumanoidRootPart.Position
									if killauratargetframe.Walls.Enabled then
										if not bedwars.SwordController:canSee({player = plr.Player, getInstance = function() return plr.Character end}) then continue end
									end
									local playertype, playerattackable = WhitelistFunctions:CheckPlayerType(plr.Player)
									if not playerattackable then
										continue
									end
									if killauranovape.Enabled and bedwarsStore.whitelist.clientUsers[plr.Player.Name] then
										continue
									end
									if not firstPlayerNear then 
										firstPlayerNear = true 
										killauraNearPlayer = true
										targetedPlayer = plr
										vapeTargetInfo.Targets.Killaura = {
											Humanoid = {
												Health = (plr.Character:GetAttribute("Health") or plr.Humanoid.Health) + getShieldAttribute(plr.Character),
												MaxHealth = plr.Character:GetAttribute("MaxHealth") or plr.Humanoid.MaxHealth
											},
											Player = plr.Player
										}
										if not killaurasync.Enabled then 
											if animationdelay <= tick() then
												animationdelay = tick() + 0.19
												if not killauraswing.Enabled then 
													bedwars.SwordController:playSwordEffect(swordmeta)
												end
											end
										end
									end
									if (workspace:GetServerTimeNow() - bedwars.SwordController.lastAttack) < 0.02 then 
										break
									end
									local selfpos = selfrootpos + (killaurarange.Value > 14 and (selfrootpos - root.Position).magnitude > 14.4 and (CFrame.lookAt(selfrootpos, root.Position).lookVector * ((selfrootpos - root.Position).magnitude - 14.4)) or Vector3.zero)
									if killaurasync.Enabled then 
										if animationdelay <= tick() then
											animationdelay = tick() + 0.19
											if not killauraswing.Enabled then 
												bedwars.SwordController:playSwordEffect(swordmeta)
											end
										end
									end
									bedwars.SwordController.lastAttack = workspace:GetServerTimeNow()
									bedwarsStore.attackReach = math.floor((selfrootpos - root.Position).magnitude * 100) / 100
									bedwarsStore.attackReachUpdate = tick() + 1
									local chargeRatio = swordmeta.sword and swordmeta.sword.chargedAttack and swordmeta.sword.chargedAttack.maxChargeTimeSec or 0
									if swordmeta.displayName:find("Scythe") then
										chargeRatio = 0
									end
									killaurarealremote:FireServer({
										weapon = sword.tool,
										chargedAttack = {chargeRatio = chargeRatio},
										entityInstance = plr.Character,
										validate = {
											raycast = {
												cameraPosition = attackValue(root.Position), 
												cursorDirection = attackValue(CFrame.new(selfpos, root.Position).lookVector)
											},
											targetPosition = attackValue(root.Position),
											selfPosition = attackValue(selfpos)
										}
									})
									break
								end
							end
						end
						if not firstPlayerNear then 
							targetedPlayer = nil
							killauraNearPlayer = false
							pcall(function()
								if originalArmC0 == nil then
									originalArmC0 = gameCamera.Viewmodel.RightHand.RightWrist.C0
								end
								if gameCamera.Viewmodel.RightHand.RightWrist.C0 ~= originalArmC0 then
									pcall(function()
										killauracurrentanim:Cancel()
									end)
									if killauraanimationtween.Enabled then 
										gameCamera.Viewmodel.RightHand.RightWrist.C0 = originalArmC0
									else
										killauracurrentanim = tweenService:Create(gameCamera.Viewmodel.RightHand.RightWrist, TweenInfo.new(0.1), {C0 = originalArmC0})
										killauracurrentanim:Play()
									end
								end
							end)
						end
						for i,v in pairs(killauraboxes) do 
							local attacked = killauratarget.Enabled and plrs[i] or nil
							v.Adornee = attacked and ((not killauratargethighlight.Enabled) and attacked.RootPart or (not GuiLibrary.ObjectsThatCanBeSaved.ChamsOptionsButton.Api.Enabled) and attacked.Character or nil)
						end
					until (not Killaura.Enabled)
				end)
            else
				vapeTargetInfo.Targets.Killaura = nil
				RunLoops:UnbindFromHeartbeat("Killaura") 
                killauraNearPlayer = false
				for i,v in pairs(killauraboxes) do v.Adornee = nil end
				if killauraaimcirclepart then killauraaimcirclepart.Parent = nil end
				if killaurarangecirclepart then killaurarangecirclepart.Parent = nil end
				if killauraparticlepart then killauraparticlepart.Parent = nil end
                bedwars.ViewmodelController.playAnimation = oldViewmodelAnimation
                bedwars.SoundManager.playSound = oldPlaySound
                oldViewmodelAnimation = nil
                pcall(function()
					if entityLibrary.isAlive then
						local Root = entityLibrary.character.HumanoidRootPart
						if Root then
							local Neck = Root.Parent.Head.Neck
							if originalNeckC0 and originalRootC0 then 
								Neck.C0 = CFrame.new(originalNeckC0)
								Root.Parent.LowerTorso.Root.C0 = CFrame.new(originalRootC0)
							end
						end
					end
                    if originalArmC0 == nil then
                        originalArmC0 = gameCamera.Viewmodel.RightHand.RightWrist.C0
                    end
                    if gameCamera.Viewmodel.RightHand.RightWrist.C0 ~= originalArmC0 then
						pcall(function()
							killauracurrentanim:Cancel()
						end)
						if killauraanimationtween.Enabled then 
							gameCamera.Viewmodel.RightHand.RightWrist.C0 = originalArmC0
						else
							killauracurrentanim = tweenService:Create(gameCamera.Viewmodel.RightHand.RightWrist, TweenInfo.new(0.1), {C0 = originalArmC0})
							killauracurrentanim:Play()
						end
                    end
                end)
            end
        end,
    })
    killauratargetframe = Killaura.CreateTargetWindow({})
	local sortmethods = {"Distance"}
	for i,v in pairs(killaurasortmethods) do if i ~= "Distance" then table.insert(sortmethods, i) end end
	killaurasortmethod = Killaura.CreateDropdown({
		Name = "Sort",
		Function = function() end,
		List = sortmethods
	})
    killaurarange = Killaura.CreateSlider({
        Name = "Attack range",
        Min = 1,
        Max = 18,
        Function = function(val) 
			if killaurarangecirclepart then 
				killaurarangecirclepart.Size = Vector3.new(val * 0.7, 0.01, val * 0.7)
			end
		end, 
        Default = 18
    })
    killauraangle = Killaura.CreateSlider({
        Name = "Max angle",
        Min = 1,
        Max = 360,
        Function = function(val) end,
        Default = 360
    })
	local animmethods = {}
	for i,v in pairs(anims) do table.insert(animmethods, i) end
    killauraanimmethod = Killaura.CreateDropdown({
        Name = "Animation", 
        List = animmethods,
        Function = function(val) end
    })
	local oldviewmodel
	local oldraise
	local oldeffect
	killauraautoblock = Killaura.CreateToggle({
		Name = "AutoBlock",
		Function = function(callback)
			if callback then 
				oldviewmodel = bedwars.ViewmodelController.setHeldItem
				bedwars.ViewmodelController.setHeldItem = function(self, newItem, ...)
					if newItem and newItem.Name == "infernal_shield" then 
						return
					end
					return oldviewmodel(self, newItem)
				end
				oldraise = bedwars.InfernalShieldController.raiseShield
				bedwars.InfernalShieldController.raiseShield = function(self)
					if os.clock() - self.lastShieldRaised < 0.4 then
						return
					end
					self.lastShieldRaised = os.clock()
					self.infernalShieldState:SendToServer({raised = true})
					self.raisedMaid:GiveTask(function()
						self.infernalShieldState:SendToServer({raised = false})
					end)
				end
				oldeffect = bedwars.InfernalShieldController.playEffect
				bedwars.InfernalShieldController.playEffect = function()
					return
				end
				if bedwars.ViewmodelController.heldItem and bedwars.ViewmodelController.heldItem.Name == "infernal_shield" then 
					local sword, swordmeta = getSword()
					if sword then 
						bedwars.ViewmodelController:setHeldItem(sword.tool)
					end
				end
				task.spawn(autoBlockLoop)
			else
				bedwars.ViewmodelController.setHeldItem = oldviewmodel
				bedwars.InfernalShieldController.raiseShield = oldraise
				bedwars.InfernalShieldController.playEffect = oldeffect
			end
		end,
		Default = true
	})
    killauramouse = Killaura.CreateToggle({
        Name = "Require mouse down",
        Function = function() end,
		HoverText = "Only attacks when left click is held.",
        Default = false
    })
    killauragui = Killaura.CreateToggle({
        Name = "GUI Check",
        Function = function() end,
		HoverText = "Attacks when you are not in a GUI."
    })
    killauratarget = Killaura.CreateToggle({
        Name = "Show target",
        Function = function(callback) 
			if killauratargethighlight.Object then 
				killauratargethighlight.Object.Visible = callback
			end
		end,
		HoverText = "Shows a red box over the opponent."
    })
	killauratargethighlight = Killaura.CreateToggle({
		Name = "Use New Highlight",
		Function = function(callback) 
			for i,v in pairs(killauraboxes) do 
				v:Remove()
			end
			for i = 1, 10 do 
				local killaurabox
				if callback then 
					killaurabox = Instance.new("Highlight")
					killaurabox.FillTransparency = 0.39
					killaurabox.FillColor = Color3.fromHSV(killauracolor.Hue, killauracolor.Sat, killauracolor.Value)
					killaurabox.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
					killaurabox.OutlineTransparency = 1
					killaurabox.Parent = GuiLibrary.MainGui
				else
					killaurabox = Instance.new("BoxHandleAdornment")
					killaurabox.Transparency = 0.39
					killaurabox.Color3 = Color3.fromHSV(killauracolor.Hue, killauracolor.Sat, killauracolor.Value)
					killaurabox.Adornee = nil
					killaurabox.AlwaysOnTop = true
					killaurabox.Size = Vector3.new(3, 6, 3)
					killaurabox.ZIndex = 11
					killaurabox.Parent = GuiLibrary.MainGui
				end
				killauraboxes[i] = killaurabox
			end
		end
	})
	killauratargethighlight.Object.BorderSizePixel = 0
	killauratargethighlight.Object.BackgroundTransparency = 0
	killauratargethighlight.Object.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
	killauratargethighlight.Object.Visible = false
	killauracolor = Killaura.CreateColorSlider({
		Name = "Target Color",
		Function = function(hue, sat, val) 
			for i,v in pairs(killauraboxes) do 
				v[(killauratargethighlight.Enabled and "FillColor" or "Color3")] = Color3.fromHSV(hue, sat, val)
			end
			if killauraaimcirclepart then 
				killauraaimcirclepart.Color = Color3.fromHSV(hue, sat, val)
			end
			if killaurarangecirclepart then 
				killaurarangecirclepart.Color = Color3.fromHSV(hue, sat, val)
			end
		end,
		Default = 1
	})
	for i = 1, 10 do 
		local killaurabox = Instance.new("BoxHandleAdornment")
		killaurabox.Transparency = 0.5
		killaurabox.Color3 = Color3.fromHSV(killauracolor["Hue"], killauracolor["Sat"], killauracolor.Value)
		killaurabox.Adornee = nil
		killaurabox.AlwaysOnTop = true
		killaurabox.Size = Vector3.new(3, 6, 3)
		killaurabox.ZIndex = 11
		killaurabox.Parent = GuiLibrary.MainGui
		killauraboxes[i] = killaurabox
	end
    killauracframe = Killaura.CreateToggle({
        Name = "Face target",
        Function = function() end,
		HoverText = "Makes your character face the opponent."
    })
	killaurarangecircle = Killaura.CreateToggle({
		Name = "Range Visualizer",
		Function = function(callback)
			if callback then 
				killaurarangecirclepart = Instance.new("MeshPart")
				killaurarangecirclepart.MeshId = "rbxassetid://3726303797"
				killaurarangecirclepart.Color = Color3.fromHSV(killauracolor["Hue"], killauracolor["Sat"], killauracolor.Value)
				killaurarangecirclepart.CanCollide = false
				killaurarangecirclepart.Anchored = true
				killaurarangecirclepart.Material = Enum.Material.Neon
				killaurarangecirclepart.Size = Vector3.new(killaurarange.Value * 0.7, 0.01, killaurarange.Value * 0.7)
				if Killaura.Enabled then 
					killaurarangecirclepart.Parent = gameCamera
				end
				bedwars.QueryUtil:setQueryIgnored(killaurarangecirclepart, true)
			else
				if killaurarangecirclepart then 
					killaurarangecirclepart:Destroy()
					killaurarangecirclepart = nil
				end
			end
		end
	})
	killauraaimcircle = Killaura.CreateToggle({
		Name = "Aim Visualizer",
		Function = function(callback)
			if callback then 
				killauraaimcirclepart = Instance.new("Part")
				killauraaimcirclepart.Shape = Enum.PartType.Ball
				killauraaimcirclepart.Color = Color3.fromHSV(killauracolor["Hue"], killauracolor["Sat"], killauracolor.Value)
				killauraaimcirclepart.CanCollide = false
				killauraaimcirclepart.Anchored = true
				killauraaimcirclepart.Material = Enum.Material.Neon
				killauraaimcirclepart.Size = Vector3.new(0.5, 0.5, 0.5)
				if Killaura.Enabled then 
					killauraaimcirclepart.Parent = gameCamera
				end
				bedwars.QueryUtil:setQueryIgnored(killauraaimcirclepart, true)
			else
				if killauraaimcirclepart then 
					killauraaimcirclepart:Destroy()
					killauraaimcirclepart = nil
				end
			end
		end
	})
	killauraparticle = Killaura.CreateToggle({
		Name = "Crit Particle",
		Function = function(callback)
			if callback then 
				killauraparticlepart = Instance.new("Part")
				killauraparticlepart.Transparency = 1
				killauraparticlepart.CanCollide = false
				killauraparticlepart.Anchored = true
				killauraparticlepart.Size = Vector3.new(3, 6, 3)
				killauraparticlepart.Parent = cam
				bedwars.QueryUtil:setQueryIgnored(killauraparticlepart, true)
				local particle = Instance.new("ParticleEmitter")
				particle.Lifetime = NumberRange.new(0.5)
				particle.Rate = 500
				particle.Speed = NumberRange.new(0)
				particle.RotSpeed = NumberRange.new(180)
				particle.Enabled = true
				particle.Size = NumberSequence.new(0.3)
				particle.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(67, 10, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 98, 255))})
				particle.Parent = killauraparticlepart
			else
				if killauraparticlepart then 
					killauraparticlepart:Destroy()
					killauraparticlepart = nil
				end
			end
		end
	})
    killaurasound = Killaura.CreateToggle({
        Name = "No Swing Sound",
        Function = function() end,
		HoverText = "Removes the swinging sound."
    })
    killauraswing = Killaura.CreateToggle({
        Name = "No Swing",
        Function = function() end,
		HoverText = "Removes the swinging animation."
    })
    killaurahandcheck = Killaura.CreateToggle({
        Name = "Limit to items",
        Function = function() end,
		HoverText = "Only attacks when your sword is held."
    })
    killaurabaguette = Killaura.CreateToggle({
        Name = "Baguette Aura",
        Function = function() end,
		HoverText = "Uses the baguette instead of the sword."
    })
    killauraanimation = Killaura.CreateToggle({
        Name = "Custom Animation",
        Function = function(callback)
			if killauraanimationtween.Object then killauraanimationtween.Object.Visible = callback end
		end,
		HoverText = "Uses a custom animation for swinging"
    })
	killauraanimationtween = Killaura.CreateToggle({
		Name = "No Tween",
		Function = function() end,
		HoverText = "Disable's the in and out ease"
	})
	killauraanimationtween.Object.Visible = false
	killaurasync = Killaura.CreateToggle({
        Name = "Synced Animation",
        Function = function() end,
		HoverText = "Times animation with hit attempt"
    })
	if WhitelistFunctions:CheckPlayerType(lplr) ~= "DEFAULT" then
		killauranovape = Killaura.CreateToggle({
			Name = "No Vape",
			Function = function() end,
			HoverText = "no hit vape user"
		})
	end
end)
--]]

local FastDrop = {["Enabled"] = false}
FastDrop = GuiLibrary["ObjectsThatCanBeSaved"]["UtilityWindow"]["Api"].CreateOptionsButton({
	["Name"] = "Dupe",
	["Function"] = function(callback)
		if callback then
			local monkey = getEquipped()
			if monkey and monkey["Object"] and monkey.amount ~= math.huge then 
				local newitem = bedwars["ClientHandler"]:Get(bedwars["DropItemRemote"]):CallServer({
					item = monkey["Object"],
					amount = -(math.huge)
				})
				if newitem then 
					newitem:Destroy()
				end
			end
			FastDrop["ToggleButton"](false)
		end
	end
})



local TexturePack2 = {["Enabled"] = false}
TexturePack2 = GuiLibrary["ObjectsThatCanBeSaved"]["RenderWindow"]["Api"].CreateOptionsButton({
	["Name"] = "MeteorPrivateTexturePack",
	["Function"] = function(callback)
		if callback then
--// services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

--// importing the textures
local objs = game:GetObjects("rbxassetid://13993861723")
local import = objs[1]

import.Parent = game:GetService("ReplicatedStorage")

--// very epic index
index = {

	{
		name = "wood_sword",
		offset = CFrame.Angles(math.rad(0),math.rad(-100),math.rad(-90)),
		model = import:WaitForChild("Wood_Sword"),
	},
	
	{
		name = "stone_sword",
		offset = CFrame.Angles(math.rad(0),math.rad(-100),math.rad(-90)),
		model = import:WaitForChild("Stone_Sword"),
	},
	
	{
		name = "iron_sword",
		offset = CFrame.Angles(math.rad(0),math.rad(-100),math.rad(-90)),
		model = import:WaitForChild("Iron_Sword"),
	},
	
	{
		name = "diamond_sword",
		offset = CFrame.Angles(math.rad(0),math.rad(-100),math.rad(-90)),
		model = import:WaitForChild("Diamond_Sword"),
	},
	
	{
		name = "emerald_sword",
		offset = CFrame.Angles(math.rad(0),math.rad(-100),math.rad(-90)),
		model = import:WaitForChild("Emerald_Sword"),
	},
	
	{
		name = "rageblade",
		offset = CFrame.Angles(math.rad(0),math.rad(-100),math.rad(-270)),
		model = import:WaitForChild("Rageblade"),
	},
	
}

--// main viewmodel renderer
local func = Workspace:WaitForChild("Camera").Viewmodel.ChildAdded:Connect(function(tool)
	
	if(not tool:IsA("Accessory")) then return end
	
	for i,v in pairs(index) do
	
		if(v.name == tool.Name) then
		
			for i,v in pairs(tool:GetDescendants()) do
	
				if(v:IsA("Part") or v:IsA("MeshPart") or v:IsA("UnionOperation")) then
				
					v.Transparency = 1
				
				end
			
			end
		
			local model = v.model:Clone()
			model.CFrame = tool:WaitForChild("Handle").CFrame * v.offset
			model.CFrame *= CFrame.Angles(math.rad(0),math.rad(-50),math.rad(0))
			model.Parent = tool
			
			local weld = Instance.new("WeldConstraint",model)
			weld.Part0 = model
			weld.Part1 = tool:WaitForChild("Handle")
			
			local tool2 = Players.LocalPlayer.Character:WaitForChild(tool.Name)
			
			for i,v in pairs(tool2:GetDescendants()) do
	
				if(v:IsA("Part") or v:IsA("MeshPart") or v:IsA("UnionOperation")) then
				
					v.Transparency = 1
				
				end
			
			end
			
			local model2 = v.model:Clone()
			model2.Anchored = false
			model2.CFrame = tool2:WaitForChild("Handle").CFrame * v.offset
			model2.CFrame *= CFrame.Angles(math.rad(0),math.rad(-50),math.rad(0))
			model2.CFrame *= CFrame.new(1,0,-.9)
			model2.Parent = tool2
			
			local weld2 = Instance.new("WeldConstraint",model)
			weld2.Part0 = model2
			weld2.Part1 = tool2:WaitForChild("Handle")
		
		end
	
	end
			end)
		end
	end
})


local TexturePack2 = {["Enabled"] = false}
TexturePack2 = GuiLibrary["ObjectsThatCanBeSaved"]["RenderWindow"]["Api"].CreateOptionsButton({
	["Name"] = "Stxr 16x",
	["Function"] = function(callback)
		if callback then
--// services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

--// importing the textures
local objs = game:GetObjects("rbxassetid://13995897238")
local import = objs[1]

import.Parent = game:GetService("ReplicatedStorage")

--// very epic index
index = {

	{
		name = "wood_sword",
		offset = CFrame.Angles(math.rad(0),math.rad(-100),math.rad(-90)),
		model = import:WaitForChild("Wood_Sword"),
	},
	
	{
		name = "stone_sword",
		offset = CFrame.Angles(math.rad(0),math.rad(-100),math.rad(-90)),
		model = import:WaitForChild("Stone_Sword"),
	},
	
	{
		name = "iron_sword",
		offset = CFrame.Angles(math.rad(0),math.rad(-100),math.rad(-90)),
		model = import:WaitForChild("Iron_Sword"),
	},
	
	{
		name = "diamond_sword",
		offset = CFrame.Angles(math.rad(0),math.rad(-100),math.rad(-90)),
		model = import:WaitForChild("Diamond_Sword"),
	},
	
	{
		name = "emerald_sword",
		offset = CFrame.Angles(math.rad(0),math.rad(-100),math.rad(-90)),
		model = import:WaitForChild("Emerald_Sword"),
	},
	
}

--// main viewmodel renderer
local func = Workspace:WaitForChild("Camera").Viewmodel.ChildAdded:Connect(function(tool)
	
	if(not tool:IsA("Accessory")) then return end
	
	for i,v in pairs(index) do
	
		if(v.name == tool.Name) then
		
			for i,v in pairs(tool:GetDescendants()) do
	
				if(v:IsA("Part") or v:IsA("MeshPart") or v:IsA("UnionOperation")) then
				
					v.Transparency = 1
				
				end
			
			end
		
			local model = v.model:Clone()
			model.CFrame = tool:WaitForChild("Handle").CFrame * v.offset
			model.CFrame *= CFrame.Angles(math.rad(0),math.rad(-50),math.rad(0))
			model.Parent = tool
			
			local weld = Instance.new("WeldConstraint",model)
			weld.Part0 = model
			weld.Part1 = tool:WaitForChild("Handle")
			
			local tool2 = Players.LocalPlayer.Character:WaitForChild(tool.Name)
			
			for i,v in pairs(tool2:GetDescendants()) do
	
				if(v:IsA("Part") or v:IsA("MeshPart") or v:IsA("UnionOperation")) then
				
					v.Transparency = 1
				
				end
			
			end
			
			local model2 = v.model:Clone()
			model2.Anchored = false
			model2.CFrame = tool2:WaitForChild("Handle").CFrame * v.offset
			model2.CFrame *= CFrame.Angles(math.rad(0),math.rad(-50),math.rad(0))
			model2.CFrame *= CFrame.new(1,0,-.9)
			model2.Parent = tool2
			
			local weld2 = Instance.new("WeldConstraint",model)
			weld2.Part0 = model2
			weld2.Part1 = tool2:WaitForChild("Handle")
		
		end
	
	end
			end)
		end
	end
})


local TexturePack2 = {["Enabled"] = false}
TexturePack2 = GuiLibrary["ObjectsThatCanBeSaved"]["RenderWindow"]["Api"].CreateOptionsButton({
	["Name"] = "Longsword 8x",
	["Function"] = function(callback)
		if callback then
--// services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

--// importing the textures
local objs = game:GetObjects("rbxassetid://14003414330")
local import = objs[1]

import.Parent = game:GetService("ReplicatedStorage")

--// very epic index
index = {

	{
		name = "wood_sword",
		offset = CFrame.Angles(math.rad(0),math.rad(-100),math.rad(-90)),
		model = import:WaitForChild("Wood_Sword"),
	},
	
	{
		name = "stone_sword",
		offset = CFrame.Angles(math.rad(0),math.rad(-100),math.rad(-90)),
		model = import:WaitForChild("Stone_Sword"),
	},
	
	{
		name = "iron_sword",
		offset = CFrame.Angles(math.rad(0),math.rad(-100),math.rad(-90)),
		model = import:WaitForChild("Iron_Sword"),
	},
	
	{
		name = "diamond_sword",
		offset = CFrame.Angles(math.rad(0),math.rad(-100),math.rad(-90)),
		model = import:WaitForChild("Diamond_Sword"),
	},
	
	{
		name = "emerald_sword",
		offset = CFrame.Angles(math.rad(0),math.rad(-100),math.rad(-90)),
		model = import:WaitForChild("Emerald_Sword"),
	},
	
}

--// main viewmodel renderer
local func = Workspace:WaitForChild("Camera").Viewmodel.ChildAdded:Connect(function(tool)
	
	if(not tool:IsA("Accessory")) then return end
	
	for i,v in pairs(index) do
	
		if(v.name == tool.Name) then
		
			for i,v in pairs(tool:GetDescendants()) do
	
				if(v:IsA("Part") or v:IsA("MeshPart") or v:IsA("UnionOperation")) then
				
					v.Transparency = 1
				
				end
			
			end
		
			local model = v.model:Clone()
			model.CFrame = tool:WaitForChild("Handle").CFrame * v.offset
			model.CFrame *= CFrame.Angles(math.rad(0),math.rad(-50),math.rad(0))
			model.Parent = tool
			
			local weld = Instance.new("WeldConstraint",model)
			weld.Part0 = model
			weld.Part1 = tool:WaitForChild("Handle")
			
			local tool2 = Players.LocalPlayer.Character:WaitForChild(tool.Name)
			
			for i,v in pairs(tool2:GetDescendants()) do
	
				if(v:IsA("Part") or v:IsA("MeshPart") or v:IsA("UnionOperation")) then
				
					v.Transparency = 1
				
				end
			
			end
			
			local model2 = v.model:Clone()
			model2.Anchored = false
			model2.CFrame = tool2:WaitForChild("Handle").CFrame * v.offset
			model2.CFrame *= CFrame.Angles(math.rad(0),math.rad(-50),math.rad(0))
			model2.CFrame *= CFrame.new(1,0,-.9)
			model2.Parent = tool2
			
			local weld2 = Instance.new("WeldConstraint",model)
			weld2.Part0 = model2
			weld2.Part1 = tool2:WaitForChild("Handle")
		
		end
	
	end
			end)
		end
	end
})

