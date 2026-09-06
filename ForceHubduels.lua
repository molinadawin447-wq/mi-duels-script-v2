-- LocalScript
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "SpiderVS_UI"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
screenGui.Parent = playerGui

-- =========================================================
-- CONFIGURACIÓN
-- =========================================================

local buttonSize = 63
local gap = 7

local buttonTexts = {
    "TP\nBAT",
    "INSTA\nRESET",
    "BYPASS\nANTIBAT",
    "AUTO\nRIGHT",
    "BAT\nAIMBOT",
    "TP\nDOWN",
    "LAGGER 1",
    "AUTO\nLEFT",
    "DROP BR",
    "CARRY SPD",
    "LAGGER 2"
}

-- =========================================================
-- CONTENEDOR DE BOTONES DERECHA
-- =========================================================

local container = Instance.new("Frame")
container.Name = "ButtonContainer"
container.BackgroundTransparency = 1
container.AnchorPoint = Vector2.new(1, 0)
container.Position = UDim2.new(1, -5, 0, 10)
container.Size = UDim2.fromOffset(300, 300)
container.Parent = screenGui

-- =========================================================
-- FUNCIÓN PARA CREAR GRADIENTE
-- =========================================================

local function addAnimatedGradient(label)
    local gradient = Instance.new("UIGradient")
    gradient.Name = "DiagonalShadow"

    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)),
        ColorSequenceKeypoint.new(0.42, Color3.fromRGB(255, 255, 255)),
        ColorSequenceKeypoint.new(0.50, Color3.fromRGB(35, 35, 35)),
        ColorSequenceKeypoint.new(0.58, Color3.fromRGB(255, 255, 255)),
        ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 255, 255))
    })

    gradient.Rotation = 45
    gradient.Offset = Vector2.new(-1.5, -1.5)
    gradient.Parent = label

    task.spawn(function()
        while label.Parent do
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
end

-- =========================================================
-- CREAR BOTÓN
-- =========================================================

local function createButton(name, text, x, y)
    local button = Instance.new("ImageButton")

    button.Name = name
    button.Size = UDim2.fromOffset(buttonSize, buttonSize)
    button.Position = UDim2.fromOffset(x, y)

    button.BackgroundTransparency = 1
    button.BorderSizePixel = 0

    -- Fondo personalizado
    button.Image = getcustomasset("Telaraña.jpg")
    button.ScaleType = Enum.ScaleType.Crop

    button.AutoButtonColor = false
    button.Parent = container

    -- Bordes redondeados
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 20)
    corner.Parent = button

    -- Texto
    local label = Instance.new("TextLabel")

    label.Name = "Text"
    label.Size = UDim2.new(1, -12, 1, -12)
    label.Position = UDim2.fromOffset(6, 6)

    label.BackgroundTransparency = 1

    label.Text = text
    label.TextColor3 = Color3.fromRGB(255, 255, 255)

    label.TextSize = 13
    label.TextScaled = false

    label.Font = Enum.Font.GothamBold
    label.TextWrapped = true

    label.TextXAlignment = Enum.TextXAlignment.Center
    label.TextYAlignment = Enum.TextYAlignment.Center

    label.Parent = button

    -- Gradiente animado
    addAnimatedGradient(label)

    return button
end

-- =========================================================
-- POSICIONES
-- =========================================================

-- Columna 1
createButton(
    "Button1",
    buttonTexts[1],
    0,
    0
)

-- Columna 2
createButton(
    "Button2",
    buttonTexts[2],
    buttonSize + gap,
    0
)

createButton(
    "Button3",
    buttonTexts[3],
    buttonSize + gap,
    buttonSize + gap
)

-- Columna 3
createButton(
    "Button4",
    buttonTexts[4],
    (buttonSize + gap) * 2,
    0
)

createButton(
    "Button5",
    buttonTexts[5],
    (buttonSize + gap) * 2,
    buttonSize + gap
)

createButton(
    "Button6",
    buttonTexts[6],
    (buttonSize + gap) * 2,
    (buttonSize + gap) * 2
)

createButton(
    "Button7",
    buttonTexts[7],
    (buttonSize + gap) * 2,
    (buttonSize + gap) * 3
)

-- Columna 4
createButton(
    "Button8",
    buttonTexts[8],
    (buttonSize + gap) * 3,
    0
)

createButton(
    "Button9",
    buttonTexts[9],
    (buttonSize + gap) * 3,
    buttonSize + gap
)

createButton(
    "Button10",
    buttonTexts[10],
    (buttonSize + gap) * 3,
    (buttonSize + gap) * 2
)

createButton(
    "Button11",
    buttonTexts[11],
    (buttonSize + gap) * 3,
    (buttonSize + gap) * 3
)

-- =========================================================
-- BOTÓN IZQUIERDO: 🕷 SPIDER.VS
-- =========================================================

local spiderButton = Instance.new("TextButton")

spiderButton.Name = "SpiderVS"

-- Aproximadamente la mitad de un botón derecho,
-- pero un poco más ancho para que quepa el texto.
spiderButton.Size = UDim2.fromOffset(90, 32)

spiderButton.AnchorPoint = Vector2.new(0, 0.5)
spiderButton.Position = UDim2.new(0, 15, 0.45, 0)

spiderButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
spiderButton.BorderSizePixel = 0

spiderButton.Text = ""
spiderButton.AutoButtonColor = false

spiderButton.Parent = screenGui

-- Bordes redondeados
local spiderCorner = Instance.new("UICorner")
spiderCorner.CornerRadius = UDim.new(0, 12)
spiderCorner.Parent = spiderButton

-- Texto SPIDER.VS
local spiderText = Instance.new("TextLabel")

spiderText.Name = "SpiderText"
spiderText.Size = UDim2.new(1, -8, 1, -4)
spiderText.Position = UDim2.fromOffset(4, 2)

spiderText.BackgroundTransparency = 1

spiderText.Text = "🕷 SPIDER.VS"
spiderText.TextColor3 = Color3.fromRGB(255, 255, 255)

spiderText.TextSize = 13
spiderText.Font = Enum.Font.GothamBold

spiderText.TextXAlignment = Enum.TextXAlignment.Center
spiderText.TextYAlignment = Enum.TextYAlignment.Center

spiderText.Parent = spiderButton

-- Gradiente del botón izquierdo
addAnimatedGradient(spiderText)