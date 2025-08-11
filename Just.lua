local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local rootPart = character:WaitForChild("HumanoidRootPart")

-- รายการพิกัดที่ต้องการวาป
local locations = {
    CFrame.new(-533.00, 58.63, 3132.92),--หมู
    CFrame.new(-1099.27, 130.38, 2420.52),--กล้วย
    CFrame.new(-1790.67, 130.10, 1135.51),--ดอกไม้
    CFrame.new(-2832.60, 20.46, 2197.16),--มะพร้าว
    CFrame.new(-4078.10, 70.95, -2818.08),--เหล็ก
    CFrame.new(-2445.71, 74.97, -2037.70),--หญ้า
    CFrame.new(-611.63, 16.96, -3343.03),--พริก
    CFrame.new(-191.36, 17.35, -2391.63),--หิน
    CFrame.new(2410.08, 33.03, -2410.61),--ไม้
    CFrame.new(5207.04, 47.10, -2238.00),--ข้าวโพด
    CFrame.new(5460.13, 49.22, -1191.45),--องุ่น
    CFrame.new(5949.39, 50.97, -1699.58),--สตอร์เบอรี่
    CFrame.new(6085.44, 51.19, -2235.12),--กระหล่ำ
}

-- ฟังก์ชันวาปไปตำแหน่ง
local function teleportTo(cframe)
    rootPart.CFrame = cframe
end

-- ฟังก์ชันกดปุ่ม E
local function pressE()
    -- ถ้าต้องส่งอีเวนต์กดปุ่ม E ในเกมจริง อาจต้องแก้ตามระบบของเกมนั้น
    -- ตัวอย่างนี้แค่จำลองว่ากด E
    game:GetService("VirtualUser"):SendKeyEvent(true, "E", false, game)
    wait(0.1)
    game:GetService("VirtualUser"):SendKeyEvent(false, "E", false, game)
end

-- ตัวแปรสำหรับเช็คหยุดนิ่ง
local lastPosition = rootPart.Position
local stoppedTime = 0
local thresholdTime = 20 -- วินาที
local moveThreshold = 1 -- ระยะที่ถือว่า "ขยับ"

local index = 1

while true do
    local target = locations[index]
    
    teleportTo(target)
    
    wait(3) -- รอหลังวาป 3 วิ
    
    pressE()
    
    -- เช็คหยุดนิ่งเป็นเวลา
    stoppedTime = 0
    lastPosition = rootPart.Position
    
    while stoppedTime < thresholdTime do
        wait(1)
        local currentPosition = rootPart.Position
        local distance = (currentPosition - lastPosition).Magnitude
        
        if distance < moveThreshold then
            stoppedTime = stoppedTime + 1
        else
            stoppedTime = 0
        end
        
        lastPosition = currentPosition
    end
    
    -- ถ้าหยุดนิ่งเกิน 20 วิ ให้ไปตำแหน่งถัดไป
    index = index + 1
    if index > #locations then
        index = 1 -- วนลูปกลับจุดแรก
    end
end
