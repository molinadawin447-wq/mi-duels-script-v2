--// 11 BOTONES - ARRIBA A LA DERECHA
--// LocalScript

local Players = game:GetService("Players")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ButtonsUI"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
screenGui.Parent = playerGui

local container = Instance.new("Frame")
container.Name = "ButtonContainer"
container.BackgroundTransparency = 1

-- Posición: arriba a la derecha
container.AnchorPoint = Vector2.new(1, 0)
container.Position = UDim2.new(1, -25, 0, 18)

container.Size = UDim2.fromOffset(300, 300)
container.Parent = screenGui

-- Botones un poquito más grandes
local buttonSize = 65
local gap = 7

local function createButton(name, column, row)
	local button = Instance.new("TextButton")

	button.Name = name
	button.Size = UDim2.fromOffset(buttonSize, buttonSize)

	local x = (column - 1) * (buttonSize + gap)
	local y = (row - 1) * (buttonSize + gap)

	button.Position = UDim2.fromOffset(x, y)

	button.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	button.BorderSizePixel = 0
	button.Text = ""
	button.AutoButtonColor = false

	button.Parent = container

	-- Redondeado
	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 20)
	corner.Parent = button
end

-- COLUMNA 1
createButton("Button1", 1, 1)

-- COLUMNA 2
createButton("Button2", 2, 1)
createButton("Button3", 2, 2)

-- COLUMNA 3
createButton("Button4", 3, 1)
createButton("Button5", 3, 2)
createButton("Button6", 3, 3)
createButton("Button7", 3, 4)

-- COLUMNA 4
createButton("Button8", 4, 1)
createButton("Button9", 4, 2)
createButton("Button10", 4, 3)
createButton("Button11", 4, 4)