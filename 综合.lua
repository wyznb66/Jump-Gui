-- 暴力区功能UI - 双按钮版
local player = game.Players.LocalPlayer
local tweenService = game:GetService("TweenService")

-- 创建主GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ViolentZoneUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = player.PlayerGui

-- 主面板（高度调整以容纳两个按钮）
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 250, 0, 190)  -- 高度从140改为190
mainFrame.Position = UDim2.new(0.5, -125, 0.5, -95)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
mainFrame.BackgroundTransparency = 0.1
mainFrame.BorderSizePixel = 2
mainFrame.BorderColor3 = Color3.fromRGB(255, 50, 50)
mainFrame.ClipsDescendants = true
mainFrame.Active = true
mainFrame.Parent = screenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 12)
mainCorner.Parent = mainFrame

-- 标题栏
local titleBar = Instance.new("TextButton")
titleBar.Size = UDim2.new(1, 0, 0, 35)
titleBar.Position = UDim2.new(0, 0, 0, 0)
titleBar.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
titleBar.BackgroundTransparency = 0.3
titleBar.BorderSizePixel = 0
titleBar.Text = "暴力区娱乐功能"
titleBar.TextColor3 = Color3.fromRGB(255, 255, 255)
titleBar.TextSize = 18
titleBar.Font = Enum.Font.SourceSansBold
titleBar.AutoButtonColor = false
titleBar.Parent = mainFrame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 12)
titleCorner.Parent = titleBar

-- 折叠箭头
local arrowLabel = Instance.new("TextLabel")
arrowLabel.Size = UDim2.new(0, 30, 0, 30)
arrowLabel.Position = UDim2.new(1, -35, 0, 2)
arrowLabel.BackgroundTransparency = 1
arrowLabel.Text = "▼"
arrowLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
arrowLabel.TextSize = 16
arrowLabel.Font = Enum.Font.SourceSansBold
arrowLabel.Parent = titleBar

-- 关闭按钮
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 25, 0, 25)
closeBtn.Position = UDim2.new(1, -60, 0, 5)
closeBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
closeBtn.BackgroundTransparency = 0.2
closeBtn.BorderSizePixel = 0
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextSize = 14
closeBtn.Font = Enum.Font.SourceSansBold
closeBtn.Parent = titleBar

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(1, 0)
closeCorner.Parent = closeBtn

-- 内容容器
local contentContainer = Instance.new("Frame")
contentContainer.Size = UDim2.new(1, 0, 1, -35)
contentContainer.Position = UDim2.new(0, 0, 0, 35)
contentContainer.BackgroundTransparency = 1
contentContainer.ClipsDescendants = true
contentContainer.Parent = mainFrame

-- ========== 功能按钮 ==========
local function createButton(text, yPos, color, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 200, 0, 40)
    btn.Position = UDim2.new(0.5, -100, 0, yPos)
    btn.BackgroundColor3 = color
    btn.BackgroundTransparency = 0.25
    btn.BorderSizePixel = 1
    btn.BorderColor3 = Color3.fromRGB(255, 255, 255)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 16
    btn.Font = Enum.Font.SourceSansBold
    btn.Parent = contentContainer

    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 8)
    btnCorner.Parent = btn

    btn.MouseEnter:Connect(function()
        btn.BackgroundTransparency = 0.1
    end)
    btn.MouseLeave:Connect(function()
        btn.BackgroundTransparency = 0.25
    end)

    btn.MouseButton1Click:Connect(callback)
    return btn
end

-- ========== 功能函数 ==========
-- 1. 暴力区跳跃功能
local function executeViolentJump()
    print("⚡ 正在加载暴力区跳跃功能...")
    local success, err = pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/wyznb66/Jump/refs/heads/main/%E6%9A%B4%E5%8A%9B%E5%8C%BA%E8%B7%B3%E8%B7%83%E9%94%AE.lua"))()
    end)
    
    if success then
        print("✅ 暴力区跳跃功能已加载！")
    else
        warn("❌ 加载失败: " .. tostring(err))
    end
end

-- 2. 固定调试速度功能
local function executeSpeedScript()
    print("⚡ 正在加载固定调试速度脚本...")
    local success, err = pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/wyznb66/Jump-Gui/refs/heads/main/%E5%9B%BA%E5%AE%9A%E8%B0%83%E8%AF%95%E9%80%9F%E5%BA%A6.lua"))()
    end)
    
    if success then
        print("✅ 固定调试速度脚本已加载！")
    else
        warn("❌ 加载失败: " .. tostring(err))
    end
end

-- 创建"暴力区跳跃"按钮（第一个按钮，位置15）
local violentBtn = createButton(
    "暴力区跳跃键",
    15,
    Color3.fromRGB(200, 40, 40),
    executeViolentJump
)

-- 创建"固定调试速度"按钮（第二个按钮，位置65）
local speedBtn = createButton(
    "固定调试速度",
    65,
    Color3.fromRGB(40, 120, 200),
    executeSpeedScript
)

-- ========== 拖动功能 ==========
local isDragging = false
local dragStart = nil
local frameStart = nil
local clickTime = 0

titleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        isDragging = true
        dragStart = input.Position
        frameStart = mainFrame.Position
        titleBar.BackgroundTransparency = 0.1
        clickTime = tick()
    end
end)

titleBar.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        isDragging = false
        titleBar.BackgroundTransparency = 0.3
    end
end)

titleBar.InputChanged:Connect(function(input)
    if isDragging then
        local delta = input.Position - dragStart
        if math.abs(delta.X) > 5 or math.abs(delta.Y) > 5 then
            mainFrame.Position = UDim2.new(
                frameStart.X.Scale,
                frameStart.X.Offset + delta.X,
                frameStart.Y.Scale,
                frameStart.Y.Offset + delta.Y
            )
        end
    end
end)

-- ========== 折叠/展开功能 ==========
local isCollapsed = false
local fullHeight = 190  -- 更新为新的高度
local collapsedHeight = 35

local function toggleCollapse()
    isCollapsed = not isCollapsed

    local targetHeight = isCollapsed and collapsedHeight or fullHeight
    local targetArrow = isCollapsed and "▶" or "▼"

    arrowLabel.Text = targetArrow

    local tween = tweenService:Create(
        mainFrame,
        TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {Size = UDim2.new(0, 250, 0, targetHeight)}
    )
    tween:Play()
end

titleBar.MouseButton1Click:Connect(function()
    if tick() - clickTime < 0.3 then
        toggleCollapse()
    end
end)

-- ========== 关闭按钮 ==========
closeBtn.MouseButton1Click:Connect(function()
    screenGui:Destroy()
    print("✅ UI已关闭")
end)

print("💀 暴力区娱乐UI已加载（点击标题折叠/展开）")
print("📌 包含两个功能按钮：")
print("   • 暴力区跳跃键")
print("   • 固定调试速度")