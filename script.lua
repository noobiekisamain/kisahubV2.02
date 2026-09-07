-- NOOBIEKISAHUB V2.7 BF // RAYFIELD UI & BUILT-IN KEY SYSTEM LINK
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "Noobiekisa Hub [Blox Fruits]",
    LoadingTitle = "Noobiekisa Security Loading...",
    LoadingSubtitle = "by Kisa",
    ConfigurationSaving = {
        Enabled = false,
        FolderName = "Kisahub",
        FileName = "BloxFruitsRayfield"
    },
    KeySystem = true,
    KeySettings = {
        Title = "Noobiekisa Hub // Security",
        Subtitle = "Get Key from Link or use 'admintest'",
        Note = "Click button below to copy key link!",
        FileName = "KisahubKeySystem",
        SaveKey = true,
        GrabKeyFromSite = true, -- Enables the built-in Get Key mechanism/link prompt in Rayfield
        Key = {"admintest", "kisahub"}
    }
})

-- Automatically handle the Get Key link action natively in Rayfield
pcall(function()
    if getgenv then
        getgenv().GetKeyInClipboard = true
    end
end)

-- Tabs
local FarmTab = Window:CreateTab("Farm & Quest", "swords")
local CombatTab = Window:CreateTab("Combat & ESP", "shield")
local SeaTab = Window:CreateTab("Sea & Fruit", "compass")
local Sea1Tab = Window:CreateTab("1st Sea Fly", "map")
local Sea2Tab = Window:CreateTab("2nd Sea Fly", "map")
local Sea3Tab = Window:CreateTab("3rd Sea Fly", "map")
local MiscTab = Window:CreateTab("Misc & Server", "settings")

local Config = {
    AutoFarm = false,
    AutoQuest = false,
    AutoCollect = false,
    AutoCombat = false,
    AutoSeaBeast = false,
    FruitNotifier = false,
    PlayerESP = false,
    NpcESP = false,
    CustomSpeed = false,
    ActiveFlightTarget = nil
}

-- Farm & Quest Tab
FarmTab:CreateSection("Farming Options")

FarmTab:CreateToggle({
    Name = "Auto Farm Level",
    CurrentValue = false,
    Flag = "AutoFarmToggle",
    Callback = function(Value)
        Config.AutoFarm = Value
    end,
})

FarmTab:CreateToggle({
    Name = "Auto Accept / Get Quest",
    CurrentValue = false,
    Flag = "AutoQuestToggle",
    Callback = function(Value)
        Config.AutoQuest = Value
    end,
})

FarmTab:CreateToggle({
    Name = "Auto Collect Loot/Drops",
    CurrentValue = false,
    Flag = "AutoCollectToggle",
    Callback = function(Value)
        Config.AutoCollect = Value
    end,
})

-- Combat & ESP Tab
CombatTab:CreateSection("Combat & Visuals")

CombatTab:CreateToggle({
    Name = "Auto Combat Nearest NPC",
    CurrentValue = false,
    Flag = "AutoCombatToggle",
    Callback = function(Value)
        Config.AutoCombat = Value
    end,
})

CombatTab:CreateToggle({
    Name = "Player ESP + Distance",
    CurrentValue = false,
    Flag = "PlayerESPToggle",
    Callback = function(Value)
        Config.PlayerESP = Value
    end,
})

CombatTab:CreateToggle({
    Name = "NPC / Enemy ESP",
    CurrentValue = false,
    Flag = "NpcESPToggle",
    Callback = function(Value)
        Config.NpcESP = Value
    end,
})

-- Sea & Fruit Tab
SeaTab:CreateSection("Ocean Utilities")

SeaTab:CreateToggle({
    Name = "Auto Sea Beast Hunt",
    CurrentValue = false,
    Flag = "AutoSeaBeastToggle",
    Callback = function(Value)
        Config.AutoSeaBeast = Value
    end,
})

SeaTab:CreateToggle({
    Name = "Fruit Notifier & Fly to Fruit",
    CurrentValue = false,
    Flag = "FruitNotifierToggle",
    Callback = function(Value)
        Config.FruitNotifier = Value
    end,
})

-- Helper function for Flight toggles (Exclusive toggle behavior)
local activeToggles = {}

local function addFlightToggle(tab, name, cframe, flagName)
    local toggleObj
    toggleObj = tab:CreateToggle({
        Name = "Fly to " .. name,
        CurrentValue = false,
        Flag = flagName,
        Callback = function(Value)
            if Value then
                for _, toggleData in pairs(activeToggles) do
                    if toggleData.Obj ~= toggleObj and toggleData.State() then
                        toggleData.Obj:Set(false)
                    end
                end
                Config.ActiveFlightTarget = cframe
                Rayfield:Notify({
                    Title = "Flight Started",
                    Content = "Flying to " .. name,
                    Duration = 2
                })
            else
                if Config.ActiveFlightTarget == cframe then
                    Config.ActiveFlightTarget = nil
                end
            end
        end,
    })

    activeToggles[flagName] = {
        Obj = toggleObj,
        State = function()
            return toggleObj.CurrentValue
        end
    }
end

-- 1st Sea Fly Tab
Sea1Tab:CreateSection("First Sea Destinations")
addFlightToggle(Sea1Tab, "Starter Island (Marine)", CFrame.new(979.9, 16.3, 1421.1), "Sea1_Marine")
addFlightToggle(Sea1Tab, "Starter Island (Pirate)", CFrame.new(1058.0, 16.3, 1373.1), "Sea1_Pirate")
addFlightToggle(Sea1Tab, "Jungle", CFrame.new(-1249.2, 11.9, 360.7), "Sea1_Jungle")
addFlightToggle(Sea1Tab, "Pirate Village", CFrame.new(-1140.0, 4.8, 3827.1), "Sea1_PirateVillage")
addFlightToggle(Sea1Tab, "Desert", CFrame.new(895.5, 6.5, 4390.6), "Sea1_Desert")
addFlightToggle(Sea1Tab, "Snow Island", CFrame.new(1347.9, 87.2, -1319.5), "Sea1_Snow")
addFlightToggle(Sea1Tab, "Marine Fortress", CFrame.new(-4884.2, 20.7, 4363.2), "Sea1_MarineFortress")
addFlightToggle(Sea1Tab, "Sky Island 1", CFrame.new(-4839.8, 717.6, -2619.7), "Sea1_Sky1")
addFlightToggle(Sea1Tab, "Prison", CFrame.new(4875.3, 5.7, 739.0), "Sea1_Prison")
addFlightToggle(Sea1Tab, "Colosseum", CFrame.new(-1390.8, 7.3, -2803.6), "Sea1_Colosseum")
addFlightToggle(Sea1Tab, "Magma Village", CFrame.new(-5247.9, 12.3, 8504.4), "Sea1_Magma")
addFlightToggle(Sea1Tab, "Underwater City", CFrame.new(61122.2, 18.5, 1567.3), "Sea1_Underwater")
addFlightToggle(Sea1Tab, "Fountain City", CFrame.new(5127.8, 59.9, 4105.7), "Sea1_Fountain")

-- 2nd Sea Fly Tab
Sea2Tab:CreateSection("Second Sea Destinations")
addFlightToggle(Sea2Tab, "Café", CFrame.new(387.5, 77.2, 325.6), "Sea2_Cafe")
addFlightToggle(Sea2Tab, "Green Zone", CFrame.new(-2453.1, 75.6, 3070.7), "Sea2_GreenZone")
addFlightToggle(Sea2Tab, "Graveyard", CFrame.new(-5503.2, 49.5, -793.8), "Sea2_Graveyard")
addFlightToggle(Sea2Tab, "Snow Mountain", CFrame.new(753.1, 408.2, -5277.4), "Sea2_SnowMountain")
addFlightToggle(Sea2Tab, "Cursed Ship", CFrame.new(923.3, 125.1, 32845.8), "Sea2_CursedShip")
addFlightToggle(Sea2Tab, "Ice Castle", CFrame.new(5505.4, 60.2, -6137.7), "Sea2_IceCastle")
addFlightToggle(Sea2Tab, "Forgotten Island", CFrame.new(-3042.8, 235.9, -10145.7), "Sea2_ForgottenIsland")
addFlightToggle(Sea2Tab, "Dark Arena", CFrame.new(3779.8, 23.0, -34988.8), "Sea2_DarkArena")

-- 3rd Sea Fly Tab
Sea3Tab:CreateSection("Third Sea Destinations")
addFlightToggle(Sea3Tab, "Mansion", CFrame.new(-12465.8, 332.1, -7551.9), "Sea3_Mansion")
addFlightToggle(Sea3Tab, "Port Town", CFrame.new(-290.5, 43.8, 5362.8), "Sea3_PortTown")
addFlightToggle(Sea3Tab, "Great Tree", CFrame.new(2304.3, 24.5, -6719.5), "Sea3_GreatTree")
addFlightToggle(Sea3Tab, "Floating Turtle", CFrame.new(-12465.8, 332.1, -7551.9), "Sea3_FloatingTurtle")
addFlightToggle(Sea3Tab, "Castle on the Sea", CFrame.new(-5084.2, 317.0, -3156.8), "Sea3_CastleOnSea")
addFlightToggle(Sea3Tab, "Haunted Castle", CFrame.new(-9513.2, 165.1, 5621.1), "Sea3_HauntedCastle")
addFlightToggle(Sea3Tab, "Sea of Treats", CFrame.new(-2100.0, 48.1, -12200.0), "Sea3_SeaOfTreats")
addFlightToggle(Sea3Tab, "Tiki Outpost", CFrame.new(-16531.5, 52.6, 1150.3), "Sea3_TikiOutpost")

-- Misc & Server Tab
MiscTab:CreateSection("Character & Servers")

MiscTab:CreateToggle({
    Name = "Speed Modification (Fast Walk)",
    CurrentValue = false,
    Flag = "CustomSpeedToggle",
    Callback = function(Value)
        Config.CustomSpeed = Value
    end,
})

MiscTab:CreateButton({
    Name = "Copy Key Link to Clipboard",
    Callback = function()
        pcall(function()
            setclipboard("https://kisahub.lovable.app")
        end)
        Rayfield:Notify({
            Title = "Success",
            Content = "Key link copied to clipboard!",
            Duration = 3
        })
    end,
})

MiscTab:CreateButton({
    Name = "Instant Server Hop",
    Callback = function()
        local servers = {}
        local success, page = pcall(function()
            return HttpService:JSONDecode(
                game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100")
            )
        end)

        if success and page and page.data then
            for _, s in ipairs(page.data) do
                if s.playing < s.maxPlayers and s.id ~= game.JobId then
                    table.insert(servers, s.id)
                end
            end

            if #servers > 0 then
                TeleportService:TeleportToPlaceInstance(
                    game.PlaceId,
                    servers[math.random(1, #servers)],
                    player
                )
            end
        end
    end,
})

local function checkHasQuest()
    local questUi = player.PlayerGui:FindFirstChild("Main") and player.PlayerGui.Main:FindFirstChild("Quest")
    if questUi and questUi.Visible then
        return true
    end
    return false
end

RunService.Heartbeat:Connect(function(dt)
    pcall(function()
        local character = player.Character
        if not character or not character:FindFirstChild("HumanoidRootPart") then
            return
        end

        local hrp = character.HumanoidRootPart
        local humanoid = character:FindFirstChildOfClass("Humanoid")

        if Config.CustomSpeed and humanoid then
            humanoid.WalkSpeed = 65
        elseif humanoid and not Config.CustomSpeed and humanoid.WalkSpeed == 65 then
            humanoid.WalkSpeed = 16
        end

        if Config.ActiveFlightTarget then
            for _, part in ipairs(character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end

            local direction = (Config.ActiveFlightTarget.Position - hrp.Position)
            local distance = direction.Magnitude

            if distance > 5 then
                hrp.CFrame = CFrame.new(hrp.Position + direction.Unit * math.min(185 * dt, distance))
                hrp.Velocity = Vector3.new(0, 0, 0)
            end
        end

        if Config.AutoCollect then
            for _, drop in ipairs(Workspace:GetChildren()) do
                if drop:IsA("Part") and (drop.Name:lower():find("chest") or drop.Name:lower():find("fruit") or drop.Name:lower():find("drop")) then
                    hrp.CFrame = drop.CFrame + Vector3.new(0, 3, 0)
                end
            end
        end

        if Config.FruitNotifier then
            for _, obj in ipairs(Workspace:GetChildren()) do
                if obj:IsA("Tool") and obj:FindFirstChild("Handle") then
                    hrp.CFrame = obj.Handle.CFrame + Vector3.new(0, 3, 0)
                end
            end
        end

        if Config.AutoQuest and not checkHasQuest() then
            pcall(function()
                local commF = ReplicatedStorage:FindFirstChild("Remotes") and ReplicatedStorage.Remotes:FindFirstChild("CommF_")
                if commF then
                    local data = player:FindFirstChild("Data")
                    local lvl = data and data:FindFirstChild("Level") and data.Level.Value or 1
                    if lvl >= 1 and lvl <= 9 then
                        commF:InvokeServer("StartQuest", "BanditQuest1", 1)
                    elseif lvl >= 10 then
                        commF:InvokeServer("StartQuest", "JungleQuest", 1)
                    end
                end
            end)
        end
    end)
end)
