– 📌 ต้องรันใน LocalScript เท่านั้น
local Library = loadstring(game:HttpGet(“https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua”))()
local Window = Library.CreateLib(“JustHub”, “BloodTheme”)

local player = game.Players.LocalPlayer
local RunService = game:GetService(“RunService”)
local UserInputService = game:GetService(“UserInputService”)

– ================= Teleport Tab =================
local TeleportTab = Window:NewTab(“Teleport”)
local LocationSection = TeleportTab:NewSection(“เลือกสถานที่”)

local locations = {
{name = “ตลาดโลก”, cframe = CFrame.new(2846.01, 16.55, 2108.39)},
{name = “ATM ตลาดโลก”, cframe = CFrame.new(2999.37, 16.60, 2278.67)},
{name = “ผับ”, cframe = CFrame.new(3158.82, 16.69, 2300.57)},
{name = “ร้านอาหาร”, cframe = CFrame.new(3486.12, 18.24, 2581.56)},
{name = “อู่”, cframe = CFrame.new(2814.99, 18.24, 2671.00)},
{name = “โรงพยาบาล”, cframe = CFrame.new(3012.29, 16.64, 3526.09)},
{name = “สถานีตำรวจ”, cframe = CFrame.new(3632.24, 24.07, 3215.28)},
{name = “หมู”, cframe = CFrame.new(-533.00, 58.63, 3132.92)},
{name = “กล้วย”, cframe = CFrame.new(-1099.27, 130.38, 2420.52)},
{name = “ดอกไม้”, cframe = CFrame.new(-1790.67, 130.10, 1135.51)},
{name = “มะพร้าว”, cframe = CFrame.new(-2832.60, 20.46, 2197.16)},
{name = “แลนแดง”, cframe = CFrame.new(-3891.84, 76.42, -486.54)},
{name = “เหล็ก1”, cframe = CFrame.new(-4078.10, 70.95, -2818.08)},
{name = “หญ้า”, cframe = CFrame.new(-2445.71, 74.97, -2037.70)},
{name = “พริก”, cframe = CFrame.new(-611.63, 16.96, -3343.03)},
{name = “หิน”, cframe = CFrame.new(-191.36, 17.35, -2391.63)},
{name = “แลกมะม่วง”, cframe = CFrame.new(1060.44, 18.08, -521.77)},
{name = “ไม้”, cframe = CFrame.new(2410.08, 33.03, -2410.61)},
{name = “แปรรูปหิน”, cframe = CFrame.new(6149.76, 51.03, -4225.38)},
{name = “ร้านค้าและปั้ม”, cframe = CFrame.new(5668.79, 50.98, -3112.81)},
{name = “ข้าวโพด”, cframe = CFrame.new(5207.04, 47.10, -2238.00)},
{name = “องุ่น”, cframe = CFrame.new(5460.13, 49.22, -1191.45)},
{name = “สตอร์เบอรี่”, cframe = CFrame.new(5949.39, 50.97, -1699.58)},
{name = “กระหล่ำ”, cframe = CFrame.new(6085.44, 51.19, -2235.12)},
}

for _, loc in ipairs(locations) do
LocationSection:NewButton(loc.name, “กดเพื่อวาร์ปไปยัง “ .. loc.name, function()
local character = player.Character or player.CharacterAdded:Wait()
local root = character:WaitForChild(“HumanoidRootPart”)
root.CFrame = loc.cframe
end)
end

– ================= Misc Tab =================
local MiscTab = Window:NewTab(“Misc”)
local MiscSection = MiscTab:NewSection(“ฟีเจอร์เสริม”)

– Noclip variables
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
if part:IsA(“BasePart”) then
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
if part:IsA(“BasePart”) then
part.CanCollide = true
end
end
end
end

– Toggle Noclip
MiscSection:NewToggle(“เปิด/ปิด Noclip”, “เปิดหรือปิดโหมดเดินทะลุ”, function(value)
noclipEnabled = value
if noclipEnabled then
EnableNoclip()
else
DisableNoclip()
end
end)

– ================= ฟิกซ์ UI สำหรับมือถือ =================
task.wait(2) – เพิ่มเวลารอให้ UI สร้างเสร็จสมบูรณ์

local CoreGui = game:GetService(“CoreGui”)
local TweenService = game:GetService(“TweenService”)

– ฟังก์ชันหาหน้าต่างหลัก
local function findMainFrame()
local gui = CoreGui:FindFirstChild(“JustHub”)
if not gui then return nil end

```
-- ลองหาแบบต่างๆ
local mainFrame = gui:FindFirstChild("Main") 
    or gui:FindFirstChild("MainFrame")
    or gui:FindFirstChildOfClass("Frame")

-- หาลึกขึ้นไปถ้าไม่เจอ
if not mainFrame then
    for _, child in pairs(gui:GetDescendants()) do
        if child:IsA("Frame") and child.Size.X.Scale > 0.3 and child.Size.Y.Scale > 0.3 then
            mainFrame = child
            break
        end
    end
end

return mainFrame
```

end

local function setupMobileUI()
local mainFrame = findMainFrame()
if not mainFrame then
print(“ไม่พบ MainFrame”)
return
end

```
print("พบ MainFrame:", mainFrame.Name)

-- ทำให้ลากได้บนมือถือและเดสก์ทอป
mainFrame.Active = true
mainFrame.Draggable = true

-- ปรับปรุงการลากสำหรับมือถือ
if UserInputService.TouchEnabled then
    -- เพิ่ม ZIndex ให้สูงกว่า
    mainFrame.ZIndex = 10
    
    -- ปรับ SelectionImageObject สำหรับ Touch
    mainFrame.SelectionImageObject = nil
    
    -- เพิ่ม Properties สำหรับ Touch
    pcall(function()
        mainFrame.TouchPan = true
    end)
end

-- สร้างปุ่มปิดที่ทำงานได้ดีบนมือถือ
local closeBtn = Instance.new("TextButton")
closeBtn.Name = "CloseButton"
closeBtn.Size = UDim2.new(0, 35, 0, 35) -- ขยายขนาดสำหรับมือถือ
closeBtn.Position = UDim2.new(1, -40, 0, 5)
closeBtn.BackgroundColor3 = Color3.fromRGB(220, 53, 69) -- สีแดงที่เด่นชัด
closeBtn.BorderSizePixel = 0
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.new(1, 1, 1)
closeBtn.TextScaled = true
closeBtn.Font = Enum.Font.SourceSansBold
closeBtn.ZIndex = 20 -- ให้อยู่ข้างหน้าสุด
closeBtn.Active = true -- สำคัญสำหรับ Touch

-- เพิ่ม Corner และ Shadow
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 8)
corner.Parent = closeBtn

-- Hover Effect
closeBtn.MouseEnter:Connect(function()
    local tween = TweenService:Create(closeBtn, TweenInfo.new(0.2), {
        BackgroundColor3 = Color3.fromRGB(255, 69, 89),
        Size = UDim2.new(0, 38, 0, 38)
    })
    tween:Play()
end)

closeBtn.MouseLeave:Connect(function()
    local tween = TweenService:Create(closeBtn, TweenInfo.new(0.2), {
        BackgroundColor3 = Color3.fromRGB(220, 53, 69),
        Size = UDim2.new(0, 35, 0, 35)
    })
    tween:Play()
end)

-- เชื่อมต่อการปิด (รองรับทั้ง Click และ Touch)
closeBtn.Activated:Connect(function() -- ใช้ Activated แทน MouseButton1Click
    print("ปิด GUI")
    local gui = CoreGui:FindFirstChild("JustHub")
    if gui then
        -- ปิดการเชื่อมต่อ Noclip ก่อน
        if noclipConnection then
            noclipConnection:Disconnect()
        end
        DisableNoclip()
        
        -- Tween ปิด
        local closeTween = TweenService:Create(gui, TweenInfo.new(0.3), {
            Size = UDim2.new(0, 0, 0, 0)
        })
        closeTween:Play()
        closeTween.Completed:Connect(function()
            gui:Destroy()
        end)
    end
end)

closeBtn.Parent = mainFrame
print("สร้างปุ่มปิดเสร็จแล้ว")

-- เพิ่ม Toggle Button สำหรับซ่อน/แสดง UI (ใหม่!)
local toggleBtn = Instance.new("TextButton")
toggleBtn.Name = "ToggleButton"
toggleBtn.Size = UDim2.new(0, 30, 0, 30)
toggleBtn.Position = UDim2.new(1, -75, 0, 5)
toggleBtn.BackgroundColor3 = Color3.fromRGB(52, 144, 220)
toggleBtn.BorderSizePixel = 0
toggleBtn.Text = "_"
toggleBtn.TextColor3 = Color3.new(1, 1, 1)
toggleBtn.TextScaled = true
toggleBtn.Font = Enum.Font.SourceSansBold
toggleBtn.ZIndex = 20
toggleBtn.Active = true

local toggleCorner = Instance.new("UICorner")
toggleCorner.CornerRadius = UDim.new(0, 6)
toggleCorner.Parent = toggleBtn

local isMinimized = false
local originalSize = mainFrame.Size

toggleBtn.Activated:Connect(function()
    if isMinimized then
        -- แสดง UI
        mainFrame:TweenSize(originalSize, "Out", "Quad", 0.3)
        toggleBtn.Text = "_"
        isMinimized = false
    else
        -- ซ่อน UI (เก็บแค่ Header)
        originalSize = mainFrame.Size
        mainFrame:TweenSize(UDim2.new(originalSize.X.Scale, originalSize.X.Offset, 0, 50), "Out", "Quad", 0.3)
        toggleBtn.Text = "□"
        isMinimized = true
    end
end)

toggleBtn.Parent = mainFrame
```

end

– เรียกใช้ฟังก์ชัน
setupMobileUI()

– ตรวจสอบซ้ำในกรณีที่ UI ยังไม่พร้อม
task.wait(1)
if not CoreGui:FindFirstChild(“JustHub”) or not findMainFrame() then
task.wait(2)
setupMobileUI()
end