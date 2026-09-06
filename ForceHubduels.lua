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
container.AnchorPoint = Vector2.new(1, 0)
container.Position = UDim2.new(1, -5, 0, 10)
container.Size = UDim2.fromOffset(300, 300)
container.Parent = screenGui

local buttonSize = 63
local gap = 7

local function createButton(name, column, row, text)
	local button = Instance.new("ImageButton")

	button.Name = name
	button.Size = UDim2.fromOffset(buttonSize, buttonSize)

	local x = (column - 1) * (buttonSize + gap)
	local y = (row - 1) * (buttonSize + gap)

	button.Position = UDim2.fromOffset(x, y)

	button.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	button.BorderSizePixel = 0
	button.Image = getcustomasset("Telaraña.jpg")
	button.ScaleType = Enum.ScaleType.Crop
	button.AutoButtonColor = false

	button.Parent = container

	-- Texto
	local label = Instance.new("TextLabel")
	label.Name = "ButtonText"
	label.Size = UDim2.new(1, -6, 1, -6)
	label.Position = UDim2.fromOffset(3, 3)
	label.BackgroundTransparency = 1
	label.Text = text
	label.TextColor3 = Color3.fromRGB(255, 255, 255)
	label.TextScaled = true
	label.Font = Enum.Font.GothamBold
	label.TextWrapped = true
	label.TextXAlignment = Enum.TextXAlignment.Center
	label.TextYAlignment = Enum.TextYAlignment.Center
	label.Parent = button

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 20)
	corner.Parent = button
end

--// COLUMNA 1
createButton("Button1", 1, 1, "TP\nBAT")

--// COLUMNA 2
createButton("Button2", 2, 1, "INSTA\nRESET")
createButton("Button3", 2, 2, "BYPASS\nANTIBAT")

--// COLUMNA 3
createButton("Button4", 3, 1, "AUTO\nRIGHT")
createButton("Button5", 3, 2, "BAT\nAIMBOT")
createButton("Button6", 3, 3, "TP\nDOWN")
createButton("Button7", 3, 4, "LAGGER 1")

--// COLUMNA 4
createButton("Button8", 4, 1, "AUTO\nLEFT")
createButton("Button9", 4, 2, "DROP BR")
createButton("Button10", 4, 3, "CARRY SPD")
createButton("Button11", 4, 4, "LAGGER 2")