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
frame.Position = UDim2.new(1, -10, 0, 45)

frame.BackgroundTransparency = 1
frame.Parent = screenGui

-- Tamaño de los botones
local botonSize = 65

-- Botones bastante pegados
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

		-- Columna 1 y 2 arriba, alineadas con la fila 1
		if columna == 1 or columna == 2 then
			yInicial = 0
		else
			-- Columnas 3 y 4 centradas verticalmente
			local altura = cantidad * botonSize + (cantidad - 1) * separacionY
			yInicial = (260 - altura) / 2
		end

		boton.Position = UDim2.new(
			0,
			(columna - 1) * (botonSize + separacionX),
			0,
			yInicial + (fila - 1) * (botonSize + separacionY)
		)

		-- Sin texto
		boton.Text = ""

		-- Negro oscuro
		boton.BackgroundColor3 = Color3.fromRGB(10, 10, 10)

		boton.BorderSizePixel = 0

		-- Esquinas redondeadas
		local corner = Instance.new("UICorner")
		corner.CornerRadius = UDim.new(0, 15)
		corner.Parent = boton

		boton.Parent = frame
	end
end