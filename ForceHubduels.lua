-- LocalScript (colocar en StarterGui o dentro de un ScreenGui)
local player = game.Players.LocalPlayer
local gui = player:WaitForChild("PlayerGui")

-- Crear la pantalla principal
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = gui

-- Contenedor principal (anclado a la derecha)
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 160, 1, 0)          -- ancho fijo, alto toda la pantalla
mainFrame.Position = UDim2.new(1, -170, 0, 0)     -- pegado al borde derecho con margen
mainFrame.BackgroundTransparency = 1              -- fondo transparente
mainFrame.Parent = screenGui

-- Layout para apilar botones verticalmente
local layout = Instance.new("UIListLayout")
layout.Parent = mainFrame
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
layout.VerticalAlignment = Enum.VerticalAlignment.Top
layout.Padding = UDim.new(0, 6)                   -- separación entre botones
layout.SortOrder = Enum.SortOrder.LayoutOrder

-- Lista de nombres (exactamente como en la imagen)
local nombres = {
    "BAT V2",
    "DROP BR",
    "AUTO LEFT",
    "RESET",
    "ANTI DESYNC",
    "BAT AIMBOT",
    "AUTO RIGHT",
    "TP DOWN",
    "CARRY SPD",
    "LAGGER 1",
    "LAGGER 2",
    "e duel!"
}

-- Crear cada botón
for _, texto in ipairs(nombres) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 140, 0, 28)           -- tamaño pequeño
    btn.BackgroundColor3 = Color3.fromRGB(20, 20, 20) -- negro oscuro
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)   -- blanco
    btn.Text = texto
    btn.TextScaled = true                         -- ajusta el texto al tamaño del botón
    btn.Font = Enum.Font.SourceSansBold
    btn.BorderSizePixel = 0                       -- sin borde (opcional)
    btn.AutoButtonColor = false                   -- evita cambios de color al hacer clic
    btn.Parent = mainFrame
end