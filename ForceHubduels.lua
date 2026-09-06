--// 11 BOTONES - ARRIBA A LA DERECHA
--// + SPIDER HUB - IZQUIERDA
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


--==================================================
--// CONTENEDOR DE LOS BOTONES DE LA DERECHA
--==================================================

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


--==================================================
--// FUNCIÓN PARA CREAR LOS BOTONES
--==================================================

local function createButton(name, column, row, text)

	local button = Instance.new("ImageButton")

	button.Name = name
	button.Size = UDim2.fromOffset(buttonSize, buttonSize)

	local x = (column - 1) * (buttonSize + gap)
	local y = (row - 1) * (buttonSize + gap)

	button.Position = UDim2.fromOffset(x, y)

	button.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	button.BorderSizePixel = 0

	-- Fondo Telaraña
	button.Image = getcustomasset("Telaraña.jpg")
	button.ScaleType = Enum.ScaleType.Crop

	button.AutoButtonColor = false
	button.Parent = container


	-- Esquinas redondeadas
	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 20)
	corner.Parent = button


	-- Texto
	local label = Instance.new("TextLabel")

	label.Name = "ButtonText"

	-- Espacio alrededor de las letras
	label.Size = UDim2.new(1, -12, 1, -12)
	label.Position = UDim2.fromOffset(6, 6)

	label.BackgroundTransparency = 1

	label.Text = text

	-- Mismo tamaño para todas
	label.TextSize = 13
	label.TextScaled = false

	-- Blanco puro
	label.TextColor3 = Color3.fromRGB(255, 255, 255)

	-- Letras gruesas
	label.Font = Enum.Font.GothamBold

	label.TextWrapped = true
	label.TextXAlignment = Enum.TextXAlignment.Center
	label.TextYAlignment = Enum.TextYAlignment.Center

	label.Parent = button

	table.insert(textLabels, label)
end


--==================================================
--// COLUMNA 1
--==================================================

createButton("Button1", 1, 1, "TP\nBAT")


--==================================================
--// COLUMNA 2
--==================================================

createButton("Button2", 2, 1, "INSTA\nRESET")
createButton("Button3", 2, 2, "BYPASS\nANTIBAT")


--==================================================
--// COLUMNA 3
--==================================================

createButton("Button4", 3, 1, "AUTO\nRIGHT")
createButton("Button5", 3, 2, "BAT\nAIMBOT")
createButton("Button6", 3, 3, "TP\nDOWN")
createButton("Button7", 3, 4, "LAGGER 1")


--==================================================
--// COLUMNA 4
--==================================================

createButton("Button8", 4, 1, "AUTO\nLEFT")
createButton("Button9", 4, 2, "DROP BR")
createButton("Button10", 4, 3, "CARRY SPD")
createButton("Button11", 4, 4, "LAGGER 2")


--==================================================
--// SOMBRA OSCURA DIAGONAL
--// PARA TODOS LOS BOTONES
--==================================================

for _, label in ipairs(textLabels) do

	local gradient = Instance.new("UIGradient")

	gradient.Name = "DiagonalShadow"

	gradient.Color = ColorSequence.new({

		ColorSequenceKeypoint.new(
			0.00,
			Color3.fromRGB(255, 255, 255)
		),

		ColorSequenceKeypoint.new(
			0.42,
			Color3.fromRGB(255, 255, 255)
		),

		-- Sombra oscura
		ColorSequenceKeypoint.new(
			0.50,
			Color3.fromRGB(35, 35, 35)
		),

		ColorSequenceKeypoint.new(
			0.58,
			Color3.fromRGB(255, 255, 255)
		),

		ColorSequenceKeypoint.new(
			1.00,
			Color3.fromRGB(255, 255, 255)
		)
	})

	-- Diagonal
	gradient.Rotation = 45

	gradient.Offset = Vector2.new(-1.5, -1.5)

	gradient.Parent = label
end


--==================================================
--// ANIMACIÓN DE LA SOMBRA
--// TODOS LOS BOTONES AL MISMO TIEMPO
--==================================================

task.spawn(function()

	while true do

		-- Empieza arriba a la izquierda
		for _, label in ipairs(textLabels) do

			local gradient = label:FindFirstChild("DiagonalShadow")

			if gradient then
				gradient.Offset = Vector2.new(-1.5, -1.5)
			end

		end


		-- Va hacia abajo a la derecha
		for _, label in ipairs(textLabels) do

			local gradient = label:FindFirstChild("DiagonalShadow")

			if gradient then

				TweenService:Create(
					gradient,

					TweenInfo.new(
						1.8,
						Enum.EasingStyle.Linear,
						Enum.EasingDirection.InOut
					),

					{
						Offset = Vector2.new(1.5, 1.5)
					}

				):Play()

			end

		end


		task.wait(2.05)

	end

end)


--==================================================
--// BOTÓN SPIDER HUB - IZQUIERDA
--==================================================

local spiderButton = Instance.new("ImageButton")

spiderButton.Name = "SpiderHub"

spiderButton.Size = UDim2.fromOffset(115, 115)

-- Un poco más arriba y centrado a la izquierda
spiderButton.AnchorPoint = Vector2.new(0, 0.5)
spiderButton.Position = UDim2.new(0, 15, 0.45, 0)

-- Fondo negro
spiderButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
spiderButton.BackgroundTransparency = 0

spiderButton.BorderSizePixel = 0
spiderButton.Image = ""
spiderButton.AutoButtonColor = false

spiderButton.Parent = screenGui


-- Esquinas redondeadas
local spiderCorner = Instance.new("UICorner")

spiderCorner.CornerRadius = UDim.new(0, 20)
spiderCorner.Parent = spiderButton


--==================================================
--// LOGO DE ARAÑA
--==================================================

local spiderLogo = Instance.new("ImageLabel")

spiderLogo.Name = "SpiderLogo"

spiderLogo.Size = UDim2.fromOffset(45, 45)

spiderLogo.AnchorPoint = Vector2.new(0.5, 0)

spiderLogo.Position = UDim2.new(0.5, 0, 0, 8)

spiderLogo.BackgroundTransparency = 1

-- Archivo del logo
spiderLogo.Image = getcustomasset("Araña.png")

spiderLogo.ScaleType = Enum.ScaleType.Fit

spiderLogo.Parent = spiderButton


--==================================================
--// TEXTO SPIDER HUB
--==================================================

local spiderText = Instance.new("TextLabel")

spiderText.Name = "SpiderText"

spiderText.Size = UDim2.new(1, -12, 0, 40)

spiderText.AnchorPoint = Vector2.new(0.5, 1)

spiderText.Position = UDim2.new(0.5, 0, 1, -8)

spiderText.BackgroundTransparency = 1

spiderText.Text = "SPIDER HUB"

-- Mismo blanco que los botones
spiderText.TextColor3 = Color3.fromRGB(255, 255, 255)

-- Mismo tamaño aproximado
spiderText.TextSize = 13

spiderText.TextScaled = false

-- Letras gruesas
spiderText.Font = Enum.Font.GothamBold

spiderText.TextWrapped = true

spiderText.TextXAlignment = Enum.TextXAlignment.Center
spiderText.TextYAlignment = Enum.TextYAlignment.Center

spiderText.Parent = spiderButton


--==================================================
--// SOMBRA OSCURA PARA SPIDER HUB
--==================================================

local spiderGradient = Instance.new("UIGradient")

spiderGradient.Name = "DiagonalShadow"

spiderGradient.Color = ColorSequence.new({

	ColorSequenceKeypoint.new(
		0.00,
		Color3.fromRGB(255, 255, 255)
	),

	ColorSequenceKeypoint.new(
		0.42,
		Color3.fromRGB(255, 255, 255)
	),

	-- Sombra oscura
	ColorSequenceKeypoint.new(
		0.50,
		Color3.fromRGB(35, 35, 35)
	),

	ColorSequenceKeypoint.new(
		0.58,
		Color3.fromRGB(255, 255, 255)
	),

	ColorSequenceKeypoint.new(
		1.00,
		Color3.fromRGB(255, 255, 255)
	)
})

-- Misma dirección diagonal
spiderGradient.Rotation = 45

spiderGradient.Offset = Vector2.new(-1.5, -1.5)

spiderGradient.Parent = spiderText


--==================================================
--// ANIMACIÓN DE SPIDER HUB
--==================================================

task.spawn(function()

	while true do

		spiderGradient.Offset = Vector2.new(-1.5, -1.5)

		local tween = TweenService:Create(

			spiderGradient,

			TweenInfo.new(
				1.8,
				Enum.EasingStyle.Linear,
				Enum.EasingDirection.InOut
			),

			{
				Offset = Vector2.new(1.5, 1.5)
			}

		)

		tween:Play()

		tween.Completed:Wait()

		task.wait(0.25)

	end

end)