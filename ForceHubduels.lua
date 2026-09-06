--// 11 BOTONES - ARRIBA A LA DERECHA
--// LocalScript

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

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

local textLabels = {}

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

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 20)
	corner.Parent = button

	--// TEXTO
	local label = Instance.new("TextLabel")
	label.Name = "ButtonText"
	label.Size = UDim2.new(1, -12, 1, -12)
	label.Position = UDim2.fromOffset(6, 6)
	label.BackgroundTransparency = 1

	label.Text = text
	label.TextSize = 13
	label.TextScaled = false

	--// Gris claro
	label.TextColor3 = Color3.fromRGB(210, 210, 210)

	--// Letras gruesas
	label.Font = Enum.Font.GothamBold

	label.TextWrapped = true
	label.TextXAlignment = Enum.TextXAlignment.Center
	label.TextYAlignment = Enum.TextYAlignment.Center

	label.Parent = button

	table.insert(textLabels, label)
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


--// BRILLO DIAGONAL PARA TODAS LAS PALABRAS
for _, label in ipairs(textLabels) do

	local gradient = Instance.new("UIGradient")
	gradient.Name = "DiagonalGlow"

	-- Gris normal + franja brillante
	gradient.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(150, 150, 150)),
		ColorSequenceKeypoint.new(0.42, Color3.fromRGB(150, 150, 150)),
		ColorSequenceKeypoint.new(0.50, Color3.fromRGB(255, 255, 255)),
		ColorSequenceKeypoint.new(0.58, Color3.fromRGB(150, 150, 150)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(150, 150, 150))
	})

	-- La franja va diagonalmente
	gradient.Rotation = 45
	gradient.Offset = Vector2.new(-1.5, -1.5)
	gradient.Parent = label
end

--// MISMO MOVIMIENTO PARA TODAS LAS PALABRAS
task.spawn(function()
	while true do

		-- Desde arriba-izquierda
		for _, label in ipairs(textLabels) do
			local gradient = label:FindFirstChild("DiagonalGlow")

			if gradient then
				gradient.Offset = Vector2.new(-1.5, -1.5)
			end
		end

		-- Hacia abajo-derecha
		local tweens = {}

		for _, label in ipairs(textLabels) do
			local gradient = label:FindFirstChild("DiagonalGlow")

			if gradient then
				local tween = TweenService:Create(
					gradient,
					TweenInfo.new(
						1.8,
						Enum.EasingStyle.Linear,
						Enum.EasingDirection.InOut
					),
					{
						Offset = Vector2.new(1.5, 1.5)
					}
				)

				table.insert(tweens, tween)
				tween:Play()
			end
		end

		task.wait(1.8)
		task.wait(0.25)
	end
end)