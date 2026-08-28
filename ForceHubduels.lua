-- LocalScript

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "BotonesUI"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
screenGui.Parent = playerGui

-- Contenedor principal (derecha)
local frame = Instance.new("Frame")
frame.Name = "Botones"
frame.Size = UDim2.new(0, 276, 0, 260)
frame.AnchorPoint = Vector2.new(1, 0)
frame.Position = UDim2.new(1, -10, 0, 25)
frame.BackgroundTransparency = 1
frame.Parent = screenGui

-- Tamaño de los botones
local botonSize = 65
local separacionX = 4
local separacionY = 4

-- Distribución: 1 / 2 / 4 / 4
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

        -- Textos
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

-- ========================
-- FUNCIONALIDAD DEL BOTÓN RESET (Boton_1_1)
-- ========================
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

-- ========================
-- FUNCIONALIDAD DEL BOTÓN TP DOWN (Boton_3_3)
-- ========================
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

        local direction = Vector3.new(0, -500, 0)
        local result = workspace:Raycast(startPos, direction, raycastParams)

        if result then
            local hitPoint = result.Position
            rootPart.CFrame = CFrame.new(hitPoint + Vector3.new(0, 3, 0))
        end
    end)
end

-- ========================
-- BOTÓN "force hub" (arrastrable, izquierda)
-- ========================
local forceButton = Instance.new("TextButton")
forceButton.Name = "ForceHub"
forceButton.Size = UDim2.new(0, 120, 0, 60)
forceButton.Position = UDim2.new(0, 10, 0, 100)
forceButton.Text = "force hub"
forceButton.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
forceButton.TextColor3 = Color3.fromRGB(200, 200, 200)
forceButton.Font = Enum.Font.GothamBold
forceButton.TextSize = 20
forceButton.BorderSizePixel = 0

local cornerBtn = Instance.new("UICorner")
cornerBtn.CornerRadius = UDim.new(0, 10)
cornerBtn.Parent = forceButton

forceButton.Parent = screenGui

-- Arrastre force hub
local draggingForce = false
local dragStartForce = nil
local startPosForce = nil

forceButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        draggingForce = true
        dragStartForce = input.Position
        startPosForce = forceButton.Position
    end
end)

forceButton.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        draggingForce = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if draggingForce and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStartForce
        forceButton.Position = UDim2.new(
            0, startPosForce.X.Offset + delta.X,
            0, startPosForce.Y.Offset + delta.Y
        )
    end
end)

-- ================================================================
-- NUEVO BOTÓN NUMÉRICO (pequeño, centro-abajo, arrastrable, inicia en 0)
-- ================================================================
local numButton = Instance.new("TextButton")
numButton.Name = "NumButton"
numButton.Size = UDim2.new(0, 55, 0, 55)          -- Tamaño pequeño
numButton.Position = UDim2.new(0.5, 0, 0.9, 0)    -- Centro inferior
numButton.AnchorPoint = Vector2.new(0.5, 0.5)     -- Anclado al centro
numButton.Text = "0"                              -- Número inicial
numButton.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
numButton.TextColor3 = Color3.fromRGB(200, 200, 200)
numButton.Font = Enum.Font.GothamBold
numButton.TextSize = 28                           -- Texto grande para que se vea bien
numButton.BorderSizePixel = 0

local cornerNum = Instance.new("UICorner")
cornerNum.CornerRadius = UDim.new(0, 12)          -- Bordes redondeados
cornerNum.Parent = numButton

numButton.Parent = screenGui

-- Arrastre del botón numérico (con el dedo o mouse)
local draggingNum = false
local dragStartNum = nil
local startPosNum = nil

numButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        draggingNum = true
        dragStartNum = input.Position
        startPosNum = numButton.Position
    end
end)

numButton.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        draggingNum = false
    end
end)

-- Escuchamos el movimiento global (para arrastrar)
UserInputService.InputChanged:Connect(function(input)
    if draggingNum and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStartNum
        numButton.Position = UDim2.new(
            0, startPosNum.X.Offset + delta.X,
            0, startPosNum.Y.Offset + delta.Y
        )
    end
end)