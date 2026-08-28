-- LocalScript

local Players = game:GetService("Players")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "BotonesUI"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
screenGui.Parent = playerGui

-- Contenedor
local frame = Instance.new("Frame")
frame.Name = "Botones"
frame.Size = UDim2.new(0, 276, 0, 260)

-- DERECHA y MÁS ARRIBA
frame.AnchorPoint = Vector2.new(1, 0)
frame.Position = UDim2.new(1, -10, 0, 25)

frame.BackgroundTransparency = 1
frame.Parent = screenGui

-- Tamaño de los botones
local botonSize = 65

-- Separación
local separacionX = 4
local separacionY = 4

-- Distribución: 1 / 2 / 4 / 4
local columnas = {
	1,
	2,
	4,
	4
}

for columna = 1, 4 do

	local cantidad = columnas[columna]

	for fila = 1, cantidad do

		local boton = Instance.new("TextButton")
		boton.Name = "Boton_" .. columna .. "_" .. fila

		boton.Size = UDim2.new(0, botonSize, 0, botonSize)

		local yInicial

		-- Columnas 1 y 2 arriba
		if columna == 1 or columna == 2 then
			yInicial = 0
		else
			-- Columnas 3 y 4 centradas
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

		-- Estilo del texto
		boton.TextColor3 = Color3.fromRGB(200, 200, 200)
		boton.TextSize = 17
		boton.Font = Enum.Font.GothamBold
		boton.TextScaled = false
		boton.TextWrapped = true

		-- Fondo negro
		boton.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
		boton.BorderSizePixel = 0

		-- Esquinas redondeadas
		local corner = Instance.new("UICorner")
		corner.CornerRadius = UDim.new(0, 15)
		corner.Parent = boton

		boton.Parent = frame
	end
end