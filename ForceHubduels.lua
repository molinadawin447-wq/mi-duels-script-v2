repeat task.wait() until game:IsLoaded()

-- ===================== FORCE HUB - STARTUP SPLASH =====================
local HUB_NAME = "FORCE HUB"
local SUBTITLE = "AUTO STEAL & MORE"

local ACCENT = Color3.fromRGB(132, 58, 255)
local ACCENT_2 = Color3.fromRGB(218, 160, 255)
local BACKGROUND = Color3.fromRGB(4, 3, 9)

local INTRO_TIME = 5.2
local TAP_TO_SKIP = true

local ReplicatedFirst = game:GetService("ReplicatedFirst")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

ReplicatedFirst:RemoveDefaultLoadingScreen()

local player = Players.LocalPlayer or Players.PlayerAdded:Wait()
local playerGui = player:WaitForChild("PlayerGui")

local old = playerGui:FindFirstChild("ComplexHubIntro")
if old then old:Destroy() end

local finished = false
local closing = false
local renderConnection
local random = Random.new()

local function round(object, radius)
	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, radius)
	corner.Parent = object
	return corner
end

local function outline(object, color, thickness, transparency)
	local stroke = Instance.new("UIStroke")
	stroke.Color = color
	stroke.Thickness = thickness
	stroke.Transparency = transparency or 0
	stroke.Parent = object
	return stroke
end

local function addScale(object, value)
	local scale = Instance.new("UIScale")
	scale.Scale = value
	scale.Parent = object
	return scale
end

local function play(object, duration, goal, style, direction)
	if finished or not object or not object.Parent then return end
	local tween = TweenService:Create(
		object,
		TweenInfo.new(duration, style or Enum.EasingStyle.Quint, direction or Enum.EasingDirection.Out),
		goal
	)
	tween:Play()
	return tween
end

local function waitTime(seconds)
	local started = os.clock()
	while not finished and os.clock() - started < seconds do
		RunService.Heartbeat:Wait()
	end
	return not finished
end

local gui = Instance.new("ScreenGui")
gui.Name = "ComplexHubIntro"
gui.IgnoreGuiInset = true
gui.ResetOnSpawn = false
gui.DisplayOrder = 100000
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = playerGui

local root = Instance.new("Frame")
root.Size = UDim2.fromScale(1, 1)
root.BackgroundColor3 = BACKGROUND
root.BorderSizePixel = 0
root.ClipsDescendants = true
root.Parent = gui

local backgroundGradient = Instance.new("UIGradient")
backgroundGradient.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(2, 2, 6)),
	ColorSequenceKeypoint.new(0.45, Color3.fromRGB(17, 7, 31)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(2, 2, 6)),
})
backgroundGradient.Rotation = 20
backgroundGradient.Parent = root

local camera = workspace.CurrentCamera
while not camera or camera.ViewportSize.X < 20 do
	RunService.RenderStepped:Wait()
	camera = workspace.CurrentCamera
end

local view = camera.ViewportSize
local shortest = math.min(view.X, view.Y)
local uiScaleValue = math.clamp(shortest / 720, 0.72, 1.12)

local scene = Instance.new("Frame")
scene.Size = UDim2.fromScale(1, 1)
scene.BackgroundTransparency = 1
scene.Parent = root

local topPanel = Instance.new("Frame")
topPanel.Size = UDim2.fromScale(1, 0.5)
topPanel.BackgroundColor3 = Color3.fromRGB(3, 3, 8)
topPanel.BorderSizePixel = 0
topPanel.ZIndex = 500
topPanel.Parent = root

local bottomPanel = Instance.new("Frame")
bottomPanel.AnchorPoint = Vector2.new(0, 1)
bottomPanel.Position = UDim2.fromScale(0, 1)
bottomPanel.Size = UDim2.fromScale(1, 0.5)
bottomPanel.BackgroundColor3 = Color3.fromRGB(3, 3, 8)
bottomPanel.BorderSizePixel = 0
bottomPanel.ZIndex = 500
bottomPanel.Parent = root

local topEdge = Instance.new("Frame")
topEdge.AnchorPoint = Vector2.new(0, 1)
topEdge.Position = UDim2.fromScale(0, 1)
topEdge.Size = UDim2.new(1, 0, 0, 2)
topEdge.BackgroundColor3 = ACCENT
topEdge.BackgroundTransparency = 0.15
topEdge.BorderSizePixel = 0
topEdge.Parent = topPanel

local bottomEdge = topEdge:Clone()
bottomEdge.AnchorPoint = Vector2.new(0, 0)
bottomEdge.Position = UDim2.fromScale(0, 0)
bottomEdge.Parent = bottomPanel

local grid = Instance.new("Frame")
grid.Size = UDim2.fromScale(1, 1)
grid.BackgroundTransparency = 1
grid.ZIndex = 1
grid.Parent = scene

for i = 0, 18 do
	local vertical = Instance.new("Frame")
	vertical.Size = UDim2.new(0, 1, 1, 0)
	vertical.Position = UDim2.fromScale(i / 18, 0)
	vertical.BackgroundColor3 = ACCENT
	vertical.BackgroundTransparency = 0.93
	vertical.BorderSizePixel = 0
	vertical.Parent = grid
end

for i = 0, 10 do
	local horizontal = Instance.new("Frame")
	horizontal.Size = UDim2.new(1, 0, 0, 1)
	horizontal.Position = UDim2.fromScale(0, i / 10)
	horizontal.BackgroundColor3 = ACCENT
	horizontal.BackgroundTransparency = 0.94
	horizontal.BorderSizePixel = 0
	horizontal.Parent = grid
end

local particles = {}
for i = 1, 42 do
	local particle = Instance.new("Frame")
	local size = random:NextInteger(2, 5)
	particle.AnchorPoint = Vector2.new(0.5, 0.5)
	particle.Position = UDim2.fromScale(
		random:NextNumber(0.03, 0.97),
		random:NextNumber(0.03, 0.97)
	)
	particle.Size = UDim2.fromOffset(size, size)
	particle.BackgroundColor3 = i % 5 == 0 and Color3.fromRGB(245, 240, 255) or ACCENT_2
	particle.BackgroundTransparency = random:NextNumber(0.45, 0.85)
	particle.BorderSizePixel = 0
	particle.ZIndex = 2
	particle.Parent = scene
	round(particle, 999)
	particles[i] = {
		object = particle,
		speed = random:NextNumber(0.008, 0.024),
		offset = random:NextNumber(0, math.pi * 2),
	}
end

local center = Instance.new("Frame")
center.AnchorPoint = Vector2.new(0.5, 0.5)
center.Position = UDim2.fromScale(0.5, 0.47)
center.Size = UDim2.fromOffset(430, 430)
center.BackgroundTransparency = 1
center.ZIndex = 20
center.Parent = scene

local centerScale = addScale(center, uiScaleValue * 0.72)

local glow = Instance.new("Frame")
glow.AnchorPoint = Vector2.new(0.5, 0.5)
glow.Position = UDim2.fromScale(0.5, 0.5)
glow.Size = UDim2.fromOffset(210, 210)
glow.BackgroundColor3 = ACCENT
glow.BackgroundTransparency = 0.9
glow.BorderSizePixel = 0
glow.ZIndex = 10
glow.Parent = center
round(glow, 999)

local ring1 = Instance.new("Frame")
ring1.AnchorPoint = Vector2.new(0.5, 0.5)
ring1.Position = UDim2.fromScale(0.5, 0.5)
ring1.Size = UDim2.fromOffset(176, 176)
ring1.BackgroundTransparency = 1
ring1.Rotation = 0
ring1.ZIndex = 22
ring1.Parent = center
round(ring1, 999)
local ring1Stroke = outline(ring1, ACCENT_2, 3, 1)

local ring2 = Instance.new("Frame")
ring2.AnchorPoint = Vector2.new(0.5, 0.5)
ring2.Position = UDim2.fromScale(0.5, 0.5)
ring2.Size = UDim2.fromOffset(126, 126)
ring2.BackgroundTransparency = 1
ring2.Rotation = 0
ring2.ZIndex = 23
ring2.Parent = center
round(ring2, 999)
local ring2Stroke = outline(ring2, ACCENT, 2, 1)

local ring3 = Instance.new("Frame")
ring3.AnchorPoint = Vector2.new(0.5, 0.5)
ring3.Position = UDim2.fromScale(0.5, 0.5)
ring3.Size = UDim2.fromOffset(78, 78)
ring3.BackgroundColor3 = Color3.fromRGB(18, 8, 34)
ring3.BackgroundTransparency = 1
ring3.BorderSizePixel = 0
ring3.ZIndex = 24
ring3.Parent = center
round(ring3, 999)
local ring3Stroke = outline(ring3, ACCENT_2, 2, 1)

local core = Instance.new("Frame")
core.AnchorPoint = Vector2.new(0.5, 0.5)
core.Position = UDim2.fromScale(0.5, 0.5)
core.Size = UDim2.fromOffset(18, 18)
core.BackgroundColor3 = Color3.fromRGB(250, 247, 255)
core.BackgroundTransparency = 1
core.BorderSizePixel = 0
core.ZIndex = 25
core.Parent = center
round(core, 999)

local coreGlow = Instance.new("Frame")
coreGlow.AnchorPoint = Vector2.new(0.5, 0.5)
coreGlow.Position = UDim2.fromScale(0.5, 0.5)
coreGlow.Size = UDim2.fromOffset(52, 52)
coreGlow.BackgroundColor3 = ACCENT
coreGlow.BackgroundTransparency = 1
coreGlow.BorderSizePixel = 0
coreGlow.ZIndex = 21
coreGlow.Parent = center
round(coreGlow, 999)

local orbitDots = {}
for i = 1, 8 do
	local dot = Instance.new("Frame")
	dot.AnchorPoint = Vector2.new(0.5, 0.5)
	dot.Size = UDim2.fromOffset(i % 3 == 0 and 6 or 4, i % 3 == 0 and 6 or 4)
	dot.BackgroundColor3 = i % 2 == 0 and ACCENT_2 or Color3.fromRGB(250, 247, 255)
	dot.BackgroundTransparency = 1
	dot.BorderSizePixel = 0
	dot.ZIndex = 26
	dot.Parent = center
	round(dot, 999)
	orbitDots[i] = dot
end

local scan = Instance.new("Frame")
scan.AnchorPoint = Vector2.new(0.5, 0.5)
scan.Position = UDim2.fromScale(0.5, 0)
scan.Size = UDim2.new(1, 0, 0, 90)
scan.BackgroundTransparency = 1
scan.BorderSizePixel = 0
scan.ZIndex = 8
scan.Parent = scene

local scanGradient = Instance.new("UIGradient")
scanGradient.Transparency = NumberSequence.new({
	NumberSequenceKeypoint.new(0, 1),
	NumberSequenceKeypoint.new(0.5, 0.82),
	NumberSequenceKeypoint.new(1, 1),
})
scanGradient.Color = ColorSequence.new(ACCENT)
scanGradient.Rotation = 90
scanGradient.Parent = scan

local titleHolder = Instance.new("Frame")
titleHolder.AnchorPoint = Vector2.new(0.5, 0.5)
titleHolder.Position = UDim2.fromScale(0.5, 0.69)
titleHolder.Size = UDim2.fromOffset(820, 120)
titleHolder.BackgroundTransparency = 1
titleHolder.ZIndex = 50
titleHolder.Parent = scene

local titleScale = addScale(titleHolder, uiScaleValue)

local title = Instance.new("TextLabel")
title.Size = UDim2.fromScale(1, 0.58)
title.BackgroundTransparency = 1
title.Text = ""
title.TextColor3 = Color3.fromRGB(248, 246, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 43
title.TextTransparency = 0
title.TextXAlignment = Enum.TextXAlignment.Center
title.TextYAlignment = Enum.TextYAlignment.Center
title.ZIndex = 51
title.Parent = titleHolder

local titleStroke = outline(title, ACCENT, 1, 0.68)

local subtitle = Instance.new("TextLabel")
subtitle.AnchorPoint = Vector2.new(0.5, 0)
subtitle.Position = UDim2.fromScale(0.5, 0.62)
subtitle.Size = UDim2.fromScale(1, 0.25)
subtitle.BackgroundTransparency = 1
subtitle.Text = SUBTITLE
subtitle.TextColor3 = Color3.fromRGB(169, 150, 196)
subtitle.Font = Enum.Font.GothamMedium
subtitle.TextSize = 12
subtitle.TextTransparency = 1
subtitle.TextXAlignment = Enum.TextXAlignment.Center
subtitle.ZIndex = 51
subtitle.Parent = titleHolder

local progressBack = Instance.new("Frame")
progressBack.AnchorPoint = Vector2.new(0.5, 0.5)
progressBack.Position = UDim2.fromScale(0.5, 0.84)
progressBack.Size = UDim2.fromOffset(360, 7)
progressBack.BackgroundColor3 = Color3.fromRGB(37, 29, 49)
progressBack.BackgroundTransparency = 1
progressBack.BorderSizePixel = 0
progressBack.ClipsDescendants = true
progressBack.ZIndex = 52
progressBack.Parent = scene
round(progressBack, 999)

local progressFill = Instance.new("Frame")
progressFill.Size = UDim2.fromScale(0, 1)
progressFill.BackgroundColor3 = ACCENT
progressFill.BorderSizePixel = 0
progressFill.ZIndex = 53
progressFill.Parent = progressBack
round(progressFill, 999)

local progressGradient = Instance.new("UIGradient")
progressGradient.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, ACCENT),
	ColorSequenceKeypoint.new(0.62, ACCENT_2),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)),
})
progressGradient.Parent = progressFill

local percent = Instance.new("TextLabel")
percent.AnchorPoint = Vector2.new(0.5, 0.5)
percent.Position = UDim2.fromScale(0.5, 0.89)
percent.Size = UDim2.fromOffset(100, 24)
percent.BackgroundTransparency = 1
percent.Text = "0%"
percent.TextColor3 = Color3.fromRGB(158, 139, 184)
percent.TextTransparency = 1
percent.Font = Enum.Font.GothamMedium
percent.TextSize = 11
percent.ZIndex = 52
percent.Parent = scene

local status = Instance.new("TextLabel")
status.AnchorPoint = Vector2.new(0.5, 0.5)
status.Position = UDim2.fromScale(0.5, 0.93)
status.Size = UDim2.fromOffset(300, 22)
status.BackgroundTransparency = 1
status.Text = "Preparing interface"
status.TextColor3 = Color3.fromRGB(132, 116, 154)
status.TextTransparency = 1
status.Font = Enum.Font.GothamMedium
status.TextSize = 10
status.ZIndex = 52
status.Parent = scene

local skipButton = Instance.new("TextButton")
skipButton.Size = UDim2.fromScale(1, 1)
skipButton.BackgroundTransparency = 1
skipButton.Text = ""
skipButton.AutoButtonColor = false
skipButton.ZIndex = 1000
skipButton.Parent = root

local skipText = Instance.new("TextLabel")
skipText.AnchorPoint = Vector2.new(0.5, 1)
skipText.Position = UDim2.new(0.5, 0, 1, -22)
skipText.Size = UDim2.fromOffset(180, 22)
skipText.BackgroundTransparency = 1
skipText.Text = "tap to skip"
skipText.TextColor3 = Color3.fromRGB(145, 132, 163)
skipText.TextTransparency = TAP_TO_SKIP and 0.28 or 1
skipText.Font = Enum.Font.GothamMedium
skipText.TextSize = 11
skipText.ZIndex = 1001
skipText.Parent = root

local flash = Instance.new("Frame")
flash.Size = UDim2.fromScale(1, 1)
flash.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
flash.BackgroundTransparency = 1
flash.BorderSizePixel = 0
flash.ZIndex = 900
flash.Parent = root

local function closeIntro()
	if closing then return end
	closing = true
	finished = true
	if renderConnection then renderConnection:Disconnect() end

	TweenService:Create(
		flash,
		TweenInfo.new(0.07, Enum.EasingStyle.Linear),
		{BackgroundTransparency = 0.12}
	):Play()

	task.wait(0.07)

	TweenService:Create(
		topPanel,
		TweenInfo.new(0.65, Enum.EasingStyle.Quint, Enum.EasingDirection.InOut),
		{Position = UDim2.fromScale(0, -0.5)}
	):Play()

	TweenService:Create(
		bottomPanel,
		TweenInfo.new(0.65, Enum.EasingStyle.Quint, Enum.EasingDirection.InOut),
		{Position = UDim2.fromScale(0, 1.5)}
	):Play()

	TweenService:Create(
		flash,
		TweenInfo.new(0.3, Enum.EasingStyle.Quad),
		{BackgroundTransparency = 1}
	):Play()

	TweenService:Create(
		root,
		TweenInfo.new(0.65, Enum.EasingStyle.Quad),
		{BackgroundTransparency = 1}
	):Play()

	task.wait(0.68)
	player:SetAttribute("HubIntroFinished", true)
	gui:Destroy()
end

if TAP_TO_SKIP then
	skipButton.Activated:Connect(closeIntro)
else
	skipButton.Active = false
end

renderConnection = RunService.RenderStepped:Connect(function(dt)
	if finished then return end
	ring1.Rotation += 24 * dt
	ring2.Rotation -= 38 * dt
	backgroundGradient.Rotation += 2 * dt
	progressGradient.Rotation += 22 * dt

	local time = os.clock()
	glow.Size = UDim2.fromOffset(
		210 + math.sin(time * 2.5) * 16,
		210 + math.sin(time * 2.5) * 16
	)
	coreGlow.Size = UDim2.fromOffset(
		52 + math.sin(time * 4.8) * 7,
		52 + math.sin(time * 4.8) * 7
	)

	for i, dot in ipairs(orbitDots) do
		local radius = i % 2 == 0 and 88 or 62
		local speed = i % 2 == 0 and 0.62 or -0.86
		local angle = time * speed + (math.pi * 2 / #orbitDots) * i
		dot.Position = UDim2.fromOffset(
			215 + math.cos(angle) * radius,
			215 + math.sin(angle) * radius
		)
	end

	for i, particleData in ipairs(particles) do
		local particle = particleData.object
		local x = particle.Position.X.Scale
		local y = particle.Position.Y.Scale - particleData.speed * dt
		if y < -0.03 then
			y = 1.03
			x = random:NextNumber(0.03, 0.97)
		end
		particle.Position = UDim2.fromScale(
			x + math.sin(time + particleData.offset) * 0.00015,
			y
		)
	end
end)

task.spawn(function()
	play(
		topPanel,
		0.7,
		{Position = UDim2.fromScale(0, -0.5)},
		Enum.EasingStyle.Quint,
		Enum.EasingDirection.InOut
	)
	play(
		bottomPanel,
		0.7,
		{Position = UDim2.fromScale(0, 1.5)},
		Enum.EasingStyle.Quint,
		Enum.EasingDirection.InOut
	)

	if not waitTime(0.38) then return end

	play(centerScale, 0.75, {Scale = uiScaleValue}, Enum.EasingStyle.Back)
	play(ring1Stroke, 0.45, {Transparency = 0.15})
	play(ring2Stroke, 0.52, {Transparency = 0.22})
	play(ring3, 0.4, {BackgroundTransparency = 0.08})
	play(ring3Stroke, 0.45, {Transparency = 0.08})
	play(core, 0.38, {BackgroundTransparency = 0})
	play(coreGlow, 0.38, {BackgroundTransparency = 0.78})

	for i, dot in ipairs(orbitDots) do
		task.delay(i * 0.045, function()
			play(dot, 0.24, {BackgroundTransparency = 0.05})
		end)
	end

	play(
		scan,
		1.1,
		{Position = UDim2.fromScale(0.5, 1)},
		Enum.EasingStyle.Linear
	)

	if not waitTime(0.52) then return end

	for i = 1, #HUB_NAME do
		if finished then return end
		title.Text = string.sub(HUB_NAME, 1, i)
		if string.sub(HUB_NAME, i, i) ~= " " then
			play(core, 0.07, {Size = UDim2.fromOffset(23, 23)})
			task.delay(0.07, function()
				play(core, 0.1, {Size = UDim2.fromOffset(18, 18)})
			end)
		end
		task.wait(0.035)
	end

	play(subtitle, 0.32, {TextTransparency = 0})
	play(progressBack, 0.3, {BackgroundTransparency = 0.12})
	play(percent, 0.3, {TextTransparency = 0})
	play(status, 0.3, {TextTransparency = 0})

	if not waitTime(0.28) then return end

	local loadStart = os.clock()
	local loadDuration = math.max(1.3, INTRO_TIME - 2.4)

	play(
		progressFill,
		loadDuration,
		{Size = UDim2.fromScale(1, 1)},
		Enum.EasingStyle.Quart,
		Enum.EasingDirection.InOut
	)

	while not finished do
		local progress = math.clamp((os.clock() - loadStart) / loadDuration, 0, 1)
		local value = math.floor(progress * 100)
		percent.Text = value .. "%"
		if value < 30 then
			status.Text = "Preparing interface"
		elseif value < 65 then
			status.Text = "Loading modules"
		elseif value < 92 then
			status.Text = "Finalizing"
		else
			status.Text = "Ready"
		end
		if progress >= 1 then break end
		RunService.RenderStepped:Wait()
	end

	if finished then return end

	percent.Text = "100%"
	status.Text = "Ready"

	play(flash, 0.06, {BackgroundTransparency = 0.12}, Enum.EasingStyle.Linear)
	play(centerScale, 0.15, {Scale = uiScaleValue * 1.12})
	play(titleScale, 0.15, {Scale = uiScaleValue * 1.04})

	if not waitTime(0.07) then return end

	play(flash, 0.25, {BackgroundTransparency = 1}, Enum.EasingStyle.Quad)
	play(centerScale, 0.22, {Scale = uiScaleValue})
	play(titleScale, 0.22, {Scale = uiScaleValue})

	if not waitTime(0.25) then return end

	topPanel.Position = UDim2.fromScale(0, -0.5)
	bottomPanel.Position = UDim2.fromScale(0, 1.5)

	play(topPanel, 0.48, {Position = UDim2.fromScale(0, 0)})
	play(bottomPanel, 0.48, {Position = UDim2.fromScale(0, 1)})

	if not waitTime(0.45) then return end

	closeIntro()
end)

-- ============================================================
-- SCRIPT PRINCIPAL (botones, robo automático, anti‑muerte)
-- ============================================================
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TS = game:GetService("TweenService")
local Stats = game:GetService("Stats")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- ============================================================
-- FUNCIÓN AUXILIAR PARA IDENTIFICAR PARCELA PROPIA
-- ============================================================
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

-- ============================================================
-- VARIABLES PARA LOS CAMPOS DEL PANEL
-- ============================================================
local speedNormalInput = nil
local carrySpdInput = nil

-- Función para aplicar velocidad normal (desde el campo "Speed Normal")
local function applyNormalSpeed()
    local char = player.Character
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum then return end
    if speedNormalInput then
        local val = tonumber(speedNormalInput.Text)
        if val and val > 0 and val <= 100 then
            hum.WalkSpeed = val
        end
    end
end

-- Función para aplicar velocidad de carry (desde el campo "Carry SPD")
local function applyCarrySpeed()
    local char = player.Character
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum then return end
    if carrySpdInput then
        local val = tonumber(carrySpdInput.Text)
        if val and val > 0 and val <= 100 then
            hum.WalkSpeed = val
        end
    end
end

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
-- BOTÓN "FORCE HUB" IZQUIERDA + PANEL DE CONFIGURACIÓN (MÁS ANCHO Y ALTO)
-- ============================================================
do
    local configScreen = Instance.new("ScreenGui")
    configScreen.Name = "ForceHubConfig"
    configScreen.ResetOnSpawn = false
    configScreen.IgnoreGuiInset = true
    configScreen.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    configScreen.Parent = playerGui

    -- Botón toggle (izquierda, arriba)
    local toggleBtn = Instance.new("TextButton")
    toggleBtn.Name = "ToggleButton"
    toggleBtn.Size = UDim2.new(0, 130, 0, 40)
    toggleBtn.Position = UDim2.new(0, 10, 0, 60)
    toggleBtn.AnchorPoint = Vector2.new(0, 0)
    toggleBtn.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
    toggleBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
    toggleBtn.Text = "FORCE HUB"
    toggleBtn.Font = Enum.Font.GothamBold
    toggleBtn.TextSize = 16
    toggleBtn.TextWrapped = true
    toggleBtn.BorderSizePixel = 0
    toggleBtn.AutoButtonColor = false
    toggleBtn.ZIndex = 2
    toggleBtn.Parent = configScreen
    local cornerBtn = Instance.new("UICorner")
    cornerBtn.CornerRadius = UDim.new(0, 15)
    cornerBtn.Parent = toggleBtn

    -- Panel más grande: 320x340
    local configPanel = Instance.new("Frame")
    configPanel.Name = "ConfigPanel"
    configPanel.Size = UDim2.new(0, 320, 0, 340)
    configPanel.Position = UDim2.new(0, 10, 0.5, 0)
    configPanel.AnchorPoint = Vector2.new(0, 0.5)
    configPanel.BackgroundColor3 = Color3.fromRGB(10, 10, 10)  -- Negro oscuro
    configPanel.BackgroundTransparency = 0.05
    configPanel.BorderSizePixel = 0
    configPanel.Visible = false
    configPanel.ZIndex = 10
    configPanel.ClipsDescendants = true
    configPanel.Parent = configScreen
    local cornerPanel = Instance.new("UICorner")
    cornerPanel.CornerRadius = UDim.new(0, 15)
    cornerPanel.Parent = configPanel

    -- Borde gris
    local panelStroke = Instance.new("UIStroke")
    panelStroke.Color = Color3.fromRGB(200, 200, 200)
    panelStroke.Thickness = 1.5
    panelStroke.Transparency = 0.3
    panelStroke.Parent = configPanel

    -- Título "FORCE HUB"
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, -40, 0, 35)
    titleLabel.Position = UDim2.new(0, 15, 0, 5)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = "FORCE HUB"
    titleLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextSize = 18
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.ZIndex = 11
    titleLabel.Parent = configPanel

    -- Botón cerrar 'X' más pegado
    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 35, 0, 35)
    closeBtn.Position = UDim2.new(1, -8, 0, 3)
    closeBtn.AnchorPoint = Vector2.new(1, 0)
    closeBtn.BackgroundTransparency = 1
    closeBtn.Text = "✕"
    closeBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.TextSize = 20
    closeBtn.BorderSizePixel = 0
    closeBtn.ZIndex = 12
    closeBtn.Parent = configPanel

    -- ============ PESTAÑAS ============
    local tabsFrame = Instance.new("Frame")
    tabsFrame.Size = UDim2.new(1, -20, 0, 35)
    tabsFrame.Position = UDim2.new(0, 10, 0, 42)
    tabsFrame.BackgroundTransparency = 1
    tabsFrame.ZIndex = 13
    tabsFrame.Parent = configPanel

    local tabSpeed = Instance.new("TextButton")
    tabSpeed.Size = UDim2.new(0, 110, 1, 0)
    tabSpeed.Position = UDim2.new(0, 0, 0, 0)
    tabSpeed.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
    tabSpeed.TextColor3 = Color3.fromRGB(200, 200, 200)
    tabSpeed.Text = "SPEED"
    tabSpeed.Font = Enum.Font.GothamBold
    tabSpeed.TextSize = 14
    tabSpeed.BorderSizePixel = 0
    tabSpeed.AutoButtonColor = false
    tabSpeed.ZIndex = 14
    tabSpeed.Parent = tabsFrame
    local cornerSpeed = Instance.new("UICorner")
    cornerSpeed.CornerRadius = UDim.new(0, 8)
    cornerSpeed.Parent = tabSpeed

    local tabCombat = Instance.new("TextButton")
    tabCombat.Size = UDim2.new(0, 110, 1, 0)
    tabCombat.Position = UDim2.new(1, -110, 0, 0)
    tabCombat.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
    tabCombat.TextColor3 = Color3.fromRGB(200, 200, 200)
    tabCombat.Text = "COMBAT"
    tabCombat.Font = Enum.Font.GothamBold
    tabCombat.TextSize = 14
    tabCombat.BorderSizePixel = 0
    tabCombat.AutoButtonColor = false
    tabCombat.ZIndex = 14
    tabCombat.Parent = tabsFrame
    local cornerCombat = Instance.new("UICorner")
    cornerCombat.CornerRadius = UDim.new(0, 8)
    cornerCombat.Parent = tabCombat

    -- Contenedores de contenido
    local contentSpeed = Instance.new("Frame")
    contentSpeed.Size = UDim2.new(1, -20, 1, -85)
    contentSpeed.Position = UDim2.new(0, 10, 0, 80)
    contentSpeed.BackgroundTransparency = 1
    contentSpeed.Visible = true
    contentSpeed.ZIndex = 15
    contentSpeed.Parent = configPanel

    local contentCombat = Instance.new("Frame")
    contentCombat.Size = UDim2.new(1, -20, 1, -85)
    contentCombat.Position = UDim2.new(0, 10, 0, 80)
    contentCombat.BackgroundTransparency = 1
    contentCombat.Visible = false
    contentCombat.ZIndex = 15
    contentCombat.Parent = configPanel

    -- ===== CONTENIDO DE SPEED =====
    -- Etiqueta "Speed Normal"
    local lblSpeedNormal = Instance.new("TextLabel")
    lblSpeedNormal.Size = UDim2.new(0, 120, 0, 30)
    lblSpeedNormal.Position = UDim2.new(0, 0, 0, 0)
    lblSpeedNormal.BackgroundTransparency = 1
    lblSpeedNormal.Text = "Speed Normal"
    lblSpeedNormal.TextColor3 = Color3.fromRGB(200, 200, 200)
    lblSpeedNormal.Font = Enum.Font.Gotham
    lblSpeedNormal.TextSize = 14
    lblSpeedNormal.TextXAlignment = Enum.TextXAlignment.Left
    lblSpeedNormal.ZIndex = 16
    lblSpeedNormal.Parent = contentSpeed

    -- TextBox para velocidad normal (inicial 60)
    speedNormalInput = Instance.new("TextBox")
    speedNormalInput.Size = UDim2.new(0, 80, 0, 30)
    speedNormalInput.Position = UDim2.new(1, -80, 0, 0)
    speedNormalInput.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    speedNormalInput.TextColor3 = Color3.fromRGB(200, 200, 200)
    speedNormalInput.Font = Enum.Font.Gotham
    speedNormalInput.TextSize = 14
    speedNormalInput.Text = "60"
    speedNormalInput.PlaceholderText = "1-100"
    speedNormalInput.ClearTextOnFocus = false
    speedNormalInput.ZIndex = 16
    speedNormalInput.Parent = contentSpeed
    local cornerNormal = Instance.new("UICorner")
    cornerNormal.CornerRadius = UDim.new(0, 6)
    cornerNormal.Parent = speedNormalInput

    -- Etiqueta "Carry SPD"
    local lblCarrySpd = Instance.new("TextLabel")
    lblCarrySpd.Size = UDim2.new(0, 120, 0, 30)
    lblCarrySpd.Position = UDim2.new(0, 0, 0, 40)
    lblCarrySpd.BackgroundTransparency = 1
    lblCarrySpd.Text = "Carry SPD"
    lblCarrySpd.TextColor3 = Color3.fromRGB(200, 200, 200)
    lblCarrySpd.Font = Enum.Font.Gotham
    lblCarrySpd.TextSize = 14
    lblCarrySpd.TextXAlignment = Enum.TextXAlignment.Left
    lblCarrySpd.ZIndex = 16
    lblCarrySpd.Parent = contentSpeed

    -- TextBox para Carry SPD (inicial 30)
    carrySpdInput = Instance.new("TextBox")
    carrySpdInput.Size = UDim2.new(0, 80, 0, 30)
    carrySpdInput.Position = UDim2.new(1, -80, 0, 40)
    carrySpdInput.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    carrySpdInput.TextColor3 = Color3.fromRGB(200, 200, 200)
    carrySpdInput.Font = Enum.Font.Gotham
    carrySpdInput.TextSize = 14
    carrySpdInput.Text = "30"
    carrySpdInput.PlaceholderText = "1-100"
    carrySpdInput.ClearTextOnFocus = false
    carrySpdInput.ZIndex = 16
    carrySpdInput.Parent = contentSpeed
    local cornerCarry = Instance.new("UICorner")
    cornerCarry.CornerRadius = UDim.new(0, 6)
    cornerCarry.Parent = carrySpdInput

    -- ===== CONTENIDO DE COMBAT =====
    local lblCombatPlaceholder = Instance.new("TextLabel")
    lblCombatPlaceholder.Size = UDim2.new(1, 0, 1, 0)
    lblCombatPlaceholder.BackgroundTransparency = 1
    lblCombatPlaceholder.Text = "Opciones de combate\n(próximamente)"
    lblCombatPlaceholder.TextColor3 = Color3.fromRGB(150, 150, 150)
    lblCombatPlaceholder.Font = Enum.Font.Gotham
    lblCombatPlaceholder.TextSize = 14
    lblCombatPlaceholder.TextYAlignment = Enum.TextYAlignment.Top
    lblCombatPlaceholder.ZIndex = 16
    lblCombatPlaceholder.Parent = contentCombat

    -- ============ FUNCIONALIDAD DE PESTAÑAS ============
    local function selectTab(selected)
        tabSpeed.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
        tabCombat.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
        contentSpeed.Visible = false
        contentCombat.Visible = false

        if selected == "speed" then
            tabSpeed.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
            contentSpeed.Visible = true
        elseif selected == "combat" then
            tabCombat.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
            contentCombat.Visible = true
        end
    end

    tabSpeed.MouseButton1Click:Connect(function()
        selectTab("speed")
    end)

    tabCombat.MouseButton1Click:Connect(function()
        selectTab("combat")
    end)

    selectTab("speed")

    -- ============ FUNCIONALIDAD DE CIERRE ============
    toggleBtn.MouseButton1Click:Connect(function()
        configPanel.Visible = not configPanel.Visible
    end)

    closeBtn.MouseButton1Click:Connect(function()
        configPanel.Visible = false
    end)
end

-- ============================================================
-- FUNCIONALIDAD DEL BOTÓN CARRY SPD (Boton_4_3)
-- ============================================================
local carryButton = frame:FindFirstChild("Boton_4_3")
if carryButton then
    carryButton.MouseButton1Click:Connect(function()
        applyCarrySpeed()
    end)
end

-- ============================================================
-- APLICAR VELOCIDAD NORMAL AL INICIO Y AL REAPARECER
-- ============================================================
local function onCharacterAdded(char)
    -- Esperar a que el Humanoid esté listo
    local hum = char:WaitForChild("Humanoid", 5)
    if hum then
        -- Aplicar velocidad normal si el campo existe
        if speedNormalInput then
            local val = tonumber(speedNormalInput.Text)
            if val and val > 0 and val <= 100 then
                hum.WalkSpeed = val
            end
        end
    end
end

-- Conectar al evento de personaje añadido
if player.Character then
    onCharacterAdded(player.Character)
end
player.CharacterAdded:Connect(onCharacterAdded)

-- ============================================================
-- RESET (mata y reaparece)
-- ============================================================
local resetButton = frame:FindFirstChild("Boton_1_1")
if resetButton then
    local isResetting = false
    resetButton.MouseButton1Click:Connect(function()
        if isResetting then return end
        isResetting = true
        resetButton.BackgroundColor3 = Color3.fromRGB(128, 128, 128)

        local char = player.Character
        if char then
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum then
                hum.Health = 0
                task.wait(math.random(10, 30) / 100)
            else
                pcall(function() char:BreakJoints() end)
                task.wait(0.2)
            end
        end

        local startTime = tick()
        while tick() - startTime < 3 do
            if player.Character and player.Character ~= char then break end
            task.wait(0.1)
        end

        if not player.Character or player.Character == char then
            pcall(function() player:LoadCharacter() end)
            task.wait(0.2)
        end

        task.wait(math.random(10, 20) / 10)
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
-- AUTO LEFT – Ir al cerebro de mi propia base
-- ============================================================
local autoLeftButton = frame:FindFirstChild("Boton_4_1")
if autoLeftButton then
    autoLeftButton.MouseButton1Click:Connect(function()
        local char = player.Character
        if not char then return end
        local rootPart = char:FindFirstChild("HumanoidRootPart")
        if not rootPart then return end

        local plots = workspace:FindFirstChild("Plots")
        if not plots then return end

        local myPlot = nil
        for _, plot in ipairs(plots:GetChildren()) do
            if plot:IsA("Model") and isMyPlotByName(plot.Name) then
                myPlot = plot
                break
            end
        end
        if not myPlot then return end

        local brainPart = nil
        for _, child in ipairs(myPlot:GetDescendants()) do
            if child:IsA("BasePart") and string.find(string.lower(child.Name), "brain") then
                brainPart = child
                break
            end
        end
        if brainPart then
            rootPart.CFrame = CFrame.new(brainPart.Position + Vector3.new(0, 3, 0))
        end
    end)
end

-- ============================================================
-- AUTO RIGHT – Ir al cerebro de la base enemiga
-- ============================================================
local autoRightButton = frame:FindFirstChild("Boton_4_2")
if autoRightButton then
    autoRightButton.MouseButton1Click:Connect(function()
        local char = player.Character
        if not char then return end
        local rootPart = char:FindFirstChild("HumanoidRootPart")
        if not rootPart then return end

        local plots = workspace:FindFirstChild("Plots")
        if not plots then return end

        local enemyPlot = nil
        for _, plot in ipairs(plots:GetChildren()) do
            if plot:IsA("Model") and not isMyPlotByName(plot.Name) then
                enemyPlot = plot
                break
            end
        end
        if not enemyPlot then return end

        local brainPart = nil
        for _, child in ipairs(enemyPlot:GetDescendants()) do
            if child:IsA("BasePart") and string.find(string.lower(child.Name), "brain") then
                brainPart = child
                break
            end
        end
        if brainPart then
            rootPart.CFrame = CFrame.new(brainPart.Position + Vector3.new(0, 3, 0))
        end
    end)
end

-- ============================================================
-- SISTEMA AUTO STEAL
-- ============================================================
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

    local NEGRO = Color3.fromRGB(0, 0, 0)
    local GRIS_OSCURO = Color3.fromRGB(40, 40, 40)
    local GRIS_MEDIO = Color3.fromRGB(100, 100, 100)
    local GRIS_CLARO = Color3.fromRGB(200, 200, 200)

    local spFrame = Instance.new("Frame", spScreenGui)
    spFrame.Name = "StealProgressGui"
    spFrame.Size = UDim2.new(0, 380, 0, 34)
    spFrame.Position = UDim2.new(0.5, 0, 1, -65)
    spFrame.AnchorPoint = Vector2.new(0.5, 1)
    spFrame.BackgroundColor3 = NEGRO
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

    local stealLabel = Instance.new("TextLabel", textFrame)
    stealLabel.Size = UDim2.new(0, 55, 1, 0)
    stealLabel.Position = UDim2.new(0, 6, 0, 0)
    stealLabel.BackgroundTransparency = 1
    stealLabel.Text = "STEAL"
    stealLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    stealLabel.Font = Enum.Font.GothamBold
    stealLabel.TextSize = 11
    stealLabel.TextXAlignment = Enum.TextXAlignment.Left

    pctLabel = Instance.new("TextLabel", textFrame)
    pctLabel.Size = UDim2.new(0, 45, 1, 0)
    pctLabel.Position = UDim2.new(0, 62, 0, 0)
    pctLabel.BackgroundTransparency = 1
    pctLabel.Text = "0%"
    pctLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    pctLabel.Font = Enum.Font.GothamBold
    pctLabel.TextSize = 14
    pctLabel.TextXAlignment = Enum.TextXAlignment.Center

    local barBg = Instance.new("Frame", textFrame)
    barBg.Size = UDim2.new(0, 100, 0, 18)
    barBg.Position = UDim2.new(0, 112, 0.5, -9)
    barBg.BackgroundColor3 = GRIS_OSCURO
    barBg.BorderSizePixel = 0
    barBg.ClipsDescendants = true
    Instance.new("UICorner", barBg).CornerRadius = UDim.new(1, 0)

    local barStroke = Instance.new("UIStroke", barBg)
    barStroke.Color = Color3.fromRGB(255, 255, 255)
    barStroke.Thickness = 1
    barStroke.Transparency = 0.3

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

    separator = Instance.new("Frame", textFrame)
    separator.Size = UDim2.new(0, 1.5, 0, 20)
    separator.Position = UDim2.new(0, 218, 0.5, -10)
    separator.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    separator.BackgroundTransparency = 0.3
    separator.BorderSizePixel = 0

    local antennaLabel = Instance.new("TextLabel", textFrame)
    antennaLabel.Size = UDim2.new(0, 20, 1, 0)
    antennaLabel.Position = UDim2.new(0, 225, 0, 0)
    antennaLabel.BackgroundTransparency = 1
    antennaLabel.Text = "📡"
    antennaLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    antennaLabel.Font = Enum.Font.Gotham
    antennaLabel.TextSize = 16
    antennaLabel.TextXAlignment = Enum.TextXAlignment.Center

    fpsLabel = Instance.new("TextLabel", textFrame)
    fpsLabel.Size = UDim2.new(0, 60, 1, 0)
    fpsLabel.Position = UDim2.new(0, 248, 0, 0)
    fpsLabel.BackgroundTransparency = 1
    fpsLabel.Text = "FPS: 0"
    fpsLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    fpsLabel.Font = Enum.Font.Gotham
    fpsLabel.TextSize = 12
    fpsLabel.TextXAlignment = Enum.TextXAlignment.Left

    pingLabel = Instance.new("TextLabel", textFrame)
    pingLabel.Size = UDim2.new(0, 65, 1, 0)
    pingLabel.Position = UDim2.new(0, 312, 0, 0)
    pingLabel.BackgroundTransparency = 1
    pingLabel.Text = "PING: 0ms"
    pingLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    pingLabel.Font = Enum.Font.Gotham
    pingLabel.TextSize = 12
    pingLabel.TextXAlignment = Enum.TextXAlignment.Right

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
-- ANTI-DIE (inalterado)
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