local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CoreGui = game:GetService("CoreGui")

local player = Players.LocalPlayer

-- Forward declaration of main hub loader
local launchMainHub

-- 1. Load WindUI for the Key System
local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()

local WindowKey = WindUI:CreateWindow({
    Title = "Noobiekisa Hub [Key System]",
    Size = UDim2.new(0, 420, 0, 260),
    Transparent = false,
    Theme = "Dark",
    Acrylic = false
})

local TabKey = WindowKey:Tab({
    Title = "Authentication",
    Icon = "key"
})

local inputKey = ""

TabKey:Input({
    Title = "Enter Key",
    Placeholder = "Noob-Q...",
    Callback = function(Value)
        inputKey = Value
    end
})

local statusLabel = TabKey:Paragraph({
    Title = "Status",
    Content = "Please enter your key to load Noobiekisa Hub. (Keys last 12 hours)"
})

-- 12-Hour Key System Storage Handler
local KEY_DURATION = 12 * 60 * 60 -- 12 hours in seconds
local SAVE_FILE = "NoobiekisaHub_KeyData.json"

local function getSavedKeyData()
    local success, data = pcall(function()
        if readfile and isfile and isfile(SAVE_FILE) then
            return HttpService:JSONDecode(readfile(SAVE_FILE))
        end
    end)
    if success and type(data) == "table" then
        return data
    end
    return nil
end

local function saveKeyData(key)
    pcall(function()
        if writefile then
            local data = {
                Key = key,
                Expiry = os.time() + KEY_DURATION
            }
            writefile(SAVE_FILE, HttpService:JSONEncode(data))
        end
    end)
end

-- Check existing saved valid key on startup
local savedData = getSavedKeyData()
if savedData and savedData.Expiry and os.time() < savedData.Expiry then
    task.spawn(function()
        task.wait(0.5)
        pcall(function()
            WindowKey:Close()
        end)
        launchMainHub()
    end)
end

TabKey:Button({
    Title = "Verify Key",
    Callback = function()
        local cleanKey = string.match(inputKey or "", "^%s*(.-)%s*$")
        
        if cleanKey:match("^Noob%-Q[A-Za-z0-9][A-Za-z0-9][A-Za-z0-9][A-Za-z0-9][A-Za-z0-9][A-Za-z0-9][A-Za-z0-9][A-Za-z0-9][A-Za-z0-9][A-Za-z0-9][A-Za-z0-9][A-Za-z0-9][A-Za-z0-9][A-Za-z0-9][A-Za-z0-9]$") and #cleanKey == 21 then
            saveKeyData(cleanKey)
            statusLabel:SetDesc("Key verified successfully! (Valid for 12 hours). Loading main hub...")
            task.wait(0.5)
            
            pcall(function()
                WindowKey:Close()
            end)
            
            launchMainHub()
        else
            statusLabel:SetDesc("Incorrect key format. Try again.")
        end
    end
})

TabKey:Button({
    Title = "Copy Key Link",
    Callback = function()
        pcall(function()
            setclipboard("https://kisahub.lovable.app")
        end)
        statusLabel:SetDesc("Key link copied to clipboard!")
    end
})

-- Secret Developer Generator Tab (Only visible for authorized users)
local playerNameLower = player.Name:lower()
if playerNameLower == "noobiekisa" or playerNameLower == "noobiekisaalt" or playerNameLower == "farmmeguysiam" then
    local TabDev = WindowKey:Tab({
        Title = "Dev Generator",
        Icon = "shield-alert"
    })

    local generatedKeyDisplay = TabDev:Paragraph({
        Title = "Generated Key",
        Content = "Click below to generate a valid 12-hour bypass key."
    })

    TabDev:Button({
        Title = "Generate Valid Key",
        Callback = function()
            local chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
            local randomPart = ""
            for i = 1, 15 do
                local randIdx = math.random(1, #chars)
                randomPart = randomPart .. chars:sub(randIdx, randIdx)
            end
            local newValidKey = "Noob-Q" .. randomPart
            
            pcall(function()
                setclipboard(newValidKey)
            end)
            
            generatedKeyDisplay:SetDesc("Key: " .. newValidKey .. " (Copied to clipboard!)")
        end
    })
end


-- 2. Define Main Hub Function using Linoria Library
launchMainHub = function()
    local repo = 'https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/'
    local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
    local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
    local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()

    local Window = Library:CreateWindow({
        Title = 'Noobiekisa Hub [Blox Fruits]',
        Center = true,
        AutoShow = true,
        TabPadding = 8,
        MenuFadeTime = 0.2
    })

    -- Tabs
    local Tabs = {
        Farm = Window:AddTab('Farm & Quest'),
        Combat = Window:AddTab('Combat, ESP & Misc'),
        Sea = Window:AddTab('Sea & Fruit'),
        Fly = Window:AddTab('Island Fly'),
        Settings = Window:AddTab('UI Settings')
    }

    -- Groupboxes
    local FarmGroup = Tabs.Farm:AddLeftGroupbox('Farming Options')
    
    local CombatGroup = Tabs.Combat:AddLeftGroupbox('Combat & Visuals')
    local MiscGroup = Tabs.Combat:AddRightGroupbox('Character & Utilities')
    local ServerGroup = Tabs.Combat:AddRightGroupbox('Server Utilities')
    
    local SeaGroup = Tabs.Sea:AddLeftGroupbox('Ocean Utilities')
    
    local FlyGroup1 = Tabs.Fly:AddLeftGroupbox('1st Sea Destinations')
    local FlyGroup2 = Tabs.Fly:AddRightGroupbox('2nd Sea Destinations')
    local FlyGroup3 = Tabs.Fly:AddLeftGroupbox('3rd Sea Destinations')

    -- Settings Groupboxes (Linoria Theme & Unload Setup)
    local MenuGroup = Tabs.Settings:AddLeftGroupbox('Menu')

    MenuGroup:AddButton('Unload UI', function() 
        Library:Unload() 
    end)
    MenuGroup:AddLabel('Menu bind'):AddKeyPicker('MenuKeybind', { Default = 'End', NoUI = true, Text = 'Menu keybind' })

    Library.ToggleKeybind = Options.MenuKeybind

    ThemeManager:SetLibrary(Library)
    SaveManager:SetLibrary(Library)
    SaveManager:IgnoreThemeSettings()
    SaveManager:SetIgnoreIndexes({ 'MenuKeybind' })
    ThemeManager:SetFolder('NoobiekisaHub')
    SaveManager:SetFolder('NoobiekisaHub/blox_fruits')
    SaveManager:BuildConfigSection(Tabs.Settings)
    ThemeManager:ApplyToTab(Tabs.Settings)

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

    -- Farm Tab Elements
    FarmGroup:AddToggle('AutoFarm', {
        Text = 'Auto Farm Level',
        Default = false,
        Callback = function(Value) Config.AutoFarm = Value end
    })

    FarmGroup:AddToggle('AutoQuest', {
        Text = 'Auto Accept / Get Quest',
        Default = false,
        Callback = function(Value) Config.AutoQuest = Value end
    })

    FarmGroup:AddToggle('AutoCollect', {
        Text = 'Auto Collect Loot/Drops',
        Default = false,
        Callback = function(Value) Config.AutoCollect = Value end
    })

    -- Combat Tab Elements
    CombatGroup:AddToggle('AutoCombat', {
        Text = 'Auto Combat Nearest NPC',
        Default = false,
        Callback = function(Value) Config.AutoCombat = Value end
    })

    CombatGroup:AddToggle('PlayerESP', {
        Text = 'Player ESP + Distance',
        Default = false,
        Callback = function(Value) Config.PlayerESP = Value end
    })

    CombatGroup:AddToggle('NpcESP', {
        Text = 'NPC / Enemy ESP',
        Default = false,
        Callback = function(Value) Config.NpcESP = Value end
    })

    -- Sea Tab Elements
    SeaGroup:AddToggle('AutoSeaBeast', {
        Text = 'Auto Sea Beast Hunt',
        Default = false,
        Callback = function(Value) Config.AutoSeaBeast = Value end
    })

    SeaGroup:AddToggle('FruitNotifier', {
        Text = 'Fruit Notifier & Fly to Fruit',
        Default = false,
        Callback = function(Value) Config.FruitNotifier = Value end
    })

    -- Island Fly Dropdowns
    local function addFlightDropdown(group, name, destinations)
        group:AddDropdown('Dropdown_' .. name, {
            Values = destinations,
            Default = 1,
            Multi = false,
            Text = name,
            Callback = function(Value)
                pcall(function()
                    game:GetService("StarterGui"):SetCore("SendNotification", {
                        Title = "Feature Unavailable",
                        Text = "Island fly to " .. Value .. " is temporarily disabled.",
                        Duration = 3
                    })
                end)
            end
        })
    end

    addFlightDropdown(FlyGroup1, 'First Sea Select', {
        'Starter Island (Marine)', 'Starter Island (Pirate)', 'Jungle', 'Pirate Village',
        'Desert', 'Snow Island', 'Marine Fortress', 'Sky Island 1', 'Prison',
        'Colosseum', 'Magma Village', 'Underwater City', 'Fountain City'
    })

    addFlightDropdown(FlyGroup2, 'Second Sea Select', {
        'Café', 'Green Zone', 'Graveyard', 'Snow Mountain', 'Cursed Ship',
        'Ice Castle', 'Forgotten Island', 'Dark Arena'
    })

    addFlightDropdown(FlyGroup3, 'Third Sea Select', {
        'Mansion', 'Port Town', 'Great Tree', 'Floating Turtle',
        'Castle on the Sea', 'Haunted Castle', 'Sea of Treats', 'Tiki Outpost'
    })

    -- Misc / Character Elements
    MiscGroup:AddToggle('CustomSpeed', {
        Text = 'Speed Modification (Fast Walk)',
        Default = false,
        Callback = function(Value) Config.CustomSpeed = Value end
    })

    ServerGroup:AddButton('Copy Key Link', function()
        pcall(function()
            setclipboard("https://kisahub.lovable.app")
        end)
    end)

    ServerGroup:AddButton('Instant Server Hop', function()
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
    end)

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
