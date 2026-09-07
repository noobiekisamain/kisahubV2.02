local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer

-- 1. Load WindUI Library
local WindUI = loadstring(game:HttpGet('https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua'))()

-- 2. Create Window
local Window = WindUI:CreateWindow({
    Title = "Noobiekisa Hub [Blox Fruits]",
    Icon = "swords",
    Author = "by Kisa",
    Folder = "Kisahub",
    Size = UDim2.fromOffset(580, 460),
    Transparent = true,
    Theme = "Dark",
    Acrylic = true,
    ToggleKey = Enum.KeyCode.RightShift, -- Explicitly sets Right Shift to open/close the menu
})

-- 3. Dedicated Key System Window / Tab
local KeyTab = Window:Tab({ Title = "Key System", Icon = "key" })
KeyTab:Paragraph({ Title = "Authentication Required", Desc = "Enter your key or use test keys ('admintest' / 'kisahub') to unlock the hub." })

local enteredKey = ""
KeyTab:Input({
    Title = "Enter Key",
    Placeholder = "Type key here...",
    Callback = function(value)
        enteredKey = value
    end,
})

local hubUnlocked = false

KeyTab:Button({
    Title = "Verify Key",
    Callback = function()
        if enteredKey == "admintest" or enteredKey == "kisahub" then
            hubUnlocked = true
            WindUI:Notify({ Title = "Success", Content = "Key verified! Hub unlocked.", Duration = 3 })
        else
            WindUI:Notify({ Title = "Access Denied", Content = "Invalid key. Try 'admintest' or 'kisahub'.", Duration = 3 })
        end
    end,
})

KeyTab:Button({
    Title = "Copy Key Link",
    Callback = function()
        pcall(function() setclipboard("https://kisahub.lovable.app") end)
        WindUI:Notify({ Title = "Link Copied", Content = "Key link copied to clipboard!", Duration = 3 })
    end,
})

-- Tabs
local Tabs = {
    Farm = Window:Tab({ Title = "Farm & Quest", Icon = "swords" }),
    Combat = Window:Tab({ Title = "Combat & ESP", Icon = "shield" }),
    Sea = Window:Tab({ Title = "Sea & Fruit", Icon = "compass" }),
    Sea1 = Window:Tab({ Title = "1st Sea Fly", Icon = "map" }),
    Sea2 = Window:Tab({ Title = "2nd Sea Fly", Icon = "map" }),
    Sea3 = Window:Tab({ Title = "3rd Sea Fly", Icon = "map" }),
    Misc = Window:Tab({ Title = "Misc & Server", Icon = "settings" }),
}

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
Tabs.Farm:Paragraph({ Title = "Farming Options", Desc = "Automated level farming and quest functions." })

Tabs.Farm:Toggle({
    Title = "Auto Farm Level",
    Default = false,
    Callback = function(Value)
        Config.AutoFarm = Value
    end,
})

Tabs.Farm:Toggle({
    Title = "Auto Accept / Get Quest",
    Default = false,
    Callback = function(Value)
        Config.AutoQuest = Value
    end,
})

Tabs.Farm:Toggle({
    Title = "Auto Collect Loot/Drops",
    Default = false,
    Callback = function(Value)
        Config.AutoCollect = Value
    end,
})

-- Combat & ESP Tab
Tabs.Combat:Paragraph({ Title = "Combat & Visuals", Desc = "Player tracking, NPC highlights, and automated targeting." })

Tabs.Combat:Toggle({
    Title = "Auto Combat Nearest NPC",
    Default = false,
    Callback = function(Value)
        Config.AutoCombat = Value
    end,
})

Tabs.Combat:Toggle({
    Title = "Player ESP + Distance",
    Default = false,
    Callback = function(Value)
        Config.PlayerESP = Value
    end,
})

Tabs.Combat:Toggle({
    Title = "NPC / Enemy ESP",
    Default = false,
    Callback = function(Value)
        Config.NpcESP = Value
    end,
})

-- Sea & Fruit Tab
Tabs.Sea:Paragraph({ Title = "Ocean Utilities", Desc = "Sea beast tracking and fruit notification features." })

Tabs.Sea:Toggle({
    Title = "Auto Sea Beast Hunt",
    Default = false,
    Callback = function(Value)
        Config.AutoSeaBeast = Value
    end,
})

Tabs.Sea:Toggle({
    Title = "Fruit Notifier & Fly to Fruit",
    Default = false,
    Callback = function(Value)
        Config.FruitNotifier = Value
    end,
})

-- Helper function for Flight toggles with exclusive toggle behavior
local activeToggles = {}

local function addFlightToggle(tab, name, cframe, flagName)
    local toggleObj
    toggleObj = tab:Toggle({
        Title = "Fly to " .. name,
        Default = false,
        Callback = function(Value)
            if Value then
                for fName, toggleData in pairs(activeToggles) do
                    if fName ~= flagName and toggleData.State() then
                        toggleData.Set(false)
                    end
                end
                Config.ActiveFlightTarget = cframe
                WindUI:Notify({
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
        Set = function(val)
            toggleObj:Set(val)
        end,
        State = function()
            return toggleObj.Value
        end
    }
end

-- 1st Sea Fly Tab
Tabs.Sea1:Paragraph({ Title = "First Sea Destinations", Desc = "Teleport flight paths for Sea 1." })
addFlightToggle(Tabs.Sea1, "Starter Island (Marine)", CFrame.new(979.9, 16.3, 1421.1), "Sea1_Marine")
addFlightToggle(Tabs.Sea1, "Starter Island (Pirate)", CFrame.new(1058.0, 16.3, 1373.1), "Sea1_Pirate")
addFlightToggle(Tabs.Sea1, "Jungle", CFrame.new(-1249.2, 11.9, 360.7), "Sea1_Jungle")
addFlightToggle(Tabs.Sea1, "Pirate Village", CFrame.new(-1140.0, 4.8, 3827.1), "Sea1_PirateVillage")
addFlightToggle(Tabs.Sea1, "Desert", CFrame.new(895.5, 6.5, 4390.6), "Sea1_Desert")
addFlightToggle(Tabs.Sea1, "Snow Island", CFrame.new(1347.9, 87.2, -1319.5), "Sea1_Snow")
addFlightToggle(Tabs.Sea1, "Marine Fortress", CFrame.new(-4884.2, 20.7, 4363.2), "Sea1_MarineFortress")
addFlightToggle(Tabs.Sea1, "Sky Island 1", CFrame.new(-4839.8, 717.6, -2619.7), "Sea1_Sky1")
addFlightToggle(Tabs.Sea1, "Prison", CFrame.new(4875.3, 5.7, 739.0), "Sea1_Prison")
addFlightToggle(Tabs.Sea1, "Colosseum", CFrame.new(-1390.8, 7.3, -2803.6), "Sea1_Colosseum")
addFlightToggle(Tabs.Sea1, "Magma Village", CFrame.new(-5247.9, 12.3, 8504.4), "Sea1_Magma")
addFlightToggle(Tabs.Sea1, "Underwater City", CFrame.new(61122.2, 18.5, 1567.3), "Sea1_Underwater")
addFlightToggle(Tabs.Sea1, "Fountain City", CFrame.new(5127.8, 59.9, 4105.7), "Sea1_Fountain")

-- 2nd Sea Fly Tab
Tabs.Sea2:Paragraph({ Title = "Second Sea Destinations", Desc = "Teleport flight paths for Sea 2." })
addFlightToggle(Tabs.Sea2, "Café", CFrame.new(387.5, 77.2, 325.6), "Sea2_Cafe")
addFlightToggle(Tabs.Sea2, "Green Zone", CFrame.new(-2453.1, 75.6, 3070.7), "Sea2_GreenZone")
addFlightToggle(Tabs.Sea2, "Graveyard", CFrame.new(-5503.2, 49.5, -793.8), "Sea2_Graveyard")
addFlightToggle(Tabs.Sea2, "Snow Mountain", CFrame.new(753.1, 408.2, -5277.4), "Sea2_SnowMountain")
addFlightToggle(Tabs.Sea2, "Cursed Ship", CFrame.new(923.3, 125.1, 32845.8), "Sea2_CursedShip")
addFlightToggle(Tabs.Sea2, "Ice Castle", CFrame.new(5505.4, 60.2, -6137.7), "Sea2_IceCastle")
addFlightToggle(Tabs.Sea2, "Forgotten Island", CFrame.new(-3042.8, 235.9, -10145.7), "Sea2_ForgottenIsland")
addFlightToggle(Tabs.Sea2, "Dark Arena", CFrame.new(3779.8, 23.0, -34988.8), "Sea2_DarkArena")

-- 3rd Sea Fly Tab
Tabs.Sea3:Paragraph({ Title = "Third Sea Destinations", Desc = "Teleport flight paths for Sea 3." })
addFlightToggle(Tabs.Sea3, "Mansion", CFrame.new(-12465.8, 332.1, -7551.9), "Sea3_Mansion")
addFlightToggle(Tabs.Sea3, "Port Town", CFrame.new(-290.5, 43.8, 5362.8), "Sea3_PortTown")
addFlightToggle(Tabs.Sea3, "Great Tree", CFrame.new(2304.3, 24.5, -6719.5), "Sea3_GreatTree")
addFlightToggle(Tabs.Sea3, "Floating Turtle", CFrame.new(-12465.8, 332.1, -7551.9), "Sea3_FloatingTurtle")
addFlightToggle(Tabs.Sea3, "Castle on the Sea", CFrame.new(-5084.2, 317.0, -3156.8), "Sea3_CastleOnSea")
addFlightToggle(Tabs.Sea3, "Haunted Castle", CFrame.new(-9513.2, 165.1, 5621.1), "Sea3_HauntedCastle")
addFlightToggle(Tabs.Sea3, "Sea of Treats", CFrame.new(-2100.0, 48.1, -12200.0), "Sea3_SeaOfTreats")
addFlightToggle(Tabs.Sea3, "Tiki Outpost", CFrame.new(-16531.5, 52.6, 1150.3), "Sea3_TikiOutpost")

-- Misc & Server Tab
Tabs.Misc:Paragraph({ Title = "Character & Servers", Desc = "Speed modifications, server hopping, and key options." })

Tabs.Misc:Toggle({
    Title = "Speed Modification (Fast Walk)",
    Default = false,
    Callback = function(Value)
        Config.CustomSpeed = Value
    end,
})

Tabs.Misc:Button({
    Title = "Copy Key Link to Clipboard",
    Callback = function()
        pcall(function()
            setclipboard("https://kisahub.lovable.app")
        end)
        WindUI:Notify({
            Title = "Success",
            Content = "Key link copied to clipboard!",
            Duration = 3
        })
    end,
})

Tabs.Misc:Button({
    Title = "Instant Server Hop",
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

-- =========================================================================
-- ESP & FARM ENGINE LOOPS
-- =========================================================================
local playerHighlights = {}
local enemyHighlights = {}

local function updateESP()
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= player and plr.Character then
            if Config.PlayerESP then
                if not playerHighlights[plr] then
                    local hl = Instance.new("Highlight")
                    hl.Adornee = plr.Character
                    hl.FillColor = Color3.fromRGB(0, 170, 255)
                    hl.OutlineColor = Color3.fromRGB(255, 255, 255)
                    hl.Parent = plr.Character
                    playerHighlights[plr] = hl
                else
                    playerHighlights[plr].Enabled = true
                end
            else
                if playerHighlights[plr] then
                    playerHighlights[plr].Enabled = false
                end
            end
        end
    end

    local enemiesFolder = Workspace:FindFirstChild("Enemies")
    if enemiesFolder then
        for _, enemy in ipairs(enemiesFolder:GetChildren()) do
            if enemy:FindFirstChild("HumanoidRootPart") and enemy:FindFirstChildOfClass("Humanoid") then
                if Config.NpcESP then
                    if not enemyHighlights[enemy] then
                        local hl = Instance.new("Highlight")
                        hl.Adornee = enemy
                        hl.FillColor = Color3.fromRGB(255, 50, 50)
                        hl.OutlineColor = Color3.fromRGB(255, 255, 255)
                        hl.Parent = enemy
                        enemyHighlights[enemy] = hl
                    else
                        enemyHighlights[enemy].Enabled = true
                    end
                else
                    if enemyHighlights[enemy] then
                        enemyHighlights[enemy].Enabled = false
                    end
                end
            end
        end
    end
end

RunService.Heartbeat:Connect(function(dt)
    pcall(function()
        updateESP()

        if not hubUnlocked then return end

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
                hrp.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
            end
        end

        if Config.AutoCollect then
            for _, obj in ipairs(Workspace:GetChildren()) do
                if (obj:IsA("Part") or obj:IsA("MeshPart")) and (obj.Name:lower():find("chest") or obj.Name:lower():find("drop")) then
                    hrp.CFrame = obj.CFrame + Vector3.new(0, 3, 0)
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

        if Config.AutoFarm or Config.AutoCombat then
            local enemiesFolder = Workspace:FindFirstChild("Enemies")
            if enemiesFolder then
                local closestEnemy = nil
                local shortestDist = math.huge

                for _, enemy in ipairs(enemiesFolder:GetChildren()) do
                    local eHrp = enemy:FindFirstChild("HumanoidRootPart")
                    local eHum = enemy:FindFirstChildOfClass("Humanoid")
                    if eHrp and eHum and eHum.Health > 0 then
                        local dist = (hrp.Position - eHrp.Position).Magnitude
                        if dist < shortestDist then
                            shortestDist = dist
                            closestEnemy = enemy
                        end
                    end
                end

                if closestEnemy and closestEnemy:FindFirstChild("HumanoidRootPart") then
                    local targetHrp = closestEnemy.HumanoidRootPart
                    hrp.CFrame = targetHrp.CFrame * CFrame.new(0, 5, 3)
                    
                    -- Every hit makes the durability go down by x1.
                    pcall(function()
                        local tool = character:FindFirstChildOfClass("Tool")
                        if tool then
                            tool:Activate()
                        end
                    end)
                end
            end
        end
    end)
end)
