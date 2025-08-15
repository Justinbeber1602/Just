-- 📌 Must run in LocalScript only
local player = game:Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

-- Main ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "JustHubMobile"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = game:GetService("CoreGui")

-- Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0.9, 0, 0.9, 0)
MainFrame.Position = UDim2.new(0.05, 0, 0.05, 0)
MainFrame.AnchorPoint = Vector2.new(0, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BackgroundTransparency = 0.1
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

-- Corner rounding
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0.03, 0)
UICorner.Parent = MainFrame

-- Drop shadow
local UIStroke = Instance.new("UIStroke")
UIStroke.Thickness = 2
UIStroke.Color = Color3.fromRGB(80, 80, 80)
UIStroke.Parent = MainFrame

-- Title Bar
local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Size = UDim2.new(1, 0, 0.08, 0)
TitleBar.Position = UDim2.new(0, 0, 0, 0)
TitleBar.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

local TitleText = Instance.new("TextLabel")
TitleText.Name = "TitleText"
TitleText.Size = UDim2.new(0.7, 0, 1, 0)
TitleText.Position = UDim2.new(0.15, 0, 0, 0)
TitleText.BackgroundTransparency = 1
TitleText.Text = "JustHub"
TitleText.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleText.TextScaled = true
TitleText.Font = Enum.Font.GothamBold
TitleText.Parent = TitleBar

-- Close Button
local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Size = UDim2.new(0.1, 0, 0.8, 0)
CloseButton.Position = UDim2.new(0.89, 0, 0.1, 0)
CloseButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextScaled = true
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Parent = TitleBar

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0.3, 0)
CloseCorner.Parent = CloseButton

CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Tab Buttons
local TabButtonsFrame = Instance.new("Frame")
TabButtonsFrame.Name = "TabButtonsFrame"
TabButtonsFrame.Size = UDim2.new(1, 0, 0.1, 0)
TabButtonsFrame.Position = UDim2.new(0, 0, 0.08, 0)
TabButtonsFrame.BackgroundTransparency = 1
TabButtonsFrame.Parent = MainFrame

-- Content Frame
local ContentFrame = Instance.new("Frame")
ContentFrame.Name = "ContentFrame"
ContentFrame.Size = UDim2.new(1, 0, 0.82, 0)
ContentFrame.Position = UDim2.new(0, 0, 0.18, 0)
ContentFrame.BackgroundTransparency = 1
ContentFrame.Parent = MainFrame

-- Scrolling Frame for content
local ScrollFrame = Instance.new("ScrollingFrame")
ScrollFrame.Name = "ScrollFrame"
ScrollFrame.Size = UDim2.new(1, 0, 1, 0)
ScrollFrame.Position = UDim2.new(0, 0, 0, 0)
ScrollFrame.BackgroundTransparency = 1
ScrollFrame.ScrollBarThickness = 5
ScrollFrame.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100)
ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
ScrollFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
ScrollFrame.Parent = ContentFrame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Padding = UDim.new(0, 10)
UIListLayout.Parent = ScrollFrame

-- Create tabs
local Tabs = {
    Teleport = {
        Name = "Teleport",
        Color = Color3.fromRGB(80, 120, 200)
    },
    Misc = {
        Name = "Misc",
        Color = Color3.fromRGB(200, 120, 80)
    }
}

local currentTab = nil

-- Function to create a tab button
local function createTabButton(tabName, color, positionX)
    local TabButton = Instance.new("TextButton")
    TabButton.Name = tabName.."TabButton"
    TabButton.Size = UDim2.new(0.45, 0, 0.9, 0)
    TabButton.Position = UDim2.new(positionX, 0, 0.05, 0)
    TabButton.BackgroundColor3 = color
    TabButton.Text = tabName
    TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    TabButton.TextScaled = true
    TabButton.Font = Enum.Font.GothamBold
    TabButton.Parent = TabButtonsFrame
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0.2, 0)
    Corner.Parent = TabButton
    
    TabButton.MouseButton1Click:Connect(function()
        if currentTab ~= tabName then
            -- Clear current content
            for _, child in ipairs(ScrollFrame:GetChildren()) do
                if child:IsA("Frame") then
                    child:Destroy()
                end
            end
            
            -- Show new content
            if tabName == "Teleport" then
                createTeleportContent()
            elseif tabName == "Misc" then
                createMiscContent()
            end
            
            currentTab = tabName
        end
    end)
    
    return TabButton
end

-- Create the tab buttons
local teleportTabButton = createTabButton("Teleport", Tabs.Teleport.Color, 0.025)
local miscTabButton = createTabButton("Misc", Tabs.Misc.Color, 0.525)

-- Function to create a button
local function createButton(text, description, callback, parent)
    local ButtonFrame = Instance.new("Frame")
    ButtonFrame.Name = text.."ButtonFrame"
    ButtonFrame.Size = UDim2.new(0.95, 0, 0, 60)
    ButtonFrame.Position = UDim2.new(0.025, 0, 0, 0)
    ButtonFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    ButtonFrame.Parent = parent
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0.1, 0)
    Corner.Parent = ButtonFrame
    
    local Button = Instance.new("TextButton")
    Button.Name = text.."Button"
    Button.Size = UDim2.new(1, 0, 1, 0)
    Button.Position = UDim2.new(0, 0, 0, 0)
    Button.BackgroundTransparency = 1
    Button.Text = ""
    Button.Parent = ButtonFrame
    
    local Title = Instance.new("TextLabel")
    Title.Name = "Title"
    Title.Size = UDim2.new(0.9, 0, 0.6, 0)
    Title.Position = UDim2.new(0.05, 0, 0.1, 0)
    Title.BackgroundTransparency = 1
    Title.Text = text
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.TextScaled = true
    Title.Font = Enum.Font.GothamBold
    Title.Parent = ButtonFrame
    
    local Desc = Instance.new("TextLabel")
    Desc.Name = "Description"
    Desc.Size = UDim2.new(0.9, 0, 0.3, 0)
    Desc.Position = UDim2.new(0.05, 0, 0.6, 0)
    Desc.BackgroundTransparency = 1
    Desc.Text = description
    Desc.TextColor3 = Color3.fromRGB(200, 200, 200)
    Desc.TextXAlignment = Enum.TextXAlignment.Left
    Desc.TextScaled = true
    Desc.Font = Enum.Font.Gotham
    Desc.Parent = ButtonFrame
    
    -- Hover effect
    Button.MouseEnter:Connect(function()
        TweenService:Create(ButtonFrame, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(70, 70, 70)}):Play()
    end)
    
    Button.MouseLeave:Connect(function()
        TweenService:Create(ButtonFrame, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(50, 50, 50)}):Play()
    end)
    
    Button.MouseButton1Click:Connect(function()
        TweenService:Create(ButtonFrame, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(100, 100, 100)}):Play()
        TweenService:Create(ButtonFrame, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(50, 50, 50)}):Play()
        callback()
    end)
    
    return ButtonFrame
end

-- Function to create teleport content
local function createTeleportContent()
    local SectionTitle = Instance.new("TextLabel")
    SectionTitle.Name = "TeleportSectionTitle"
    SectionTitle.Size = UDim2.new(0.9, 0, 0, 40)
    SectionTitle.Position = UDim2.new(0.05, 0, 0, 0)
    SectionTitle.BackgroundTransparency = 1
    SectionTitle.Text = "เลือกสถานที่"
    SectionTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    SectionTitle.TextScaled = true
    SectionTitle.Font = Enum.Font.GothamBold
    SectionTitle.Parent = ScrollFrame
    
    local locations = {
        {name = "ตลาดโลก", cframe = CFrame.new(2846.01, 16.55, 2108.39)},
        {name = "ATM ตลาดโลก", cframe = CFrame.new(2999.37, 16.60, 2278.67)},
        {name = "ผับ", cframe = CFrame.new(3158.82, 16.69, 2300.57)},
        {name = "ร้านอาหาร", cframe = CFrame.new(3486.12, 18.24, 2581.56)},
        {name = "อู่", cframe = CFrame.new(2814.99, 18.24, 2671.00)},
        {name = "โรงพยาบาล", cframe = UDim2.new(0.9, 0, 0, 40)
    SectionTitle.Position = UDim2.new(0.05, 0, 0, 0)
    SectionTitle.BackgroundTransparency = 1
    SectionTitle.Text = "ฟีเจอร์เสริม"
    SectionTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    SectionTitle.TextScaled = true
    SectionTitle.Font = Enum.Font.GothamBold
    SectionTitle.Parent = ScrollFrame
    
    -- Noclip Toggle
    local noclipEnabled = false
    local noclipConnection
    
    local function EnableNoclip()
        if noclipConnection then
            noclipConnection:Disconnect()
            noclipConnection = nil
        end
        noclipConnection = RunService.Stepped:Connect(function()
            if not noclipEnabled then return end
            local character = player.Character
            if character then
                for _, part in pairs(character:GetChildren()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end)
    end
    
    local function DisableNoclip()
        if noclipConnection then
            noclipConnection:Disconnect()
            noclipConnection = nil
        end
        local character = player.Character
        if character then
            for _, part in pairs(character:GetChildren()) do
                if part:IsA("BasePart") then
                    part.CanCollide = true
                end
            end
        end
    end
    
    local noclipButton = createButton("Noclip", "เปิด/ปิดโหมดเดินทะลุ", function()
        noclipEnabled = not noclipEnabled
        if noclipEnabled then
            EnableNoclip()
            noclipButton.Title.Text = "Noclip: เปิด"
        else
            DisableNoclip()
            noclipButton.Title.Text = "Noclip: ปิด"
        end
    end, ScrollFrame)
    
    -- More Misc buttons can be added here
end

-- Make window draggable
local dragging
local dragInput
local dragStart
local startPos

local function updateInput(input)
    local delta = input.Position - dragStart
    MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, 
                                 startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

TitleBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        updateInput(input)
    end
end)

-- Start with Teleport tab open
createTeleportContent()
currentTab = "Teleport"
