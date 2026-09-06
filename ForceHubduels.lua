--// BOTONES CON IMAGEN LOCAL (Delta)
--// Usa Drawing.Image desde workspace/Telaraña.jpg

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer
local mouse = player:GetMouse()

-- Verificar que la imagen existe
local imagePath = "workspace/Telaraña.jpg"  -- Ruta relativa a la carpeta de Delta
local fileExists = pcall(function() return readfile(imagePath) end)
if not fileExists then
    -- Crear un mensaje de error en pantalla
    local errorLabel = Instance.new("TextLabel")
    errorLabel.Size = UDim2.new(1, 0, 0.1, 0)
    errorLabel.Position = UDim2.new(0, 0, 0.5, 0)
    errorLabel.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    errorLabel.Text = "❌ No se encontró " .. imagePath
    errorLabel.TextScaled = true
    errorLabel.Parent = player.PlayerGui
    return
end

-- Configuración de los "botones"
local buttonSize = 63
local gap = 7
local columns = 4
local rows = 4
local startX = 5  -- margen derecho (porque está anclado a la derecha)
local startY = 10

-- Calculamos la posición en píxeles desde la esquina superior derecha
local screenX, screenY = mouse.ViewSizeX, mouse.ViewSizeY

-- Lista para guardar los objetos Drawing.Image
local drawnButtons = {}

-- Función para crear un Drawing.Image
local function createImageButton(column, row)
    local x = screenX - startX - (column) * (buttonSize + gap) + (buttonSize + gap)  -- Ajuste para que esté a la derecha
    local y = startY + (row - 1) * (buttonSize + gap)
    
    local img = Drawing.new("Image")
    img.Size = Vector2.new(buttonSize, buttonSize)
    img.Position = Vector2.new(x, y)
    img.Data = readfile(imagePath)  -- Carga la imagen desde el archivo
    img.Visible = true
    img.ZIndex = 10
    img.Transparency = 0
    img.Parent = nil  -- No necesita padre, se dibuja directamente
    
    -- Guardar para detección de clics
    table.insert(drawnButtons, {
        Image = img,
        X = x,
        Y = y,
        W = buttonSize,
        H = buttonSize,
        Name = "Button" .. column .. "_" .. row
    })
end

-- Crear los 11 botones según la distribución original
-- COLUMNA 1: solo (1,1)
createImageButton(1, 1)

-- COLUMNA 2: (2,1) y (2,2)
createImageButton(2, 1)
createImageButton(2, 2)

-- COLUMNA 3: (3,1),(3,2),(3,3),(3,4)
createImageButton(3, 1)
createImageButton(3, 2)
createImageButton(3, 3)
createImageButton(3, 4)

-- COLUMNA 4: (4,1),(4,2),(4,3),(4,4)
createImageButton(4, 1)
createImageButton(4, 2)
createImageButton(4, 3)
createImageButton(4, 4)

-- Mensaje de confirmación
local confirm = Instance.new("TextLabel")
confirm.Size = UDim2.new(0.3, 0, 0.08, 0)
confirm.Position = UDim2.new(0.35, 0, 0.05, 0)
confirm.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
confirm.Text = "✅ 11 botones con Telaraña"
confirm.TextScaled = true
confirm.Parent = player.PlayerGui
task.wait(2)
confirm:Destroy()

-- Detección de clics en los botones dibujados
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        local clickX, clickY = input.Position.X, input.Position.Y
        for _, btn in ipairs(drawnButtons) do
            if clickX >= btn.X and clickX <= btn.X + btn.W and
               clickY >= btn.Y and clickY <= btn.Y + btn.H then
                print("🖱️ Clic en " .. btn.Name)
                -- Aquí puedes poner la acción que quieras para cada botón
                -- Ejemplo: mostrar un mensaje
                local msg = Instance.new("TextLabel")
                msg.Size = UDim2.new(0.2, 0, 0.05, 0)
                msg.Position = UDim2.new(0.4, 0, 0.3, 0)
                msg.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                msg.TextColor3 = Color3.fromRGB(255, 255, 255)
                msg.Text = "Clic en " .. btn.Name
                msg.TextScaled = true
                msg.Parent = player.PlayerGui
                task.wait(0.8)
                msg:Destroy()
            end
        end
    end
end)

print("✅ Botones dibujados correctamente")