-- FORCE HUB - Script de Duels y Auto Steal
-- Presiona RIGHT SHIFT para abrir/cerrar el hub
-- @kircxz67

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local VirtualUser = game:GetService("VirtualUser")
local TeleportService = game:GetService("TeleportService")
local StarterGui = game:GetService("StarterGui")

local player = Players.LocalPlayer
local mouse = player:GetMouse()

-- ============================================
-- CREACIÓN DE LA GUI
-- ============================================

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "FORCEHUB"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

-- Frame principal
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 420, 0, 520)
mainFrame.Position = UDim2.new(0.5, -210, 0.5, -260)
mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
mainFrame.BackgroundTransparency = 0.05
mainFrame.BorderSizePixel = 2
mainFrame.BorderColor3 = Color3.fromRGB(255, 30, 30)
mainFrame.ClipsDescendants = true
mainFrame.Parent = screenGui

-- Efecto glow/brillo
local glow = Instance.new("Frame")
glow.Size = UDim2.new(1, 20, 1, 20)
glow.Position = UDim2.new(0, -10, 0, -10)
glow.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
glow.BackgroundTransparency = 0.85
glow.BorderSizePixel = 0
glow.Parent = mainFrame

-- ============================================
-- BARRA DE TÍTULO
-- ============================================

local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 45)
titleBar.BackgroundColor3 = Color3.fromRGB(40, 5, 5)
titleBar.BorderSizePixel = 0
titleBar.Parent = mainFrame

local titleText = Instance.new("TextLabel")
titleText.Size = UDim2.new(0.6, 0, 1, 0)
titleText.Position = UDim2.new(0.05, 0, 0, 0)
titleText.BackgroundTransparency = 1
titleText.Text = "⚡ FORCE HUB ⚡"
titleText.TextColor3 = Color3.fromRGB(255, 60, 60)
titleText.TextScaled = true
titleText.Font = Enum.Font.GothamBold
titleText.TextStrokeColor3 = Color3.fromRGB(255, 200, 0)
titleText.TextStrokeTransparency = 0.2
titleText.Parent = titleBar

-- Botón cerrar
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 32, 0, 32)
closeBtn.Position = UDim2.new(1, -38, 0, 6)
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
closeBtn.BorderSizePixel = 0
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextScaled = true
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Parent = titleBar
closeBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
end)

-- Botón minimizar
local minBtn = Instance.new("TextButton")
minBtn.Size = UDim2.new(0, 32, 0, 32)
minBtn.Position = UDim2.new(1, -75, 0, 6)
minBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
minBtn.BorderSizePixel = 0
minBtn.Text = "─"
minBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
minBtn.TextScaled = true
minBtn.Font = Enum.Font.GothamBold
minBtn.Parent = titleBar
minBtn.MouseButton1Click:Connect(function()
    mainFrame.Size = UDim2.new(0, 420, 0, 45)
    mainFrame.Position = UDim2.new(0.5, -210, 0.5, -22)
    for _, child in pairs(mainFrame:GetChildren()) do
        if child ~= titleBar and child ~= glow and child.Name ~= "DragHandle" then
            child.Visible = false
        end
    end
end)

-- Sistema de arrastre
local dragHandle = Instance.new("Frame")
dragHandle.Size = UDim2.new(0.5, 0, 1, 0)
dragHandle.Position = UDim2.new(0.25, 0, 0, 0)
dragHandle.BackgroundTransparency = 1
dragHandle.Parent = titleBar

local dragging = false
local dragInput, dragStart, startPos

dragHandle.InputBegan:Connect(function(input)
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

dragHandle.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement and dragging then
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- ============================================
-- CONTENEDOR DE BOTONES (Scrollable)
-- ============================================

local content = Instance.new("ScrollingFrame")
content.Size = UDim2.new(1, -10, 1, -55)
content.Position = UDim2.new(0, 5, 0, 50)
content.BackgroundTransparency = 1
content.ScrollBarThickness = 4
content.ScrollBarImageColor3 = Color3.fromRGB(255, 50, 50)
content.CanvasSize = UDim2.new(0, 0, 0, 620)
content.Parent = mainFrame

local listLayout = Instance.new("UIListLayout")
listLayout.Padding = UDim.new(0, 6)
listLayout.SortOrder = Enum.SortOrder.LayoutOrder
listLayout.Parent = content

-- ============================================
-- FUNCIÓN PARA CREAR BOTONES
-- ============================================

function createButton(text, color, callback, desc)
    local btnFrame = Instance.new("Frame")
    btnFrame.Size = UDim2.new(1, -10, 0, 42)
    btnFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 32)
    btnFrame.BorderSizePixel = 1
    btnFrame.BorderColor3 = Color3.fromRGB(45, 45, 65)
    btnFrame.Parent = content
    
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 1, 0)
    btn.BackgroundTransparency = 1
    btn.Text = ""
    btn.Parent = btnFrame
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.65, -10, 1, 0)
    label.Position = UDim2.new(0.03, 0, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.fromRGB(230, 230, 255)
    label.TextSize = 15
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Font = Enum.Font.GothamSemibold
    label.Parent = btnFrame
    
    local status = Instance.new("TextLabel")
    status.Size = UDim2.new(0.25, 0, 1, 0)
    status.Position = UDim2.new(0.72, 0, 0, 0)
    status.BackgroundTransparency = 1
    status.Text = "OFF"
    status.TextColor3 = Color3.fromRGB(255, 60, 60)
    status.TextSize = 13
    status.TextXAlignment = Enum.TextXAlignment.Right
    status.Font = Enum.Font.GothamBold
    status.Parent = btnFrame
    status.Name = "Status"
    
    local indicator = Instance.new("Frame")
    indicator.Size = UDim2.new(0, 10, 0, 10)
    indicator.Position = UDim2.new(1, -16, 0.5, -5)
    indicator.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
    indicator.BorderSizePixel = 0
    indicator.Parent = btnFrame
    indicator.Name = "Indicator"
    
    -- Efecto hover
    btn.MouseButton1Click:Connect(function()
        callback(btnFrame, status, indicator)
    end)
    
    btnFrame.MouseEnter:Connect(function()
        TweenService:Create(btnFrame, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(35, 35, 50)}):Play()
    end)
    
    btnFrame.MouseLeave:Connect(function()
        TweenService:Create(btnFrame, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(20, 20, 32)}):Play()
    end)
    
    return btnFrame
end

-- ============================================
-- FUNCIÓN TOGGLE
-- ============================================

function toggleButton(frame, status, indicator)
    local isOn = status.Text == "ON"
    if isOn then
        status.Text = "OFF"
        status.TextColor3 = Color3.fromRGB(255, 60, 60)
        indicator.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
    else
        status.Text = "ON"
        status.TextColor3 = Color3.fromRGB(60, 255, 60)
        indicator.BackgroundColor3 = Color3.fromRGB(60, 255, 60)
    end
    return not isOn
end

-- ============================================
-- FUNCIONES PRINCIPALES
-- ============================================

-- Obtener jugador más cercano
function getClosestPlayer()
    local closest = nil
    local closestDist = math.huge
    local char = player.Character
    if not char then return nil end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return nil end
    
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= player then
            local pChar = p.Character
            if pChar then
                local pRoot = pChar:FindFirstChild("HumanoidRootPart")
                if pRoot then
                    local dist = (root.Position - pRoot.Position).Magnitude
                    if dist < closestDist then
                        closestDist = dist
                        closest = p
                    end
                end
            end
        end
    end
    return closest
end

-- Obtener todos los jugadores con distancia
function getAllPlayersWithDistance()
    local result = {}
    local char = player.Character
    if not char then return result end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return result end
    
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= player then
            local pChar = p.Character
            if pChar then
                local pRoot = pChar:FindFirstChild("HumanoidRootPart")
                if pRoot then
                    local dist = (root.Position - pRoot.Position).Magnitude
                    table.insert(result, {player = p, distance = dist})
                end
            end
        end
    end
    table.sort(result, function(a, b) return a.distance < b.distance end)
    return result
end

-- ============================================
-- AUTO STEAL
-- ============================================

local autoStealEnabled = false
local stealCooldown = false

createButton("☠ AUTO STEAL", Color3.fromRGB(200, 0, 0), function(frame, status, indicator)
    autoStealEnabled = toggleButton(frame, status, indicator)
    if autoStealEnabled then
        print("[FORCE HUB] Auto Steal ACTIVADO")
    else
        print("[FORCE HUB] Auto Steal DESACTIVADO")
    end
end)

-- Loop de Auto Steal
RunService.Heartbeat:Connect(function()
    if autoStealEnabled and not stealCooldown then
        stealCooldown = true
        task.spawn(function()
            local target = getClosestPlayer()
            if target then
                local targetChar = target.Character
                if targetChar then
                    local targetRoot = targetChar:FindFirstChild("HumanoidRootPart")
                    if targetRoot then
                        -- Intentar robar (simular click)
                        local pos, onScreen = game:GetService("Camera"):WorldToViewportPoint(targetRoot.Position)
                        if onScreen then
                            VirtualUser:CaptureController()
                            VirtualUser:ClickButton1(Vector2.new(pos.X, pos.Y))
                        end
                    end
                end
            end
            wait(0.35) -- Cooldown entre robos
            stealCooldown = false
        end)
    end
end)

-- ============================================
-- AUTO PARRY / BLOQUEO
-- ============================================

local autoParryEnabled = false

createButton("🛡 AUTO PARRY", Color3.fromRGB(0, 120, 220), function(frame, status, indicator)
    autoParryEnabled = toggleButton(frame, status, indicator)
end)

RunService.Heartbeat:Connect(function()
    if autoParryEnabled then
        -- Buscar tecla de parry/block y presionarla
        -- Adaptar al juego específico
        local key = Enum.KeyCode.F
        VirtualUser:CaptureController()
        VirtualUser:KeyDown(key)
        wait(0.05)
        VirtualUser:KeyUp(key)
    end
end)

-- ============================================
-- AUTO REBIRTH
-- ============================================

local autoRebirthEnabled = false

createButton("🔄 AUTO REBIRTH", Color3.fromRGB(200, 150, 0), function(frame, status, indicator)
    autoRebirthEnabled = toggleButton(frame, status, indicator)
end)

task.spawn(function()
    while true do
        if autoRebirthEnabled then
            -- Buscar botón de rebirth en la GUI
            local rebirthGui = player.PlayerGui:FindFirstChild("Rebirth")
            if rebirthGui then
                local btn = rebirthGui:FindFirstChild("RebirthButton") or rebirthGui:FindFirstChild("Button")
                if btn and btn:IsA("TextButton") then
                    btn:Fire()
                end
            end
            -- Buscar ClickDetector
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj:IsA("ClickDetector") and obj.Name:lower():find("rebirth") then
                    fireclickdetector(obj)
                end
            end
        end
        wait(2)
    end
end)

-- ============================================
-- ANTI AFK
-- ============================================

local antiAFKEnabled = false

createButton("💤 ANTI AFK", Color3.fromRGB(150, 0, 200), function(frame, status, indicator)
    antiAFKEnabled = toggleButton(frame, status, indicator)
end)

task.spawn(function()
    while true do
        if antiAFKEnabled then
            VirtualUser:CaptureController()
            VirtualUser:ClickButton2(Vector2.new())
            wait(20)
        end
        wait(1)
    end
end)

-- ============================================
-- AUTO FARM
-- ============================================

local autoFarmEnabled = false

createButton("⚔ AUTO FARM", Color3.fromRGB(0, 200, 100), function(frame, status, indicator)
    autoFarmEnabled = toggleButton(frame, status, indicator)
end)

task.spawn(function()
    while true do
        if autoFarmEnabled then
            -- Buscar enemigos o NPCs cercanos
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj:IsA("Model") and obj:FindFirstChild("Humanoid") then
                    local hrp = obj:FindFirstChild("HumanoidRootPart")
                    if hrp then
                        local char = player.Character
                        if char then
                            local root = char:FindFirstChild("HumanoidRootPart")
                            if root then
                                local dist = (root.Position - hrp.Position).Magnitude
                                if dist < 20 then
                                    -- Atacar al enemigo
                                    local humanoid = obj:FindFirstChild("Humanoid")
                                    if humanoid and humanoid.Health > 0 then
                                        -- Simular ataque
                                        VirtualUser:CaptureController()
                                        VirtualUser:ClickButton1(Vector2.new())
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
        wait(0.5)
    end
end)

-- ============================================
-- SPEED BOOST
-- ============================================

local speedBoostEnabled = false

createButton("💨 SPEED BOOST", Color3.fromRGB(0, 150, 255), function(frame, status, indicator)
    speedBoostEnabled = toggleButton(frame, status, indicator)
    if speedBoostEnabled then
        local char = player.Character
        if char then
            local hum = char:FindFirstChild("Humanoid")
            if hum then
                hum.WalkSpeed = 50
                hum.JumpPower = 80
            end
        end
    else
        local char = player.Character
        if char then
            local hum = char:FindFirstChild("Humanoid")
            if hum then
                hum.WalkSpeed = 16
                hum.JumpPower = 50
            end
        end
    end
end)

-- ============================================
-- ESP / WALLHACK
-- ============================================

local espEnabled = false
local espObjects = {}

function createESP()
    clearESP()
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= player then
            local char = p.Character
            if char then
                local hrp = char:FindFirstChild("HumanoidRootPart")
                if hrp then
                    -- Caja ESP
                    local box = Instance.new("BoxHandleAdornment")
                    box.Size = Vector3.new(3, 5, 3)
                    box.Color3 = Color3.fromRGB(255, 50, 50)
                    box.Transparency = 0.3
                    box.AlwaysOnTop = true
                    box.ZIndex = 10
                    box.Adornee = hrp
                    box.Parent = hrp
                    table.insert(espObjects, box)
                    
                    -- Nombre y distancia
                    local billboard = Instance.new("BillboardGui")
                    billboard.Size = UDim2.new(0, 120, 0, 30)
                    billboard.Adornee = hrp
                    billboard.Parent = hrp
                    
                    local label = Instance.new("TextLabel")
                    label.Size = UDim2.new(1, 0, 1, 0)
                    label.BackgroundTransparency = 1
                    label.Text = p.Name
                    label.TextColor3 = Color3.fromRGB(255, 255, 255)
                    label.TextScaled = true
                    label.Font = Enum.Font.GothamBold
                    label.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
                    label.TextStrokeTransparency = 0.3
                    label.Parent = billboard
                    
                    -- Línea de distancia
                    local line = Instance.new("LineHandleAdornment")
                    line.Color3 = Color3.fromRGB(255, 0, 0)
                    line.Transparency = 0.3
                    line.AlwaysOnTop = true
                    line.ZIndex = 5
                    line.Parent = hrp
                    
                    table.insert(espObjects, billboard)
                    table.insert(espObjects, line)
                end
            end
        end
    end
end

function clearESP()
    for _, obj in pairs(espObjects) do
        pcall(function() obj:Destroy() end)
    end
    espObjects = {}
end

createButton("👁 ESP", Color3.fromRGB(0, 255, 200), function(frame, status, indicator)
    espEnabled = toggleButton(frame, status, indicator)
    if espEnabled then
        createESP()
        -- Actualizar ESP periódicamente
        task.spawn(function()
            while espEnabled do
                createESP()
                wait(2)
            end
        end)
    else
        clearESP()
    end
end)

-- ============================================
-- TELEPORT AL JUGADOR MÁS CERCANO
-- ============================================

createButton("🚀 TELEPORT", Color3.fromRGB(255, 100, 0), function()
    local target = getClosestPlayer()
    if target then
        local char = player.Character
        if char then
            local hrp = char:FindFirstChild("HumanoidRootPart")
            local targetChar = target.Character
            if targetChar then
                local targetHrp = targetChar:FindFirstChild("HumanoidRootPart")
                if targetHrp and hrp then
                    hrp.CFrame = targetHrp.CFrame + Vector3.new(0, 2, 0)
                    print("[FORCE HUB] Teleportado a " .. target.Name)
                end
            end
        end
    end
end)

-- ============================================
-- ABRIR SHOP
-- ============================================

createButton("🛒 OPEN SHOP", Color3.fromRGB(255, 200, 0), function()
    local shopGui = player.PlayerGui:FindFirstChild("Shop")
    if shopGui then
        shopGui.Enabled = true
        local btn = shopGui:FindFirstChild("OpenButton") or shopGui:FindFirstChild("ShopButton")
        if btn and btn:IsA("TextButton") then
            btn:Fire()
        end
    end
    -- Buscar en workspace
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("ClickDetector") and obj.Name:lower():find("shop") then
            fireclickdetector(obj)
        end
    end
end)

-- ============================================
-- TRADE
-- ============================================

createButton("💱 TRADE", Color3.fromRGB(200, 100, 255), function()
    local target = getClosestPlayer()
    if target then
        -- Buscar sistema de trade
        local tradeGui = player.PlayerGui:FindFirstChild("Trade")
        if tradeGui then
            local btn = tradeGui:FindFirstChild("SendRequest") or tradeGui:FindFirstChild("TradeButton")
            if btn and btn:IsA("TextButton") then
                btn:Fire()
            end
        end
        print("[FORCE HUB] Solicitud de trade enviada a " .. target.Name)
    end
end)

-- ============================================
-- REJOIN (Reconectar al servidor)
-- ============================================

createButton("🔄 REJOIN", Color3.fromRGB(255, 0, 255), function()
    local jobId = game.JobId
    TeleportService:TeleportToPlaceInstance(game.PlaceId, jobId, player)
end)

-- ============================================
-- CODES (Abrir códigos)
-- ============================================

createButton("📋 CODES", Color3.fromRGB(100, 200, 255), function()
    -- Abrir panel de códigos
    local codesGui = player.PlayerGui:FindFirstChild("Codes")
    if codesGui then
        codesGui.Enabled = true
    end
    -- Buscar en workspace
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("ClickDetector") and obj.Name:lower():find("code") then
            fireclickdetector(obj)
        end
    end
end)

-- ============================================
-- TOGGLE GUI CON TECLA (RIGHT SHIFT)
-- ============================================

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.RightShift then
        mainFrame.Visible = not mainFrame.Visible
    end
end)

-- ============================================
-- INICIALIZACIÓN
-- ============================================

mainFrame.Visible = true
print("⚡ FORCE HUB CARGADO ⚡")
print("Presiona RIGHT SHIFT para abrir/cerrar")
print("Creado por @kircxz67")