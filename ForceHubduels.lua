-- LocalScript

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TS = game:GetService("TweenService")
local Stats = game:GetService("Stats")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- ============================================================
-- GUI PRINCIPAL (botones derecha)
-- ============================================================
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "BotonesUI"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
screenGui.Parent = playerGui

local frame = Instance.new("Frame")
frame.Name = "Botones"
frame.Size = UDim2.new(0, 276, 0, 260)
frame.AnchorPoint = Vector2.new(1, 0)
frame.Position = UDim2.new(1, -10, 0, 25)
frame.BackgroundTransparency = 1
frame.Parent = screenGui

local botonSize = 65
local separacionX = 4
local separacionY = 4
local columnas = {1, 2, 4, 4}

for columna = 1, 4 do
    local cantidad = columnas[columna]
    for fila = 1, cantidad do
        local boton = Instance.new("TextButton")
        boton.Name = "Boton_" .. columna .. "_" .. fila
        boton.Size = UDim2.new(0, botonSize, 0, botonSize)

        local yInicial
        if columna == 1 or columna == 2 then
            yInicial = 0
        else
            local altura = cantidad * botonSize + (cantidad - 1) * separacionY
            yInicial = (260 - altura) / 2
        end

        boton.Position = UDim2.new(
            0,
            (columna - 1) * (botonSize + separacionX),
            0,
            yInicial + (fila - 1) * (botonSize + separacionY)
        )

        if columna == 1 and fila == 1 then
            boton.Text = "RESET"
        elseif columna == 2 and fila == 1 then
            boton.Text = "BAT V2"
        elseif columna == 2 and fila == 2 then
            boton.Text = "ANTI DESYNC"
        elseif columna == 3 and fila == 1 then
            boton.Text = "DROP BR"
        elseif columna == 3 and fila == 2 then
            boton.Text = "BAT AIMBOT"
        elseif columna == 3 and fila == 3 then
            boton.Text = "TP DOWN"
        elseif columna == 3 and fila == 4 then
            boton.Text = "LAGGER 1"
        elseif columna == 4 and fila == 1 then
            boton.Text = "AUTO LEFT"
        elseif columna == 4 and fila == 2 then
            boton.Text = "AUTO RIGHT"
        elseif columna == 4 and fila == 3 then
            boton.Text = "CARRY SPD"
        elseif columna == 4 and fila == 4 then
            boton.Text = "LAGGER 2"
        else
            boton.Text = ""
        end

        boton.TextColor3 = Color3.fromRGB(200, 200, 200)
        boton.TextSize = 17
        boton.Font = Enum.Font.GothamBold
        boton.TextScaled = false
        boton.TextWrapped = true
        boton.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
        boton.BorderSizePixel = 0
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 15)
        corner.Parent = boton
        boton.Parent = frame
    end
end

-- RESET
local resetButton = frame:FindFirstChild("Boton_1_1")
if resetButton then
    local isResetting = false
    resetButton.MouseButton1Click:Connect(function()
        if isResetting then return end
        isResetting = true
        player:LoadCharacter()
        resetButton.BackgroundColor3 = Color3.fromRGB(128, 128, 128)
        task.wait(1)
        resetButton.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
        isResetting = false
    end)
end

-- TP DOWN
local tpDownButton = frame:FindFirstChild("Boton_3_3")
if tpDownButton then
    tpDownButton.MouseButton1Click:Connect(function()
        local char = player.Character
        if not char then return end
        local rootPart = char:FindFirstChild("HumanoidRootPart")
        if not rootPart then return end
        local startPos = rootPart.Position
        local raycastParams = RaycastParams.new()
        raycastParams.FilterDescendantsInstances = {char}
        raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
        local result = workspace:Raycast(startPos, Vector3.new(0, -500, 0), raycastParams)
        if result then
            rootPart.CFrame = CFrame.new(result.Position + Vector3.new(0, 3, 0))
        end
    end)
end

-- ============================================================
-- SISTEMA AUTO STEAL (con su propia GUI)
-- ============================================================

-- Estado del robo
local Steal = {
    AutoStealEnabled = false,
    StealRadius = 55,
    StealDuration = 0.2,
    Mode = "half",
    HalfFireRange = 10,
    HalfHoldMin = 1.3,
    HalfHoldMax = 2.6,
    HalfEntryDelay = 0.3,
    Data = {}
}
local isStealing = false
local stealStartTime = nil
local autoConn = nil
local progressFill, pctLabel, fpsLabel, pingLabel, separator

-- Funciones auxiliares (copiadas del script original)
local function isMyPlotByName(plotName)
    local plots = workspace:FindFirstChild("Plots")
    if not plots then return false end
    local plot = plots:FindFirstChild(plotName)
    if not plot then return false end
    local sign = plot:FindFirstChild("PlotSign")
    if sign then
        local yb = sign:FindFirstChild("YourBase")
        if yb and yb:IsA("BillboardGui") then
            return yb.Enabled == true
        end
    end
    return false
end

local function findNearestPrompt()
    local char = player.Character
    if not char then return nil end
    local root = char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("UpperTorso") or char:FindFirstChild("Torso")
    if not root then return nil end
    local plots = workspace:FindFirstChild("Plots")
    if not plots then return nil end
    local nearest, dist = nil, math.huge
    for _, plot in ipairs(plots:GetChildren()) do
        if plot:IsA("Model") and not isMyPlotByName(plot.Name) then
            local pods = plot:FindFirstChild("AnimalPodiums")
            if pods then
                for _, pod in ipairs(pods:GetChildren()) do
                    local base = pod:FindFirstChild("Base")
                    local sp = base and base:FindFirstChild("Spawn")
                    if sp then
                        local d = (sp.Position - root.Position).Magnitude
                        if d <= Steal.StealRadius and d < dist then
                            local found = nil
                            local att = sp:FindFirstChild("PromptAttachment")
                            if att then
                                for _, pr in ipairs(att:GetChildren()) do
                                    if pr:IsA("ProximityPrompt") and pr.ActionText and pr.ActionText:find("Steal") then
                                        found = pr
                                    end
                                end
                            end
                            if not found then
                                for _, pr in ipairs(sp:GetDescendants()) do
                                    if pr:IsA("ProximityPrompt") and pr.ActionText and pr.ActionText:find("Steal") then
                                        found = pr
                                    end
                                end
                            end
                            if found then
                                nearest, dist = found, d
                            end
                        end
                    end
                end
            end
        end
    end
    return nearest
end

local function _promptDist(prompt)
    local char = player.Character
    if not char then return math.huge end
    local root = char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("UpperTorso") or char:FindFirstChild("Torso")
    if not root then return math.huge end
    local part = prompt.Parent
    if part and part:IsA("Attachment") then part = part.Parent end
    if part and part:IsA("BasePart") then
        return (part.Position - root.Position).Magnitude
    end
    local ok, cf = pcall(function() return prompt.Parent and prompt.Parent.WorldPosition end)
    if ok and cf then
        return (cf - root.Position).Magnitude
    end
    return math.huge
end

local function executeSteal(prompt)
    if isStealing then return end
    if not Steal.Data[prompt] then
        Steal.Data[prompt] = { hold = {}, trigger = {}, ready = true }
        if getconnections then
            for _, c in ipairs(getconnections(prompt.PromptButtonHoldBegan)) do
                if c.Function then table.insert(Steal.Data[prompt].hold, c.Function) end
            end
            for _, c in ipairs(getconnections(prompt.Triggered)) do
                if c.Function then table.insert(Steal.Data[prompt].trigger, c.Function) end
            end
        end
    end
    local data = Steal.Data[prompt]
    if not data.ready then return end
    data.ready = false
    isStealing = true
    stealStartTime = tick()
    if Steal.Mode == "half" then
        task.spawn(function()
            for _, fn in ipairs(data.hold) do task.spawn(fn) end
            task.wait(Steal.HalfHoldMin)
            local inRange = _promptDist(prompt) <= Steal.HalfFireRange
            while true do
                local el = tick() - stealStartTime
                if el > Steal.HalfHoldMax or not prompt.Parent then break end
                if _promptDist(prompt) <= Steal.HalfFireRange then
                    if not inRange then task.wait(Steal.HalfEntryDelay) end
                    for _, fn in ipairs(data.trigger) do task.spawn(fn) end
                    break
                end
                task.wait()
            end
            task.wait(0.05)
            data.ready = true
            isStealing = false
        end)
    else
        task.spawn(function()
            for _, fn in ipairs(data.hold) do task.spawn(fn) end
            local el = 0
            while el < Steal.StealDuration do
                el = el + task.wait()
            end
            for _, fn in ipairs(data.trigger) do task.spawn(fn) end
            task.wait(0.05)
            data.ready = true
            isStealing = false
        end)
    end
end

local function startAutoSteal()
    if autoConn then return end
    autoConn = RunService.Heartbeat:Connect(function()
        if not Steal.AutoStealEnabled or isStealing then return end
        local p = findNearestPrompt()
        if p then executeSteal(p) end
    end)
end

local function stopAutoSteal()
    if autoConn then autoConn:Disconnect(); autoConn = nil end
    isStealing = false
end

_G.AutoSteal = Steal

-- ============================================================
-- GUI de robo (barra, FPS, ping, botón "force hub")
-- ============================================================
do
    local _oldSPG = player.PlayerGui:FindFirstChild("StealProgressScreenGui")
    if _oldSPG then _oldSPG:Destroy() end

    local spScreenGui = Instance.new("ScreenGui")
    spScreenGui.Name = "StealProgressScreenGui"
    spScreenGui.ResetOnSpawn = false
    spScreenGui.DisplayOrder = 200
    spScreenGui.IgnoreGuiInset = true
    spScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    spScreenGui.Parent = player.PlayerGui

    -- Colores ahora en negro y grises
    local NEGRO = Color3.fromRGB(0, 0, 0)
    local GRIS_OSCURO = Color3.fromRGB(40, 40, 40)
    local GRIS_MEDIO = Color3.fromRGB(100, 100, 100)
    local GRIS_CLARO = Color3.fromRGB(200, 200, 200)

    -- Marco principal (fondo negro)
    local spFrame = Instance.new("Frame", spScreenGui)
    spFrame.Name = "StealProgressGui"
    spFrame.Size = UDim2.new(0, 380, 0, 34)
    spFrame.Position = UDim2.new(0.5, 0, 1, -65)
    spFrame.AnchorPoint = Vector2.new(0.5, 1)
    spFrame.BackgroundColor3 = NEGRO          -- Fondo negro
    spFrame.BackgroundTransparency = 0.1
    spFrame.BorderSizePixel = 0
    spFrame.Active = true
    spFrame.Visible = true
    spFrame.ZIndex = 300
    spFrame.ClipsDescendants = true
    Instance.new("UICorner", spFrame).CornerRadius = UDim.new(0, 14)

    local border = Instance.new("UIStroke", spFrame)
    border.Color = Color3.fromRGB(255, 255, 255)
    border.Thickness = 1.5
    border.Transparency = 0.2

    -- Sombra
    local shadow = Instance.new("Frame", spScreenGui)
    shadow.Name = "Shadow"
    shadow.Size = UDim2.new(0, 390, 0, 40)
    shadow.Position = UDim2.new(0.5, 0, 1, -62)
    shadow.AnchorPoint = Vector2.new(0.5, 1)
    shadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    shadow.BackgroundTransparency = 0.4
    shadow.BorderSizePixel = 0
    shadow.ZIndex = 299
    Instance.new("UICorner", shadow).CornerRadius = UDim.new(0, 16)

    local textFrame = Instance.new("Frame", spFrame)
    textFrame.Size = UDim2.new(1, 0, 1, 0)
    textFrame.BackgroundTransparency = 1

    -- Etiqueta "STEAL" (más pequeña)
    local stealLabel = Instance.new("TextLabel", textFrame)
    stealLabel.Size = UDim2.new(0, 55, 1, 0)
    stealLabel.Position = UDim2.new(0, 6, 0, 0)
    stealLabel.BackgroundTransparency = 1
    stealLabel.Text = "STEAL"
    stealLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    stealLabel.Font = Enum.Font.GothamBold
    stealLabel.TextSize = 11          -- Reducido para que el número sea más visible
    stealLabel.TextXAlignment = Enum.TextXAlignment.Left

    -- Porcentaje
    pctLabel = Instance.new("TextLabel", textFrame)
    pctLabel.Size = UDim2.new(0, 45, 1, 0)
    pctLabel.Position = UDim2.new(0, 62, 0, 0)
    pctLabel.BackgroundTransparency = 1
    pctLabel.Text = "0%"
    pctLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    pctLabel.Font = Enum.Font.GothamBold
    pctLabel.TextSize = 14
    pctLabel.TextXAlignment = Enum.TextXAlignment.Center

    -- Barra de progreso (fondo gris oscuro)
    local barBg = Instance.new("Frame", textFrame)
    barBg.Size = UDim2.new(0, 100, 0, 18)
    barBg.Position = UDim2.new(0, 112, 0.5, -9)
    barBg.BackgroundColor3 = GRIS_OSCURO   -- Fondo de la barra oscuro
    barBg.BorderSizePixel = 0
    barBg.ClipsDescendants = true
    Instance.new("UICorner", barBg).CornerRadius = UDim.new(1, 0)

    local barStroke = Instance.new("UIStroke", barBg)
    barStroke.Color = Color3.fromRGB(255, 255, 255)
    barStroke.Thickness = 1
    barStroke.Transparency = 0.3

    -- Relleno de la barra (gris, gradiente de oscuro a claro)
    progressFill = Instance.new("Frame", barBg)
    progressFill.Size = UDim2.new(0, 0, 1, 0)
    progressFill.BackgroundColor3 = GRIS_MEDIO
    progressFill.BorderSizePixel = 0
    Instance.new("UICorner", progressFill).CornerRadius = UDim.new(1, 0)

    local gradient = Instance.new("UIGradient", progressFill)
    gradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, GRIS_OSCURO),
        ColorSequenceKeypoint.new(0.5, GRIS_MEDIO),
        ColorSequenceKeypoint.new(1, GRIS_CLARO)
    }
    gradient.Rotation = 90

    -- Separador
    separator = Instance.new("Frame", textFrame)
    separator.Size = UDim2.new(0, 1.5, 0, 20)
    separator.Position = UDim2.new(0, 218, 0.5, -10)
    separator.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    separator.BackgroundTransparency = 0.3
    separator.BorderSizePixel = 0

    -- Emoji antena
    local antennaLabel = Instance.new("TextLabel", textFrame)
    antennaLabel.Size = UDim2.new(0, 20, 1, 0)
    antennaLabel.Position = UDim2.new(0, 225, 0, 0)
    antennaLabel.BackgroundTransparency = 1
    antennaLabel.Text = "📡"
    antennaLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    antennaLabel.Font = Enum.Font.Gotham
    antennaLabel.TextSize = 16
    antennaLabel.TextXAlignment = Enum.TextXAlignment.Center

    -- FPS
    fpsLabel = Instance.new("TextLabel", textFrame)
    fpsLabel.Size = UDim2.new(0, 60, 1, 0)
    fpsLabel.Position = UDim2.new(0, 248, 0, 0)
    fpsLabel.BackgroundTransparency = 1
    fpsLabel.Text = "FPS: 0"
    fpsLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    fpsLabel.Font = Enum.Font.Gotham
    fpsLabel.TextSize = 12
    fpsLabel.TextXAlignment = Enum.TextXAlignment.Left

    -- PING
    pingLabel = Instance.new("TextLabel", textFrame)
    pingLabel.Size = UDim2.new(0, 65, 1, 0)
    pingLabel.Position = UDim2.new(0, 312, 0, 0)
    pingLabel.BackgroundTransparency = 1
    pingLabel.Text = "PING: 0ms"
    pingLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    pingLabel.Font = Enum.Font.Gotham
    pingLabel.TextSize = 12
    pingLabel.TextXAlignment = Enum.TextXAlignment.Right

    -- Botón "force hub" (negro con letras blancas) – TOGGLE AUTO STEAL
    local spToggleBtn = Instance.new("TextButton", spFrame)
    spToggleBtn.Size = UDim2.new(0, 80, 0, 30)
    spToggleBtn.Position = UDim2.new(0, 5, 0.5, -15)
    spToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    spToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    spToggleBtn.Text = "force hub"
    spToggleBtn.Font = Enum.Font.GothamBold
    spToggleBtn.TextSize = 13
    spToggleBtn.BorderSizePixel = 0
    spToggleBtn.ZIndex = 310
    spToggleBtn.AutoButtonColor = false
    Instance.new("UICorner", spToggleBtn).CornerRadius = UDim.new(0, 6)

    local _spWasDragged = false
    spToggleBtn.Activated:Connect(function()
        if _spWasDragged then return end
        Steal.AutoStealEnabled = not Steal.AutoStealEnabled
        if Steal.AutoStealEnabled then
            startAutoSteal()
        else
            stopAutoSteal()
        end
    end)

    -- FPS/PING en tiempo real
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

    -- Barra en bucle (0% → 100% en 0.5s)
    local progress = 0
    local speed = 0.5
    RunService.RenderStepped:Connect(function(deltaTime)
        if not spFrame.Visible then return end
        progress = progress + (deltaTime / speed)
        if progress >= 1 then progress = 0 end
        local f = math.clamp(progress, 0, 1)
        progressFill.Size = UDim2.new(f, 0, 1, 0)
        pctLabel.Text = math.floor(f * 100 + 0.5) .. "%"
    end)

    -- Arrastre de todo el marco (incluido el botón)
    local dragging = false
    local dragStart = nil
    local startPos = nil
    spFrame.InputBegan:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            _spWasDragged = false
            dragStart = inp.Position
            startPos = spFrame.Position
            inp.Changed:Connect(function()
                if inp.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    UserInputService.InputChanged:Connect(function(inp)
        if not dragging then return end
        if inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch then
            local dx = inp.Position.X - dragStart.X
            local dy = inp.Position.Y - dragStart.Y
            if math.abs(dx) > 5 or math.abs(dy) > 5 then
                _spWasDragged = true
            end
            local cam = workspace.CurrentCamera
            local vp = cam and cam.ViewportSize or Vector2.new(1000, 1000)
            local sz = spFrame.AbsoluteSize
            local newXScalePx = startPos.X.Scale * vp.X
            local newX = math.clamp(newXScalePx + startPos.X.Offset + dx, sz.X / 2, vp.X - sz.X / 2)
            local newY = math.clamp(startPos.Y.Scale * vp.Y + startPos.Y.Offset + dy, sz.Y, vp.Y)
            spFrame.Position = UDim2.new(startPos.X.Scale, newX - newXScalePx, startPos.Y.Scale, newY - startPos.Y.Scale * vp.Y)
            shadow.Position = UDim2.new(spFrame.Position.X.Scale, spFrame.Position.X.Offset + 5, spFrame.Position.Y.Scale, spFrame.Position.Y.Offset + 5)
        end
    end)

    local function updateShadow()
        shadow.Position = UDim2.new(spFrame.Position.X.Scale, spFrame.Position.X.Offset + 5, spFrame.Position.Y.Scale, spFrame.Position.Y.Offset + 5)
    end
    spFrame:GetPropertyChangedSignal("Position"):Connect(updateShadow)
    updateShadow()

    _G._CursedSetProgressBarVisible = function(v)
        spFrame.Visible = v
        shadow.Visible = v
    end
end

-- Activar Auto Steal por defecto
Steal.AutoStealEnabled = true
pcall(startAutoSteal)

-- ============================================================
-- ANTI-DIE (inalterado del script original)
-- ============================================================
do
    local Workspace = game:GetService("Workspace")
    local connections = {}

    local function enableAntiDie()
        local char = player.Character
        if not char then return end
        local hum = char:FindFirstChildOfClass("Humanoid")
        if not hum then return end

        local healthConn = hum:GetPropertyChangedSignal("Health"):Connect(function()
            if hum.Health <= 0 then
                hum.Health = hum.MaxHealth
            end
        end)
        table.insert(connections, healthConn)

        local diedConn = hum.Died:Connect(function()
            task.wait()
            pcall(function()
                local newHum = Instance.new("Humanoid")
                newHum.Name = "Humanoid"
                newHum.Parent = char
                if Workspace.CurrentCamera then
                    Workspace.CurrentCamera.CameraSubject = newHum
                end
                hum:Destroy()
            end)
        end)
        table.insert(connections, diedConn)
    end

    local function setup()
        for _, conn in pairs(connections) do
            pcall(conn.Disconnect, conn)
        end
        connections = {}
        enableAntiDie()
    end

    setup()
    player.CharacterAdded:Connect(function()
        task.wait(0.1)
        setup()
    end)
end