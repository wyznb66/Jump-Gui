-- 速度监测与控制GUI - 锁定速度版本
local player = game.Players.LocalPlayer
local userInputService = game:GetService("UserInputService")
local runService = game:GetService("RunService")

-- ========== 配置 ==========
local CONFIG = {
    lockedSpeed = nil,  -- nil表示未锁定，使用游戏默认
    originalSpeed = nil,
}

-- ========== 创建GUI ==========
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "SpeedControlGUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = player.PlayerGui

-- ========== 主框架 ==========
local mainFrame = Instance.new("Frame")
mainFrame.Name = "SpeedControl"
mainFrame.Size = UDim2.new(0, 250, 0, 200)
mainFrame.Position = UDim2.new(0.3, 0, 0.3, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
mainFrame.BackgroundTransparency = 0.15
mainFrame.BorderSizePixel = 0
mainFrame.ClipsDescendants = true
mainFrame.Parent = screenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 12)
mainCorner.Parent = mainFrame

-- ========== 标题栏 ==========
local titleBar = Instance.new("Frame")
titleBar.Name = "TitleBar"
titleBar.Size = UDim2.new(1, 0, 0, 30)
titleBar.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
titleBar.BackgroundTransparency = 0.3
titleBar.BorderSizePixel = 0
titleBar.Parent = mainFrame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 12)
titleCorner.Parent = titleBar

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, -80, 1, 0)
titleLabel.Position = UDim2.new(0, 10, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "📊 速度控制"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextSize = 16
titleLabel.Font = Enum.Font.SourceSansBold
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Parent = titleBar

local foldBtn = Instance.new("TextButton")
foldBtn.Name = "FoldBtn"
foldBtn.Size = UDim2.new(0, 30, 1, -6)
foldBtn.Position = UDim2.new(1, -65, 0, 3)
foldBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
foldBtn.BackgroundTransparency = 0.3
foldBtn.BorderSizePixel = 0
foldBtn.Text = "−"
foldBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
foldBtn.TextSize = 20
foldBtn.Font = Enum.Font.SourceSansBold
foldBtn.Parent = titleBar

local foldCorner = Instance.new("UICorner")
foldCorner.CornerRadius = UDim.new(0, 6)
foldCorner.Parent = foldBtn

local closeBtn = Instance.new("TextButton")
closeBtn.Name = "CloseBtn"
closeBtn.Size = UDim2.new(0, 30, 1, -6)
closeBtn.Position = UDim2.new(1, -35, 0, 3)
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
closeBtn.BackgroundTransparency = 0.3
closeBtn.BorderSizePixel = 0
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextSize = 18
closeBtn.Font = Enum.Font.SourceSansBold
closeBtn.Parent = titleBar

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 6)
closeCorner.Parent = closeBtn

-- ========== 内容区域 ==========
local contentFrame = Instance.new("Frame")
contentFrame.Name = "Content"
contentFrame.Size = UDim2.new(1, -20, 1, -40)
contentFrame.Position = UDim2.new(0, 10, 0, 35)
contentFrame.BackgroundTransparency = 1
contentFrame.Parent = mainFrame

-- 速度显示
local speedLabel = Instance.new("TextLabel")
speedLabel.Name = "SpeedLabel"
speedLabel.Size = UDim2.new(1, 0, 0, 30)
speedLabel.Position = UDim2.new(0, 0, 0, 0)
speedLabel.BackgroundTransparency = 1
speedLabel.Text = "当前速度: 0.0 单位/秒"
speedLabel.TextColor3 = Color3.fromRGB(100, 200, 255)
speedLabel.TextSize = 16
speedLabel.Font = Enum.Font.SourceSans
speedLabel.TextXAlignment = Enum.TextXAlignment.Left
speedLabel.Parent = contentFrame

-- 锁定状态显示
local lockStatusLabel = Instance.new("TextLabel")
lockStatusLabel.Name = "LockStatusLabel"
lockStatusLabel.Size = UDim2.new(1, 0, 0, 20)
lockStatusLabel.Position = UDim2.new(0, 0, 0, 28)
lockStatusLabel.BackgroundTransparency = 1
lockStatusLabel.Text = "🔓 未锁定"
lockStatusLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
lockStatusLabel.TextSize = 13
lockStatusLabel.Font = Enum.Font.SourceSans
lockStatusLabel.TextXAlignment = Enum.TextXAlignment.Left
lockStatusLabel.Parent = contentFrame

-- 分隔线
local divider = Instance.new("Frame")
divider.Size = UDim2.new(1, 0, 0, 1)
divider.Position = UDim2.new(0, 0, 0, 50)
divider.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
divider.BorderSizePixel = 0
divider.Parent = contentFrame

-- 加速控制区域
local controlLabel = Instance.new("TextLabel")
controlLabel.Size = UDim2.new(0, 80, 0, 25)
controlLabel.Position = UDim2.new(0, 0, 0, 57)
controlLabel.BackgroundTransparency = 1
controlLabel.Text = "添加移速:"
controlLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
controlLabel.TextSize = 14
controlLabel.Font = Enum.Font.SourceSans
controlLabel.TextXAlignment = Enum.TextXAlignment.Left
controlLabel.Parent = contentFrame

local inputBox = Instance.new("TextBox")
inputBox.Name = "SpeedInput"
inputBox.Size = UDim2.new(0, 60, 0, 25)
inputBox.Position = UDim2.new(0, 85, 0, 57)
inputBox.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
inputBox.BackgroundTransparency = 0.2
inputBox.BorderSizePixel = 0
inputBox.Text = "1"
inputBox.TextColor3 = Color3.fromRGB(255, 255, 255)
inputBox.TextSize = 14
inputBox.Font = Enum.Font.SourceSans
inputBox.TextXAlignment = Enum.TextXAlignment.Center
inputBox.PlaceholderText = "数值"
inputBox.Parent = contentFrame

local inputCorner = Instance.new("UICorner")
inputCorner.CornerRadius = UDim.new(0, 4)
inputCorner.Parent = inputBox

local confirmBtn = Instance.new("TextButton")
confirmBtn.Name = "ConfirmBtn"
confirmBtn.Size = UDim2.new(0, 50, 0, 25)
confirmBtn.Position = UDim2.new(0, 150, 0, 57)
confirmBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
confirmBtn.BackgroundTransparency = 0.2
confirmBtn.BorderSizePixel = 0
confirmBtn.Text = "确定"
confirmBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
confirmBtn.TextSize = 14
confirmBtn.Font = Enum.Font.SourceSansBold
confirmBtn.Parent = contentFrame

local confirmCorner = Instance.new("UICorner")
confirmCorner.CornerRadius = UDim.new(0, 4)
confirmCorner.Parent = confirmBtn

local resetBtn = Instance.new("TextButton")
resetBtn.Name = "ResetBtn"
resetBtn.Size = UDim2.new(0, 60, 0, 25)
resetBtn.Position = UDim2.new(0, 0, 0, 87)
resetBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
resetBtn.BackgroundTransparency = 0.2
resetBtn.BorderSizePixel = 0
resetBtn.Text = "🔄 还原"
resetBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
resetBtn.TextSize = 14
resetBtn.Font = Enum.Font.SourceSansBold
resetBtn.Parent = contentFrame

local resetCorner = Instance.new("UICorner")
resetCorner.CornerRadius = UDim.new(0, 4)
resetCorner.Parent = resetBtn

-- ========== 折叠功能 ==========
local folded = false

foldBtn.MouseButton1Click:Connect(function()
    folded = not folded
    if folded then
        mainFrame.Size = UDim2.new(0, 250, 0, 30)
        foldBtn.Text = "+"
        contentFrame.Visible = false
    else
        mainFrame.Size = UDim2.new(0, 250, 0, 200)
        foldBtn.Text = "−"
        contentFrame.Visible = true
    end
end)

-- ========== 关闭功能 ==========
closeBtn.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

-- ========== 拖动功能 ==========
local dragData = {
    dragging = false,
    dragStart = nil,
    startPos = nil,
}

titleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragData.dragging = true
        dragData.dragStart = input.Position
        dragData.startPos = mainFrame.Position
    end
end)

titleBar.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragData.dragging = false
    end
end)

titleBar.InputChanged:Connect(function(input)
    if dragData.dragging and (input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement) then
        local delta = input.Position - dragData.dragStart
        mainFrame.Position = UDim2.new(
            dragData.startPos.X.Scale,
            dragData.startPos.X.Offset + delta.X,
            dragData.startPos.Y.Scale,
            dragData.startPos.Y.Offset + delta.Y
        )
    end
end)

-- ========== 速度锁定系统 ==========
local speedLockConnection = nil
local currentLockedSpeed = nil

function getHumanoid()
    local character = player.Character
    if not character then return nil end
    return character:FindFirstChild("Humanoid")
end

function getCharacterSpeed()
    local character = player.Character
    if not character then return 0 end
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    if not rootPart then return 0 end
    local velocity = rootPart.Velocity
    return math.sqrt(velocity.X^2 + velocity.Y^2 + velocity.Z^2)
end

-- 核心：锁定速度的循环
function startSpeedLock(targetSpeed)
    -- 停止旧的锁定
    stopSpeedLock()
    
    currentLockedSpeed = targetSpeed
    CONFIG.lockedSpeed = targetSpeed
    
    -- 立即应用一次
    applyLockedSpeed(targetSpeed)
    
    -- 启动循环锁定（每帧检测并修正）
    speedLockConnection = runService.Heartbeat:Connect(function()
        applyLockedSpeed(targetSpeed)
    end)
    
    lockStatusLabel.Text = "🔒 已锁定: " .. string.format("%.1f", targetSpeed)
    lockStatusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
    print("🔒 速度已锁定为: " .. targetSpeed)
end

function applyLockedSpeed(targetSpeed)
    local humanoid = getHumanoid()
    if not humanoid then return end
    
    -- 如果当前速度不等于目标速度，强制修正
    if math.abs(humanoid.WalkSpeed - targetSpeed) > 0.01 then
        humanoid.WalkSpeed = targetSpeed
    end
end

function stopSpeedLock()
    if speedLockConnection then
        speedLockConnection:Disconnect()
        speedLockConnection = nil
    end
    currentLockedSpeed = nil
    CONFIG.lockedSpeed = nil
end

function resetSpeed()
    -- 停止锁定
    stopSpeedLock()
    
    local humanoid = getHumanoid()
    if not humanoid then
        print("❌ 找不到角色")
        return
    end
    
    -- 还原到原始速度
    if CONFIG.originalSpeed then
        humanoid.WalkSpeed = CONFIG.originalSpeed
        lockStatusLabel.Text = "🔓 已还原: " .. string.format("%.1f", CONFIG.originalSpeed)
        print("🔄 速度已还原为: " .. CONFIG.originalSpeed)
    else
        -- 如果没有记录原始速度，使用19
        humanoid.WalkSpeed = 19
        CONFIG.originalSpeed = 19
        lockStatusLabel.Text = "🔓 已还原: 19.0"
        print("🔄 速度已还原为默认值: 19")
    end
    
    lockStatusLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
end

function addSpeed(amount)
    local humanoid = getHumanoid()
    if not humanoid then
        print("❌ 找不到角色")
        return
    end
    
    -- 如果当前没有锁定，先记录当前速度作为基础
    local baseSpeed
    if currentLockedSpeed then
        baseSpeed = currentLockedSpeed
    else
        baseSpeed = humanoid.WalkSpeed
    end
    
    local newSpeed = baseSpeed + amount
    if newSpeed < 1 then newSpeed = 1 end
    
    -- 锁定新速度
    startSpeedLock(newSpeed)
    print("⚡ 速度已增加 " .. amount .. "，当前锁定: " .. newSpeed)
end

-- ========== UI按钮事件 ==========
confirmBtn.MouseButton1Click:Connect(function()
    local inputText = inputBox.Text
    local number = tonumber(inputText)
    
    if number then
        addSpeed(number)
    else
        print("❌ 请输入有效数字")
    end
end)

resetBtn.MouseButton1Click:Connect(function()
    resetSpeed()
end)

inputBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        local number = tonumber(inputBox.Text)
        if number then
            addSpeed(number)
        else
            print("❌ 请输入有效数字")
        end
    end
end)

-- ========== 速度显示更新 ==========
runService.Heartbeat:Connect(function()
    local speed = getCharacterSpeed()
    speedLabel.Text = string.format("当前速度: %.1f 单位/秒", speed)
end)

-- ========== 角色重生处理 ==========
player.CharacterAdded:Connect(function(char)
    task.wait(0.5)
    print("🔄 角色重生，恢复速度锁定")
    
    -- 重新获取原始速度
    local humanoid = getHumanoid()
    if humanoid then
        if not CONFIG.originalSpeed then
            CONFIG.originalSpeed = humanoid.WalkSpeed
        end
        
        -- 如果之前有锁定的速度，重新锁定
        if currentLockedSpeed then
            startSpeedLock(currentLockedSpeed)
        else
            -- 否则确保速度是原始值
            humanoid.WalkSpeed = CONFIG.originalSpeed or 19
        end
    end
end)

-- ========== 初始化 ==========
task.wait(0.5)
local humanoid = getHumanoid()
if humanoid then
    CONFIG.originalSpeed = humanoid.WalkSpeed
    print("📝 初始速度: " .. CONFIG.originalSpeed)
    lockStatusLabel.Text = "🔓 未锁定 (" .. string.format("%.1f", CONFIG.originalSpeed) .. ")"
end

print("✅ 速度控制GUI已加载！")
print("🔒 速度锁定系统已启用 - 速度不会因疾跑/下蹲而重置")
print("📊 实时监测速度 | ⚡ 添加速度将永久锁定 | 🔄 还原解除锁定")