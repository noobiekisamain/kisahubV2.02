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

-- 2. Create Standalone Key System Window First
local KeyWindow = WindUI:CreateWindow({
    Title = "Noobiekisa Hub [Key System]",
    Icon = "key",
    Author = "by Kisa",
    Folder = "KisahubKey",
    Size = UDim2.fromOffset(450, 260),
    Transparent = true,
    Theme = "Dark",
    Acrylic = true,
    ToggleKey = Enum.KeyCode.Insert,
})

local KeyTab = KeyWindow:Tab({ Title = "Authentication", Icon = "key" })
KeyTab:Paragraph({ Title = "Key Required", Desc = "Please enter your key to load Noobiekisa Hub." })

local enteredKey = ""
KeyTab:Input({
    Title = "Enter Key",
    Placeholder = "Type key here...",
    Callback = function(value)
        enteredKey = value
    end,
})

local launchMainHub

KeyTab:Button({
    Title = "Verify Key",
    Callback = function()
        -- Trim any accidental spaces from user input
        local cleanKey = string.match(enteredKey, "^%s*(.-)%s*$")
        
        -- Exact validation: starts with "Noob-Q" followed by precisely 15 alphanumeric characters (no symbols)
        if cleanKey:match("^Noob%-Q[A-Za-z0-9][A-Za-z0-9][A-Za-z0-9][A-Za-z0-9][A-Za-z0-9][A-Za-z0-9][A-Za-z0-9][A-Za-z0-9][A-Za-z0-9][A-Za-z0-9][A-Za-z0-9][A-Za-z0-9][A-Za-z0-9][A-Za-z0-9][A-Za-z0-9]$") and #cleanKey == 21 then
            WindUI:Notify({ Title = "Success", Content = "Key correct! Loading hub...", Duration = 2 })
            
            pcall(function()
                KeyWindow:Close()
            end)
            
            launchMainHub()
        else
            WindUI:Notify({ Title = "Access Denied", Content = "Incorrect key format. Try again.", Duration = 3 })
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

-- 3. Define Main Hub Function (All features and modules are locked inside this closure)
launchMainHub = function()
    local Window = WindUI:CreateWindow({
        Title = "Noobiekisa Hub [Blox Fruits]",
        Icon = "swords",
        Author = "by Kisa",
        Folder = "Kisahub",
        Size = UDim2.fromOffset(580, 460),
        Transparent = true,
        Theme = "Dark",
        Acrylic = true,
        ToggleKey = Enum.KeyCode.RightShift,
    })

    -- Initialize Content Tabs
    local FarmTab = Window:Tab({ Title = "Farm & Quest", Icon = "swords" })
    local CombatTab = Window:Tab({ Title = "Combat & ESP", Icon = "shield" })
    local SeaTab = Window:Tab({ Title = "Sea & Fruit", Icon = "compass" })
    local Sea1Tab = Window:Tab({ Title = "1st Sea Fly", Icon = "map" })
    local Sea2Tab = Window:Tab({ Title = "2nd Sea Fly", Icon = "map" })
    local Sea3Tab = Window:Tab({ Title = "3rd Sea Fly", Icon = "map" })
    local MiscTab = Window:Tab({ Title = "Misc & Server", Icon = "settings" })

    local Config = {
        AutoFarm = false,
        AutoQuest = false,
        AutoCollect = false,
        AutoCombat = false,
        AutoSeaBeast = false,
        FruitNotifier = false,
        PlayerESP = false,
        NpcESP = false,
        CustomSpeed = false
    }

    -- Farm & Quest Tab
    FarmTab:Paragraph({ Title = "Farming Options", Desc = "Automated level farming and quest functions." })

    FarmTab:Toggle({
        Title = "Auto Farm Level",
        Default = false,
        Callback = function(Value)
            Config.AutoFarm = Value
        end,
    })

    FarmTab:Toggle({
        Title = "Auto Accept / Get Quest",
        Default = false,
        Callback = function(Value)
            Config.AutoQuest = Value
        end,
    })

    FarmTab:Toggle({
        Title = "Auto Collect Loot/Drops",
        Default = false,
        Callback = function(Value)
            Config.AutoCollect = Value
        end,
    })

    -- Combat & ESP Tab
    CombatTab:Paragraph({ Title = "Combat & Visuals", Desc = "Player tracking, NPC highlights, and automated targeting." })

    CombatTab:Toggle({
        Title = "Auto Combat Nearest NPC",
        Default = false,
        Callback = function(Value)
            Config.AutoCombat = Value
        end,
    })

    CombatTab:Toggle({
        Title = "Player ESP + Distance",
        Default = false,
        Callback = function(Value)
            Config.PlayerESP = Value
        end,
    })

    CombatTab:Toggle({
        Title = "NPC / Enemy ESP",
        Default = false,
        Callback = function(Value)
            Config.NpcESP = Value
        end,
    })

    -- Sea & Fruit Tab
    SeaTab:Paragraph({ Title = "Ocean Utilities", Desc = "Sea beast tracking and fruit notification features." })

    SeaTab:Toggle({
        Title = "Auto Sea Beast Hunt",
        Default = false,
        Callback = function(Value)
            Config.AutoSeaBeast = Value
        end,
    })

    SeaTab:Toggle({
        Title = "Fruit Notifier & Fly to Fruit",
        Default = false,
        Callback = function(Value)
            Config.FruitNotifier = Value
        end,
    })

    -- Island Fly Helper - Temporarily Disabled Notice
    local function addFlightToggle(tab, name)
        local toggleObj
        toggleObj = tab:Toggle({
            Title = "Fly to " .. name,
            Default = false,
            Callback = function(Value)
                if Value then
                    toggleObj:Set(false)
                    WindUI:Notify({
                        Title = "Feature Unavailable",
                        Content = "Island fly is temporarily disabled.",
                        Duration = 3
                    })
                end
            end,
        })
    end

    -- 1st Sea Fly Tab
    Sea1Tab:Paragraph({ Title = "First Sea Destinations", Desc = "Safe anti-cheat flight paths for Sea 1." })
    addFlightToggle(Sea1Tab, "Starter Island (Marine)")
    addFlightToggle(Sea1Tab, "Starter Island (Pirate)")
    addFlightToggle(Sea1Tab, "Jungle")
    addFlightToggle(Sea1Tab, "Pirate Village")
    addFlightToggle(Sea1Tab, "Desert")
    addFlightToggle(Sea1Tab, "Snow Island")
    addFlightToggle(Sea1Tab, "Marine Fortress")
    addFlightToggle(Sea1Tab, "Sky Island 1")
    addFlightToggle(Sea1Tab, "Prison")
    addFlightToggle(Sea1Tab, "Colosseum")
    addFlightToggle(Sea1Tab, "Magma Village")
    addFlightToggle(Sea1Tab, "Underwater City")
    addFlightToggle(Sea1Tab, "Fountain City")

    -- 2nd Sea Fly Tab
    Sea2Tab:Paragraph({ Title = "Second Sea Destinations", Desc = "Safe anti-cheat flight paths for Sea 2." })
    addFlightToggle(Sea2Tab, "Café")
    addFlightToggle(Sea2Tab, "Green Zone")
    addFlightToggle(Sea2Tab, "Graveyard")
    addFlightToggle(Sea2Tab, "Snow Mountain")
    addFlightToggle(Sea2Tab, "Cursed Ship")
    addFlightToggle(Sea2Tab, "Ice Castle")
    addFlightToggle(Sea2Tab, "Forgotten Island")
    addFlightToggle(Sea2Tab, "Dark Arena")

    -- 3rd Sea Fly Tab
    Sea3Tab:Paragraph({ Title = "Third Sea Destinations", Desc = "Safe anti-cheat flight paths for Sea 3." })
    addFlightToggle(Sea3Tab, "Mansion")
    addFlightToggle(Sea3Tab, "Port Town")
    addFlightToggle(Sea3Tab, "Great Tree")
    addFlightToggle(Sea3Tab, "Floating Turtle")
    addFlightToggle(Sea3Tab, "Castle on the Sea")
    addFlightToggle(Sea3Tab, "Haunted Castle")
    addFlightToggle(Sea3Tab, "Sea of Treats")
    addFlightToggle(Sea3Tab, "Tiki Outpost")

    -- Misc & Server Tab
    MiscTab:Paragraph({ Title = "Character & Appearance", Desc = "Speed modifications, UI themes, and server tools." })

    MiscTab:Toggle({
        Title = "Speed Modification (Fast Walk)",
        Default = false,
        Callback = function(Value)
            Config.CustomSpeed = Value
        end,
    })

    MiscTab:Dropdown({
        Title = "Select UI Theme",
        Values = {"Dark", "Light", "Rose", "Plant", "Indigo", "Sky", "Violet", "Amber", "Emerald", "Midnight", "Crimson"},
        Default = "Dark",
        Callback = function(selectedTheme)
            pcall(function()
                WindUI:SetTheme(selectedTheme)
            end)
        end,
    })

    MiscTab:Button({
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

    MiscTab:Button({
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
    -- ESP, SEA BEAST HUNT & FARM ENGINE LOOPS
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

            if Config.AutoSeaBeast then
                local targetBeast = nil
                local sbFolder = Workspace:FindFirstChild("SeaBeasts") or Workspace:FindFirstChild("Enemies")
                if sbFolder then
                    for _, obj in ipairs(sbFolder:GetChildren()) do
                        if obj.Name:lower():find("seabeast") or obj.Name:lower():find("sea beast") then
                            local bHrp = obj:FindFirstChild("HumanoidRootPart")
                            local bHum = obj:FindFirstChildOfClass("Humanoid")
                            if bHrp and bHum and bHum.Health > 0 then
                                targetBeast = obj
                                break
                            end
                        end
                    end
                end

                if targetBeast and targetBeast:FindFirstChild("HumanoidRootPart") then
                    local bHrp = targetBeast.HumanoidRootPart
                    hrp.CFrame = bHrp.CFrame * CFrame.new(0, 30, 0)
                    pcall(function()
                        local tool = character:FindFirstChildOfClass("Tool")
                        if tool then
                            tool:Activate()
                        end
                    end)
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
                        if eHrp and eHum and eHum.Health > 0 and not enemy.Name:lower():find("seabeast") then
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
end
