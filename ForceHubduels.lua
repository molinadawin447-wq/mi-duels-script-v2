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

-- ============================================================
-- INTRO CON DADOS NEGROS Y TÍTULO "FORCE HUB" (MAYÚSCULAS)
-- ============================================================
task.spawn(function()
    -- Configuración de música
    local introSoundEnabled = true
    local introSoundInstance = nil

    if introSoundEnabled then
        task.spawn(function()
            local urlIntro = "https://files.catbox.moe/66xaq4.mp3"
            local numeFisier = "dicenew_introo.mp3"
            
            if not (isfile and isfile(numeFisier)) then
                local ok, data = pcall(function() return game:HttpGet(urlIntro) end)
                if ok and data then 
                    pcall(function() writefile(numeFisier, data) end) 
                end
            end
            
            introSoundInstance = Instance.new("Sound")
            pcall(function()
                introSoundInstance.SoundId = getcustomasset(numeFisier)
                introSoundInstance.Volume = 3
                introSoundInstance.Looped = false
                introSoundInstance.Parent = game:GetService("CoreGui")
                introSoundInstance:Play()
            end)
        end)
    end

    repeat task.wait() until game:IsLoaded()

    local introStarted = tick()
    task.wait(.35)

    -- Crear GUI para la intro
    local introGui = Instance.new("ScreenGui")
    introGui.Name = "HarkDuelsIntro"
    introGui.ResetOnSpawn = false
    introGui.IgnoreGuiInset = true
    introGui.DisplayOrder = 9999
    introGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    pcall(function() 
        if syn and syn.protect_gui then syn.protect_gui(introGui) end 
    end)

    if not pcall(function() introGui.Parent = game:GetService("CoreGui") end) then
        introGui.Parent = player:WaitForChild("PlayerGui")
    end

    -- Fondo oscuro total
    local stage = Instance.new("Frame", introGui)
    stage.Size = UDim2.fromScale(1, 1)
    stage.BackgroundTransparency = 1
    stage.ClipsDescendants = true

    -- Fondo negro puro
    local bgGlow = Instance.new("Frame", stage)
    bgGlow.Size = UDim2.fromScale(1, 1)
    bgGlow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    bgGlow.BackgroundTransparency = 0
    bgGlow.BorderSizePixel = 0
    
    -- Sutil gradiente para profundidad
    local bgGrad = Instance.new("UIGradient", bgGlow)
    bgGrad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(5, 5, 5)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(15, 15, 15)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(5, 5, 5))
    })
    bgGrad.Rotation = 45

    -- Función para esperar un tiempo específico
    local function waitForIntroSecond(second)
        local remaining = second - (tick() - introStarted)
        if remaining > 0 then task.wait(remaining) end
    end

    -- Distribución de puntos en los dados
    local layouts = {
        [1] = {{.5, .5}},
        [2] = {{.28, .28}, {.72, .72}},
        [3] = {{.28, .28}, {.5, .5}, {.72, .72}},
        [4] = {{.28, .28}, {.72, .28}, {.28, .72}, {.72, .72}},
        [5] = {{.28, .28}, {.72, .28}, {.5, .5}, {.28, .72}, {.72, .72}},
        [6] = {{.28, .23}, {.72, .23}, {.28, .5}, {.72, .5}, {.28, .76}, {.72, .76}},
    }

    -- Colores del tema (Negro total)
    local COLORS = {
        dieBg = Color3.fromRGB(8, 8, 10),
        dieDark = Color3.fromRGB(3, 3, 5),
        dieFace = Color3.fromRGB(12, 12, 15),
        pipColor = Color3.fromRGB(25, 25, 30),
        accentBlack = Color3.fromRGB(20, 20, 25),
        accentBlackDark = Color3.fromRGB(5, 5, 8),
        accentBlackLight = Color3.fromRGB(30, 30, 35),
        shadow = Color3.fromRGB(0, 0, 0),
        border = Color3.fromRGB(40, 40, 45),
        white = Color3.fromRGB(255, 255, 255),
        whiteDim = Color3.fromRGB(200, 200, 200),
    }

    -- Función para crear un dado NEGRO mate
    local function makeIntroDie(size, pos, value)
        local group = Instance.new("CanvasGroup", stage)
        group.AnchorPoint = Vector2.new(.5, .5)
        group.Position = pos
        group.Size = UDim2.fromOffset(size + 14, size + 16)
        group.BackgroundTransparency = 1
        group.ZIndex = 20
        group.ClipsDescendants = true

        -- Sombra
        local shadow = Instance.new("Frame", group)
        shadow.Size = UDim2.fromOffset(size, size)
        shadow.Position = UDim2.fromOffset(10, 11)
        shadow.BackgroundColor3 = COLORS.shadow
        shadow.BackgroundTransparency = .55
        shadow.BorderSizePixel = 0
        Instance.new("UICorner", shadow).CornerRadius = UDim.new(0, math.floor(size * .2))

        -- Profundidad (negro más oscuro)
        local depth = Instance.new("Frame", group)
        depth.Size = UDim2.fromOffset(size, size)
        depth.Position = UDim2.fromOffset(8, 8)
        depth.BackgroundColor3 = COLORS.accentBlackDark
        depth.BackgroundTransparency = .15
        depth.BorderSizePixel = 0
        Instance.new("UICorner", depth).CornerRadius = UDim.new(0, math.floor(size * .2))

        -- Cara del dado (negro mate)
        local face = Instance.new("Frame", group)
        face.Size = UDim2.fromOffset(size, size)
        face.Position = UDim2.fromOffset(7, 5)
        face.BackgroundColor3 = COLORS.dieFace
        face.BorderSizePixel = 0
        face.ZIndex = 22
        Instance.new("UICorner", face).CornerRadius = UDim.new(0, math.floor(size * .2))

        -- Borde negro sutil
        local stroke = Instance.new("UIStroke", face)
        stroke.Color = COLORS.accentBlack
        stroke.Thickness = 1.5
        stroke.Transparency = .3

        -- Gradiente de la cara (efecto mate profundo)
        local grad = Instance.new("UIGradient", face)
        grad.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(18, 18, 22)),
            ColorSequenceKeypoint.new(.5, Color3.fromRGB(10, 10, 13)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(8, 8, 10))
        })
        grad.Rotation = 35

        -- Puntos negros con brillo sutil
        for _, point in ipairs(layouts[value]) do
            local pip = Instance.new("Frame", face)
            pip.AnchorPoint = Vector2.new(.5, .5)
            pip.Position = UDim2.fromScale(point[1], point[2])
            pip.Size = UDim2.fromOffset(math.max(7, math.floor(size * .13)), math.max(7, math.floor(size * .13)))
            pip.BackgroundColor3 = COLORS.accentBlackLight
            pip.BorderSizePixel = 0
            pip.ZIndex = 24
            Instance.new("UICorner", pip).CornerRadius = UDim.new(1, 0)
            
            -- Sutil borde en los puntos
            local pipGlow = Instance.new("UIStroke", pip)
            pipGlow.Color = COLORS.whiteDim
            pipGlow.Transparency = .85
            pipGlow.Thickness = 0.5
        end

        -- Brillo superior muy sutil
        local shine = Instance.new("Frame", face)
        shine.Size = UDim2.new(0, math.max(4, math.floor(size * .25)), 0, math.max(2, math.floor(size * .08)))
        shine.Position = UDim2.new(0, math.floor(size * .05), 0, math.floor(size * .08))
        shine.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        shine.BackgroundTransparency = .85
        shine.BorderSizePixel = 0
        shine.ZIndex = 23
        shine.Rotation = -25
        Instance.new("UICorner", shine).CornerRadius = UDim.new(1, 0)

        -- Escala del dado
        local scale = Instance.new("UIScale", group)
        return group, scale, grad
    end

    -- Definir la trayectoria de los dados (8 dados alrededor)
    local dice = {}
    local routes = {
        {44, UDim2.new(-.1, 0, .24, 0), UDim2.new(.27, 0, .33, 0), 1, 900, .00},
        {54, UDim2.new(-.12, 0, .65, 0), UDim2.new(.31, 0, .62, 0), 4, 1080, .08},
        {38, UDim2.new(.22, 0, -.12, 0), UDim2.new(.40, 0, .27, 0), 2, -900, .16},
        {46, UDim2.new(.38, 0, 1.12, 0), UDim2.new(.42, 0, .72, 0), 5, 1080, .12},
        {44, UDim2.new(1.1, 0, .25, 0), UDim2.new(.73, 0, .34, 0), 3, -900, .00},
        {54, UDim2.new(1.12, 0, .68, 0), UDim2.new(.69, 0, .63, 0), 6, -1080, .08},
        {38, UDim2.new(.78, 0, -.12, 0), UDim2.new(.60, 0, .27, 0), 4, 900, .16},
        {46, UDim2.new(.64, 0, 1.12, 0), UDim2.new(.58, 0, .72, 0), 2, -1080, .12},
    }

    -- Crear y animar cada dado
    for _, route in ipairs(routes) do
        local die, scale, grad = makeIntroDie(route[1], route[2], route[4])
        scale.Scale = .35
        die.GroupTransparency = .18
        table.insert(dice, {die, scale, grad, route[3], route[5], route[2]})

        task.delay(route[6], function()
            TweenService:Create(die, TweenInfo.new(.78, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                Position = route[3],
                Rotation = route[5],
                GroupTransparency = 0
            }):Play()
            
            TweenService:Create(scale, TweenInfo.new(.7, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                Scale = 1
            }):Play()
            
            TweenService:Create(grad, TweenInfo.new(.78), {
                Rotation = route[5] > 0 and 395 or -325,
                Offset = Vector2.new(route[5] > 0 and .28 or -.28, 0)
            }):Play()
        end)
    end

    -- Efecto de agitación de los dados
    task.wait(.88)
    for i, item in ipairs(dice) do
        local drift = i % 2 == 0 and 32 or -32
        TweenService:Create(item[1], TweenInfo.new(.48, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            Rotation = item[1].Rotation + drift
        }):Play()
    end

    -- Retirada de los dados
    waitForIntroSecond(4.4)
    for _, item in ipairs(dice) do
        local direction = item[5] > 0 and 1 or -1
        local retreat = item[4]:Lerp(item[6], .42)
        
        TweenService:Create(item[1], TweenInfo.new(.46, Enum.EasingStyle.Quint, Enum.EasingDirection.InOut), {
            Position = retreat,
            Rotation = item[1].Rotation + direction * 360
        }):Play()
        
        TweenService:Create(item[2], TweenInfo.new(.46, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            Scale = .82
        }):Play()
        
        TweenService:Create(item[3], TweenInfo.new(.46), {
            Offset = Vector2.new(-direction * .2, 0),
            Rotation = direction * 210
        }):Play()
    end

    -- Reunión de los dados
    waitForIntroSecond(5.0)
    for _, item in ipairs(dice) do
        local direction = item[5] > 0 and 1 or -1
        
        TweenService:Create(item[1], TweenInfo.new(.58, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Position = item[4],
            Rotation = item[1].Rotation + direction * 720
        }):Play()
        
        TweenService:Create(item[2], TweenInfo.new(.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Scale = 1
        }):Play()
        
        TweenService:Create(item[3], TweenInfo.new(.58), {
            Offset = Vector2.new(direction * .3, 0),
            Rotation = direction * 395
        }):Play()
    end

    -- Dado central (negro con detalles blancos sutiles)
    local center, centerScale, centerGrad = makeIntroDie(98, UDim2.new(.5, 0, 1.18, 0), 6)
    centerScale.Scale = .56
    center.GroupTransparency = .08
    center.ZIndex = 40

    TweenService:Create(center, TweenInfo.new(.82, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out), {
        Position = UDim2.new(.5, 0, .5, 0),
        Rotation = 1440,
        GroupTransparency = 0
    }):Play()
    
    TweenService:Create(centerScale, TweenInfo.new(.66, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Scale = 1
    }):Play()
    
    TweenService:Create(centerGrad, TweenInfo.new(.82), {
        Rotation = 430,
        Offset = Vector2.new(.42, 0)
    }):Play()

    -- Efecto de impacto (blanco sutil)
    task.wait(.76)
    local impact = Instance.new("Frame", stage)
    impact.AnchorPoint = Vector2.new(.5, .5)
    impact.Position = UDim2.fromScale(.5, .5)
    impact.Size = UDim2.fromOffset(80, 80)
    impact.BackgroundTransparency = 1
    impact.ZIndex = 15
    Instance.new("UICorner", impact).CornerRadius = UDim.new(1, 0)
    
    local impactStroke = Instance.new("UIStroke", impact)
    impactStroke.Color = COLORS.whiteDim
    impactStroke.Thickness = 3
    impactStroke.Transparency = .1

    TweenService:Create(impact, TweenInfo.new(.52, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
        Size = UDim2.fromOffset(310, 310)
    }):Play()
    
    TweenService:Create(impactStroke, TweenInfo.new(.52), {
        Transparency = 1,
        Thickness = 1
    }):Play()

    -- Partículas blancas del impacto
    for i = 1, 12 do
        local spark = Instance.new("Frame", stage)
        spark.AnchorPoint = Vector2.new(.5, .5)
        spark.Position = UDim2.fromScale(.5, .5)
        spark.Size = UDim2.fromOffset(i % 3 == 0 and 6 or 3, i % 3 == 0 and 18 or 12)
        spark.BackgroundColor3 = i % 2 == 0 and COLORS.whiteDim or COLORS.white
        spark.BorderSizePixel = 0
        spark.ZIndex = 16
        spark.Rotation = i * 30
        Instance.new("UICorner", spark).CornerRadius = UDim.new(1, 0)
        
        local angle = math.rad(i * 30)
        local radius = 115 + (i % 3) * 18
        
        TweenService:Create(spark, TweenInfo.new(.48, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
            Position = UDim2.new(.5, math.cos(angle) * radius, .5, math.sin(angle) * radius),
            BackgroundTransparency = 1,
            Rotation = i * 30 + 90
        }):Play()
    end

    -- Efecto de rebote del dado central
    TweenService:Create(centerScale, TweenInfo.new(.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Scale = .88
    }):Play()
    task.wait(.12)
    TweenService:Create(centerScale, TweenInfo.new(.24, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Scale = 1
    }):Play()

    -- Desaparición de los dados periféricos
    task.wait(.55)
    for _, item in ipairs(dice) do
        TweenService:Create(item[1], TweenInfo.new(.38, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
            Position = UDim2.fromScale(.5, .5),
            Rotation = item[1].Rotation + 180,
            GroupTransparency = 1
        }):Play()
        
        TweenService:Create(item[2], TweenInfo.new(.38), {
            Scale = .3
        }):Play()
    end

    -- Desaparición del dado central
    TweenService:Create(center, TweenInfo.new(.34, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
        Position = UDim2.new(.5, 0, .45, 0),
        Rotation = 1530,
        GroupTransparency = 1
    }):Play()
    
    TweenService:Create(centerScale, TweenInfo.new(.34), {
        Scale = .55
    }):Play()

    -- ============================================
    -- TEXTO "FORCE HUB" en MAYÚSCULAS
    -- ============================================
    task.wait(.25)
    
    -- Texto principal (cambiado a "FORCE HUB")
    local title = Instance.new("TextLabel", stage)
    title.AnchorPoint = Vector2.new(.5, .5)
    title.Position = UDim2.new(.5, 0, .62, 0)
    title.Size = UDim2.new(0, 400, 0, 90)
    title.BackgroundTransparency = 1
    title.RichText = true
    title.Text = 'FORCE HUB'   -- <--- AHORA EN MAYÚSCULAS
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.TextSize = 52
    title.Font = Enum.Font.GothamBlack
    title.TextTransparency = 1
    title.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    title.TextStrokeTransparency = .2
    title.ZIndex = 30

    -- Gradiente blanco sutil para el título
    local titleGrad = Instance.new("UIGradient", title)
    titleGrad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(200, 200, 200)),
        ColorSequenceKeypoint.new(0.3, Color3.fromRGB(255, 255, 255)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 255)),
        ColorSequenceKeypoint.new(0.7, Color3.fromRGB(255, 255, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(200, 200, 200))
    })
    titleGrad.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0.1),
        NumberSequenceKeypoint.new(0.5, 0),
        NumberSequenceKeypoint.new(1, 0.1)
    })

    TweenService:Create(title, TweenInfo.new(.52, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Position = UDim2.new(.5, 0, .5, 0),
        TextTransparency = 0,
        TextStrokeTransparency = .1
    }):Play()

    -- Línea subrayado blanca
    local underline = Instance.new("Frame", stage)
    underline.AnchorPoint = Vector2.new(.5, .5)
    underline.Position = UDim2.new(.5, 0, .555, 0)
    underline.Size = UDim2.fromOffset(0, 2)
    underline.BackgroundColor3 = COLORS.whiteDim
    underline.BorderSizePixel = 0
    underline.ZIndex = 30
    Instance.new("UICorner", underline).CornerRadius = UDim.new(1, 0)

    -- Brillo sutil en la línea
    local underlineGlow = Instance.new("UIGradient", underline)
    underlineGlow.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(180, 180, 180)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(180, 180, 180))
    })

    TweenService:Create(underline, TweenInfo.new(.55, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
        Size = UDim2.fromOffset(220, 2)
    }):Play()

    -- ============================================
    -- SUBTÍTULO "BY YERKLY" (se mantiene)
    -- ============================================
    local subtitle = Instance.new("TextLabel", stage)
    subtitle.AnchorPoint = Vector2.new(.5, .5)
    subtitle.Position = UDim2.new(.5, 0, .58, 0)
    subtitle.Size = UDim2.new(0, 200, 0, 25)
    subtitle.BackgroundTransparency = 1
    subtitle.Text = "✦ BY YERKLY ✦"
    subtitle.TextColor3 = COLORS.whiteDim
    subtitle.TextSize = 11
    subtitle.Font = Enum.Font.GothamBold
    subtitle.TextTransparency = 1
    subtitle.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    subtitle.TextStrokeTransparency = .5
    subtitle.ZIndex = 31

    -- Gradiente sutil para el subtítulo
    local subGrad = Instance.new("UIGradient", subtitle)
    subGrad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(180, 180, 180)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(180, 180, 180))
    })

    TweenService:Create(subtitle, TweenInfo.new(.45, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
        Position = UDim2.new(.5, 0, .565, 0),
        TextTransparency = 0
    }):Play()

    -- ============================================
    -- DESVANECIDO FINAL
    -- ============================================
    task.wait(2.0)
    
    -- Desvanecer el subtítulo primero
    TweenService:Create(subtitle, TweenInfo.new(.3, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
        TextTransparency = 1
    }):Play()
    
    -- Luego el título
    task.wait(.15)
    TweenService:Create(title, TweenInfo.new(.38, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
        Position = UDim2.new(.5, 0, .42, 0),
        TextTransparency = 1,
        TextStrokeTransparency = 1
    }):Play()
    
    TweenService:Create(underline, TweenInfo.new(.3, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
        Size = UDim2.fromOffset(0, 2),
        BackgroundTransparency = 1
    }):Play()

    -- Destruir la GUI de la intro
    task.wait(.4)
    pcall(function() introGui:Destroy() end)
end)