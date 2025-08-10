-- 📌 ต้องรันใน LocalScript เท่านั้น
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- UI หลัก
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "BlackhubUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

local font = Enum.Font.GothamSemibold

-- Main Frame
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 350, 0, 400)
mainFrame.Position = UDim2.new(0.5, -175, 0.5, -200)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
mainFrame.BorderColor3 = Color3.fromRGB(255, 0, 0)
mainFrame.Visible = true
mainFrame.Parent = screenGui

-- Top Bar
local topBar = Instance.new("Frame", mainFrame)
topBar.Size = UDim2.new(1, 0, 0, 35)
topBar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
topBar.BorderSizePixel = 0

local titleLabel = Instance.new("TextLabel", topBar)
titleLabel.Size = UDim2.new(1, -40, 1, 0)
titleLabel.Position = UDim2.new(0, 10, 0, 0)
titleLabel.Text = "Blackhub"
titleLabel.Font = font
titleLabel.TextSize = 18
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.BackgroundTransparency = 1
titleLabel.TextXAlignment = Enum.TextXAlignment.Left

local minimizeButton = Instance.new("TextButton", topBar)
minimizeButton.Size = UDim2.new(0, 30, 0, 30)
minimizeButton.Position = UDim2.new(1, -35, 0, 2)
minimizeButton.Text = "➖"
minimizeButton.Font = font
minimizeButton.TextSize = 20
minimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
minimizeButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
minimizeButton.BorderColor3 = Color3.fromRGB(255, 0, 0)

-- Tab Buttons
local tabButtonsFrame = Instance.new("Frame", mainFrame)
tabButtonsFrame.Size = UDim2.new(1, 0, 0, 40)
tabButtonsFrame.Position = UDim2.new(0, 0, 0, 35)
tabButtonsFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
tabButtonsFrame.BorderSizePixel = 0

local tabs = {"Main", "Teleports", "Misc", "Player", "Pets"}
local tabButtons = {}

for i, tabName in ipairs(tabs) do
    local tabButton = Instance.new("TextButton", tabButtonsFrame)
    tabButton.Size = UDim2.new(1/#tabs, 0, 1, 0)
    tabButton.Position = UDim2.new((i-1)/#tabs, 0, 0, 0)
    tabButton.Text = tabName
    tabButton.Font = font
    tabButton.TextSize = 14
    tabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    tabButton.BackgroundColor3 = i == 1 and Color3.fromRGB(40, 40, 40) or Color3.fromRGB(30, 30, 30)
    tabButton.BorderSizePixel = 0
    tabButton.Name = tabName
    
    tabButton.MouseButton1Click:Connect(function()
        for _, btn in ipairs(tabButtons) do
            btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        end
        tabButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        -- Switch tabs logic would go here
    end)
    
    table.insert(tabButtons, tabButton)
end

-- Content Frame
local contentFrame = Instance.new("Frame", mainFrame)
contentFrame.Position = UDim2.new(0, 0, 0, 75)
contentFrame.Size = UDim2.new(1, 0, 1, -75)
contentFrame.BackgroundTransparency = 1

-- Auto Plant Section
local autoPlantFrame = Instance.new("Frame", contentFrame)
autoPlantFrame.Size = UDim2.new(1, -20, 0, 200)
autoPlantFrame.Position = UDim2.new(0, 10, 0, 10)
autoPlantFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
autoPlantFrame.BorderColor3 = Color3.fromRGB(255, 0, 0)

local autoPlantTitle = Instance.new("TextLabel", autoPlantFrame)
autoPlantTitle.Size = UDim2.new(1, 0, 0, 30)
autoPlantTitle.Position = UDim2.new(0, 0, 0, 0)
autoPlantTitle.Text = "Auto Plant"
autoPlantTitle.Font = font
autoPlantTitle.TextSize = 16
autoPlantTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
autoPlantTitle.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
autoPlantTitle.BorderSizePixel = 0

-- Harvesting Section
local harvestingTitle = Instance.new("TextLabel", autoPlantFrame)
harvestingTitle.Size = UDim2.new(1, -10, 0, 25)
harvestingTitle.Position = UDim2.new(0, 5, 0, 35)
harvestingTitle.Text = "Harvesting"
harvestingTitle.Font = font
harvestingTitle.TextSize = 14
harvestingTitle.TextColor3 = Color3.fromRGB(200, 200, 200)
harvestingTitle.BackgroundTransparency = 1
harvestingTitle.TextXAlignment = Enum.TextXAlignment.Left

local selectMutations = Instance.new("TextLabel", autoPlantFrame)
selectMutations.Size = UDim2.new(1, -10, 0, 20)
selectMutations.Position = UDim2.new(0, 5, 0, 60)
selectMutations.Text = "Select Mutations"
selectMutations.Font = font
selectMutations.TextSize = 12
selectMutations.TextColor3 = Color3.fromRGB(180, 180, 180)
selectMutations.BackgroundTransparency = 1
selectMutations.TextXAlignment = Enum.TextXAlignment.Left

local tryAquil = Instance.new("TextLabel", autoPlantFrame)
tryAquil.Size = UDim2.new(1, -10, 0, 20)
tryAquil.Position = UDim2.new(0, 5, 0, 80)
tryAquil.Text = "Try aquil"
tryAquil.Font = font
tryAquil.TextSize = 12
tryAquil.TextColor3 = Color3.fromRGB(180, 180, 180)
tryAquil.BackgroundTransparency = 1
tryAquil.TextXAlignment = Enum.TextXAlignment.Left

-- Fruit Selection
local fruitOptions = {"All", "Normal", "Gold", "Select Fruit Wanted", "Various"}
local fruitYPos = 105

for i, option in ipairs(fruitOptions) do
    local fruitOption = Instance.new("TextLabel", autoPlantFrame)
    fruitOption.Size = UDim2.new(1, -20, 0, 20)
    fruitOption.Position = UDim2.new(0, 15, 0, fruitYPos)
    fruitOption.Text = "- " .. option
    fruitOption.Font = font
    fruitOption.TextSize = 12
    fruitOption.TextColor3 = Color3.fromRGB(180, 180, 180)
    fruitOption.BackgroundTransparency = 1
    fruitOption.TextXAlignment = Enum.TextXAlignment.Left
    fruitYPos = fruitYPos + 20
end

-- Harvest Delay
local harvestDelayFrame = Instance.new("Frame", contentFrame)
harvestDelayFrame.Size = UDim2.new(1, -20, 0, 50)
harvestDelayFrame.Position = UDim2.new(0, 10, 0, 220)
harvestDelayFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
harvestDelayFrame.BorderColor3 = Color3.fromRGB(255, 0, 0)

local harvestDelayTitle = Instance.new("TextLabel", harvestDelayFrame)
harvestDelayTitle.Size = UDim2.new(1, 0, 0, 30)
harvestDelayTitle.Position = UDim2.new(0, 0, 0, 0)
harvestDelayTitle.Text = "Harvest Delay"
harvestDelayTitle.Font = font
harvestDelayTitle.TextSize = 16
harvestDelayTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
harvestDelayTitle.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
harvestDelayTitle.BorderSizePixel = 0

local delayValue = Instance.new("TextLabel", harvestDelayFrame)
delayValue.Size = UDim2.new(1, -10, 0, 20)
delayValue.Position = UDim2.new(0, 10, 0, 30)
delayValue.Text = "1 Harvest Delay"
delayValue.Font = font
delayValue.TextSize = 14
delayValue.TextColor3 = Color3.fromRGB(200, 200, 200)
delayValue.BackgroundTransparency = 1
delayValue.TextXAlignment = Enum.TextXAlignment.Left

-- Teleport Section (from your existing code)
local teleportFrame = Instance.new("Frame", contentFrame)
teleportFrame.Size = UDim2.new(1, -20, 1, -240)
teleportFrame.Position = UDim2.new(0, 10, 0, 280)
teleportFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
teleportFrame.BorderColor3 = Color3.fromRGB(255, 0, 0)
teleportFrame.Visible = false

local teleportTitle = Instance.new("TextLabel", teleportFrame)
teleportTitle.Size = UDim2.new(1, 0, 0, 30)
teleportTitle.Position = UDim2.new(0, 0, 0, 0)
teleportTitle.Text = "Teleports"
teleportTitle.Font = font
teleportTitle.TextSize = 16
teleportTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
teleportTitle.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
teleportTitle.BorderSizePixel = 0

local searchBox = Instance.new("TextBox", teleportFrame)
searchBox.Size = UDim2.new(1, -20, 0, 35)
searchBox.Position = UDim2.new(0, 10, 0, 40)
searchBox.PlaceholderText = "🔍 Search location..."
searchBox.Font = font
searchBox.TextSize = 18
searchBox.TextColor3 = Color3.new(1, 1, 1)
searchBox.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
searchBox.BorderColor3 = Color3.fromRGB(255, 0, 0)
searchBox.ClearTextOnFocus = false

local scrollFrame = Instance.new("ScrollingFrame", teleportFrame)
scrollFrame.Position = UDim2.new(0, 10, 0, 85)
scrollFrame.Size = UDim2.new(1, -20, 1, -95)
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
scrollFrame.ScrollBarThickness = 8
scrollFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
scrollFrame.BorderColor3 = Color3.fromRGB(255, 0, 0)
scrollFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
scrollFrame.ScrollingDirection = Enum.ScrollingDirection.Y

local UIListLayout = Instance.new("UIListLayout", scrollFrame)
UIListLayout.Padding = UDim.new(0, 8)
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

-- จุดทั้งหมดจากโค้ดเดิม
local locations = {
    {name = "ตลาดโลก", cframe = CFrame.new(2846.01, 16.55, 2108.39)},
    {name = "ATM ตลาดโลก", cframe = CFrame.new(2999.37, 16.60, 2278.67)},
    {name = "ผับ", cframe = CFrame.new(3158.82, 16.69, 2300.57)},
    {name = "ร้านอาหาร", cframe = CFrame.new(3486.12, 18.24, 2581.56)},
    {name = "อู่", cframe = CFrame.new(2814.99, 18.24, 2671.00)},
    {name = "โรงพยาบาล", cframe = CFrame.new(3012.29, 16.64, 3526.09)},
    {name = "สถานีตำรวจ", cframe = CFrame.new(3632.24, 24.07, 3215.28)},
    {name = "หมู", cframe = CFrame.new(-533.00, 58.63, 3132.92)},
    {name = "กล้วย", cframe = CFrame.new(-1099.27, 130.38, 2420.52)},
    {name = "ดอกไม้", cframe = CFrame.new(-1790.67, 130.10, 1135.51)},
    {name = "มะพร้าว", cframe = CFrame.new(-2832.60, 20.46, 2197.16)},
    {name = "แลนแดง", cframe = CFrame.new(-3891.84, 76.42, -486.54)},
    {name = "เหล็ก1", cframe = CFrame.new(-4078.10, 70.95, -2818.08)},
    {name = "หญ้า", cframe = CFrame.new(-2445.71, 74.97, -2037.70)},
    {name = "พริก", cframe = CFrame.new(-611.63, 16.96, -3343.03)},
    {name = "หิน", cframe = CFrame.new(-191.36, 17.35, -2391.63)},
    {name = "แลกมะม่วง", cframe = CFrame.new(1060.44, 18.08, -521.77)},
    {name = "ไม้", cframe = CFrame.new(2410.08, 33.03, -2410.61)},
    {name = "แปรรูปหิน", cframe = CFrame.new(6149.76, 51.03, -4225.38)},
    {name = "ร้านค้าและปั้ม", cframe = CFrame.new(5668.79, 50.98, -3112.81)},
    {name = "ข้าวโพด", cframe = CFrame.new(5207.04, 47.10, -2238.00)},
    {name = "องุ่น", cframe = CFrame.new(5460.13, 49.22, -1191.45)},
    {name = "สตอร์เบอรี่", cframe = CFrame.new(5949.39, 50.97, -1699.58)},
    {name = "กระหล่ำ", cframe = CFrame.new(6085.44, 51.19, -2235.12)},
}

-- ฟังก์ชันสร้างปุ่ม
local function createTPItem(location)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -10, 0, 45)
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    btn.BorderColor3 = Color3.fromRGB(255, 0, 0)
    btn.Text = location.name
    btn.Font = font
    btn.TextSize = 18
    btn.TextColor3 = Color3.fromRGB(255, 0, 0)
    btn.AutoButtonColor = false
    btn.Name = location.name:lower()

    btn.MouseEnter:Connect(function()
        btn.BackgroundColor3 = Color3.fromRGB(60, 20, 20)
    end)
    btn.MouseLeave:Connect(function()
        btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    end)

    btn.MouseButton1Click:Connect(function()
        local character = player.Character or player.CharacterAdded:Wait()
        local root = character:WaitForChild("HumanoidRootPart")
        root.CFrame = location.cframe
    end)

    btn.MouseButton2Click:Connect(function()
        if setclipboard then
            setclipboard("CFrame.new(" .. tostring(location.cframe) .. ")")
            btn.Text = "📋 Copied!"
            task.delay(1, function()
                btn.Text = location.name
            end)
        end
    end)

    btn.Parent = scrollFrame
end

-- ฟังก์ชันค้นหา
local function filterButtons(query)
    query = query:lower()
    for _, child in ipairs(scrollFrame:GetChildren()) do
        if child:IsA("TextButton") then
            child.Visible = (query == "") or (string.find(child.Name, query) ~= nil)
        end
    end
end

searchBox:GetPropertyChangedSignal("Text"):Connect(function()
    filterButtons(searchBox.Text)
end)

for _, loc in ipairs(locations) do
    createTPItem(loc)
end

-- Tab Switching
local function switchTab(tabName)
    autoPlantFrame.Visible = tabName == "Main"
    harvestDelayFrame.Visible = tabName == "Main"
    teleportFrame.Visible = tabName == "Teleports"
    -- Add other tabs as needed
end

for i, tabButton in ipairs(tabButtons) do
    tabButton.MouseButton1Click:Connect(function()
        switchTab(tabButton.Name)
    end)
end

-- ปุ่มย่อ/ขยาย
local minimized = false
minimizeButton.MouseButton1Click:Connect(function()
    minimized = not minimized
    contentFrame.Visible = not minimized
    minimizeButton.Text = minimized and "➕" or "➖"
end)

-- ปุ่ม Ctrl ซ่อน/แสดง
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.LeftControl or input.KeyCode == Enum.KeyCode.RightControl then
        mainFrame.Visible = not mainFrame.Visible
    end
end)

-- ปุ่ม Toggle ขวาล่าง
local toggleButton = Instance.new("TextButton", screenGui)
toggleButton.Size = UDim2.new(0, 40, 0, 40)
toggleButton.Position = UDim2.new(1, -50, 1, -50)
toggleButton.BackgroundColor3 = Color3.fromRGB(40, 0, 0)
toggleButton.BorderColor3 = Color3.fromRGB(255, 0, 0)
toggleButton.Text = "📦"
toggleButton.Font = font
toggleButton.TextSize = 20
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.Active = true

toggleButton.MouseButton1Click:Connect(function()
    mainFrame.Visible = not mainFrame.Visible
end)

-- Drag and Drop functionality
local dragging = false
local dragInput
local dragStart
local startPos

local function updateDrag(input)
    local delta = input.Position - dragStart
    mainFrame.Position = UDim2.new(
        startPos.X.Scale,
        startPos.X.Offset + delta.X,
        startPos.Y.Scale,
        startPos.Y.Offset + delta.Y
    )
end

topBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

topBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement and dragging then
        updateDrag(input)
    end
end)

-- Initialize with Main tab visible
switchTab("Main")
