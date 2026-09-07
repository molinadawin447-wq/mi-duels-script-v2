-- LocalScript (colocar en StarterPlayerScripts o StarterGui)
local Players = game:GetService("Players")
local player = Players.LocalPlayer

player:WaitForChild("PlayerGui")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "BotonesGui"
screenGui.Parent = player.PlayerGui

-- Configuración
local buttonSize = 63
local spacingH = 15   -- separación horizontal entre columnas
local spacingV = 10   -- separación vertical entre botones de una misma columna
local columnCounts = {1, 2, 4, 4}  -- número de botones por columna (de izquierda a derecha)

-- Calcular alturas de cada columna y la altura máxima
local columnHeights = {}
local maxHeight = 0
for _, count in ipairs(columnCounts) do
    local h = count * buttonSize + (count - 1) * spacingV
    table.insert(columnHeights, h)
    if h > maxHeight then maxHeight = h end
end

local totalWidth = #columnCounts * buttonSize + (#columnCounts - 1) * spacingH
local totalHeight = maxHeight

-- Contenedor principal (invisible) que agrupa todo y se centra en la pantalla
local container = Instance.new("Frame")
container.Name = "Container"
container.BackgroundTransparency = 1
container.Size = UDim2.new(0, totalWidth, 0, totalHeight)
container.Position = UDim2.new(0.5, -totalWidth/2, 0.5, -totalHeight/2)
container.Parent = screenGui

-- Crear cada columna
for colIndex, count in ipairs(columnCounts) do
    local colHeight = columnHeights[colIndex]
    -- Frame contenedor de la columna (invisible)
    local colFrame = Instance.new("Frame")
    colFrame.Name = "Columna" .. colIndex
    colFrame.BackgroundTransparency = 1
    colFrame.Size = UDim2.new(0, buttonSize, 0, colHeight)
    colFrame.Position = UDim2.new(0, (colIndex-1)*(buttonSize + spacingH), 0.5, -colHeight/2)
    colFrame.Parent = container
    
    -- Crear botones dentro de la columna
    for i = 1, count do
        local button = Instance.new("ImageButton")
        button.Name = "Boton" .. colIndex .. "_" .. i
        button.Size = UDim2.new(0, buttonSize, 0, buttonSize)
        -- Calcular posición Y para centrar verticalmente el conjunto de botones
        local yOffset = (colHeight - (count * buttonSize + (count-1)*spacingV)) / 2
        local yPos = yOffset + (i-1) * (buttonSize + spacingV)
        button.Position = UDim2.new(0, 0, 0, yPos)
        button.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
        button.BackgroundTransparency = 0
        button.BorderSizePixel = 1
        button.BorderColor3 = Color3.fromRGB(100, 100, 100)
        button.AutoButtonColor = true
        button.Text = ""
        button.Image = ""
        button.Parent = colFrame
        
        -- Hacer el botón circular (radio 50%)
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0.5, 0)
        corner.Parent = button
    end
end

-- Reposicionar el contenedor si la pantalla cambia de tamaño (opcional)
container:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
    container.Position = UDim2.new(0.5, -container.Size.X.Offset / 2, 0.5, -container.Size.Y.Offset / 2)
end)