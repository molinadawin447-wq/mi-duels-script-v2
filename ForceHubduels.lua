repeat task.wait() until game:IsLoaded()

-- ===================== FORCE HUB - STARTUP SPLASH =====================
do
	local Players = game:GetService("Players")
	local LP2 = Players.LocalPlayer
	local TweenService2 = game:GetService("TweenService")
	local SoundService2 = game:GetService("SoundService")

	local splashGui = Instance.new("ScreenGui")
	splashGui.Name = "ForceHubSplash"
	splashGui.ResetOnSpawn = false
	splashGui.DisplayOrder = 999
	splashGui.IgnoreGuiInset = true
	if not pcall(function() splashGui.Parent = game:GetService("CoreGui") end) then
		splashGui.Parent = LP2:WaitForChild("PlayerGui")
	end

	local overlay = Instance.new("Frame", splashGui)
	overlay.Size = UDim2.new(1,0,1,0)
	overlay.BackgroundColor3 = Color3.fromRGB(0,0,0)
	overlay.BackgroundTransparency = 0
	overlay.BorderSizePixel = 0
	overlay.ZIndex = 1

	local tapHint = Instance.new("TextLabel", splashGui)
	tapHint.Size = UDim2.new(1, 0, 0, 20)
	tapHint.Position = UDim2.new(0, 0, 1, -36)
	tapHint.BackgroundTransparency = 1
	tapHint.Text = "tap anywhere to skip"
	tapHint.TextColor3 = Color3.fromRGB(80, 110, 160)
	tapHint.Font = Enum.Font.Gotham
	tapHint.TextSize = 11
	tapHint.ZIndex = 10
	tapHint.TextXAlignment = Enum.TextXAlignment.Center

	local skipZone = Instance.new("TextButton", splashGui)
	skipZone.Size = UDim2.new(1,0,1,0)
	skipZone.BackgroundTransparency = 1
	skipZone.Text = ""
	skipZone.ZIndex = 9

	local container = Instance.new("Frame", splashGui)
	container.Size = UDim2.new(0,320,0,120)
	container.Position = UDim2.new(0.5,-160,0,-140)
	container.BackgroundTransparency = 1
	container.BorderSizePixel = 0
	container.ZIndex = 2
	container.ClipsDescendants = false

	local titleSplash = Instance.new("TextLabel", container)
	titleSplash.Size = UDim2.new(1,0,0,70)
	titleSplash.Position = UDim2.new(0,0,0,0)
	titleSplash.BackgroundTransparency = 1
	titleSplash.Text = "FORCE HUB"
	titleSplash.TextColor3 = Color3.fromRGB(255,255,255)
	titleSplash.Font = Enum.Font.GothamBlack
	titleSplash.TextSize = 48
	titleSplash.TextTransparency = 0
	titleSplash.ZIndex = 3
	do
		local g = Instance.new("UIGradient", titleSplash)
		g.Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(80,160,255)),
			ColorSequenceKeypoint.new(0.5, Color3.fromRGB(200,225,255)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(100,80,255))
		})
	end

	local subSplash = Instance.new("TextLabel", container)
	subSplash.Size = UDim2.new(1,0,0,24)
	subSplash.Position = UDim2.new(0,0,0,72)
	subSplash.BackgroundTransparency = 1
	subSplash.Text = "Auto Steal & More"
	subSplash.TextColor3 = Color3.fromRGB(100,140,200)
	subSplash.Font = Enum.Font.Gotham
	subSplash.TextSize = 13
	subSplash.TextTransparency = 0
	subSplash.ZIndex = 3

	-- Fragmentos para el efecto shatter (ahora forman "FORCE HUB")
	local fragments = {}
	local fragTexts = {"F","OR","CE"," H","U","B"}
	local fragColors = {
		Color3.fromRGB(80,160,255),
		Color3.fromRGB(140,100,255),
		Color3.fromRGB(200,225,255),
		Color3.fromRGB(100,80,255),
		Color3.fromRGB(80,180,255),
		Color3.fromRGB(160,120,255),
	}
	for i, txt in ipairs(fragTexts) do
		local frag = Instance.new("TextLabel", splashGui)
		frag.Size = UDim2.new(0,90,0,60)
		frag.AnchorPoint = Vector2.new(0.5,0.5)
		-- Centrado ajustado para 6 fragmentos
		frag.Position = UDim2.new(0.5, (i-3.5)*52, 0.5, -30)
		frag.BackgroundTransparency = 1
		frag.Text = txt
		frag.TextColor3 = fragColors[i]
		frag.Font = Enum.Font.GothamBlack
		frag.TextSize = 44
		frag.TextTransparency = 1
		frag.ZIndex = 5
		frag.Rotation = 0
		table.insert(fragments, frag)
	end

	local function playSound(id, pitch, vol, parent, delay)
		task.delay(delay or 0, function()
			local s = Instance.new("Sound")
			s.SoundId = id
			s.PlaybackSpeed = pitch
			s.Volume = vol
			s.Parent = parent
			s.RollOffMaxDistance = 0
			s:Play()
			game:GetService("Debris"):AddItem(s, 3)
		end)
	end

	local function playGlitchImpact()
		playSound("rbxassetid://1588058260", 1.0, 0.9, SoundService2, 0)
		playSound("rbxassetid://8627516764", 0.8, 0.7, SoundService2, 0.02)
		playSound("rbxassetid://1588058260", 1.4, 0.5, SoundService2, 0.05)
		playSound("rbxassetid://8627516764", 1.2, 0.4, SoundService2, 0.1)
	end

	local function playWhistle()
		local WHISTLE_ID = "rbxassetid://4612414100"
		playSound(WHISTLE_ID, 2.2, 0.7, SoundService2, 0)
		playSound(WHISTLE_ID, 1.7, 0.8, SoundService2, 0.07)
		playSound(WHISTLE_ID, 1.2, 0.9, SoundService2, 0.15)
		playSound(WHISTLE_ID, 0.85, 0.9, SoundService2, 0.24)
		playSound(WHISTLE_ID, 0.55, 0.7, SoundService2, 0.34)
		playSound(WHISTLE_ID, 0.3, 1.0, SoundService2, 0.5)
	end

	local function doShatterEffect()
		pcall(playGlitchImpact)
		local flash = Instance.new("Frame", splashGui)
		flash.Size = UDim2.new(1,0,1,0)
		flash.BackgroundColor3 = Color3.fromRGB(255,255,255)
		flash.BackgroundTransparency = 0.3
		flash.BorderSizePixel = 0
		flash.ZIndex = 8
		TweenService2:Create(flash, TweenInfo.new(0.18), {BackgroundTransparency=1}):Play()
		game:GetService("Debris"):AddItem(flash, 0.3)
		titleSplash.TextTransparency = 1
		local RunService2 = game:GetService("RunService")
		for i, frag in ipairs(fragments) do
			frag.TextTransparency = 0
			local dirX = (i - 3.5) * 60 + math.random(-80, 80)
			local dirY = math.random(120, 280)
			local rot = math.random(-180, 180)
			local startPosX = frag.Position.X.Offset
			local startPosY = frag.Position.Y.Offset
			local t = 0
			local conn
			conn = RunService2.RenderStepped:Connect(function(dt)
				t = t + dt
				if t > 0.8 then frag.TextTransparency = 1; conn:Disconnect(); return end
				local alpha = t / 0.8
				local px = startPosX + dirX * alpha
				local py = startPosY - dirY * alpha + 300 * alpha * alpha
				local fade = math.clamp(alpha * 1.4 - 0.3, 0, 1)
				frag.Position = UDim2.new(0.5, px, 0.5, py - 30)
				frag.Rotation = rot * alpha
				frag.TextTransparency = fade
				frag.TextSize = math.clamp(44 - alpha * 20, 10, 44)
			end)
		end
		for li = 1, 8 do
			task.delay(li * 0.025, function()
				local line = Instance.new("Frame", splashGui)
				line.Size = UDim2.new(1, 0, 0, math.random(2,6))
				line.Position = UDim2.new(0, 0, math.random(), 0)
				line.BackgroundColor3 = Color3.fromRGB(math.random(60,255), math.random(0,100), math.random(150,255))
				line.BackgroundTransparency = math.random() * 0.3
				line.BorderSizePixel = 0
				line.ZIndex = 7
				TweenService2:Create(line, TweenInfo.new(0.12), {BackgroundTransparency=1}):Play()
				game:GetService("Debris"):AddItem(line, 0.2)
			end)
		end
	end

	local splashDone = false
	local function finishSplash()
		if splashDone then return end
		splashDone = true
		TweenService2:Create(subSplash, TweenInfo.new(0.3), {TextTransparency=1}):Play()
		TweenService2:Create(overlay, TweenInfo.new(0.4), {BackgroundTransparency=1}):Play()
		tapHint.Visible = false
	end

	skipZone.MouseButton1Click:Connect(function()
		titleSplash.TextTransparency = 1
		subSplash.TextTransparency = 1
		finishSplash()
	end)

	task.spawn(function()
		TweenService2:Create(overlay, TweenInfo.new(0.2), {BackgroundTransparency=0.1}):Play()
		task.wait(0.15)
		pcall(playWhistle)
		TweenService2:Create(container, TweenInfo.new(0.45, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out),
			{Position=UDim2.new(0.5,-160,0.5,-60)}):Play()
		task.wait(0.5)
		doShatterEffect()
		task.wait(0.85)
		finishSplash()
		task.wait(0.45)
		if splashGui and splashGui.Parent then splashGui:Destroy() end
	end)

	local _t0 = tick()
	while not splashDone and (tick() - _t0) < 3.0 do
		task.wait(0.05)
	end
end

-- ============================================================
-- SCRIPT ORIGINAL (botones, robo automático, anti‑muerte)
-- ============================================================
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

-- ============================================================
-- RESET (mata y reaparece)  <--- NUEVA FUNCIÓN
-- ============================================================
local resetButton = frame:FindFirstChild("Boton_1_1")
if resetButton then
    local isResetting = false
    resetButton.MouseButton1Click:Connect(function()
        if isResetting then return end
        isResetting = true

        -- 1. Matar al personaje actual
        local char = player.Character
        if char then
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum then
                hum.Health = 0
            end
            -- Opcional: romper articulaciones para muerte instantánea
            -- char:BreakJoints()
        end

        -- 2. Esperar un instante para que se vea la muerte
        task.wait(0.2)

        -- 3. Forzar reaparición (respawn)
        player:LoadCharacter()

        -- Feedback visual del botón (se pone gris y vuelve a negro)
        resetButton.BackgroundColor3 = Color3.fromRGB(128, 128, 128)
        task.wait(1)
        resetButton.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
        isResetting = false
    end)
end

-- ============================================================
-- TP DOWN
-- ============================================================
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