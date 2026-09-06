--// BOTÓN SPIDER.VS - IZQUIERDA

local spiderButton = Instance.new("TextButton")

spiderButton.Name = "SpiderVS"

-- Mitad de alto aproximadamente y un poco ancho
spiderButton.Size = UDim2.fromOffset(90, 32)

-- Un poco más arriba y centrado a la izquierda
spiderButton.AnchorPoint = Vector2.new(0, 0.5)
spiderButton.Position = UDim2.new(0, 15, 0.45, 0)

spiderButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
spiderButton.BorderSizePixel = 0
spiderButton.Text = ""
spiderButton.AutoButtonColor = false

spiderButton.Parent = screenGui

-- Esquinas redondeadas
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = spiderButton


--// TEXTO

local spiderText = Instance.new("TextLabel")

spiderText.Name = "SpiderText"
spiderText.Size = UDim2.new(1, -8, 1, -4)
spiderText.Position = UDim2.fromOffset(4, 2)

spiderText.BackgroundTransparency = 1
spiderText.Text = "🕷 SPIDER.VS"

-- Mismo color que los botones de la derecha
spiderText.TextColor3 = Color3.fromRGB(255, 255, 255)

-- Mismo tamaño y grosor
spiderText.TextSize = 13
spiderText.Font = Enum.Font.GothamBold

spiderText.TextXAlignment = Enum.TextXAlignment.Center
spiderText.TextYAlignment = Enum.TextYAlignment.Center

spiderText.Parent = spiderButton


--// MISMA SOMBRA OSCURA DIAGONAL

local gradient = Instance.new("UIGradient")

gradient.Name = "DiagonalShadow"

gradient.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)),
	ColorSequenceKeypoint.new(0.42, Color3.fromRGB(255, 255, 255)),
	ColorSequenceKeypoint.new(0.50, Color3.fromRGB(35, 35, 35)),
	ColorSequenceKeypoint.new(0.58, Color3.fromRGB(255, 255, 255)),
	ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 255, 255)),
})

gradient.Rotation = 45
gradient.Offset = Vector2.new(-1.5, -1.5)
gradient.Parent = spiderText


--// ANIMACIÓN DE LA SOMBRA

task.spawn(function()
	while true do

		gradient.Offset = Vector2.new(-1.5, -1.5)

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

		tween:Play()
		tween.Completed:Wait()

		task.wait(0.25)
	end
end)