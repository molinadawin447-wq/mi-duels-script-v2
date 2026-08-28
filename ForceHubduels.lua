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

        -- === NUEVOS AJUSTES DE TEXTO ===
        boton.TextColor3 = Color3.fromRGB(200, 200, 200)
        boton.TextSize = 15                     -- un poco más pequeño
        boton.Font = Enum.Font.Gotham           -- más delgado (sin negrita)
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

        -- Reiniciar al personaje
        player:LoadCharacter()

        -- Efecto visual: gris durante 1 segundo
        resetButton.BackgroundColor3 = Color3.fromRGB(128, 128, 128)
        wait(1)
        resetButton.BackgroundColor3 = Color3.fromRGB(10, 10, 10)

        isResetting = false
    end)
end

-- ========================
-- NUEVO BOTÓN "force hub" (arrastrable) - CON ESTILO IGUAL A LOS DEMÁS
-- ========================
local forceButton = Instance.new("TextButton")
forceButton.Name = "ForceHub"
forceButton.Size = UDim2.new(0, 120, 0, 60)
forceButton.Position = UDim2.new(0, 10, 0, 100)  -- lado izquierdo
forceButton.Text = "force hub"

-- Mismo fondo y color de texto que los botones de la derecha
forceButton.BackgroundColor3 = Color3.fromRGB(10, 10, 10)   -- fondo negro
forceButton.TextColor3 = Color3.fromRGB(200, 200, 200)      -- texto gris
forceButton.Font = Enum.Font.GothamBold
forceButton.TextSize = 20
forceButton.BorderSizePixel = 0

local cornerBtn = Instance.new("UICorner")
cornerBtn.CornerRadius = UDim.new(0, 10)
cornerBtn.Parent = forceButton

forceButton.Parent = screenGui

-- Variables para el arrastre
local dragging = false
local dragStart = nil
local startPos = nil

forceButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = forceButton.Position
    end
end)

forceButton.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        forceButton.Position = UDim2.new(
            0, startPos.X.Offset + delta.X,
            0, startPos.Y.Offset + delta.Y
        )
    end
end)