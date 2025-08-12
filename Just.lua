-- 📌 ต้องรันใน LocalScript เท่านั้น
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("JustHub", "BloodTheme")
local player = game.Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

-- ================= Teleport Tab =================
local TeleportTab = Window:NewTab("Teleport")
local LocationSection = TeleportTab:NewSection("เลือกสถานที่")

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

for _, loc in ipairs(locations) do
    LocationSection:NewButton(loc.name, "กดเพื่อวาร์ปไปยัง " .. loc.name, function()
        local character = player.Character or player.CharacterAdded:Wait()
        local root = character:WaitForChild("HumanoidRootPart")
        root.CFrame = loc.cframe
    end)
end

-- Player Teleport Section
local PlayerSection = TeleportTab:NewSection("วาร์ปไปหาผู้เล่น")

-- สร้าง Dropdown สำหรับเลือกผู้เล่น
local playersTable = {}
for _, v in pairs(game.Players:GetPlayers()) do
    if v ~= player then
        table.insert(playersTable, v.Name)
    end
end

PlayerSection:NewDropdown("เลือกผู้เล่น", "เลือกผู้เล่นที่ต้องการวาร์ปไปหา", playersTable, function(selectedPlayer)
    local targetPlayer = game.Players:FindFirstChild(selectedPlayer)
    if targetPlayer and targetPlayer.Character then
        local targetRoot = targetPlayer.Character:FindFirstChild("HumanoidRootPart")
        local myCharacter = player.Character or player.CharacterAdded:Wait()
        local myRoot = myCharacter:WaitForChild("HumanoidRootPart")
        
        if targetRoot and myRoot then
            myRoot.CFrame = targetRoot.CFrame * CFrame.new(0, 0, -5) -- วาร์ปไปด้านหลังผู้เล่น
        end
    end
end)

-- ปุ่มรีเฟรชรายชื่อผู้เล่น
PlayerSection:NewButton("รีเฟรชรายชื่อผู้เล่น", "อัพเดทรายชื่อผู้เล่นใหม่", function()
    -- ฟังก์ชันนี้จะต้องสร้าง Dropdown ใหม่ แต่ Kavo UI ไม่รองรับการอัพเดท Dropdown
    -- แนะนำให้ restart script เพื่ออัพเดทรายชื่อ
    game.StarterGui:SetCore("SendNotification", {
        Title = "JustHub",
        Text = "กรุณารีสตาร์ทสคริปต์เพื่ออัพเดทรายชื่อผู้เล่น",
        Duration = 3
    })
end)

-- ================= Misc Tab =================
local MiscTab = Window:NewTab("Misc")
local MiscSection = MiscTab:NewSection("ฟีเจอร์เสริม")

-- Noclip variables
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

-- Toggle สำหรับ Noclip
MiscSection:NewToggle("เปิด/ปิด Noclip", "เปิดหรือปิดโหมดเดินทะลุ", function(value)
    noclipEnabled = value
    if noclipEnabled then
        EnableNoclip()
    else
        DisableNoclip()
    end
end)

-- Fly System
local flyEnabled = false
local flyConnection
local flySpeed = 50
local bodyVelocity
local bodyAngularVelocity

local function EnableFly()
    local character = player.Character or player.CharacterAdded:Wait()
    local root = character:WaitForChild("HumanoidRootPart")
    local humanoid = character:WaitForChild("Humanoid")
    
    -- สร้าง BodyVelocity และ BodyAngularVelocity
    bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    bodyVelocity.Velocity = Vector3.new(0, 0, 0)
    bodyVelocity.Parent = root
    
    bodyAngularVelocity = Instance.new("BodyAngularVelocity")
    bodyAngularVelocity.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
    bodyAngularVelocity.AngularVelocity = Vector3.new(0, 0, 0)
    bodyAngularVelocity.Parent = root
    
    -- เชื่อมต่อ RenderStepped
    flyConnection = RunService.RenderStepped:Connect(function()
        if not flyEnabled then return end
        
        local camera = workspace.CurrentCamera
        local moveVector = humanoid.MoveDirection
        local lookVector = camera.CFrame.LookVector
        local rightVector = camera.CFrame.RightVector
        
        local velocity = Vector3.new(0, 0, 0)
        
        -- คำนวณทิศทางการเคลื่อนที่
        if moveVector.Magnitude > 0 then
            velocity = (lookVector * moveVector.Z + rightVector * moveVector.X) * flySpeed
        end
        
        -- เพิ่มการเคลื่อนที่ขึ้น/ลง
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
            velocity = velocity + Vector3.new(0, flySpeed, 0)
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
            velocity = velocity - Vector3.new(0, flySpeed, 0)
        end
        
        bodyVelocity.Velocity = velocity
    end)
end

local function DisableFly()
    if flyConnection then
        flyConnection:Disconnect()
        flyConnection = nil
    end
    
    if bodyVelocity then
        bodyVelocity:Destroy()
        bodyVelocity = nil
    end
    
    if bodyAngularVelocity then
        bodyAngularVelocity:Destroy()
        bodyAngularVelocity = nil
    end
end

-- Toggle สำหรับ Fly
MiscSection:NewToggle("เปิด/ปิด Fly", "เปิดหรือปิดโหมดบิน (ใช้ Space/Shift เพื่อบิน ขึ้น/ลง)", function(value)
    flyEnabled = value
    if flyEnabled then
        EnableFly()
        game.StarterGui:SetCore("SendNotification", {
            Title = "JustHub - Fly",
            Text = "เปิด Fly แล้ว | Space = ขึ้น | Shift = ลง",
            Duration = 3
        })
    else
        DisableFly()
        game.StarterGui:SetCore("SendNotification", {
            Title = "JustHub - Fly",
            Text = "ปิด Fly แล้ว",
            Duration = 3
        })
    end
end)

-- Slider สำหรับปรับความเร็ว Fly
MiscSection:NewSlider("ความเร็ว Fly", "ปรับความเร็วในการบิน", 100, 16, function(value)
    flySpeed = value
end)

-- God Mode System
local godModeEnabled = false
local originalHealth
local healthConnection

local function EnableGodMode()
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:WaitForChild("Humanoid")
    
    originalHealth = humanoid.MaxHealth
    humanoid.MaxHealth = math.huge
    humanoid.Health = math.huge
    
    healthConnection = humanoid.HealthChanged:Connect(function(health)
        if godModeEnabled and health < humanoid.MaxHealth then
            humanoid.Health = humanoid.MaxHealth
        end
    end)
end

local function DisableGodMode()
    if healthConnection then
        healthConnection:Disconnect()
        healthConnection = nil
    end
    
    local character = player.Character
    if character then
        local humanoid = character:FindFirstChild("Humanoid")
        if humanoid and originalHealth then
            humanoid.MaxHealth = originalHealth
            humanoid.Health = originalHealth
        end
    end
end

-- Toggle สำหรับ God Mode
MiscSection:NewToggle("เปิด/ปิด God Mode", "เปิดหรือปิดโหมดอมตะ", function(value)
    godModeEnabled = value
    if godModeEnabled then
        EnableGodMode()
        game.StarterGui:SetCore("SendNotification", {
            Title = "JustHub - God Mode",
            Text = "เปิด God Mode แล้ว",
            Duration = 3
        })
    else
        DisableGodMode()
        game.StarterGui:SetCore("SendNotification", {
            Title = "JustHub - God Mode",
            Text = "ปิด God Mode แล้ว",
            Duration = 3
        })
    end
end)

-- รีเซ็ตฟีเจอร์ทั้งหมดเมื่อตัวละครใหม่เกิด
player.CharacterAdded:Connect(function(character)
    -- รอให้ character โหลดเสร็จ
    character:WaitForChild("HumanoidRootPart")
    character:WaitForChild("Humanoid")
    
    -- รีเซ็ต connections
    if noclipEnabled then
        task.wait(0.5) -- รอสักครู่
        EnableNoclip()
    end
    
    if flyEnabled then
        task.wait(0.5)
        EnableFly()
    end
    
    if godModeEnabled then
        task.wait(0.5)
        EnableGodMode()
    end
end)

-- ทำความสะอาดเมื่อปิด script
game.Players.PlayerRemoving:Connect(function(plr)
    if plr == player then
        DisableNoclip()
        DisableFly()
        DisableGodMode()
    end
end)
