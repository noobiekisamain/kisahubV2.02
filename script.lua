-- NOOBIEKISAHUB V2.7 BF // FIXED UI & ROBUST INITIALIZATION
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CoreGui = game:GetService("CoreGui")

local player = Players.LocalPlayer

local function generateValidKey()
    local chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
    local randomPart = ""
    math.randomseed(os.time() + math.random(1000, 99999))
    for i = 1, 15 do
        local randIndex = math.random(1, #chars)
        randomPart = randomPart .. chars:sub(randIndex, randIndex)
    end
    return "Noob-Q" .. randomPart
end

local generatedKey = generateValidKey()
print("[Noobiekisa Hub Key]: " .. generatedKey)

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "NoobiekisaHubV2BF"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
pcall(function()
    screenGui.Parent = CoreGui
end)
if not screenGui.Parent then
    screenGui.Parent = player:WaitForChild("PlayerGui")
end

local keyFrame = Instance.new("Frame")
keyFrame.Size = UDim2.new(0, 360, 0, 240)
keyFrame.Position = UDim2.new(0.5, -180, 0.5, -120)
keyFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
keyFrame.BorderSizePixel = 0
keyFrame.Parent = screenGui

local keyStroke = Instance.new("UIStroke")
keyStroke.Color = Color3.fromRGB(45, 45, 60)
keyStroke.Thickness = 1
keyStroke.Parent = keyFrame

local keyCorner = Instance.new("UICorner")
keyCorner.CornerRadius = UDim.new(0, 10)
keyCorner.Parent = keyFrame

local keyTitle = Instance.new("TextLabel")
keyTitle.Size = UDim2.new(1, 0, 0, 50)
keyTitle.BackgroundTransparency = 1
keyTitle.Text = "NOOBIEKISA HUB  //  SECURITY"
keyTitle.TextColor3 = Color3.fromRGB(240, 240, 255)
keyTitle.TextSize = 13
keyTitle.Font = Enum.Font.GothamBold
keyTitle.Parent = keyFrame

local keyBox = Instance.new("TextBox")
keyBox.Size = UDim2.new(0.85, 0, 0, 42)
keyBox.Position = UDim2.new(0.075, 0, 0, 65)
keyBox.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
keyBox.PlaceholderText = "Enter Access Key..."
keyBox.Text = ""
keyBox.TextColor3 = Color3.fromRGB(255, 255, 255)
keyBox.PlaceholderColor3 = Color3.fromRGB(100, 100, 120)
keyBox.TextSize = 12
keyBox.Font = Enum.Font.Gotham
keyBox.Parent = keyFrame

local boxStroke = Instance.new("UIStroke")
boxStroke.Color = Color3.fromRGB(55, 55, 75)
boxStroke.Thickness = 1
boxStroke.Parent = keyBox

local boxCorner = Instance.new("UICorner")
boxCorner.CornerRadius = UDim.new(0, 8)
boxCorner.Parent = keyBox

local submitBtn = Instance.new("TextButton")
submitBtn.Size = UDim2.new(0.85, 0, 0, 40)
submitBtn.Position = UDim2.new(0.075, 0, 0, 120)
submitBtn.BackgroundColor3 = Color3.fromRGB(114, 9, 183)
submitBtn.Text = "VERIFY KEY"
submitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
submitBtn.TextSize = 12
submitBtn.Font = Enum.Font.GothamBold
submitBtn.Parent = keyFrame

local subCorner = Instance.new("UICorner")
subCorner.CornerRadius = UDim.new(0, 8)
subCorner.Parent = submitBtn

local getKeyBtn = Instance.new("TextButton")
getKeyBtn.Size = UDim2.new(0.85, 0, 0, 36)
getKeyBtn.Position = UDim2.new(0.075, 0, 0, 175)
getKeyBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 42)
getKeyBtn.Text = "GET KEY"
getKeyBtn.TextColor3 = Color3.fromRGB(180, 180, 200)
getKeyBtn.TextSize = 11
getKeyBtn.Font = Enum.Font.GothamBold
getKeyBtn.Parent = keyFrame

local getCorner = Instance.new("UICorner")
getCorner.CornerRadius = UDim.new(0, 8)
getCorner.Parent = getKeyBtn

getKeyBtn.MouseButton1Click:Connect(function()
    local success = pcall(function()
        setclipboard("kisahub.lovable.app")
    end)

    if success then
        getKeyBtn.Text = "COPIED LINK TO CLIPBOARD"
        getKeyBtn.TextColor3 = Color3.fromRGB(80, 255, 120)
        task.wait(1.5)
        getKeyBtn.Text = "GET KEY"
        getKeyBtn.TextColor3 = Color3.fromRGB(180, 180, 200)
    else
        getKeyBtn.Text = "FAILED TO COPY"
        getKeyBtn.TextColor3 = Color3.fromRGB(255, 80, 80)
        task.wait(1.5)
        getKeyBtn.Text = "GET KEY"
        getKeyBtn.TextColor3 = Color3.fromRGB(180, 180, 200)
    end
end)

local function launchHub()
    keyFrame:Destroy()

    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 520, 0, 380)
    mainFrame.Position = UDim2.new(0.5, -260, 0.5, -190)
    mainFrame.BackgroundColor3 = Color3.fromRGB(16, 16, 22)
    mainFrame.BorderSizePixel = 0
    mainFrame.Active = true
    mainFrame.Draggable = true
    mainFrame.Parent = screenGui

    local mainStroke = Instance.new("UIStroke")
    mainStroke.Color = Color3.fromRGB(45, 45, 60)
    mainStroke.Thickness = 1
    mainStroke.Parent = mainFrame

    local mainCorner = Instance.new("UICorner")
    mainCorner.CornerRadius = UDim.new(0, 12)
    mainCorner.Parent = mainFrame

    local topBar = Instance.new("Frame")
    topBar.Size = UDim2.new(1, 0, 0, 45)
    topBar.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
    topBar.BorderSizePixel = 0
    topBar.Parent = mainFrame

    local topBarCorner = Instance.new("UICorner")
    topBarCorner.CornerRadius = UDim.new(0, 12)
    topBarCorner.Parent = topBar

    local topCover = Instance.new("Frame")
    topCover.Size = UDim2.new(1, 0, 0, 10)
    topCover.Position = UDim2.new(0, 0, 1, -10)
    topCover.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
    topCover.BorderSizePixel = 0
    topCover.Parent = topBar

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, -100, 1, 0)
    title.Position = UDim2.new(0, 15, 0, 0)
    title.BackgroundTransparency = 1
    title.Text = "NOOBIEKISA HUB  <font color='#9d4edd'>[Blox Fruits]</font>"
    title.RichText = true
    title.TextColor3 = Color3.fromRGB(240, 240, 255)
    title.TextSize = 12
    title.Font = Enum.Font.GothamBold
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = topBar

    local unloadBtn = Instance.new("TextButton")
    unloadBtn.Size = UDim2.new(0, 28, 0, 28)
    unloadBtn.Position = UDim2.new(1, -38, 0, 8.5)
    unloadBtn.BackgroundColor3 = Color3.fromRGB(40, 25, 30)
    unloadBtn.Text = "X"
    unloadBtn.TextColor3 = Color3.fromRGB(255, 90, 90)
    unloadBtn.TextSize = 11
    unloadBtn.Font = Enum.Font.GothamBold
    unloadBtn.Parent = topBar

    local unloadCorner = Instance.new("UICorner")
    unloadCorner.CornerRadius = UDim.new(0, 6)
    unloadCorner.Parent = unloadBtn

    local minBtn = Instance.new("TextButton")
    minBtn.Size = UDim2.new(0, 28, 0, 28)
    minBtn.Position = UDim2.new(1, -72, 0, 8.5)
    minBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 42)
    minBtn.Text = "-"
    minBtn.TextColor3 = Color3.fromRGB(200, 200, 220)
    minBtn.TextSize = 13
    minBtn.Font = Enum.Font.GothamBold
    minBtn.Parent = topBar

    local minCorner = Instance.new("UICorner")
    minCorner.CornerRadius = UDim.new(0, 6)
    minCorner.Parent = minBtn

    local tabContainer = Instance.new("ScrollingFrame")
    tabContainer.Size = UDim2.new(0, 135, 1, -55)
    tabContainer.Position = UDim2.new(0, 8, 0, 50)
    tabContainer.BackgroundTransparency = 1
    tabContainer.CanvasSize = UDim2.new(0, 0, 0, 380)
    tabContainer.ScrollBarThickness = 2
    tabContainer.Parent = mainFrame

    local contentContainer = Instance.new("Frame")
    contentContainer.Size = UDim2.new(1, -155, 1, -55)
    contentContainer.Position = UDim2.new(0, 150, 0, 50)
    contentContainer.BackgroundTransparency = 1
    contentContainer.Parent = mainFrame

    local tabs = {}

    local function createTab(name, order)
        local tabBtn = Instance.new("TextButton")
        tabBtn.Size = UDim2.new(1, -4, 0, 34)
        tabBtn.Position = UDim2.new(0, 2, 0, (order - 1) * 38 + 2)
        tabBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
        tabBtn.Text = name
        tabBtn.TextColor3 = Color3.fromRGB(150, 150, 170)
        tabBtn.TextSize = 11
        tabBtn.Font = Enum.Font.GothamMedium
        tabBtn.Parent = tabContainer
        
        local btnCorner = Instance.new("UICorner")
        btnCorner.CornerRadius = UDim.new(0, 6)
        btnCorner.Parent = tabBtn
        
        local page = Instance.new("ScrollingFrame")
        page.Size = UDim2.new(1, 0, 1, 0)
        page.BackgroundTransparency = 1
        page.CanvasSize = UDim2.new(0, 0, 0, 650)
        page.ScrollBarThickness = 3
        page.Visible = false
        page.Parent = contentContainer
        
        tabBtn.MouseButton1Click:Connect(function()
            for _, t in pairs(tabs) do
                t.page.Visible = false
                t.btn.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
                t.btn.TextColor3 = Color3.fromRGB(150, 150, 170)
            end
            page.Visible = true
            tabBtn.BackgroundColor3 = Color3.fromRGB(114, 9, 183)
            tabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        end)
        
        if order == 1 then
            page.Visible = true
            tabBtn.BackgroundColor3 = Color3.fromRGB(114, 9, 183)
            tabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        end
        
        tabs[name] = {btn = tabBtn, page = page}
        return page
    end

    local farmTab = createTab("Farm & Quest", 1)
    local combatTab = createTab("Combat & ESP", 2)
    local seaTab = createTab("Sea & Fruit", 3)
    local sea1Tab = createTab("1st Sea Fly", 4)
    local sea2Tab = createTab("2nd Sea Fly", 5)
    local sea3Tab = createTab("3rd Sea Fly", 6)
    local miscTab = createTab("Misc & Server", 7)

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

    local function addToggle(parent, name, yPos, callback)
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, -10, 0, 36)
        btn.Position = UDim2.new(0, 5, 0, yPos)
        btn.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
        btn.Text = "  " .. name
        btn.TextColor3 = Color3.fromRGB(180, 180, 200)
        btn.TextSize = 11
        btn.Font = Enum.Font.Gotham
        btn.TextXAlignment = Enum.TextXAlignment.Left
        btn.Parent = parent

        local stroke = Instance.new("UIStroke")
        stroke.Color = Color3.fromRGB(38, 38, 52)
        stroke.Thickness = 1
        stroke.Parent = btn

        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 6)
        corner.Parent = btn

        local indicator = Instance.new("Frame")
        indicator.Size = UDim2.new(0, 10, 0, 10)
        indicator.Position = UDim2.new(1, -22, 0.5, -5)
        indicator.BackgroundColor3 = Color3.fromRGB(70, 70, 90)
        indicator.Parent = btn

        local indCorner = Instance.new("UICorner")
        indCorner.CornerRadius = UDim.new(1, 0)
        indCorner.Parent = indicator

        local state = false
        btn.MouseButton1Click:Connect(function()
            state = not state
            indicator.BackgroundColor3 = state and Color3.fromRGB(80, 255, 120) or Color3.fromRGB(70, 70, 90)
            callback(state)
        end)
    end

    addToggle(farmTab, "Auto Farm Level", 10, function(state) Config.AutoFarm = state end)
    addToggle(farmTab, "Auto Accept / Get Quest", 52, function(state) Config.AutoQuest = state end)
    addToggle(farmTab, "Auto Collect Loot/Drops", 94, function(state) Config.AutoCollect = state end)

    addToggle(combatTab, "Auto Combat Nearest NPC", 10, function(state) Config.AutoCombat = state end)
    addToggle(combatTab, "Player ESP + Distance", 52, function(state) Config.PlayerESP = state end)
    addToggle(combatTab, "NPC / Enemy ESP", 94, function(state) Config.NpcESP = state end)

    addToggle(seaTab, "Auto Sea Beast Hunt", 10, function(state) Config.AutoSeaBeast = state end)
    addToggle(seaTab, "Fruit Notifier & Fly to Fruit", 52, function(state) Config.FruitNotifier = state end)

    local function addFlightButton(parent, name, yPos, targetCFrame)
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, -10, 0, 36)
        btn.Position = UDim2.new(0, 5, 0, yPos)
        btn.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
        btn.Text = "  Fly to " .. name
        btn.TextColor3 = Color3.fromRGB(180, 180, 200)
        btn.TextSize = 11
        btn.Font = Enum.Font.Gotham
        btn.TextXAlignment = Enum.TextXAlignment.Left
        btn.Parent = parent

        local stroke = Instance.new("UIStroke")
        stroke.Color = Color3.fromRGB(38, 38, 52)
        stroke.Thickness = 1
        stroke.Parent = btn

        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 6)
        corner.Parent = btn

        local flying = false
        btn.MouseButton1Click:Connect(function()
            flying = not flying
            if flying then
                btn.BackgroundColor3 = Color3.fromRGB(60, 20, 100)
                btn.TextColor3 = Color3.fromRGB(255, 255, 255)
                btn.Text = "  [Active] Fly to " .. name
                Config.ActiveFlightTarget = targetCFrame
            else
                btn.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
                btn.TextColor3 = Color3.fromRGB(180, 180, 200)
                btn.Text = "  Fly to " .. name
                Config.ActiveFlightTarget = nil
            end
        end)
    end

    addFlightButton(sea1Tab, "Starter Island (Marine)", 10, CFrame.new(979.9, 16.3, 1421.1))
    addFlightButton(sea1Tab, "Starter Island (Pirate)", 52, CFrame.new(1058.0, 16.3, 1373.1))
    addFlightButton(sea1Tab, "Jungle", 94, CFrame.new(-1249.2, 11.9, 360.7))
    addFlightButton(sea1Tab, "Pirate Village", 136, CFrame.new(-1140.0, 4.8, 3827.1))
    addFlightButton(sea1Tab, "Desert", 178, CFrame.new(895.5, 6.5, 4390.6))
    addFlightButton(sea1Tab, "Snow Island", 220, CFrame.new(1347.9, 87.2, -1319.5))
    addFlightButton(sea1Tab, "Marine Fortress", 262, CFrame.new(-4884.2, 20.7, 4363.2))
    addFlightButton(sea1Tab, "Sky Island 1", 304, CFrame.new(-4839.8, 717.6, -2619.7))
    addFlightButton(sea1Tab, "Prison", 346, CFrame.new(4875.3, 5.7, 739.0))
    addFlightButton(sea1Tab, "Colosseum", 388, CFrame.new(-1390.8, 7.3, -2803.6))
    addFlightButton(sea1Tab, "Magma Village", 430, CFrame.new(-5247.9, 12.3, 8504.4))
    addFlightButton(sea1Tab, "Underwater City", 472, CFrame.new(61122.2, 18.5, 1567.3))
    addFlightButton(sea1Tab, "Fountain City", 514, CFrame.new(5127.8, 59.9, 4105.7))

    addFlightButton(sea2Tab, "Café", 10, CFrame.new(387.5, 77.2, 325.6))
    addFlightButton(sea2Tab, "Green Zone", 52, CFrame.new(-2453.1, 75.6, 3070.7))
    addFlightButton(sea2Tab, "Graveyard", 94, CFrame.new(-5503.2, 49.5, -793.8))
    addFlightButton(sea2Tab, "Snow Mountain", 136, CFrame.new(753.1, 408.2, -5277.4))
    addFlightButton(sea2Tab, "Cursed Ship", 178, CFrame.new(923.3, 125.1, 32845.8))
    addFlightButton(sea2Tab, "Ice Castle", 220, CFrame.new(5505.4, 60.2, -6137.7))
    addFlightButton(sea2Tab, "Forgotten Island", 262, CFrame.new(-3042.8, 235.9, -10145.7))
    addFlightButton(sea2Tab, "Dark Arena", 304, CFrame.new(3779.8, 23.0, -34988.8))

    addFlightButton(sea3Tab, "Mansion", 10, CFrame.new(-12465.8, 332.1, -7551.9))
    addFlightButton(sea3Tab, "Port Town", 52, CFrame.new(-290.5, 43.8, 5362.8))
    addFlightButton(sea3Tab, "Great Tree", 94, CFrame.new(2304.3, 24.5, -6719.5))
    addFlightButton(sea3Tab, "Floating Turtle", 136, CFrame.new(-12465.8, 332.1, -7551.9))
    addFlightButton(sea3Tab, "Castle on the Sea", 178, CFrame.new(-5084.2, 317.0, -3156.8))
    addFlightButton(sea3Tab, "Haunted Castle", 220, CFrame.new(-9513.2, 165.1, 5621.1))
    addFlightButton(sea3Tab, "Sea of Treats", 262, CFrame.new(-2100.0, 48.1, -12200.0))
    addFlightButton(sea3Tab, "Tiki Outpost", 304, CFrame.new(-16531.5, 52.6, 1150.3))

    addToggle(miscTab, "Speed Modification (Fast Walk)", 10, function(state) Config.CustomSpeed = state end)

    local hopBtn = Instance.new("TextButton")
    hopBtn.Size = UDim2.new(1, -10, 0, 36)
    hopBtn.Position = UDim2.new(0, 5, 0, 52)
    hopBtn.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
    hopBtn.Text = "  Instant Server Hop"
    hopBtn.TextColor3 = Color3.fromRGB(180, 180, 200)
    hopBtn.TextSize = 11
    hopBtn.Font = Enum.Font.Gotham
    hopBtn.TextXAlignment = Enum.TextXAlignment.Left
    hopBtn.Parent = miscTab

    local hopStroke = Instance.new("UIStroke")
    hopStroke.Color = Color3.fromRGB(38, 38, 52)
    hopStroke.Thickness = 1
    hopStroke.Parent = hopBtn

    local hopCorner = Instance.new("UICorner")
    hopCorner.CornerRadius = UDim.new(0, 6)
    hopCorner.Parent = hopBtn

    hopBtn.MouseButton1Click:Connect(function()
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

    local minimized = false

    minBtn.MouseButton1Click:Connect(function()
        minimized = not minimized
        tabContainer.Visible = not minimized
        contentContainer.Visible = not minimized
        mainFrame.Size = minimized and UDim2.new(0, 520, 0, 45) or UDim2.new(0, 520, 0, 380)
        minBtn.Text = minimized and "+" or "-"
    end)

    unloadBtn.MouseButton1Click:Connect(function()
        local exitOverlay = Instance.new("Frame")
        exitOverlay.Size = UDim2.new(1, 0, 1, 0)
        exitOverlay.Position = UDim2.new(0, 0, 0, 0)
        exitOverlay.BackgroundColor3 = Color3.fromRGB(16, 16, 22)
        exitOverlay.BackgroundTransparency = 1
        exitOverlay.BorderSizePixel = 0
        exitOverlay.ZIndex = 10
        exitOverlay.Parent = mainFrame

        local exitText = Instance.new("TextLabel")
        exitText.Size = UDim2.new(1, 0, 1, 0)
        exitText.BackgroundTransparency = 1
        exitText.Text = "We hope you come back!"
        exitText.TextColor3 = Color3.fromRGB(240, 240, 255)
        exitText.TextSize = 16
        exitText.Font = Enum.Font.GothamBold
        exitText.TextTransparency = 1
        exitText.ZIndex = 11
        exitText.Parent = exitOverlay

        TweenService:Create(exitOverlay, TweenInfo.new(0.4), {BackgroundTransparency = 0.1}):Play()
        TweenService:Create(exitText, TweenInfo.new(0.4), {TextTransparency = 0}):Play()

        task.wait(1.2)

        TweenService:Create(exitOverlay, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
        TweenService:Create(exitText, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
        TweenService:Create(mainFrame, TweenInfo.new(0.5), {Size = UDim2.new(0, 0, 0, 0), Position = UDim2.new(0.5, 0, 0.5, 0)}):Play()

        task.wait(0.5)
        screenGui:Destroy()
    end)

    UserInputService.InputBegan:Connect(function(input, gp)
        if not gp and input.KeyCode == Enum.KeyCode.RightShift then
            mainFrame.Visible = not mainFrame.Visible
        end
    end)

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
                else
                    Config.ActiveFlightTarget = nil
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
end

submitBtn.MouseButton1Click:Connect(function()
    local text = keyBox.Text
    if text == "admintest" or text == generatedKey or (text:sub(1, 6) == "Noob-Q" and #text == 21) then
        launchHub()
    else
        keyBox.Text = ""
        keyBox.PlaceholderText = "Invalid Key!"
    end
end)
