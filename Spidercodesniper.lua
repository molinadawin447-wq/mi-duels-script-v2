-- =========================================================
-- 🕷 SPIDER.VS UI + BARRA VISUAL + INSTA RESET + TP BAT + AUTO LEFT/RIGHT
-- =========================================================

repeat task.wait() until game:IsLoaded()

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local Stats = game:GetService("Stats")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- =========================================================
-- CONFIGURACIÓN
-- =========================================================

local buttonSize = 63
local gap = 7

local buttonTexts = {
    "TP\nBAT",
    "INSTA\nRESET",
    "BYPASS\nANTIBAT",
    "AUTO\nRIGHT",
    "BAT\nAIMBOT",
    "TP\nDOWN",
    "LAGGER 1",
    "AUTO\nLEFT",
    "DROP BR",
    "CARRY SPD",
    "LAGGER 2"
}

-- =========================================================
-- GUI PRINCIPAL
-- =========================================================

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "SpiderVS_UI"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
screenGui.DisplayOrder = 200
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = playerGui

-- =========================================================
-- CONTENEDOR DE BOTONES
-- =========================================================

local container = Instance.new("Frame")
container.Name = "ButtonContainer"
container.BackgroundTransparency = 1
container.AnchorPoint = Vector2.new(1, 0)
container.Position = UDim2.new(1, -5, 0, 10)
container.Size = UDim2.fromOffset(300, 300)
container.Parent = screenGui

-- =========================================================
-- GRADIENTE ANIMADO
-- =========================================================

local function addAnimatedGradient(label)
    local gradient = Instance.new("UIGradient")
    gradient.Name = "DiagonalShadow"
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)),
        ColorSequenceKeypoint.new(0.42, Color3.fromRGB(255, 255, 255)),
        ColorSequenceKeypoint.new(0.50, Color3.fromRGB(35, 35, 35)),
        ColorSequenceKeypoint.new(0.58, Color3.fromRGB(255, 255, 255)),
        ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 255, 255))
    })
    gradient.Rotation = 45
    gradient.Offset = Vector2.new(-1.5, -1.5)
    gradient.Parent = label

    task.spawn(function()
        while label.Parent do
            gradient.Offset = Vector2.new(-1.5, -1.5)
            local tween = TweenService:Create(
                gradient,
                TweenInfo.new(1.8, Enum.EasingStyle.Linear),
                { Offset = Vector2.new(1.5, 1.5) }
            )
            tween:Play()
            tween.Completed:Wait()
            task.wait(0.25)
        end
    end)
end

-- =========================================================
-- CREAR BOTÓN
-- =========================================================

local function createButton(name, text, x, y)
    local button = Instance.new("ImageButton")
    button.Name = name
    button.Size = UDim2.fromOffset(buttonSize, buttonSize)
    button.Position = UDim2.fromOffset(x, y)
    button.BackgroundTransparency = 1
    button.BorderSizePixel = 0
    button.Image = getcustomasset("Telaraña.jpg")
    button.ScaleType = Enum.ScaleType.Crop
    button.AutoButtonColor = false
    button.Parent = container

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 20)
    corner.Parent = button

    local label = Instance.new("TextLabel")
    label.Name = "Text"
    label.Size = UDim2.new(1, -12, 1, -12)
    label.Position = UDim2.fromOffset(6, 6)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextSize = 13
    label.TextScaled = false
    label.Font = Enum.Font.GothamBold
    label.TextWrapped = true
    label.TextXAlignment = Enum.TextXAlignment.Center
    label.TextYAlignment = Enum.TextYAlignment.Center
    label.Parent = button

    addAnimatedGradient(label)
    return button
end

-- =========================================================
-- COLUMNA 1
-- =========================================================
local btnTPBat = createButton("Button1", buttonTexts[1], 0, 0)

-- =========================================================
-- COLUMNA 2
-- =========================================================
local btnInstaReset = createButton("Button2", buttonTexts[2], buttonSize + gap, 0)
createButton("Button3", buttonTexts[3], buttonSize + gap, buttonSize + gap)

-- =========================================================
-- COLUMNA 3
-- =========================================================
local btnAutoRight = createButton("Button4", buttonTexts[4], (buttonSize + gap) * 2, 0)
createButton("Button5", buttonTexts[5], (buttonSize + gap) * 2, buttonSize + gap)
local tpDownButton = createButton("Button6", buttonTexts[6], (buttonSize + gap) * 2, (buttonSize + gap) * 2)
createButton("Button7", buttonTexts[7], (buttonSize + gap) * 2, (buttonSize + gap) * 3)

-- =========================================================
-- COLUMNA 4
-- =========================================================
local btnAutoLeft = createButton("Button8", buttonTexts[8], (buttonSize + gap) * 3, 0)
createButton("Button9", buttonTexts[9], (buttonSize + gap) * 3, buttonSize + gap)
createButton("Button10", buttonTexts[10], (buttonSize + gap) * 3, (buttonSize + gap) * 2)
createButton("Button11", buttonTexts[11], (buttonSize + gap) * 3, (buttonSize + gap) * 3)

-- =========================================================
-- TP DOWN (función original)
-- =========================================================
tpDownButton.Activated:Connect(function()
    local char = player.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return end
    local pos = root.Position
    root.CFrame = CFrame.new(pos.X, -6.84, pos.Z)
end)

-- =========================================================
-- 🕷 BOTÓN SPIDER.VS IZQUIERDA
-- =========================================================
local spiderButton = Instance.new("TextButton")
spiderButton.Name = "SpiderVS"
spiderButton.Size = UDim2.fromOffset(110, 43)
spiderButton.AnchorPoint = Vector2.new(0, 0.5)
spiderButton.Position = UDim2.new(0, 15, 0.36, 0)
spiderButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
spiderButton.BorderSizePixel = 0
spiderButton.Text = ""
spiderButton.AutoButtonColor = false
spiderButton.Parent = screenGui

local spiderCorner = Instance.new("UICorner")
spiderCorner.CornerRadius = UDim.new(0, 12)
spiderCorner.Parent = spiderButton

local spiderText = Instance.new("TextLabel")
spiderText.Name = "SpiderText"
spiderText.Size = UDim2.new(1, -8, 1, -4)
spiderText.Position = UDim2.fromOffset(4, 2)
spiderText.BackgroundTransparency = 1
spiderText.Text = "🕷 SPIDER.VS"
spiderText.TextColor3 = Color3.fromRGB(255, 255, 255)
spiderText.TextSize = 13
spiderText.Font = Enum.Font.GothamBold
spiderText.TextXAlignment = Enum.TextXAlignment.Center
spiderText.TextYAlignment = Enum.TextYAlignment.Center
spiderText.Parent = spiderButton
addAnimatedGradient(spiderText)

-- =========================================================
-- 🕷 BARRA VISUAL INFERIOR
-- =========================================================
local WHITE = Color3.fromRGB(255, 255, 255)
local BLACK = Color3.fromRGB(0, 0, 0)
local DARK = Color3.fromRGB(35, 35, 35)

-- Sombra
local shadow = Instance.new("Frame")
shadow.Name = "Shadow"
shadow.Size = UDim2.fromOffset(390, 40)
shadow.Position = UDim2.new(0.5, 5, 1, -62)
shadow.AnchorPoint = Vector2.new(0.5, 1)
shadow.BackgroundColor3 = BLACK
shadow.BackgroundTransparency = 0.35
shadow.BorderSizePixel = 0
shadow.ZIndex = 299
shadow.Parent = screenGui
local shadowCorner = Instance.new("UICorner")
shadowCorner.CornerRadius = UDim.new(0, 16)
shadowCorner.Parent = shadow

-- Barra principal
local spFrame = Instance.new("Frame")
spFrame.Name = "SpiderVSProgress"
spFrame.Size = UDim2.fromOffset(380, 34)
spFrame.Position = UDim2.new(0.5, 0, 1, -65)
spFrame.AnchorPoint = Vector2.new(0.5, 1)
spFrame.BackgroundTransparency = 1
spFrame.BorderSizePixel = 0
spFrame.Active = true
spFrame.Visible = true
spFrame.ZIndex = 300
spFrame.ClipsDescendants = true
spFrame.Parent = screenGui

local frameCorner = Instance.new("UICorner")
frameCorner.CornerRadius = UDim.new(0, 14)
frameCorner.Parent = spFrame

-- Fondo telaraña autosteal
local autoStealBackground = Instance.new("ImageLabel")
autoStealBackground.Name = "AutoStealBackground"
autoStealBackground.Size = UDim2.new(1, 0, 1, 0)
autoStealBackground.Position = UDim2.fromOffset(0, 0)
autoStealBackground.BackgroundTransparency = 1
autoStealBackground.Image = getcustomasset("Telarañaautosteal.jpg")
autoStealBackground.ScaleType = Enum.ScaleType.Crop
autoStealBackground.ZIndex = 300
autoStealBackground.Parent = spFrame
local bgCorner = Instance.new("UICorner")
bgCorner.CornerRadius = UDim.new(0, 14)
bgCorner.Parent = autoStealBackground

-- Borde
local frameStroke = Instance.new("UIStroke")
frameStroke.Color = WHITE
frameStroke.Thickness = 1.5
frameStroke.Transparency = 0.2
frameStroke.Parent = spFrame

-- Texto SPIDER.VS
local barSpiderText = Instance.new("TextLabel")
barSpiderText.Name = "SpiderText"
barSpiderText.Size = UDim2.fromOffset(125, 34)
barSpiderText.Position = UDim2.fromOffset(5, 0)
barSpiderText.BackgroundTransparency = 1
barSpiderText.Text = "🕷SPIDER.VS"
barSpiderText.TextColor3 = WHITE
barSpiderText.Font = Enum.Font.GothamBold
barSpiderText.TextSize = 14
barSpiderText.TextXAlignment = Enum.TextXAlignment.Center
barSpiderText.TextYAlignment = Enum.TextYAlignment.Center
barSpiderText.ZIndex = 310
barSpiderText.Parent = spFrame

-- Gradiente barra
local spiderGradient = Instance.new("UIGradient")
spiderGradient.Name = "DiagonalShadow"
spiderGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, WHITE),
    ColorSequenceKeypoint.new(0.42, WHITE),
    ColorSequenceKeypoint.new(0.50, DARK),
    ColorSequenceKeypoint.new(0.58, WHITE),
    ColorSequenceKeypoint.new(1, WHITE)
})
spiderGradient.Rotation = 45
spiderGradient.Offset = Vector2.new(-1.5, -1.5)
spiderGradient.Parent = barSpiderText

task.spawn(function()
    while barSpiderText.Parent do
        spiderGradient.Offset = Vector2.new(-1.5, -1.5)
        local tween = TweenService:Create(spiderGradient, TweenInfo.new(1.8, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), { Offset = Vector2.new(1.5, 1.5) })
        tween:Play()
        tween.Completed:Wait()
        task.wait(0.25)
    end
end)

-- Porcentaje
local pctLabel = Instance.new("TextLabel")
pctLabel.Name = "Percentage"
pctLabel.Size = UDim2.fromOffset(45, 34)
pctLabel.Position = UDim2.fromOffset(135, 0)
pctLabel.BackgroundTransparency = 1
pctLabel.Text = "0%"
pctLabel.TextColor3 = WHITE
pctLabel.Font = Enum.Font.GothamBold
pctLabel.TextSize = 14
pctLabel.TextXAlignment = Enum.TextXAlignment.Center
pctLabel.TextYAlignment = Enum.TextYAlignment.Center
pctLabel.ZIndex = 310
pctLabel.Parent = spFrame

-- Fondo de progreso
local barBg = Instance.new("Frame")
barBg.Name = "ProgressBackground"
barBg.Size = UDim2.fromOffset(100, 18)
barBg.Position = UDim2.fromOffset(185, 8)
barBg.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
barBg.BorderSizePixel = 0
barBg.ClipsDescendants = true
barBg.ZIndex = 310
barBg.Parent = spFrame

local barCorner = Instance.new("UICorner")
barCorner.CornerRadius = UDim.new(1, 0)
barCorner.Parent = barBg

local barStroke = Instance.new("UIStroke")
barStroke.Color = WHITE
barStroke.Thickness = 1
barStroke.Transparency = 0.25
barStroke.Parent = barBg

-- Barra blanca
local progressFill = Instance.new("Frame")
progressFill.Name = "ProgressFill"
progressFill.Size = UDim2.new(0, 0, 1, 0)
progressFill.BackgroundColor3 = WHITE
progressFill.BorderSizePixel = 0
progressFill.ZIndex = 311
progressFill.Parent = barBg

local fillCorner = Instance.new("UICorner")
fillCorner.CornerRadius = UDim.new(1, 0)
fillCorner.Parent = progressFill

-- Separador
local separator = Instance.new("Frame")
separator.Name = "Separator"
separator.Size = UDim2.fromOffset(1.5, 20)
separator.Position = UDim2.fromOffset(292, 7)
separator.BackgroundColor3 = WHITE
separator.BackgroundTransparency = 0.3
separator.BorderSizePixel = 0
separator.ZIndex = 310
separator.Parent = spFrame

-- FPS
local fpsLabel = Instance.new("TextLabel")
fpsLabel.Name = "FPS"
fpsLabel.Size = UDim2.fromOffset(55, 34)
fpsLabel.Position = UDim2.fromOffset(300, 0)
fpsLabel.BackgroundTransparency = 1
fpsLabel.Text = "FPS: 0"
fpsLabel.TextColor3 = WHITE
fpsLabel.Font = Enum.Font.Gotham
fpsLabel.TextSize = 12
fpsLabel.TextXAlignment = Enum.TextXAlignment.Left
fpsLabel.TextYAlignment = Enum.TextYAlignment.Center
fpsLabel.ZIndex = 310
fpsLabel.Parent = spFrame

-- PING
local pingLabel = Instance.new("TextLabel")
pingLabel.Name = "PING"
pingLabel.Size = UDim2.fromOffset(65, 34)
pingLabel.Position = UDim2.fromOffset(310, 0)
pingLabel.BackgroundTransparency = 1
pingLabel.Text = "PING: 0ms"
pingLabel.TextColor3 = WHITE
pingLabel.Font = Enum.Font.Gotham
pingLabel.TextSize = 12
pingLabel.TextXAlignment = Enum.TextXAlignment.Right
pingLabel.TextYAlignment = Enum.TextYAlignment.Center
pingLabel.ZIndex = 310
pingLabel.Parent = spFrame

-- Botón transparente para arrastrar
local spToggleBtn = Instance.new("TextButton")
spToggleBtn.Name = "SpiderVSButton"
spToggleBtn.Size = UDim2.new(1, 0, 1, 0)
spToggleBtn.BackgroundTransparency = 1
spToggleBtn.BorderSizePixel = 0
spToggleBtn.Text = ""
spToggleBtn.AutoButtonColor = false
spToggleBtn.ZIndex = 320
spToggleBtn.Parent = spFrame

-- =========================================================
-- ANIMACIÓN DEL PORCENTAJE
-- =========================================================
local progress = 0
local speed = 0.5

RunService.RenderStepped:Connect(function(deltaTime)
    if not spFrame.Visible then return end
    progress = progress + (deltaTime / speed)
    if progress >= 1 then progress = 0 end
    local value = math.clamp(progress, 0, 1)
    progressFill.Size = UDim2.new(value, 0, 1, 0)
    pctLabel.Text = math.floor(value * 100 + 0.5) .. "%"
end)

-- =========================================================
-- FPS Y PING
-- =========================================================
local frameCount = 0
local lastFPSUpdate = tick()

RunService.RenderStepped:Connect(function()
    frameCount = frameCount + 1
    local now = tick()
    if now - lastFPSUpdate >= 1 then
        local fps = math.floor(frameCount / (now - lastFPSUpdate))
        fpsLabel.Text = "FPS: " .. tostring(fps)
        frameCount = 0
        lastFPSUpdate = now

        local ping = 0
        pcall(function()
            ping = math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue() or 0)
        end)
        pingLabel.Text = "PING: " .. tostring(ping) .. "ms"
    end
end)

-- =========================================================
-- ARRASTRAR LA BARRA
-- =========================================================
local dragging = false
local dragStart = nil
local startPos = nil

spToggleBtn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = spFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

UIS.InputChanged:Connect(function(input)
    if not dragging then return end
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        local dx = input.Position.X - dragStart.X
        local dy = input.Position.Y - dragStart.Y
        local camera = workspace.CurrentCamera
        local viewport = camera and camera.ViewportSize or Vector2.new(1000, 1000)
        local size = spFrame.AbsoluteSize
        local newXScalePx = startPos.X.Scale * viewport.X
        local newX = math.clamp(newXScalePx + startPos.X.Offset + dx, size.X / 2, viewport.X - size.X / 2)
        local newY = math.clamp(startPos.Y.Scale * viewport.Y + startPos.Y.Offset + dy, size.Y, viewport.Y)
        spFrame.Position = UDim2.new(startPos.X.Scale, newX - newXScalePx, startPos.Y.Scale, newY - startPos.Y.Scale * viewport.Y)
    end
end)

-- =========================================================
-- ACTUALIZAR SOMBRA
-- =========================================================
local function updateShadow()
    shadow.Position = UDim2.new(spFrame.Position.X.Scale, spFrame.Position.X.Offset + 5, spFrame.Position.Y.Scale, spFrame.Position.Y.Offset + 5)
end
spFrame:GetPropertyChangedSignal("Position"):Connect(updateShadow)
updateShadow()

-- =========================================================
-- CONTROL DE VISIBILIDAD
-- =========================================================
_G._CursedSetProgressBarVisible = function(value)
    spFrame.Visible = value
    shadow.Visible = value
end

-- ============================================================
-- 🕷 SPIDER.VS INSTANT RESET (integrado)
-- ============================================================
local LP = Players.LocalPlayer
local cursedResetRemote = nil
local resetCooldown = false
local CURSED_RESET_GUID = "f888ee6e-c86d-46e1-93d7-0639d6635d42"

local function findResetRemote()
    for _, desc in ipairs(game:GetDescendants()) do
        if desc:IsA("RemoteEvent") and desc.Name:sub(1,3) == "RE/" then
            cursedResetRemote = desc
            return true
        end
    end
    return false
end

local function performInstantReset()
    if resetCooldown then return end
    resetCooldown = true

    if not cursedResetRemote then
        findResetRemote()
    end
    if not cursedResetRemote then
        for _, desc in ipairs(game:GetDescendants()) do
            if desc:IsA("RemoteEvent") and desc.Name:sub(1,3) == "RE/" then
                cursedResetRemote = desc
                break
            end
        end
    end

    if cursedResetRemote then
        local character = LP.Character
        local humanoid = character and character:FindFirstChildOfClass("Humanoid")

        if humanoid and humanoid.Health <= 0 then
            pcall(function()
                cursedResetRemote:FireServer(CURSED_RESET_GUID, LP, "balloon")
            end)
            task.delay(0.3, function()
                resetCooldown = false
            end)
            return
        end

        local resetDetected = false
        local conns = {}

        if humanoid then
            table.insert(conns, humanoid.Died:Connect(function()
                resetDetected = true
            end))
            table.insert(conns, humanoid:GetPropertyChangedSignal("Health"):Connect(function()
                if humanoid.Health <= 0 then
                    resetDetected = true
                end
            end))
        end

        if character then
            table.insert(conns, character.AncestryChanged:Connect(function(_, parent)
                if not parent then
                    resetDetected = true
                end
            end))
        end

        task.spawn(function()
            for i = 1, 50 do
                if resetDetected then break end
                pcall(function()
                    cursedResetRemote:FireServer(CURSED_RESET_GUID, LP, "balloon")
                end)
                task.wait()
            end
            for _, conn in ipairs(conns) do
                pcall(function() conn:Disconnect() end)
            end
            task.delay(0.3, function()
                resetCooldown = false
            end)
        end)

    else
        -- Fallback: matar al personaje
        local char = LP.Character
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        if hum then
            hum.Health = 0
        end
        task.delay(0.3, function()
            resetCooldown = false
        end)
    end
end

-- ============================================================
-- 🕷 SPIDER.VS TP BAT (Extraída de CRYON BLUE EDITION)
-- ============================================================

local tpBatEnabled = false
local tpBatHittingCooldown = false
local tpBatHRP = nil
local tpBatH = nil

local tpHeartbeatConn = nil
local tpRenderConn = nil
local tpCharAddedConn = nil

local function getBatTool()
    local char = LP.Character
    if not char then return nil end

    local bat = char:FindFirstChild("Bat")
    if bat then return bat end

    local backpack = LP:FindFirstChild("Backpack")
    if backpack then
        bat = backpack:FindFirstChild("Bat")
        if bat then
            bat.Parent = char
            return bat
        end
    end

    return nil
end

local function tryHit()
    if tpBatHittingCooldown then return end
    tpBatHittingCooldown = true

    pcall(function()
        local bat = getBatTool()
        if bat then
            bat:Activate()
            local remoteEvent = bat:FindFirstChildWhichIsA("RemoteEvent")
            if remoteEvent then
                remoteEvent:FireServer()
            end
            local remoteFunction = bat:FindFirstChildWhichIsA("RemoteFunction")
            if remoteFunction then
                pcall(function()
                    remoteFunction:InvokeServer()
                end)
            end
        end
    end)

    task.delay(0.08, function()
        tpBatHittingCooldown = false
    end)
end

local function getClosestPlayer()
    if not tpBatHRP then return nil, math.huge end

    local closest, closestDist = nil, math.huge
    for _, otherPlayer in pairs(Players:GetPlayers()) do
        if otherPlayer ~= LP and otherPlayer.Character then
            local targetRoot = otherPlayer.Character:FindFirstChild("HumanoidRootPart")
            if targetRoot then
                local dist = (tpBatHRP.Position - targetRoot.Position).Magnitude
                if dist < closestDist then
                    closestDist = dist
                    closest = otherPlayer
                end
            end
        end
    end

    return closest, closestDist
end

local function updateCharacterReferences()
    local char = LP.Character
    if char then
        tpBatH = char:FindFirstChildOfClass("Humanoid")
        tpBatHRP = char:FindFirstChild("HumanoidRootPart")
    end
end

local function heartbeatLoop()
    if not tpBatEnabled then return end

    if not tpBatH or not tpBatHRP or not tpBatH.Parent or not tpBatHRP.Parent then
        updateCharacterReferences()
        if not tpBatH or not tpBatHRP then return end
    end

    local target, dist = getClosestPlayer()
    if target and target.Character then
        local targetRoot = target.Character:FindFirstChild("HumanoidRootPart")
        if targetRoot then
            if sethiddenproperty then
                pcall(function()
                    sethiddenproperty(tpBatHRP, "PhysicsRepRootPart", targetRoot)
                end)
            end

            local targetPosition = targetRoot.Position + Vector3.new(0, 0.9, 0)
            if (tpBatHRP.Position - targetPosition).Magnitude > 5 then
                tpBatHRP.CFrame = CFrame.new(targetPosition)
            end

            local camera = workspace.CurrentCamera
            if camera then
                camera.CFrame = CFrame.new(camera.CFrame.Position, targetRoot.Position)
            end

            tryHit()
        end
    end
end

local function renderLoop()
    if not tpBatEnabled then return end
    if not tpBatH or not tpBatHRP or not tpBatH.Parent or not tpBatHRP.Parent then
        updateCharacterReferences()
        if not tpBatH or not tpBatHRP then return end
    end

    local target, dist = getClosestPlayer()
    if target and target.Character then
        local targetRoot = target.Character:FindFirstChild("HumanoidRootPart")
        if targetRoot then
            local camera = workspace.CurrentCamera
            if camera then
                camera.CFrame = CFrame.new(camera.CFrame.Position, targetRoot.Position)
            end
            tryHit()
        end
    end
end

function enableTPBat()
    if tpBatEnabled then return end
    tpBatEnabled = true

    updateCharacterReferences()

    if tpHeartbeatConn then tpHeartbeatConn:Disconnect() end
    if tpRenderConn then tpRenderConn:Disconnect() end

    tpHeartbeatConn = RunService.Heartbeat:Connect(heartbeatLoop)
    tpRenderConn = RunService.RenderStepped:Connect(renderLoop)

    if tpCharAddedConn then tpCharAddedConn:Disconnect() end
    tpCharAddedConn = LP.CharacterAdded:Connect(function()
        task.wait(0.2)
        updateCharacterReferences()
    end)

    print("🕷 SPIDER.VS → TP Bat activado")
end

function disableTPBat()
    if not tpBatEnabled then return end
    tpBatEnabled = false

    if tpHeartbeatConn then tpHeartbeatConn:Disconnect(); tpHeartbeatConn = nil end
    if tpRenderConn then tpRenderConn:Disconnect(); tpRenderConn = nil end
    if tpCharAddedConn then tpCharAddedConn:Disconnect(); tpCharAddedConn = nil end

    pcall(function()
        local camera = workspace.CurrentCamera
        if camera then
            camera.CFrame = CFrame.new(camera.CFrame.Position, Vector3.zero)
        end
    end)

    print("🕷 SPIDER.VS → TP Bat desactivado")
end

-- ============================================================
-- 🕷 SPIDER.VS AUTO LEFT & AUTO RIGHT (Extraído de CRYON BLUE EDITION)
-- ============================================================

local AP = {
    L1 = Vector3.new(-476.48, -6.28, 92.73),
    L2 = Vector3.new(-483.12, -4.95, 94.80),
    L_FACE = Vector3.new(-482.25, -4.96, 92.09),
    R1 = Vector3.new(-476.16, -6.52, 25.62),
    R2 = Vector3.new(-483.06, -5.03, 25.48),
    R_FACE = Vector3.new(-482.06, -6.93, 35.47),
}

local autoLeftEnabled = false
local autoRightEnabled = false
local alPhase = 1
local arPhase = 1
local alConn = nil
local arConn = nil
local normalSpeed = 60

function setNormalSpeed(speed)
    if type(speed) == "number" and speed > 0 then
        normalSpeed = speed
    end
end

function startAutoLeft(speed)
    if alConn then stopAutoLeft() end
    autoLeftEnabled = true
    alPhase = 1
    local spd = speed or normalSpeed

    alConn = RunService.Heartbeat:Connect(function()
        if not autoLeftEnabled then return end
        local char = LP.Character
        if not char then return end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        local hum = char:FindFirstChildOfClass("Humanoid")
        if not hrp or not hum then return end

        if alPhase == 1 then
            local target = Vector3.new(AP.L1.X, hrp.Position.Y, AP.L1.Z)
            local dist = (target - hrp.Position).Magnitude
            if dist < 1 then
                alPhase = 2
                local dir = (AP.L2 - hrp.Position)
                local move = Vector3.new(dir.X, 0, dir.Z).Unit
                hum:Move(move, false)
                hrp.AssemblyLinearVelocity = Vector3.new(move.X * spd, hrp.AssemblyLinearVelocity.Y, move.Z * spd)
                return
            end
            local dir = (AP.L1 - hrp.Position)
            local move = Vector3.new(dir.X, 0, dir.Z).Unit
            hum:Move(move, false)
            hrp.AssemblyLinearVelocity = Vector3.new(move.X * spd, hrp.AssemblyLinearVelocity.Y, move.Z * spd)

        elseif alPhase == 2 then
            local target = Vector3.new(AP.L2.X, hrp.Position.Y, AP.L2.Z)
            local dist = (target - hrp.Position).Magnitude
            if dist < 1 then
                hum:Move(Vector3.zero, false)
                hrp.AssemblyLinearVelocity = Vector3.zero
                autoLeftEnabled = false
                if alConn then
                    alConn:Disconnect()
                    alConn = nil
                end
                alPhase = 1
                if (AP.L_FACE - hrp.Position).Magnitude > 0.01 then
                    hrp.CFrame = CFrame.new(hrp.Position, Vector3.new(AP.L_FACE.X, hrp.Position.Y, AP.L_FACE.Z))
                end
                return
            end
            local dir = (AP.L2 - hrp.Position)
            local move = Vector3.new(dir.X, 0, dir.Z).Unit
            hum:Move(move, false)
            hrp.AssemblyLinearVelocity = Vector3.new(move.X * spd, hrp.AssemblyLinearVelocity.Y, move.Z * spd)
        end
    end)
    print("🕷 SPIDER.VS → Auto Left activado")
end

function stopAutoLeft()
    if alConn then
        alConn:Disconnect()
        alConn = nil
    end
    autoLeftEnabled = false
    alPhase = 1
    local char = LP.Character
    if char then
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then
            hum:Move(Vector3.zero, false)
        end
    end
    print("🕷 SPIDER.VS → Auto Left desactivado")
end

function startAutoRight(speed)
    if arConn then stopAutoRight() end
    autoRightEnabled = true
    arPhase = 1
    local spd = speed or normalSpeed

    arConn = RunService.Heartbeat:Connect(function()
        if not autoRightEnabled then return end
        local char = LP.Character
        if not char then return end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        local hum = char:FindFirstChildOfClass("Humanoid")
        if not hrp or not hum then return end

        if arPhase == 1 then
            local target = Vector3.new(AP.R1.X, hrp.Position.Y, AP.R1.Z)
            local dist = (target - hrp.Position).Magnitude
            if dist < 1 then
                arPhase = 2
                local dir = (AP.R2 - hrp.Position)
                local move = Vector3.new(dir.X, 0, dir.Z).Unit
                hum:Move(move, false)
                hrp.AssemblyLinearVelocity = Vector3.new(move.X * spd, hrp.AssemblyLinearVelocity.Y, move.Z * spd)
                return
            end
            local dir = (AP.R1 - hrp.Position)
            local move = Vector3.new(dir.X, 0, dir.Z).Unit
            hum:Move(move, false)
            hrp.AssemblyLinearVelocity = Vector3.new(move.X * spd, hrp.AssemblyLinearVelocity.Y, move.Z * spd)

        elseif arPhase == 2 then
            local target = Vector3.new(AP.R2.X, hrp.Position.Y, AP.R2.Z)
            local dist = (target - hrp.Position).Magnitude
            if dist < 1 then
                hum:Move(Vector3.zero, false)
                hrp.AssemblyLinearVelocity = Vector3.zero
                autoRightEnabled = false
                if arConn then
                    arConn:Disconnect()
                    arConn = nil
                end
                arPhase = 1
                if (AP.R_FACE - hrp.Position).Magnitude > 0.01 then
                    hrp.CFrame = CFrame.new(hrp.Position, Vector3.new(AP.R_FACE.X, hrp.Position.Y, AP.R_FACE.Z))
                end
                return
            end
            local dir = (AP.R2 - hrp.Position)
            local move = Vector3.new(dir.X, 0, dir.Z).Unit
            hum:Move(move, false)
            hrp.AssemblyLinearVelocity = Vector3.new(move.X * spd, hrp.AssemblyLinearVelocity.Y, move.Z * spd)
        end
    end)
    print("🕷 SPIDER.VS → Auto Right activado")
end

function stopAutoRight()
    if arConn then
        arConn:Disconnect()
        arConn = nil
    end
    autoRightEnabled = false
    arPhase = 1
    local char = LP.Character
    if char then
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then
            hum:Move(Vector3.zero, false)
        end
    end
    print("🕷 SPIDER.VS → Auto Right desactivado")
end

-- =========================================================
-- ASIGNAR FUNCIONES A LOS BOTONES
-- =========================================================

-- TP BAT (Button1)
if btnTPBat then
    btnTPBat.Activated:Connect(function()
        if tpBatEnabled then
            disableTPBat()
        else
            enableTPBat()
        end
    end)
else
    warn("🕷 SPIDER.VS → No se encontró Button1")
end

-- INSTA RESET (Button2)
if btnInstaReset then
    btnInstaReset.Activated:Connect(function()
        performInstantReset()
        print("🕷 SPIDER.VS → Insta Reset ejecutado")
    end)
else
    warn("🕷 SPIDER.VS → No se encontró Button2")
end

-- AUTO RIGHT (Button4)
if btnAutoRight then
    btnAutoRight.Activated:Connect(function()
        if autoRightEnabled then
            stopAutoRight()
        else
            startAutoRight()
        end
    end)
else
    warn("🕷 SPIDER.VS → No se encontró Button4")
end

-- AUTO LEFT (Button8)
if btnAutoLeft then
    btnAutoLeft.Activated:Connect(function()
        if autoLeftEnabled then
            stopAutoLeft()
        else
            startAutoLeft()
        end
    end)
else
    warn("🕷 SPIDER.VS → No se encontró Button8")
end

print("🕷 SPIDER.VS → Todos los módulos cargados correctamente")

-- Fin del script