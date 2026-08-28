-- LocalScript

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "BotonesUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

local frame = Instance.new("Frame")
frame.Name = "Botones"
frame.Size = UDim2.new(0, 260, 0, 250)
frame.Position = UDim2.new(0.5, -130, 0.5, -125)
frame.BackgroundTransparency = 1
frame.Parent = screenGui

-- Tamaño parecido al de la imagen
local botonSize = 60

-- Muy poca separación
local separacionX = 4
local separacionY = 4

-- Distribución:
-- 1 / 2 / 4 / 4
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

		-- Tamaño cuadrado
		boton.Size = UDim2.new(0, botonSize, 0, botonSize)

		-- Centrado vertical de cada columna
		local altura = cantidad * botonSize + (cantidad - 1) * separacionY
		local yInicial = (250 - altura) / 2

		boton.Position = UDim2.new(
			0,
			(columna - 1) * (botonSize + separacionX),
			0,
			yInicial + (fila - 1) * (botonSize + separacionY)
		)

		-- SIN LETRAS
		boton.Text = ""

		-- Negro oscuro
		boton.BackgroundColor3 = Color3.fromRGB(10, 10, 10)

		-- Sin borde
		boton.BorderSizePixel = 0

		-- Esquinas redondeadas
		local corner = Instance.new("UICorner")
		corner.CornerRadius = UDim.new(0, 15)
		corner.Parent = boton

		boton.Parent = frame
	end
end