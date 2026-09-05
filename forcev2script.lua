-- Auto Grab photo integration: Asset ID 108199149509537.




-- ============================================================
--  CT Duels | EDICIÃ“N ROJO CON NEGRO â€“ MODIFICADO CON NIGHT #3.VS
-- ============================================================


-- MENU MENU INTEGRATION
-- Visual shell transplanted onto NIGHT while preserving its feature callbacks.
-- AutoGrab, Rojo/Negro, keybinds, pages and saved state remain owned by NIGHT.
-- SECCIÃ“N 1: CONFIGURACIÃ“N INICIAL (BRANDING, COLORES, STATE)
-- ============================================================
local CANDY_BRAND = "menu"
local CANDY_DISCORD = "https://discord.gg/dpUq7VGB"
local CANDY_COLORS = {
	BG = Color3.fromRGB(0, 0, 0),
	PANEL = Color3.fromRGB(0, 0, 0),
	CARD = Color3.fromRGB(12, 0, 0),
	ACCENT = Color3.fromRGB(220, 20, 30),
	PURPLE = Color3.fromRGB(255, 40, 50),
	ICE = Color3.fromRGB(255, 70, 80),
	HOVER = Color3.fromRGB(180, 15, 25),
	TEXT = Color3.fromRGB(255, 255, 255),
	SECONDARY = Color3.fromRGB(140, 10, 20),
	STROKE = Color3.fromRGB(255, 50, 60),
	INPUT = Color3.fromRGB(220, 20, 30),
	OFF = Color3.fromRGB(8, 0, 0)
}

local BG         = Color3.fromRGB(0, 0, 0)
local SIDEBAR_BG = Color3.fromRGB(0, 0, 0)
local CARD_BG    = Color3.fromRGB(12, 0, 0)
local CARD_HOV   = Color3.fromRGB(220, 20, 30)
local KB_BG      = Color3.fromRGB(15, 0, 0)

local WHITE      = Color3.fromRGB(255, 255, 255)
local DIM        = Color3.fromRGB(140, 20, 30)
local DIM2       = Color3.fromRGB(12, 0, 0)

local BORDER     = Color3.fromRGB(255, 50, 60)
local BORDER2    = Color3.fromRGB(200, 25, 35)
local OPTION_TRANSPARENCY = 0.42
local OPTION_HOVER_TRANSPARENCY = 0.22
local TAB_TRANSPARENCY = 0.35
local TAB_HOVER_TRANSPARENCY = 0.16
local INPUT_TRANSPARENCY = 0.24

repeat task.wait() until game:IsLoaded()

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local LP = Players.LocalPlayer

-- ===== ESTILO ROJO CON NEGRO Y RESPUESTA TÃCTIL DE BOTONES =====
local BUTTON_RED = Color3.fromRGB(220, 20, 30)
local BUTTON_TOUCH_BLACK = Color3.fromRGB(0, 0, 0)

local function bindPurpleButton(button)
    if not button:IsA("TextButton") or button:GetAttribute("PurpleButtonBound") then return end
    if button.BackgroundTransparency >= 0.95 then return end
    button:SetAttribute("PurpleButtonBound", true)
    button.AutoButtonColor = false
    button.BackgroundColor3 = BUTTON_RED
    button.Activated:Connect(function()
        if not button.Parent then return end
        button.BackgroundColor3 = BUTTON_TOUCH_BLACK
        task.delay(0.14, function()
            if button and button.Parent then button.BackgroundColor3 = BUTTON_RED end
        end)
    end)
end


-- SECCIÃ“N 2: ALERTA DE PING ALTO
task.spawn(function()
    local env = (getgenv and getgenv()) or _G
    env.__CRYON_HIGH_PING_RUN = (env.__CRYON_HIGH_PING_RUN or 0) + 1
    local thisRun = env.__CRYON_HIGH_PING_RUN
    env.__CRYON_INTRO_FINISHED_RUN = 0
    local shown = false

    local function getPingMilliseconds()
        local ok, value = pcall(function()
            local stats = game:GetService("Stats")
            local network = stats:FindFirstChild("Network")
            local serverStats = network and network:FindFirstChild("ServerStatsItem")
            local pingItem = serverStats and (serverStats:FindFirstChild("Data Ping") or serverStats:FindFirstChild("Ping"))
            if not pingItem then
                return nil
            end

            local numericValue
            pcall(function()
                numericValue = pingItem:GetValue()
            end)
            if type(numericValue) == "number" then
                return numericValue
            end

            local valueString = pingItem:GetValueString()
            return tonumber(tostring(valueString):match("[%d%.]+"))
        end)
        return ok and tonumber(value) or nil
    end

    local function showHighPingAlert()
        local TweenService = game:GetService("TweenService")
        local CoreGui = game:GetService("CoreGui")
        local Players = game:GetService("Players")
        local player = Players.LocalPlayer
        local playerGui = player and player:FindFirstChildOfClass("PlayerGui")

        pcall(function()
            local old = CoreGui:FindFirstChild("CryonHighPingAlert")
            if old then old:Destroy() end
        end)
        pcall(function()
            local old = playerGui and playerGui:FindFirstChild("CryonHighPingAlert")
            if old then old:Destroy() end
        end)

        local gui = Instance.new("ScreenGui")
        gui.Name = "CryonHighPingAlert"
        gui.ResetOnSpawn = false
        gui.IgnoreGuiInset = false
        gui.DisplayOrder = 10000
        gui.ZIndexBehavior = Enum.ZIndexBehavior.Global

        local parented = pcall(function()
            gui.Parent = CoreGui
        end)
        if not parented or not gui.Parent then
            gui.Parent = playerGui
        end
        if not gui.Parent then
            gui:Destroy()
            return
        end

        local bar = Instance.new("Frame")
        bar.Name = "AlertBar"
        bar.AnchorPoint = Vector2.new(0.5, 0)
        bar.Position = UDim2.new(0.5, 0, 0, -44)
        bar.Size = UDim2.new(0, 310, 0, 32)
        bar.BackgroundColor3 = Color3.fromRGB(10,10,12)
        bar.BackgroundTransparency = 0.06
        bar.BorderSizePixel = 0
        bar.ClipsDescendants = true
        bar.ZIndex = 100
        bar.Parent = gui

        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 12)
        corner.Parent = bar

        local stroke = Instance.new("UIStroke")
        stroke.Color = Color3.fromRGB(255, 40, 50)
        stroke.Transparency = 0.2
        stroke.Thickness = 1
        stroke.Parent = bar

        local gradient = Instance.new("UIGradient")
        gradient.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(8,8,10)),
            ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 40, 50)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(8,8,10)),
        })
        gradient.Parent = bar

        local label = Instance.new("TextLabel")
        label.BackgroundTransparency = 1
        label.Position = UDim2.new(0, 10, 0, 0)
        label.Size = UDim2.new(1, -20, 1, 0)
        label.Font = Enum.Font.GothamBold
        label.Text = "high ping! Your ping is more than 150."
        label.TextColor3 = Color3.fromRGB(220, 20, 30)
        label.TextSize = 13
        label.TextStrokeColor3 = Color3.fromRGB(0,0,0)
        label.TextStrokeTransparency = 0.55
        label.TextWrapped = false
        label.TextScaled = false
        label.ZIndex = 102
        label.Parent = bar

        local slideIn = TweenService:Create(
            bar,
            TweenInfo.new(0.35, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
            {Position = UDim2.new(0.5, 0, 0, 10)}
        )
        slideIn:Play()
        slideIn.Completed:Wait()

        task.wait(2)

        local slideOut = TweenService:Create(
            bar,
            TweenInfo.new(0.35, Enum.EasingStyle.Quint, Enum.EasingDirection.In),
            {Position = UDim2.new(0.5, 0, 0, -44)}
        )
        slideOut:Play()
        slideOut.Completed:Wait()
        gui:Destroy()
    end

    while env.__CRYON_HIGH_PING_RUN == thisRun and env.__CRYON_INTRO_FINISHED_RUN ~= thisRun do
        task.wait(0.1)
    end

    while env.__CRYON_HIGH_PING_RUN == thisRun and not shown do
        local ping = getPingMilliseconds()
        if ping and ping > 150 then
            shown = true
            showHighPingAlert()
            break
        end
        task.wait(1)
    end
end)

-- SECCIÃ“N 3: INTRO ANIMADA (la mejor + canciÃ³n Ajjan.Vs)
-- RANDOM IMAGE + MUSIC + BEAT EFFECTS + SKIP
do
	local envI = (getgenv and getgenv()) or _G
	if envI.__CRYON_NO_INTRO_SAVED == true then
		envI.__CRYON_INTRO_FINISHED_RUN = envI.__CRYON_HIGH_PING_RUN or 0
	else
		task.spawn(function()
--============================================================
-- NIGHT #3.VS INTRO
-- YOUR ORIGINAL VERSION
-- RANDOM IMAGE + MUSIC + BEAT EFFECTS + SKIP
--============================================================

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local SoundService = game:GetService("SoundService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")

--============================================================
-- SETTINGS
--============================================================

-- CanciÃ³n de Ajjan.Vs Intro (make by ! kaii)
local MUSIC_SOUND_ID =
	"rbxassetid://136350225160627"

local MUSIC_VOLUME =
	0.75

local BPM =
	100

local BEAT =
	60 / BPM

-- IMAGE 2 FIRST
-- IMAGE 1 SECOND
-- THEN RANDOM WITHOUT REPEATING
local IMAGES = {
	"rbxassetid://77352629689028",
	"rbxassetid://77352629689028",
	"rbxassetid://77352629689028",
	"rbxassetid://77352629689028"
}

--============================================================
-- CLEAN OLD
--============================================================

for _, name in ipairs({
	"ShadowVSIntro"
}) do

	local old =
		PlayerGui:FindFirstChild(name)

	if old then
		old:Destroy()
	end

end

--============================================================
-- IMAGE ORDER
--============================================================

local lastImage =
	shared.ShadowVS_LastImage

local imageIndex

if not shared.ShadowVS_Run then

	shared.ShadowVS_Run =
		1

	imageIndex =
		2

elseif shared.ShadowVS_Run == 1 then

	shared.ShadowVS_Run =
		2

	imageIndex =
		1

else

	local choices = {}

	for i = 1, #IMAGES do

		if i ~= lastImage then
			table.insert(
				choices,
				i
			)
		end

	end

	imageIndex =
		choices[
			math.random(
				1,
				#choices
			)
		]

end

shared.ShadowVS_LastImage =
	imageIndex

local IMAGE_ID =
	IMAGES[imageIndex]

--============================================================
-- INTRO STATE
--============================================================

local introActive =
	true

local introFinished =
	false

local introSound =
	nil

--============================================================
-- GUI
--============================================================

local gui =
	Instance.new("ScreenGui")

gui.Name =
	"ShadowVSIntro"

gui.IgnoreGuiInset =
	true

gui.ResetOnSpawn =
	false

gui.DisplayOrder =
	999999

gui.ZIndexBehavior =
	Enum.ZIndexBehavior.Sibling

gui.Parent =
	PlayerGui

--============================================================
-- BACKGROUND
--============================================================

local background =
	Instance.new("Frame")

background.Size =
	UDim2.fromScale(
		1,
		1
	)

background.BackgroundColor3 =
	Color3.fromRGB(
		0,
		0,
		0
	)

background.BorderSizePixel =
	0

background.ClipsDescendants =
	true

background.Parent =
	gui

--============================================================
-- IMAGE
--============================================================

local image =
	Instance.new("ImageLabel")

image.AnchorPoint =
	Vector2.new(
		0.5,
		0.5
	)

image.Position =
	UDim2.fromScale(
		0.5,
		0.5
	)

image.Size =
	UDim2.fromScale(
		1.08,
		1.08
	)

image.BackgroundTransparency =
	1

image.Image =
	IMAGE_ID

image.ImageTransparency =
	1

image.ScaleType =
	Enum.ScaleType.Crop

image.ZIndex =
	1

image.Parent =
	background

--============================================================
-- DARK OVERLAY
--============================================================

local dark =
	Instance.new("Frame")

dark.Size =
	UDim2.fromScale(
		1,
		1
	)

dark.BackgroundColor3 =
	Color3.fromRGB(
		0,
		0,
		0
	)

dark.BackgroundTransparency =
	0.25

dark.BorderSizePixel =
	0

dark.ZIndex =
	2

dark.Parent =
	background

--============================================================
-- SKIP INTRO BUTTON
--============================================================

local skip =
	Instance.new("TextButton")

skip.AnchorPoint =
	Vector2.new(
		1,
		0
	)

skip.Position =
	UDim2.new(
		1,
		-14,
		0,
		14
	)

skip.Size =
	UDim2.fromOffset(
		105,
		36
	)

skip.BackgroundColor3 =
	Color3.fromRGB(
		15,
		15,
		18
	)

skip.BackgroundTransparency =
	0.15

skip.BorderSizePixel =
	0

skip.Text =
	"SKIP INTRO"

skip.TextColor3 =
	Color3.fromRGB(
		255,
		255,
		255
	)

skip.TextSize =
	12

skip.Font =
	Enum.Font.GothamBold

skip.AutoButtonColor =
	false

skip.ZIndex =
	500

skip.Parent =
	gui

local skipCorner =
	Instance.new("UICorner")

skipCorner.CornerRadius =
	UDim.new(
		0,
		7
	)

skipCorner.Parent =
	skip

local skipStroke =
	Instance.new("UIStroke")

skipStroke.Color =
	Color3.fromRGB(
		255,
		255,
		255
	)

skipStroke.Transparency =
	0.75

skipStroke.Thickness =
	1

skipStroke.Parent =
	skip

--============================================================
-- FLASH
--============================================================

local flash =
	Instance.new("Frame")

flash.Size =
	UDim2.fromScale(
		1,
		1
	)

flash.BackgroundColor3 =
	Color3.fromRGB(
		255,
		255,
		255
	)

flash.BackgroundTransparency =
	1

flash.BorderSizePixel =
	0

flash.ZIndex =
	400

flash.Parent =
	gui

--============================================================
-- TITLE
--============================================================

local introTitle =
	Instance.new("TextLabel")

introTitle.AnchorPoint =
	Vector2.new(
		0.5,
		0.5
	)

introTitle.Position =
	UDim2.fromScale(
		0.5,
		0.5
	)

introTitle.Size =
	UDim2.fromScale(
		1.1,
		0.22
	)

introTitle.BackgroundTransparency =
	1

introTitle.Text =
	"NIGHT #3.VS"

introTitle.TextColor3 =
	Color3.fromRGB(
		255,
		255,
		255
	)

introTitle.TextTransparency =
	1

introTitle.TextScaled =
	true

introTitle.Font =
	Enum.Font.GothamBlack

introTitle.ZIndex =
	20

introTitle.Parent =
	background

local titleStroke =
	Instance.new("UIStroke")

titleStroke.Color =
	Color3.fromRGB(
		0,
		0,
		0
	)

titleStroke.Thickness =
	3

titleStroke.Transparency =
	1

titleStroke.Parent =
	introTitle

--============================================================
-- SUBTITLE
--============================================================

local introSubtitle =
	Instance.new("TextLabel")

introSubtitle.AnchorPoint =
	Vector2.new(
		0.5,
		0.5
	)

introSubtitle.Position =
	UDim2.fromScale(
		0.5,
		0.59
	)

introSubtitle.Size =
	UDim2.fromScale(
		0.6,
		0.05
	)

introSubtitle.BackgroundTransparency =
	1

introSubtitle.Text =
	"https://discord.gg/zY3tSgnJ"

introSubtitle.TextColor3 =
	Color3.fromRGB(
		205,
		205,
		205
	)

introSubtitle.TextTransparency =
	1

introSubtitle.TextScaled =
	true

introSubtitle.Font =
	Enum.Font.GothamBold

introSubtitle.ZIndex =
	20

introSubtitle.Parent =
	background

--============================================================
-- PLAY MUSIC (canciÃ³n Ajjan.Vs â€“ rbxassetid://136350225160627)
--============================================================

task.spawn(function()

	if not introActive then
		return
	end

	introSound =
		Instance.new("Sound")

	introSound.Name =
		"ShadowVSIntroMusic"

	introSound.SoundId =
		MUSIC_SOUND_ID

	introSound.Volume =
		MUSIC_VOLUME

	introSound.Looped =
		false

	introSound.Parent =
		SoundService

	pcall(function()
		introSound:Play()
	end)

end)

--============================================================
-- FINISH
--============================================================

local function finishIntro()

	if introFinished then
		return
	end

	introFinished =
		true

	introActive =
		false

	pcall(function()
		local env = (getgenv and getgenv()) or _G
		env.__CRYON_INTRO_FINISHED_RUN = env.__CRYON_HIGH_PING_RUN or 0
	end)

	if introSound then

		pcall(function()

			TweenService:Create(
				introSound,
				TweenInfo.new(
					0.35
				),
				{
					Volume = 0
				}
			):Play()

		end)

		task.delay(
			0.4,
			function()

				pcall(function()

					introSound:Stop()
					introSound:Destroy()

				end)

			end
		)

	end

	pcall(function()
		gui:Destroy()
	end)

end

--============================================================
-- SKIP
--============================================================

skip.MouseButton1Click:Connect(
	finishIntro
)

--============================================================
-- SKIP HOVER
--============================================================

skip.MouseEnter:Connect(function()

	TweenService:Create(
		skip,
		TweenInfo.new(
			0.12
		),
		{
			BackgroundColor3 =
				Color3.fromRGB(
					55,
					55,
					60
				)
		}
	):Play()

end)

skip.MouseLeave:Connect(function()

	TweenService:Create(
		skip,
		TweenInfo.new(
			0.12
		),
		{
			BackgroundColor3 =
				Color3.fromRGB(
					15,
					15,
					18
				)
		}
	):Play()

end)

--============================================================
-- IMAGE FADE IN
--============================================================

TweenService:Create(
	image,
	TweenInfo.new(
		1.1,
		Enum.EasingStyle.Quint,
		Enum.EasingDirection.Out
	),
	{
		ImageTransparency =
			0
	}
):Play()

--============================================================
-- SLOW ZOOM
--============================================================

TweenService:Create(
	image,
	TweenInfo.new(
		18,
		Enum.EasingStyle.Sine,
		Enum.EasingDirection.InOut
	),
	{
		Size =
			UDim2.fromScale(
				1.18,
				1.18
			)
	}
):Play()

--============================================================
-- BEAT FLASH
--============================================================

task.spawn(function()

	while introActive
		and gui.Parent do

		flash.BackgroundTransparency =
			0.8

		TweenService:Create(
			flash,
			TweenInfo.new(
				0.12,
				Enum.EasingStyle.Quint,
				Enum.EasingDirection.Out
			),
			{
				BackgroundTransparency =
					1
			}
		):Play()

		task.wait(
			BEAT
		)

	end

end)

--============================================================
-- TITLE
--============================================================

task.wait(1.5)

if not introActive then
	return
end

TweenService:Create(
	introTitle,
	TweenInfo.new(
		0.7,
		Enum.EasingStyle.Quint,
		Enum.EasingDirection.Out
	),
	{
		Size =
			UDim2.fromScale(
				0.9,
				0.18
			),

		TextTransparency =
			0
	}
):Play()

TweenService:Create(
	titleStroke,
	TweenInfo.new(
		0.5
	),
	{
		Transparency =
			0
	}
):Play()

--============================================================
-- TITLE SHAKE
--============================================================

task.wait(1)

for i = 1, 18 do

	if not introActive then
		return
	end

	introTitle.Position =
		UDim2.fromScale(
			0.5 +
				math.random(
					-8,
					8
				) / 1000,

			0.5 +
				math.random(
					-8,
					8
				) / 1000
		)

	task.wait(
		0.025
	)

end

introTitle.Position =
	UDim2.fromScale(
		0.5,
		0.5
	)

--============================================================
-- SUBTITLE
--============================================================

TweenService:Create(
	introSubtitle,
	TweenInfo.new(
		0.6,
		Enum.EasingStyle.Quint,
		Enum.EasingDirection.Out
	),
	{
		TextTransparency =
			0
	}
):Play()

--============================================================
-- HOLD
--============================================================

task.wait(7)

if not introActive then
	return
end

--============================================================
-- FINAL BEAT FLASHES
--============================================================

for i = 1, 14 do

	if not introActive then
		return
	end

	flash.BackgroundTransparency =
		0

	task.wait(
		0.025
	)

	flash.BackgroundTransparency =
		1

	task.wait(
		0.065
	)

end

--============================================================
-- EXTRA HOLD
--============================================================

task.wait(2)

if not introActive then
	return
end

--============================================================
-- TITLE FADE
--============================================================

TweenService:Create(
	introTitle,
	TweenInfo.new(
		1.2,
		Enum.EasingStyle.Quint,
		Enum.EasingDirection.In
	),
	{
		TextTransparency =
			1
	}
):Play()

TweenService:Create(
	introSubtitle,
	TweenInfo.new(
		1,
		Enum.EasingStyle.Quint,
		Enum.EasingDirection.In
	),
	{
		TextTransparency =
			1
	}
):Play()

TweenService:Create(
	titleStroke,
	TweenInfo.new(
		1
	),
	{
		Transparency =
			1
	}
):Play()

--============================================================
-- IMAGE FADE
--============================================================

TweenService:Create(
	image,
	TweenInfo.new(
		1.5,
		Enum.EasingStyle.Quint,
		Enum.EasingDirection.In
	),
	{
		ImageTransparency =
			1
	}
):Play()

TweenService:Create(
	dark,
	TweenInfo.new(
		1.5
	),
	{
		BackgroundTransparency =
			1
	}
):Play()

--============================================================
-- MUSIC FADE
--============================================================

if introSound and
	introSound.Parent then

	TweenService:Create(
		introSound,
		TweenInfo.new(
			1.5,
			Enum.EasingStyle.Quint,
			Enum.EasingDirection.In
		),
		{
			Volume =
				0
		}
	):Play()

end

--============================================================
-- FINAL BLACK FADE
--============================================================

local finalFade =
	Instance.new("Frame")

finalFade.Size =
	UDim2.fromScale(
		1,
		1
	)

finalFade.BackgroundColor3 =
	Color3.fromRGB(
		0,
		0,
		0
	)

finalFade.BackgroundTransparency =
	1

finalFade.BorderSizePixel =
	0

finalFade.ZIndex =
	1000

finalFade.Parent =
	gui

TweenService:Create(
	finalFade,
	TweenInfo.new(
		1.5,
		Enum.EasingStyle.Quint,
		Enum.EasingDirection.In
	),
	{
		BackgroundTransparency =
			0
	}
):Play()

task.wait(
	1.6
)

finishIntro()

		end)
	end
end


-- ANIMATIONS isolated (no locals into main hub)
;(function()
local currentAnimPack = nil
local originalAnims = nil -- guarda las animaciones normales del personaje

ANIM_PACKS = {
	["Adidas Sports"] = {WalkAnim=18537392113,RunAnim=18537384940,JumpAnim=18537380791,FallAnim=18537367238,SwimIdle=18537387180,Swim=18537389531,Animation1=18537376492,Animation2=18537371272,ClimbAnim=18537363391},
	["Adidas Community"] = {WalkAnim=122150855457006,RunAnim=82598234841035,JumpAnim=75290611992385,FallAnim=98600215928904,SwimIdle=109346520324160,Swim=133308483266208,Animation1=122257458498464,Animation2=102357151005774,ClimbAnim=88763136693023},
	["Adidas Aura"] = {WalkAnim=83842218823011,RunAnim=118320322718866,JumpAnim=109996626521204,FallAnim=95603166884636,SwimIdle=94922130551805,Swim=134530128383903,Animation1=110211186840347,Animation2=114191137265065,ClimbAnim=97824616490448},
	["Wicked Popular"] = {WalkAnim=92072849924640,RunAnim=72301599441680,JumpAnim=104325245285198,FallAnim=121152442762481,Animation1=118832222982049,ClimbAnim=131326830509784,SwimIdle=113199415118199,Swim=99384245425157,Animation2=76049494037641},
	["Elder"] = {WalkAnim=10921111375,RunAnim=10921104374,JumpAnim=10921107367,FallAnim=10921105765,SwimIdle=10921110146,Swim=10921108971,ClimbAnim=10921100400,Animation1=10921101664,Animation2=10921102574},
	["Zombie"] = {WalkAnim=10921355261,RunAnim=616163682,JumpAnim=10921351278,FallAnim=10921350320,SwimIdle=10921353442,Swim=10921352344,Animation1=10921344533,Animation2=10921345304,ClimbAnim=10921343576},
	["Mage"] = {WalkAnim=10921152678,RunAnim=10921148209,JumpAnim=10921149743,FallAnim=10921148939,SwimIdle=10921151661,Swim=10921150788,ClimbAnim=10921143404,Animation1=10921144709,Animation2=10921145797},
	["Catwalk Glam"] = {WalkAnim=109168724482748,RunAnim=81024476153754,JumpAnim=116936326516985,FallAnim=92294537340807,SwimIdle=98854111361360,Swim=134591743181628,ClimbAnim=119377220967554,Animation1=133806214992291,Animation2=94970088341563},
	["Astronaut"] = {WalkAnim=10921046031,RunAnim=10921039308,JumpAnim=10921042494,FallAnim=10921040576,SwimIdle=10921045006,Swim=10921044000,ClimbAnim=10921032124,Animation1=10921034824,Animation2=10921036806},
	['Wicked "Dancing Through Life"'] = {WalkAnim=73718308412641,RunAnim=135515454877967,JumpAnim=78508480717326,FallAnim=78147885297412,SwimIdle=129183123083281,Swim=110657013921774,ClimbAnim=129447497744818,Animation1=92849173543269,Animation2=132238900951109},
	["Werewolf"] = {WalkAnim=10921342074,RunAnim=10921336997,FallAnim=10921337907,SwimIdle=10921341319,Swim=10921340419,ClimbAnim=10921329322,Animation1=10921330408,Animation2=10921333667},
	["Superhero"] = {WalkAnim=10921298616,RunAnim=10921291831,JumpAnim=10921294559,FallAnim=10921293373,SwimIdle=10921297391,Swim=10921295495,ClimbAnim=10921286911,Animation1=10921288909,Animation2=10921290167},
	["Toy"] = {WalkAnim=10921312010,RunAnim=10921306285,JumpAnim=10921308158,FallAnim=10921307241,SwimIdle=10921310341,Swim=10921309319,ClimbAnim=10921300839,Animation1=10921301576},
	["No Boundaries"] = {WalkAnim=18747074203,RunAnim=18747070484,JumpAnim=18747069148,FallAnim=18747062535,SwimIdle=18747071682,Swim=18747073181,ClimbAnim=18747060903,Animation1=18747067405,Animation2=18747063918},
	["NFL"] = {WalkAnim=110358958299415,RunAnim=117333533048078,JumpAnim=119846112151352,FallAnim=129773241321032,SwimIdle=79090109939093,Swim=132697394189921,ClimbAnim=134630013742019,Animation1=92080889861410,Animation2=74451233229259},
	["Amazon Unboxed"] = {WalkAnim=90478085024465,RunAnim=134824450619865,JumpAnim=121454505477205,FallAnim=94788218468396,SwimIdle=129126268464847,Swim=105962919001086,ClimbAnim=121145883950231,Animation1=98281136301627},
	["Vampire"] = {WalkAnim=10921326949,RunAnim=10921320299,JumpAnim=10921322186,FallAnim=10921321317,SwimIdle=10921325443,Swim=10921324408,ClimbAnim=10921314188,Animation1=10921315373},
	["Ninja"] = {RunAnim=656118852,WalkAnim=656121766,JumpAnim=656117878,FallAnim=656115606,Swim=656119721,SwimIdle=656121397,ClimbAnim=656114359,Idle={656117400,656118341,886742569}},
	["Robot"] = {RunAnim=616091570,WalkAnim=616095330,JumpAnim=616090535,FallAnim=616087089,Swim=616092998,SwimIdle=616094091,ClimbAnim=616086039,Idle={616088211,616089559,885531463}},
	["Levitation"] = {RunAnim=616010382,WalkAnim=616013216,JumpAnim=616008936,FallAnim=616005863,Swim=616011509,SwimIdle=616012453,ClimbAnim=616003713,Idle={616006778,616008087,886862142}},
	["Stylish"] = {RunAnim=616140816,WalkAnim=616146177,JumpAnim=616139451,FallAnim=616134815,Swim=616143377,SwimIdle=616144772,ClimbAnim=616133594,Idle={616136790,616138447,886888594}},
	["Bubbly"] = {RunAnim=910025107,WalkAnim=910034870,JumpAnim=910016857,FallAnim=910001910,Swim=910028158,SwimIdle=910030921,ClimbAnim=909997997,Idle={910004836,910009958,1018536639}},
	["Cartoon"] = {RunAnim=742638842,WalkAnim=742640026,JumpAnim=742637942,FallAnim=742637151,Swim=742639220,SwimIdle=742639812,ClimbAnim=742636889,Idle={742637544,742638445,885477856}},
}
_animApplying = false
function _animWaitForAnimate(char)
	for _=1,40 do
		local a=char:FindFirstChild("Animate")
		if a and a:FindFirstChild("idle") and a:FindFirstChild("run") and a:FindFirstChild("walk") then return a end
		task.wait(0.1)
	end
	return nil
end
function _animSetAnim(obj,id)
	if not obj or not id then return end
	local sid = tostring(id)
	if not sid:find("rbxassetid://") then
		sid = "rbxassetid://" .. sid:gsub("%D", "")
	end
	pcall(function() obj.AnimationId = sid end)
end
function _animStopTracks(hum)
	if not hum then return end
	for _,t in ipairs(hum:GetPlayingAnimationTracks()) do pcall(function() t:Stop(0) end) end
end
function _animEnsure(folder,name)
	if not folder then return nil end
	local a=folder:FindFirstChild(name)
	if not a then a=Instance.new("Animation");a.Name=name;a.Parent=folder end
	return a
end
function _animPick(pack,...)
	for i=1,select("#",...) do
		local k=select(i,...);local v=pack[k];if v~=nil then return v end
	end
	return nil
end

-- Guarda las animaciones originales (normales) del personaje la primera vez
local function _animSaveOriginals(animate)
	if originalAnims or not animate then return end
	local function getId(folder, animName)
		if not folder then return nil end
		local a = folder:FindFirstChild(animName)
		return a and a.AnimationId or nil
	end
	originalAnims = {
		RunAnim   = getId(animate:FindFirstChild("run"), "RunAnim"),
		WalkAnim  = getId(animate:FindFirstChild("walk"), "WalkAnim"),
		JumpAnim  = getId(animate:FindFirstChild("jump"), "JumpAnim"),
		FallAnim  = getId(animate:FindFirstChild("fall"), "FallAnim"),
		ClimbAnim = getId(animate:FindFirstChild("climb"), "ClimbAnim"),
		Swim      = getId(animate:FindFirstChild("swim"), "Swim"),
		SwimIdle  = getId(animate:FindFirstChild("swimidle"), "SwimIdle"),
		Animation1 = getId(animate:FindFirstChild("idle"), "Animation1"),
		Animation2 = getId(animate:FindFirstChild("idle"), "Animation2"),
	}
end

-- Restaura animaciones normales (Off / Default)
local function restoreDefaultAnims(char)
	char = char or LP.Character
	if not char then return false end
	local animate = _animWaitForAnimate(char)
	if not animate then return false end
	local hum = char:FindFirstChildOfClass("Humanoid")
	_animStopTracks(hum)

	-- Si tenemos originales guardados, los usamos
	if originalAnims then
		_animSetAnim(_animEnsure(animate:FindFirstChild("run"), "RunAnim"), originalAnims.RunAnim)
		_animSetAnim(_animEnsure(animate:FindFirstChild("walk"), "WalkAnim"), originalAnims.WalkAnim)
		_animSetAnim(_animEnsure(animate:FindFirstChild("jump"), "JumpAnim"), originalAnims.JumpAnim)
		_animSetAnim(_animEnsure(animate:FindFirstChild("fall"), "FallAnim"), originalAnims.FallAnim)
		_animSetAnim(_animEnsure(animate:FindFirstChild("climb"), "ClimbAnim"), originalAnims.ClimbAnim)
		_animSetAnim(_animEnsure(animate:FindFirstChild("swim"), "Swim"), originalAnims.Swim)
		_animSetAnim(_animEnsure(animate:FindFirstChild("swimidle"), "SwimIdle"), originalAnims.SwimIdle)
		local idleFolder = animate:FindFirstChild("idle")
		if idleFolder then
			_animSetAnim(_animEnsure(idleFolder, "Animation1"), originalAnims.Animation1)
			_animSetAnim(_animEnsure(idleFolder, "Animation2"), originalAnims.Animation2)
		end
	else
		-- Fallback: IDs por defecto de Roblox R15
		local DEFAULT = {
			RunAnim = "rbxassetid://913376220",
			WalkAnim = "rbxassetid://913402848",
			JumpAnim = "rbxassetid://507765000",
			FallAnim = "rbxassetid://507767968",
			ClimbAnim = "rbxassetid://507765644",
			Swim = "rbxassetid://913384386",
			SwimIdle = "rbxassetid://913389285",
			Animation1 = "rbxassetid://507766666",
			Animation2 = "rbxassetid://507766951",
		}
		_animSetAnim(_animEnsure(animate:FindFirstChild("run"), "RunAnim"), DEFAULT.RunAnim)
		_animSetAnim(_animEnsure(animate:FindFirstChild("walk"), "WalkAnim"), DEFAULT.WalkAnim)
		_animSetAnim(_animEnsure(animate:FindFirstChild("jump"), "JumpAnim"), DEFAULT.JumpAnim)
		_animSetAnim(_animEnsure(animate:FindFirstChild("fall"), "FallAnim"), DEFAULT.FallAnim)
		_animSetAnim(_animEnsure(animate:FindFirstChild("climb"), "ClimbAnim"), DEFAULT.ClimbAnim)
		_animSetAnim(_animEnsure(animate:FindFirstChild("swim"), "Swim"), DEFAULT.Swim)
		_animSetAnim(_animEnsure(animate:FindFirstChild("swimidle"), "SwimIdle"), DEFAULT.SwimIdle)
		local idleFolder = animate:FindFirstChild("idle")
		if idleFolder then
			_animSetAnim(_animEnsure(idleFolder, "Animation1"), DEFAULT.Animation1)
			_animSetAnim(_animEnsure(idleFolder, "Animation2"), DEFAULT.Animation2)
		end
	end

	animate.Disabled = true
	task.wait(0.08)
	animate.Disabled = false
	if hum then
		pcall(function()
			hum:ChangeState(Enum.HumanoidStateType.Landed)
			task.wait(0.04)
			hum:ChangeState(Enum.HumanoidStateType.Running)
		end)
	end
	return true
end

function applyAnimationPack(packName)
	if _animApplying then return false end
	_animApplying = true

	-- Off / Normal / Default â†’ volver a animaciones normales
	if packName == nil or packName == "" or packName == "Off" or packName == "Normal" or packName == "Default" then
		local ok = pcall(restoreDefaultAnims)
		currentAnimPack = nil
		_animApplying = false
		return ok
	end

	local pack = ANIM_PACKS[packName]
	if not pack then _animApplying = false; return false end

	local okApply = pcall(function()
		local char = LP.Character
		if not char then
			char = LP.CharacterAdded:Wait()
		end
		local animate = _animWaitForAnimate(char)
		if not animate then return end

		-- Guardar originales antes de aplicar el primer pack
		_animSaveOriginals(animate)

		local hum = char:FindFirstChildOfClass("Humanoid")
		_animStopTracks(hum)
		_animSetAnim(_animEnsure(animate:FindFirstChild("run"),"RunAnim"),   _animPick(pack,"RunAnim","Run"))
		_animSetAnim(_animEnsure(animate:FindFirstChild("walk"),"WalkAnim"), _animPick(pack,"WalkAnim","Walk"))
		_animSetAnim(_animEnsure(animate:FindFirstChild("jump"),"JumpAnim"), _animPick(pack,"JumpAnim","Jump"))
		_animSetAnim(_animEnsure(animate:FindFirstChild("fall"),"FallAnim"), _animPick(pack,"FallAnim","Fall"))
		_animSetAnim(_animEnsure(animate:FindFirstChild("climb"),"ClimbAnim"),_animPick(pack,"ClimbAnim","Climb"))
		_animSetAnim(_animEnsure(animate:FindFirstChild("swim"),"Swim"),      _animPick(pack,"Swim"))
		_animSetAnim(_animEnsure(animate:FindFirstChild("swimidle"),"SwimIdle"),_animPick(pack,"SwimIdle") or _animPick(pack,"Swim"))
		local idleFolder = animate:FindFirstChild("idle")
		if idleFolder then
			local a1 = _animPick(pack,"Animation1"); local a2 = _animPick(pack,"Animation2")
			if a1 or a2 then
				local id1 = a1 or a2; local id2 = a2 or a1 or id1
				local s1 = idleFolder:FindFirstChild("Animation1"); if not s1 then s1 = Instance.new("Animation"); s1.Name = "Animation1"; s1.Parent = idleFolder end
				local s2 = idleFolder:FindFirstChild("Animation2"); if not s2 then s2 = Instance.new("Animation"); s2.Name = "Animation2"; s2.Parent = idleFolder end
				_animSetAnim(s1, id1); _animSetAnim(s2, id2)
			elseif pack.Idle and #pack.Idle > 0 then
				for i = 1, math.max(2, #pack.Idle) do
					local s = idleFolder:FindFirstChild("Animation"..i); if not s then s = Instance.new("Animation"); s.Name = "Animation"..i; s.Parent = idleFolder end
					if pack.Idle[i] then _animSetAnim(s, pack.Idle[i]) end
				end
			end
		end
		animate.Disabled = true
		task.wait(0.08)
		animate.Disabled = false
		if hum then
			pcall(function()
				hum:ChangeState(Enum.HumanoidStateType.Landed)
				task.wait(0.04)
				hum:ChangeState(Enum.HumanoidStateType.Running)
			end)
		end
	end)
	currentAnimPack = packName
	_animApplying = false
	return okApply and true or false
end

-- re-apply pack after respawn (o restaurar normales si estÃ¡ en Off)
pcall(function()
	LP.CharacterAdded:Connect(function()
		task.delay(0.8, function()
			if currentAnimPack and ANIM_PACKS[currentAnimPack] then
				pcall(applyAnimationPack, currentAnimPack)
			elseif currentAnimPack == nil or currentAnimPack == "Off" then
				-- no forzar pack; dejar animaciones por defecto del juego
			end
		end)
	end)
end)

_G.NIGHT_applyAnimationPack = applyAnimationPack
_G.NIGHT_restoreDefaultAnims = restoreDefaultAnims
_G.NIGHT_getCurrentAnimPack = function() return currentAnimPack end
_G.NIGHT_setCurrentAnimPack = function(n) currentAnimPack = n end
end)()


-- ============================================================
-- Pack Accessory (Bleed 1/2/3) â€“ tomado de VisDuels
-- ============================================================
;(function()
	_G.NIGHT_OriginalOutfit = _G.NIGHT_OriginalOutfit or {shirt = nil, pants = nil}
	_G.NIGHT_OriginalAccessories = _G.NIGHT_OriginalAccessories or {}

	local ACCESSORY_PACK_ORDER = {"Off", "Bleed 1", "Bleed 2", "Bleed 3"}
	local currentAccessoryPack = "Off"

	local BLEED_PACKS = {
		["Bleed 1"] = {
			accessory   = 306969564,
			offset      = Vector3.new(0, 0.3, 0),
			headMesh    = "http://www.roblox.com/asset/?id=134079402",
			headTexture = "http://www.roblox.com/asset/?id=133940918",
			shirt       = "http://www.roblox.com/asset/?id=10632503795",
			pants       = "http://www.roblox.com/asset/?id=123161592384863",
			korblox     = "right",
		},
		["Bleed 2"] = {
			accessory   = 1744060292,
			offset      = Vector3.new(0, 1.4, -0.2),
			headMesh    = "http://www.roblox.com/asset/?id=134079402",
			headTexture = "http://www.roblox.com/asset/?id=133940918",
			shirt       = "http://www.roblox.com/asset/?id=11526718530",
			pants       = "http://www.roblox.com/asset/?id=93710523210027",
			korblox     = "right",
		},
		["Bleed 3"] = {
			accessory   = 112564966849233,
			offset      = Vector3.new(0, 0.6, 0),
			headMesh    = "http://www.roblox.com/asset/?id=134079402",
			headTexture = "http://www.roblox.com/asset/?id=133940918",
			shirt       = "http://www.roblox.com/asset/?id=11849088376",
			pants       = "http://www.roblox.com/asset/?id=16534673928",
			korblox     = "right",
		},
	}

	local function saveOriginalOutfit(char)
		if not char then return end
		local shirt = char:FindFirstChildWhichIsA("Shirt")
		local pants = char:FindFirstChildWhichIsA("Pants")
		_G.NIGHT_OriginalOutfit.shirt = shirt and shirt.ShirtTemplate or nil
		_G.NIGHT_OriginalOutfit.pants = pants and pants.PantsTemplate or nil
	end

	local function restoreOriginalOutfit(char)
		if not char then return end
		for _, obj in ipairs(char:GetChildren()) do
			if obj:IsA("Shirt") or obj:IsA("Pants") then obj:Destroy() end
		end
		if _G.NIGHT_OriginalOutfit.shirt then
			local s = Instance.new("Shirt"); s.ShirtTemplate = _G.NIGHT_OriginalOutfit.shirt; s.Parent = char
		end
		if _G.NIGHT_OriginalOutfit.pants then
			local p = Instance.new("Pants"); p.PantsTemplate = _G.NIGHT_OriginalOutfit.pants; p.Parent = char
		end
	end

	local function clearAllOutfit(char)
		if not char then return end
		for _, obj in ipairs(char:GetChildren()) do
			if obj:IsA("Shirt") or obj:IsA("Pants") then obj:Destroy() end
		end
	end

	local function saveOriginalAccessories(char)
		_G.NIGHT_OriginalAccessories = {}
		if not char then return end
		for _, child in ipairs(char:GetChildren()) do
			if child:IsA("Accessory") or child:IsA("Hat") then
				table.insert(_G.NIGHT_OriginalAccessories, child:Clone())
			end
		end
	end

	local function restoreOriginalAccessories(char)
		if not char then return end
		for _, child in ipairs(char:GetChildren()) do
			if child:IsA("Accessory") or child:IsA("Hat") or child.Name == "AuFfitAccessory" then
				child:Destroy()
			end
		end
		for _, clone in ipairs(_G.NIGHT_OriginalAccessories) do
			if clone and clone.Parent == nil then
				clone:Clone().Parent = char
			end
		end
		_G.NIGHT_OriginalAccessories = {}
	end

	local function clearAllAccessories(char)
		if not char then return end
		for _, child in ipairs(char:GetChildren()) do
			if child:IsA("Accessory") or child:IsA("Hat") or child.Name == "AuFfitAccessory" then
				child:Destroy()
			end
			if child.Name:find("Korblox_") or child.Name:find("Headless_") then
				child:Destroy()
			end
		end
		for _, partName in ipairs({"Head","LeftUpperLeg","LeftLowerLeg","LeftFoot","RightUpperLeg","RightLowerLeg","RightFoot"}) do
			local part = char:FindFirstChild(partName)
			if part and part:IsA("BasePart") then part.Transparency = 0 end
		end
	end

	local function applyBleedOutfit(packName)
		local config = BLEED_PACKS[packName]
		if not config then return false end
		local char = LP.Character
		if not char then return false end
		char:WaitForChild("Head", 10)
		local head = char:FindFirstChild("Head")
		if not head then return false end

		if config.headMesh then
			for _, d in ipairs(char:GetChildren()) do
				if d:IsA("CharacterMesh") and d.BodyPart == Enum.BodyPart.Head then
					pcall(function() d:Destroy() end)
				end
			end
			local done = false
			if head:IsA("MeshPart") then
				done = pcall(function()
					head.MeshId = config.headMesh
					if config.headTexture then head.TextureID = config.headTexture end
				end)
			end
			if not done then
				local sm = head:FindFirstChildWhichIsA("SpecialMesh") or Instance.new("SpecialMesh")
				sm.Parent = head
				sm.MeshType = Enum.MeshType.FileMesh
				sm.MeshId = config.headMesh
				sm.TextureId = config.headTexture or ""
			end
		end

		if config.shirt then
			local s = char:FindFirstChildWhichIsA("Shirt") or Instance.new("Shirt")
			s.Name = "Shirt"; s.ShirtTemplate = config.shirt; s.Parent = char
		end
		if config.pants then
			local p = char:FindFirstChildWhichIsA("Pants") or Instance.new("Pants")
			p.Name = "Pants"; p.PantsTemplate = config.pants; p.Parent = char
		end

		if config.accessory and head then
			local old = char:FindFirstChild("AuFfitAccessory")
			if old then old:Destroy() end
			local objs
			local ok, res = pcall(function()
				return game:GetObjects("rbxassetid://" .. tostring(config.accessory))
			end)
			if ok and type(res) == "table" and #res > 0 then
				objs = res
			else
				ok, res = pcall(function()
					return game:GetService("InsertService"):LoadAsset(config.accessory)
				end)
				if ok and res then objs = {res} end
			end
			if objs then
				local handle
				for _, o in ipairs(objs) do
					if o:IsA("BasePart") then handle = o; break end
					local f = o:FindFirstChildWhichIsA("BasePart", true)
					if f then handle = f; break end
				end
				if handle then
					local h = handle:Clone()
					h.Name = "AuFfitAccessory"
					h.CanCollide = false
					h.Anchored = false
					h.Massless = true
					h.Parent = char
					local weld = Instance.new("Weld")
					weld.Part0 = head
					weld.Part1 = h
					weld.C0 = CFrame.new(config.offset or Vector3.zero)
					weld.Parent = h
				end
				for _, o in ipairs(objs) do pcall(function() o:Destroy() end) end
			end
		end

		if config.korblox and config.korblox ~= "none" then
			local function attachKorblox(side)
				local ids = { left = 139607673, right = 139607718 }
				local targets = { left = "LeftUpperLeg", right = "RightUpperLeg" }
				local hides = {
					left  = {"LeftUpperLeg","LeftLowerLeg","LeftFoot"},
					right = {"RightUpperLeg","RightLowerLeg","RightFoot"}
				}
				local targetPart = char:FindFirstChild(targets[side])
				if not targetPart then return false end
				for _, partName in ipairs(hides[side]) do
					local limb = char:FindFirstChild(partName)
					if limb and limb:IsA("BasePart") then limb.Transparency = 1 end
				end
				local success, objects = pcall(function()
					return game:GetObjects("rbxassetid://" .. ids[side])
				end)
				if not success or not objects or #objects == 0 then return false end
				local assetModel = objects[1]
				local mainMesh = assetModel:IsA("BasePart") and assetModel or assetModel:FindFirstChildWhichIsA("BasePart", true)
				if not mainMesh then assetModel:Destroy(); return false end
				mainMesh.CanCollide = false
				mainMesh.Massless = true
				mainMesh.CFrame = targetPart.CFrame
				local weld = Instance.new("WeldConstraint")
				weld.Part0 = targetPart
				weld.Part1 = mainMesh
				weld.Parent = mainMesh
				assetModel.Parent = char
				return true
			end
			if config.korblox == "left" then attachKorblox("left")
			elseif config.korblox == "right" then attachKorblox("right") end
		end
		return true
	end

	local function applyAccessoryPack(packName)
		local char = LP.Character
		if not char then return end
		currentAccessoryPack = packName or "Off"
		if packName == "Off" then
			clearAllAccessories(char)
			restoreOriginalOutfit(char)
			restoreOriginalAccessories(char)
			return
		end
		if not _G.NIGHT_OriginalOutfit.shirt and not _G.NIGHT_OriginalOutfit.pants then
			saveOriginalOutfit(char)
		end
		if #_G.NIGHT_OriginalAccessories == 0 then
			saveOriginalAccessories(char)
		end
		clearAllOutfit(char)
		clearAllAccessories(char)
		applyBleedOutfit(packName)
	end

	_G.NIGHT_applyAccessoryPack = applyAccessoryPack
	_G.NIGHT_getCurrentAccessoryPack = function() return currentAccessoryPack end
	_G.NIGHT_setCurrentAccessoryPack = function(n) currentAccessoryPack = n end
	_G.NIGHT_ACCESSORY_PACK_ORDER = ACCESSORY_PACK_ORDER

	pcall(function()
		LP.CharacterAdded:Connect(function()
			task.delay(1.0, function()
				if currentAccessoryPack and currentAccessoryPack ~= "Off" then
					pcall(applyAccessoryPack, currentAccessoryPack)
				end
			end)
		end)
	end)
end)()


-- Anti Die system (isolated, no discord on billboard)
;(function()
	local Players = game:GetService("Players")
	local RunService = game:GetService("RunService")
	local Workspace = game:GetService("Workspace")
	local LP = Players.LocalPlayer
	local enabled = false
	local heartConn, charAddedConn = nil, nil
	local deathConns = {}
	local billboardGui, billboardFrame, billboardUpdater = nil, nil, nil

	local function destroyBillboard()
		if billboardUpdater then pcall(function() billboardUpdater:Disconnect() end); billboardUpdater = nil end
		if billboardGui then pcall(function() billboardGui:Destroy() end); billboardGui = nil end
		billboardFrame = nil
	end

	local function createBillboard(char)
		if not char then return end
		local head = char:FindFirstChild("Head")
		if not head then return end
		destroyBillboard()
		billboardGui = Instance.new("ScreenGui")
		billboardGui.Name = "NightAntiDieBillboard"
		billboardGui.ResetOnSpawn = false
		billboardGui.IgnoreGuiInset = true
		pcall(function() billboardGui.Parent = game:GetService("CoreGui") end)
		if not billboardGui.Parent then
			billboardGui.Parent = LP:FindFirstChildOfClass("PlayerGui") or LP:WaitForChild("PlayerGui")
		end
		billboardFrame = Instance.new("Frame", billboardGui)
		billboardFrame.Size = UDim2.new(0, 160, 0, 36)
		billboardFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		billboardFrame.BackgroundTransparency = 0.3
		billboardFrame.BorderSizePixel = 0
		Instance.new("UICorner", billboardFrame).CornerRadius = UDim.new(0, 8)
		local txt1 = Instance.new("TextLabel", billboardFrame)
		txt1.Size = UDim2.new(1, 0, 1, 0)
		txt1.BackgroundTransparency = 1
		txt1.Text = "ANTI DIE"
		txt1.TextColor3 = Color3.fromRGB(255, 255, 255)
		txt1.Font = Enum.Font.GothamBlack
		txt1.TextSize = 18
		txt1.TextXAlignment = Enum.TextXAlignment.Center
		txt1.TextYAlignment = Enum.TextYAlignment.Center
		local camera = Workspace.CurrentCamera
		billboardUpdater = RunService.Heartbeat:Connect(function()
			if not billboardGui or not billboardGui.Parent then return end
			if not head or not head.Parent then billboardFrame.Visible = false; return end
			local pos, onScreen = camera:WorldToScreenPoint(head.Position)
			if onScreen then
				billboardFrame.Position = UDim2.new(0, pos.X - 80, 0, pos.Y - 40)
				billboardFrame.Visible = true
			else
				billboardFrame.Visible = false
			end
		end)
	end

	local function protectChar(char)
		if not char then return end
		local hum = char:WaitForChild("Humanoid", 5)
		if not hum then return end
		hum.MaxHealth = math.huge
		hum.Health = math.huge
		table.insert(deathConns, hum.StateChanged:Connect(function(_, new)
			if not enabled then return end
			if new == Enum.HumanoidStateType.Dead then
				hum.Health = math.huge
				hum:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
			end
		end))
		hum:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
		table.insert(deathConns, hum:GetPropertyChangedSignal("Health"):Connect(function()
			if not enabled then return end
			if hum.Health < hum.MaxHealth then hum.Health = math.huge end
		end))
		if heartConn then heartConn:Disconnect() end
		heartConn = RunService.Heartbeat:Connect(function()
			if not enabled then return end
			if hum and hum.Parent and hum.Health < hum.MaxHealth then hum.Health = math.huge end
		end)
		createBillboard(char)
	end

	local function startProtect()
		for _, c in ipairs(deathConns) do pcall(function() c:Disconnect() end) end
		deathConns = {}
		if heartConn then heartConn:Disconnect(); heartConn = nil end
		if charAddedConn then charAddedConn:Disconnect(); charAddedConn = nil end
		protectChar(LP.Character)
		charAddedConn = LP.CharacterAdded:Connect(function(c)
			if not enabled then return end
			task.wait(0.1)
			for _, c2 in ipairs(deathConns) do pcall(function() c2:Disconnect() end) end
			deathConns = {}
			protectChar(c)
		end)
	end

	local function stopProtect()
		for _, c in ipairs(deathConns) do pcall(function() c:Disconnect() end) end
		deathConns = {}
		if heartConn then heartConn:Disconnect(); heartConn = nil end
		if charAddedConn then charAddedConn:Disconnect(); charAddedConn = nil end
		destroyBillboard()
		local char = LP.Character
		if char then
			local hum = char:FindFirstChildOfClass("Humanoid")
			if hum then
				hum:SetStateEnabled(Enum.HumanoidStateType.Dead, true)
				hum.MaxHealth = 100
				hum.Health = math.min(hum.Health, 100)
			end
		end
	end

	_G.NIGHT_setAntiDie = function(on)
		enabled = on and true or false
		if enabled then startProtect() else stopProtect() end
	end
	_G.NIGHT_getAntiDie = function() return enabled end
end)()


-- Music packs (Chocolate + hub songs)
;(function()
	local SoundService = game:GetService("SoundService")
	local current = nil
	local sound = nil
	local PACKS = {
		["Tryhard"] = {id = "rbxassetid://137188221417776", vol = 0.7},
		["Tryhard 2"] = {id = "rbxassetid://77142753938657", vol = 0.7},
		["Tryhard Def"] = {id = "rbxassetid://75196377290071", vol = 0.7},
		["XD"] = {id = "rbxassetid://90813223538688", vol = 0.7},
		["67"] = {id = "rbxassetid://98859392001383", vol = 0.7},
		["3AM"] = {id = "rbxassetid://73755162651548", vol = 0.7},
		["Beretta"] = {id = "rbxassetid://94281718874647", vol = 0.7},
		["Brasil"] = {id = "rbxassetid://91225667489242", vol = 0.7},
		["Brasil 2"] = {id = "rbxassetid://135750430892149", vol = 0.7},
		["Migizin"] = {id = "rbxassetid://91630262633548", vol = 0.7},
	}
	local NAMES = {"Off","Tryhard","Tryhard 2","Tryhard Def","XD","67","3AM","Beretta","Brasil","Brasil 2","Migizin"}

	local function stop()
		if sound then
			pcall(function() sound:Stop(); sound:Destroy() end)
			sound = nil
		end
	end

	local function play(name)
		stop()
		current = name
		if not name or name == "Off" then return end
		local pack = PACKS[name]
		if not pack then return end
		pcall(function()
			local parent = SoundService
			pcall(function() if gethui then parent = gethui() end end)
			local s = Instance.new("Sound")
			s.Name = "NightMusic_" .. tostring(name):gsub("%s","_")
			s.SoundId = pack.id
			s.Volume = pack.vol or 0.7
			s.Looped = true
			s.Parent = parent
			s:Play()
			sound = s
		end)
	end

	local function cycle()
		local idx = 1
		for i, n in ipairs(NAMES) do
			if n == current then idx = i; break end
		end
		idx = idx % #NAMES + 1
		play(NAMES[idx])
		return NAMES[idx]
	end

	_G.NIGHT_musicPlay = play
	_G.NIGHT_musicStop = stop
	_G.NIGHT_musicCycle = cycle
	_G.NIGHT_musicGet = function() return current or "Off" end
	_G.NIGHT_musicNames = NAMES
end)()


-- Dual keybind helper (outside main IIFE to save locals)
_G.NIGHT_rowDualKB = function(baseCard, cLabel, WHITE, DIM, KB_BG, INPUT_TRANSPARENCY, BORDER, UIS, TweenService, State, tabName, label, kbEntry)
	local c = baseCard(tabName, 48)
	local titleLabel = cLabel(c, label, 10, 120, 11, WHITE, Enum.Font.GothamBold)
	titleLabel.Position = UDim2.new(0, 10, 0.5, -8)
	local function makeHalf(isPad)
		local b = Instance.new("TextButton", c)
		b.Size = UDim2.new(0, 52, 0, 22)
		b.BackgroundColor3 = KB_BG
		b.BackgroundTransparency = INPUT_TRANSPARENCY
		b.BorderSizePixel = 0
		b.TextColor3 = WHITE
		b.Font = Enum.Font.GothamBold
		b.TextSize = 8
		b.ZIndex = 11
		Instance.new("UICorner", b).CornerRadius = UDim.new(0, 8)
		local bs = Instance.new("UIStroke", b); bs.Color = BORDER; bs.Thickness = 1
		local function refresh()
			if isPad then
				b.Text = kbEntry.gp and ("GP:" .. kbEntry.gp.Name) or "Pad"
			else
				b.Text = kbEntry.kb and kbEntry.kb.Name or "PC"
			end
		end
		refresh()
		local li, lc = false, nil
		b.MouseButton1Click:Connect(function()
			if li then
				li = false; _anyKeyListening = false
				if lc then lc:Disconnect(); lc = nil end
				refresh(); b.TextColor3 = WHITE
				return
			end
			li = true; _anyKeyListening = true
			b.Text = "Â·Â·Â·"; b.TextColor3 = DIM
			lc = UIS.InputBegan:Connect(function(inp)
				if not li then return end
				local isKb = inp.UserInputType == Enum.UserInputType.Keyboard
				local isGp = string.sub(inp.UserInputType.Name, 1, 7) == "Gamepad"
				if not isKb and not isGp then return end
				if inp.KeyCode == Enum.KeyCode.Escape then
					li = false; _anyKeyListening = false
					if lc then lc:Disconnect(); lc = nil end
					refresh(); b.TextColor3 = WHITE
					return
				end
				if isPad then kbEntry.gp = inp.KeyCode else kbEntry.kb = inp.KeyCode end
				li = false; _anyKeyListening = false
				if lc then lc:Disconnect(); lc = nil end
				refresh(); b.TextColor3 = WHITE
				if State.requestConfigSave then State.requestConfigSave() end
			end)
		end)
		return b
	end
	local pcBtn = makeHalf(false)
	pcBtn.Position = UDim2.new(1, -114, 0.5, -11)
	local padBtn = makeHalf(true)
	padBtn.Position = UDim2.new(1, -58, 0.5, -11)
end


-- Skins + Medusa Reset (isolated)
;(function()
	local Players = game:GetService("Players")
	local LP = Players.LocalPlayer
	local current = "Off"
	local medusaOn = false
	local medusaBusy = false
	local medusaConns = {}
	local medusaCharConn = nil
	local resetFn = nil

	_G.NIGHT_registerInstaReset = function(fn) resetFn = fn end

	local function clearAccessories()
		local char = LP.Character
		if not char then return end
		for _, child in ipairs(char:GetChildren()) do
			if child.Name:find("Korblox_") or child.Name:find("Headless_") then
				pcall(function() child:Destroy() end)
			end
		end
		for _, partName in ipairs({"Head", "RightUpperLeg", "RightLowerLeg", "RightFoot"}) do
			local part = char:FindFirstChild(partName)
			if part and part:IsA("BasePart") then part.Transparency = 0 end
		end
	end

	local function attachKorblox()
		local char = LP.Character
		if not char then return end
		local targetPart = char:FindFirstChild("RightUpperLeg")
		if not targetPart then return end
		local old = char:FindFirstChild("Korblox_RightLeg")
		if old then old:Destroy() end
		for _, n in ipairs({"RightUpperLeg", "RightLowerLeg", "RightFoot"}) do
			local limb = char:FindFirstChild(n)
			if limb and limb:IsA("BasePart") then limb.Transparency = 1 end
		end
		local ok, objects = pcall(function() return game:GetObjects("rbxassetid://139607718") end)
		if not ok or not objects or #objects == 0 then return end
		local assetModel = objects[1]
		assetModel.Name = "Korblox_RightLeg"
		local mainMesh = assetModel:IsA("BasePart") and assetModel or assetModel:FindFirstChildWhichIsA("BasePart", true)
		if not mainMesh then return end
		mainMesh.CanCollide = false
		mainMesh.CFrame = targetPart.CFrame
		local weld = Instance.new("WeldConstraint")
		weld.Part0 = targetPart
		weld.Part1 = mainMesh
		weld.Parent = mainMesh
		assetModel.Parent = char
	end

	local function attachHeadless()
		local char = LP.Character
		if not char then return end
		local targetPart = char:FindFirstChild("Head")
		if not targetPart then return end
		local old = char:FindFirstChild("Headless_Headless")
		if old then old:Destroy() end
		targetPart.Transparency = 1
		local ok, objects = pcall(function() return game:GetObjects("rbxassetid://134082579") end)
		if not ok or not objects or #objects == 0 then return end
		local assetModel = objects[1]
		assetModel.Name = "Headless_Headless"
		local mainMesh = assetModel:IsA("BasePart") and assetModel or assetModel:FindFirstChildWhichIsA("BasePart", true)
		if not mainMesh then return end
		mainMesh.CanCollide = false
		mainMesh.CFrame = targetPart.CFrame
		local weld = Instance.new("WeldConstraint")
		weld.Part0 = targetPart
		weld.Part1 = mainMesh
		weld.Parent = mainMesh
		assetModel.Parent = char
	end

	local function applySkin(packName)
		current = packName or "Off"
		clearAccessories()
		if current == "Korblox" or current == "Both" then pcall(attachKorblox) end
		if current == "Headless" or current == "Both" then pcall(attachHeadless) end
	end

	_G.NIGHT_applySkin = applySkin
	_G.NIGHT_getSkin = function() return current end

	LP.CharacterAdded:Connect(function()
		task.delay(0.45, function()
			if current and current ~= "Off" then pcall(applySkin, current) end
		end)
	end)

	local function clearMedusa()
		for _, c in ipairs(medusaConns) do pcall(function() c:Disconnect() end) end
		medusaConns = {}
	end

	local function tryReset()
		if not medusaOn or medusaBusy then return end
		medusaBusy = true
		task.spawn(function()
			if resetFn then pcall(resetFn) end
			task.wait(1.1)
			medusaBusy = false
		end)
	end

	local function watchPart(part)
		if not part or not part:IsA("BasePart") then return end
		table.insert(medusaConns, part:GetPropertyChangedSignal("Anchored"):Connect(function()
			if not medusaOn then return end
			if part.Anchored and part.Transparency == 1 then
				tryReset()
			end
		end))
	end

	local function watchChar(char)
		clearMedusa()
		if not char then return end
		for _, part in ipairs(char:GetDescendants()) do
			if part:IsA("BasePart") then watchPart(part) end
		end
		table.insert(medusaConns, char.DescendantAdded:Connect(function(part)
			if part:IsA("BasePart") then watchPart(part) end
		end))
	end

	_G.NIGHT_setMedusaReset = function(on)
		medusaOn = on and true or false
		if medusaOn then
			if not medusaCharConn then
				medusaCharConn = LP.CharacterAdded:Connect(watchChar)
			end
			if LP.Character then watchChar(LP.Character) end
		else
			clearMedusa()
		end
	end
	_G.NIGHT_getMedusaReset = function() return medusaOn end
end)()

-- SECCIÃ“N 4: VARIABLES GLOBALES Y STATE
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local LP = Players.LocalPlayer

;(function()
local NS, CS, LS, LS2 = 60, 30, 15, 24.5

local laggerPhase = 0

ninoTimeEnabled = false
ninoTimerGuiBB = nil
ninoTimerText = nil
ninoStunActive = false
ninoStunStartTime = 0
ninoStunDuration = 3.0
ninoStunConnection = nil
ninoStateChangedConnection = nil
ninoLastDisplayedSecond = nil
setNinoTimeVisual = nil

function ninoCreateBillboard()
	if ninoTimerGuiBB then return end
	local char = LP.Character
	if not char then return end
	local head = char:FindFirstChild("Head")
	if not head then return end
	ninoTimerGuiBB = Instance.new("BillboardGui")
	ninoTimerGuiBB.Name = "NinoTimeBB"
	ninoTimerGuiBB.Adornee = head
	ninoTimerGuiBB.Size = UDim2.new(0, 120, 0, 36)
	ninoTimerGuiBB.StudsOffset = Vector3.new(0, 3.5, 0)
	ninoTimerGuiBB.AlwaysOnTop = true
	ninoTimerGuiBB.Parent = game:GetService("CoreGui")
	ninoTimerText = Instance.new("TextLabel", ninoTimerGuiBB)
	ninoTimerText.Size = UDim2.new(1, 0, 1, 0)
	ninoTimerText.BackgroundTransparency = 1
	ninoTimerText.Text = "READY!!"
	ninoTimerText.TextColor3 = Color3.fromRGB(45,180,90)
	ninoTimerText.Font = Enum.Font.GothamBlack
	ninoTimerText.TextSize = 20
	ninoTimerText.TextStrokeTransparency = 0.5
	ninoTimerText.TextStrokeColor3 = Color3.fromRGB(0,0,0)
	ninoTimerText.TextXAlignment = Enum.TextXAlignment.Center
	ninoTimerText.TextYAlignment = Enum.TextYAlignment.Center
end

function ninoUpdateDisplay()
	if not ninoTimerText then return end
	if not ninoStunActive then
		ninoTimerText.Text = "READY!!"
		ninoTimerText.TextColor3 = Color3.fromRGB(45,180,90)
		ninoTimerText.TextSize = 20
		if ninoTimerGuiBB then ninoTimerGuiBB.Enabled = ninoTimeEnabled end
		return
	end
	local elapsed = tick() - ninoStunStartTime
	local remaining = math.max(0, ninoStunDuration - elapsed)
	if remaining <= 0 then
		ninoStunActive = false
		if ninoStunConnection then ninoStunConnection:Disconnect(); ninoStunConnection = nil end
		ninoTimerText.Text = "READY!!"
		ninoTimerText.TextColor3 = Color3.fromRGB(45,180,90)
		ninoTimerText.TextSize = 20
		if ninoTimerGuiBB then ninoTimerGuiBB.Enabled = true end
		return
	end
	local second = math.ceil(remaining)
	if second ~= ninoLastDisplayedSecond then
		ninoLastDisplayedSecond = second
		ninoTimerText.Text = tostring(second)
		ninoTimerText.TextSize = 32
		if second == 3 then ninoTimerText.TextColor3 = Color3.fromRGB(72,28,115)
		elseif second == 2 then ninoTimerText.TextColor3 = Color3.fromRGB(45,180,90)
		elseif second == 1 then ninoTimerText.TextColor3 = Color3.fromRGB(170,95,235) end
	end
	if ninoTimerGuiBB then ninoTimerGuiBB.Enabled = true end
end

function ninoOnStunDetected()
	if not ninoTimeEnabled then return end
	if ninoStunActive then return end
	ninoStunActive = true
	ninoStunStartTime = tick()
	ninoLastDisplayedSecond = nil
	ninoCreateBillboard()
	ninoUpdateDisplay()
	if ninoStunConnection then ninoStunConnection:Disconnect() end
	ninoStunConnection = RunService.Heartbeat:Connect(ninoUpdateDisplay)
end

function ninoSetupDetection(char)
	if ninoStateChangedConnection then ninoStateChangedConnection:Disconnect() end
	local hum = char and char:FindFirstChildOfClass("Humanoid")
	if not hum then return end
	ninoStateChangedConnection = hum.StateChanged:Connect(function(_, newState)
		if not ninoTimeEnabled then return end
		local isStunned = (newState == Enum.HumanoidStateType.Physics or
		                   newState == Enum.HumanoidStateType.Ragdoll or
		                   newState == Enum.HumanoidStateType.FallingDown)
		if isStunned then ninoOnStunDetected() end
	end)
end

function setNinoTime(enabled)
	ninoTimeEnabled = enabled
	if setNinoTimeVisual then setNinoTimeVisual(enabled) end
	if not enabled then
		if ninoStunConnection then ninoStunConnection:Disconnect(); ninoStunConnection = nil end
		ninoStunActive = false
		if ninoTimerGuiBB then ninoTimerGuiBB.Enabled = false end
		if ninoStateChangedConnection then ninoStateChangedConnection:Disconnect(); ninoStateChangedConnection = nil end
	else
		ninoCreateBillboard()
		local char = LP.Character
		if char then
			local hum = char:FindFirstChildOfClass("Humanoid")
			if hum then
				local st = hum:GetState()
				if st == Enum.HumanoidStateType.Physics or st == Enum.HumanoidStateType.Ragdoll then ninoOnStunDetected() end
			end
			ninoSetupDetection(char)
		end
	end
end
local State = {
	speedToggled = false, laggerToggled = false, autoBatToggled = false,
	speedProfile = "Normal",
	profileLaggerNormalSpeed = 40,
	profileLaggerCarrySpeed = 20,
	hittingCooldown = false, infJumpEnabled = false,
	antiRagdollEnabled = false, fpsBoostEnabled = false,
	antiLagEnabled = false,
	guiVisible = true,
	noIntro = (((getgenv and getgenv()) or _G).__CRYON_NO_INTRO_SAVED == true),
	introEnabled = (((getgenv and getgenv()) or _G).__CRYON_NO_INTRO_SAVED ~= true), selectedIntroMusic = 1,
	isStealing = false, stealStartTime = nil, lastStealTick = 0,
	lastKnownHealth = 100,
	dropActive = false,
	dropBrainrotActive = false,
	autoLeftEnabled = false, autoRightEnabled = false,
	tpBatEnabled = false,
	unwalkEnabled = false,
	stretchRezEnabled = false, removeAccessoriesEnabled = false,
	darkModeEnabled = false, skyStyle = "Off",
	backgroundAssetId = "139887397490573",
	backgroundAssetIds = {
		"119466264281320",
		"108199149509537",
		"121087678749100",
		"98596557474777",
		"124833425021074",
		"93357962442247",
		"137732510773181",
	},
	imageChoiceVisuals = {},
	buttonImages = {}, -- name -> assetId string ("" = none)
    dropConn = nil,
    dropBrainrotConn = nil,
    autoCarryEnabled = true,
    batV1Speed = 60,
    batV2Speed = 60,
}

local _anyKeyListening, uiLocked = false, false
local setLockUIVisual, MobilePanel, rebuildMobileButtons, resetMobileButtons
local autoSavePositions = function() end
local mobilePanelStyle = "darkhub"
local mobileBtnFrames, mobileBtnActive, allMobileBtns = {}, {}, {}
local mobileButtonsByName = {}
local mobileButtonDefaultPositions = {}
local BTN_POSITIONS_DH = {
	Drop       = UDim2.new(1, -298, 1, -334),
	AutoLeft   = UDim2.new(1, -144, 1, -334),
	AutoBat    = UDim2.new(1, -298, 1, -270),
	AutoRight  = UDim2.new(1, -144, 1, -270),
	TPDown     = UDim2.new(1, -298, 1, -206),
	Speed      = UDim2.new(1, -144, 1, -206),
	Lagger     = UDim2.new(1, -144, 1, -142),
}

local KB = {
	AutoLeft  = {kb = Enum.KeyCode.Z,           gp = nil},
	AutoRight = {kb = Enum.KeyCode.C,           gp = nil},
	Drop      = {kb = Enum.KeyCode.X,           gp = nil},
	TPDown    = {kb = Enum.KeyCode.F,           gp = nil},
	AutoBat   = {kb = Enum.KeyCode.E,           gp = nil},
	AutoBatV2 = {kb = nil,                      gp = nil},
	TPBat     = {kb = nil,                      gp = nil},
	Speed     = {kb = Enum.KeyCode.Q,           gp = nil},
	Lagger    = {kb = Enum.KeyCode.R,           gp = nil},
	InstaReset= {kb = nil,                      gp = nil},
	GuiHide   = {kb = Enum.KeyCode.LeftControl, gp = nil},
	MusicPC   = {kb = Enum.KeyCode.M,           gp = nil},
	MusicPad  = {kb = nil,                      gp = Enum.KeyCode.DPadUp},
	Taunt     = {kb = nil,                      gp = nil},
}

local function kbMatch(entry, kc)
	return kc == entry.kb or (entry.gp and kc == entry.gp)
end

local function getProfileNormalSpeed()
	return State.speedProfile == "Lagger" and State.profileLaggerNormalSpeed or NS
end

local function getProfileCarrySpeed()
	return State.speedProfile == "Lagger" and State.profileLaggerCarrySpeed or CS
end

local AP = {
	L1=Vector3.new(-476.48,-6.28,92.73), L2=Vector3.new(-483.12,-4.95,94.80), L_FACE=Vector3.new(-482.25,-4.96,92.09),
	R1=Vector3.new(-476.16,-6.52,25.62), R2=Vector3.new(-483.06,-5.03,25.48), R_FACE=Vector3.new(-482.06,-6.93,35.47),
}

local Steal = {
	AutoStealEnabled = false, StealRadius = 8, StealDuration = 1.3,
	Data = {}, plotCache = {}, plotCacheTime = {},
	cachedPrompts = {}, promptCacheTime = 0,
}

local Conns = {
	autoSteal = nil, antiRag = nil,
	anchor = {}, progress = nil,
}

local safetyPositionIsValid
local startBatAimbot, stopBatAimbot
local function findAnyToolMob()
	local c=LP.Character
	if c then for _,v in ipairs(c:GetChildren()) do if v:IsA("Tool") then return v end end end
	local bp=LP:FindFirstChildOfClass("Backpack")
	if bp then for _,v in ipairs(bp:GetChildren()) do if v:IsA("Tool") then return v end end end
	return nil
end
local function getClosestPlayerMob2()
	local root=LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
	if not root then return nil,math.huge end
	local cp,cd=nil,math.huge
	for _,p in pairs(Players:GetPlayers()) do
		if p~=LP and p.Character then
			local tr=p.Character:FindFirstChild("HumanoidRootPart")
			local ph=p.Character:FindFirstChildOfClass("Humanoid")
			if tr and ph and ph.Health>0 then
				local d=(root.Position-tr.Position).Magnitude
				if d<cd then cd=d; cp=p end
			end
		end
	end
	return cp,cd
end
local MOB_SWING_COOLDOWN=0.08
local function tryHitBatMob()
	if State.hittingCooldown then return end; State.hittingCooldown=true
	pcall(function()
		local c=LP.Character; if not c then return end
		local hum2=c:FindFirstChildOfClass("Humanoid"); local tool=findAnyToolMob()
		if tool then
			if tool.Parent~=c and hum2 then pcall(function() hum2:EquipTool(tool) end) end
			local remote=tool:FindFirstChildOfClass("RemoteEvent")
			if remote then pcall(function() remote:FireServer() end)
			else pcall(function() tool:Activate() end) end
		end
	end)
	task.delay(MOB_SWING_COOLDOWN,function() State.hittingCooldown=false end)
end
local _aimbotTarget = nil

local function findBat()
	local char = LP.Character; if not char then return nil end
	for _, tool in ipairs(char:GetChildren()) do
		if tool:IsA("Tool") and (tool.Name:lower():find("bat") or tool.Name:lower():find("slap")) then return tool end
	end
	local bp = LP:FindFirstChild("Backpack")
	if bp then
		for _, tool in ipairs(bp:GetChildren()) do
			if tool:IsA("Tool") and (tool.Name:lower():find("bat") or tool.Name:lower():find("slap")) then return tool end
		end
	end
	return nil
end

local function getClosestTarget()
	local root = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
	if not root then return nil end
	local closest, minDist = nil, math.huge
	for _, plr in ipairs(Players:GetPlayers()) do
		if plr ~= LP and plr.Character then
			local tRoot = plr.Character:FindFirstChild("HumanoidRootPart")
			local hum = plr.Character:FindFirstChildOfClass("Humanoid")
			if tRoot and hum and hum.Health > 0 then
				local dist = (tRoot.Position - root.Position).Magnitude
				if dist < minDist then minDist = dist; closest = tRoot end
			end
		end
	end
	return closest
end

-- ============================================================
--  FUNCIONES DE BAT AIMBOT V1 (modificadas para excluir TP Bat)
-- ============================================================
stopBatAimbot = function()
	if Conns.aimbot then Conns.aimbot:Disconnect(); Conns.aimbot = nil end
	_aimbotTarget = nil
	local c = LP.Character
	local root = c and c:FindFirstChild("HumanoidRootPart")
	if root then root.AssemblyLinearVelocity = Vector3.zero; root.AssemblyAngularVelocity = Vector3.zero end
	local hum2 = c and c:FindFirstChildOfClass("Humanoid")
	if hum2 then hum2.AutoRotate = true end
	State.hittingCooldown = false
	_autoBatTarget = nil
	_autoBatEquippedThisRun = false
end

startBatAimbot = function()
	-- El Aimbot normal usa ahora el comportamiento predictivo de Empire Duels.
	if State.tpBatEnabled then
		State._setTPBatEnabled(false)
	end

	if Conns.aimbot then Conns.aimbot:Disconnect() end
	State._empireAimbotLastScan = 0
	State._empireAimbotTarget = nil

	local hum0 = LP.Character and LP.Character:FindFirstChildOfClass("Humanoid")
	if hum0 then hum0.AutoRotate = false end

	Conns.aimbot = RunService.Heartbeat:Connect(function()
		if not State.autoBatToggled then return end
		local char = LP.Character
		if not char then return end
		local root = char:FindFirstChild("HumanoidRootPart")
		local hum = char:FindFirstChildOfClass("Humanoid")
		if not root or not hum then return end

		if not char:FindFirstChildOfClass("Tool") then
			local bat = findBat()
			if bat then pcall(function() hum:EquipTool(bat) end) end
		end

		local now = tick()
		local target = State._empireAimbotTarget
		if now - (State._empireAimbotLastScan or 0) > 0.1 or not target or not target.Parent then
			State._empireAimbotLastScan = now
			target = getClosestTarget()
			State._empireAimbotTarget = target
		else
			local targetHum = target.Parent and target.Parent:FindFirstChildOfClass("Humanoid")
			if not targetHum or targetHum.Health <= 0 then
				target = nil
				State._empireAimbotTarget = nil
			end
		end

		if not target then
			hum.AutoRotate = true
			root.AssemblyAngularVelocity = Vector3.zero
			return
		end

		hum.AutoRotate = false
		_aimbotTarget = target
		local targetVel = target.AssemblyLinearVelocity
		local myPos = root.Position
		local targetPos = target.Position
		local predictPos = targetPos + targetVel * 0.14 + target.CFrame.LookVector * 0.3
		local direction = predictPos - myPos
		local flatDir = Vector3.new(direction.X, 0, direction.Z)
		if flatDir.Magnitude > 0.01 then
			flatDir = flatDir.Unit
		else
			flatDir = Vector3.new(0, 0, 1)
		end

		local chaseSpeed = State.batV1Speed or 58
		local desiredHeight = targetPos.Y + 3.7
		local yVel = (desiredHeight - myPos.Y) * 19.5 + targetVel.Y * 0.8
		if hum.FloorMaterial ~= Enum.Material.Air then yVel = math.max(yVel, 13) end
		yVel = math.clamp(yVel, -70, 110)
		local desiredVel = Vector3.new(flatDir.X * chaseSpeed, yVel, flatDir.Z * chaseSpeed)
		root.AssemblyLinearVelocity = root.AssemblyLinearVelocity:Lerp(desiredVel, 0.8)

		local predictTime = math.clamp(targetVel.Magnitude / 150, 0.05, 0.2)
		local predictedPos = targetPos + targetVel * predictTime
		local toPredict = predictedPos - myPos
		if toPredict.Magnitude > 0.1 then
			local goalCF = CFrame.lookAt(myPos, predictedPos)
			local diffCF = root.CFrame:Inverse() * goalCF
			local rx, ry, rz = diffCF:ToEulerAnglesXYZ()
			rx = math.clamp(rx, -2.5, 2.5)
			ry = math.clamp(ry, -2.5, 2.5)
			rz = math.clamp(rz, -2.5, 2.5)
			root.AssemblyAngularVelocity = root.CFrame:VectorToWorldSpace(Vector3.new(rx * 42, ry * 42, rz * 42))
		end

		if State.autoSwingEnabled then
			local bat = char:FindFirstChildOfClass("Tool") or findBat()
			if bat and bat:IsA("Tool") then pcall(function() bat:Activate() end) end
		end
	end)
end

LP.CharacterAdded:Connect(function()
    task.wait(0.5)
end)

local PLOT_CACHE_DURATION, PROMPT_CACHE_REFRESH, STEAL_COOLDOWN = 2, 0.15, 0.1

local h, hrp, speedLbl
local setAutoGrab, setAutoBat, setInfJump, setSuperJump, setAntiRag, setFps, setUnwalkToggle, autoLeftSetVisual, autoRightSetVisual, autoBatSetVisual, setIntroToggle, setNoIntroToggle
local setAntiLag, setStretchRez, setRemoveAccessories, setDarkMode, setSkyStyle, setSkySelectorVisual
local setMedusaCounter, setBatCounter, setInstaGrab, setAutoSwingVisual
local startAntiRagdoll, stopAntiRagdoll, applyFPSBoost, startAutoSteal, stopAutoSteal
local mobileSpeedSetActive, mobileLaggerSetActive, mobileLaggerCarrySetActive, saveConfig, loadConfig = nil, nil, nil, nil, nil

State._configLoading = false
State._configLoaded = false
State._saveAfterLoad = false
State._saveRequestId = 0
State._lastSaveError = nil
State._configDirty = false
State._positionDirty = false

State._resolveFileFunction = function(name)
	local direct = nil
	if name == "writefile" then direct = writefile
	elseif name == "readfile" then direct = readfile
	elseif name == "isfile" then direct = isfile
	elseif name == "delfile" then direct = delfile
	elseif name == "makefolder" then direct = makefolder
	elseif name == "isfolder" then direct = isfolder end
	if type(direct) == "function" then return direct end

	local environments = {}
	pcall(function()
		if getgenv then table.insert(environments, getgenv()) end
	end)
	pcall(function()
		if getrenv then table.insert(environments, getrenv()) end
	end)
	table.insert(environments, _G)

	for _, environment in ipairs(environments) do
		if type(environment) == "table" then
			local candidate = rawget(environment, name)
			if type(candidate) == "function" then return candidate end
			local synEnvironment = rawget(environment, "syn")
			if type(synEnvironment) == "table" then
				local synCandidate = rawget(synEnvironment, name)
				if type(synCandidate) == "function" then return synCandidate end
			end
		end
	end

	if type(syn) == "table" and type(syn[name]) == "function" then
		return syn[name]
	end
	return nil
end

State._safeWriteFile = function(path, data)
	local writer = State._resolveFileFunction("writefile")
	if type(writer) ~= "function" then
		return false, "writefile no disponible en este ejecutor"
	end
	local ok, err = pcall(writer, path, data)
	if not ok then return false, tostring(err) end
	return true
end

State._safeReadFile = function(path)
	local reader = State._resolveFileFunction("readfile")
	if type(reader) ~= "function" then
		return nil, "readfile no disponible en este ejecutor"
	end
	local ok, result = pcall(reader, path)
	if not ok or type(result) ~= "string" or result == "" then
		return nil, ok and "archivo vacÃ­o" or tostring(result)
	end
	return result
end

State._safeDeleteFile = function(path)
	local deleter = State._resolveFileFunction("delfile")
	if type(deleter) ~= "function" then return false end
	local ok = pcall(deleter, path)
	return ok
end

State._readValidJsonFile = function(path)
	local raw = State._safeReadFile(path)
	if type(raw) ~= "string" then return nil, nil end
	local ok, decoded = pcall(function() return HttpService:JSONDecode(raw) end)
	if not ok or type(decoded) ~= "table" then return nil, raw end
	return decoded, raw
end

State._writeVerifiedJson = function(path, encoded)
	local writeOk, writeErr = State._safeWriteFile(path, encoded)
	if not writeOk then return false, writeErr end
	local decoded, raw = State._readValidJsonFile(path)
	if type(decoded) ~= "table" or raw ~= encoded then
		return false, "la verificaciÃ³n del archivo fallÃ³: " .. tostring(path)
	end
	return true
end

State._atomicJsonSave = function(mainPath, backupPath, tempPath, encoded)
	local jsonOk, decoded = pcall(function() return HttpService:JSONDecode(encoded) end)
	if not jsonOk or type(decoded) ~= "table" then
		return false, "JSON invÃ¡lido antes de guardar"
	end

	local currentData, currentRaw = State._readValidJsonFile(mainPath)

	if type(currentData) == "table" and currentRaw == encoded then
		return true
	end

	if type(currentData) == "table" and type(currentRaw) == "string" then
		local backupOk, backupErr = State._safeWriteFile(backupPath, currentRaw)
		if not backupOk then return false, backupErr end
	end

	local tempOk, tempErr = State._safeWriteFile(tempPath, encoded)
	if not tempOk then return false, tempErr end

	local mainOk, mainErr = State._safeWriteFile(mainPath, encoded)
	if not mainOk then return false, mainErr end

	if type(currentData) ~= "table" then
		State._safeWriteFile(backupPath, encoded)
	end

	return true
end

State.requestConfigSave = function()
	if State._configLoading or not State._configLoaded then
		State._saveAfterLoad = true
		State._configDirty = true
		return
	end
	if State._configLoadFailed then
		return
	end

	State._configDirty = true
	State._saveRequestId = State._saveRequestId + 1
	local requestId = State._saveRequestId

	task.delay(1.75, function()
		if requestId ~= State._saveRequestId or State._configLoading then return end
		if not State._configDirty then return end
		if saveConfig then
			local ok, result = pcall(saveConfig)
			if not ok then State._lastSaveError = tostring(result) end
		end
	end)
end
local normalBox, carryBox, laggerBox, laggerBox2, durValBtn, uiScaleBox
local modeValLbl, progressFill, progressPct, progressRadLbl
local radValBtn
local alConn, arConn, alPhase, arPhase = nil, nil, 1, 1
local autoTPDownEnabled, autoTPDownConn, autoTPDownHeight = false, nil, 20

local startBatAimbotV2, stopBatAimbotV2
local _autoBatLastScan = 0
local _autoBatTarget = nil
local _autoBatEquippedThisRun = false

local autoBatV2SetVisual, setAutoBatV2, setHideButtonsVisual, setAutoTPDownVisual

local btnInstaReset = nil

State.buttonsSizeValue = State.buttonsSizeValue or 50
State.buttonsShape = State.buttonsShape or "Normal"

function getMobileButtonPixels(value)
	value = math.clamp(math.floor((tonumber(value) or 50) + 0.5), 0, 100)
	return math.floor(36 + (value * 0.48) + 0.5)
end

function normalizeMobileButtonsShape(shape)
	shape = tostring(shape or "Normal")
	if shape == "Circle" or shape == "Normal" or shape == "Square" or shape == "Rectangle" then
		return shape
	end
	return "Normal"
end

function applyShapeToMobileButton(button)
	if not button or not button.Parent then return end

	local pixels = getMobileButtonPixels(State.buttonsSizeValue)
	local textPixels = math.clamp(math.floor(8 + State.buttonsSizeValue * 0.07 + 0.5), 8, 15)
	local shape = normalizeMobileButtonsShape(State.buttonsShape)
	local width, height = pixels, pixels
	local radius = UDim.new(0, math.clamp(math.floor(pixels * 0.30 + 0.5), 8, math.floor(pixels / 2)))

	if shape == "Circle" then
		radius = UDim.new(1, 0)
	elseif shape == "Square" then
		radius = UDim.new(0, 0)
	elseif shape == "Rectangle" then
		width = math.floor(pixels * 1.55 + 0.5)
		height = math.max(28, math.floor(pixels * 0.75 + 0.5))
		radius = UDim.new(0, math.max(5, math.floor(height * 0.18 + 0.5)))
	end

	button.Size = UDim2.new(0, width, 0, height)
	button.TextSize = textPixels

	local corner = button:FindFirstChild("ButtonShapeCorner")
	if not corner or not corner:IsA("UICorner") then
		corner = button:FindFirstChildOfClass("UICorner")
	end
	if not corner then
		corner = Instance.new("UICorner")
		corner.Parent = button
	end
	corner.Name = "ButtonShapeCorner"
	corner.CornerRadius = radius

	-- Sincronizar esquina de la imagen del botÃ³n
	local img = button:FindFirstChild("ButtonImage")
	if img and img:IsA("ImageLabel") then
		local imgCorner = img:FindFirstChild("ButtonImageCorner")
		if not imgCorner then
			imgCorner = Instance.new("UICorner")
			imgCorner.Name = "ButtonImageCorner"
			imgCorner.Parent = img
		end
		imgCorner.CornerRadius = radius
	end
end

function applyMobileButtonsShape(shape)
	State.buttonsShape = normalizeMobileButtonsShape(shape)
	for _, mobileBtn in pairs(mobileButtonsByName) do
		applyShapeToMobileButton(mobileBtn)
	end
	for _, specialBtn in ipairs({btnBatV2, btnInstaReset}) do
		applyShapeToMobileButton(specialBtn)
	end
	return State.buttonsShape
end

function applyMobileButtonsSize(value)
	State.buttonsSizeValue = math.clamp(math.floor((tonumber(value) or 50) + 0.5), 0, 100)
	applyMobileButtonsShape(State.buttonsShape)
end

-- ===== IMÃGENES EN BOTONES MÃ“VILES (usa los mismos assetIds del script) =====
function ensureButtonImageLabel(button)
	if not button or not button.Parent then return nil end
	local img = button:FindFirstChild("ButtonImage")
	if img and img:IsA("ImageLabel") then return img end
	img = Instance.new("ImageLabel")
	img.Name = "ButtonImage"
	img.Size = UDim2.new(1, 0, 1, 0)
	img.Position = UDim2.new(0, 0, 0, 0)
	img.BackgroundTransparency = 1
	img.ImageTransparency = 0.15
	img.ScaleType = Enum.ScaleType.Crop
	img.ZIndex = button.ZIndex
	img.Image = ""
	img.Parent = button
	-- Esquinas iguales al botÃ³n
	local corner = button:FindFirstChild("ButtonShapeCorner")
	if corner then
		local imgCorner = Instance.new("UICorner")
		imgCorner.Name = "ButtonImageCorner"
		imgCorner.CornerRadius = corner.CornerRadius
		imgCorner.Parent = img
	end
	return img
end

function applyImageToMobileButton(button, assetId)
	if not button then return end
	local img = ensureButtonImageLabel(button)
	if not img then return end
	assetId = tostring(assetId or "")
	if assetId == "" or assetId == "None" or assetId == "Off" then
		img.Image = ""
		img.Visible = false
		return
	end
	img.Visible = true
	local idStr = assetId:gsub("%D", "")
	img.Image = "rbxthumb://type=Asset&id=" .. idStr .. "&w=420&h=420"
	task.defer(function()
		if img and img.Parent and (img.Image == "" or img.IsLoaded == false) then
			img.Image = "rbxassetid://" .. idStr
		end
	end)
end

function setMobileButtonImage(name, assetId)
	State.buttonImages[name] = (assetId and assetId ~= "" and assetId ~= "None" and assetId ~= "Off") and tostring(assetId) or ""
	local btn = mobileButtonsByName[name]
	if btn then
		applyImageToMobileButton(btn, State.buttonImages[name])
	end
	-- Botones especiales
	if name == "BatV2" and btnBatV2 then
		applyImageToMobileButton(btnBatV2, State.buttonImages[name])
	elseif name == "InstaReset" and btnInstaReset then
		applyImageToMobileButton(btnInstaReset, State.buttonImages[name])
	end
	if State.requestConfigSave then State.requestConfigSave() end
end

function applyAllButtonImages()
	for name, id in pairs(State.buttonImages or {}) do
		local btn = mobileButtonsByName[name]
		if btn then applyImageToMobileButton(btn, id) end
	end
	if btnBatV2 and State.buttonImages["BatV2"] then
		applyImageToMobileButton(btnBatV2, State.buttonImages["BatV2"])
	end
	if btnInstaReset and State.buttonImages["InstaReset"] then
		applyImageToMobileButton(btnInstaReset, State.buttonImages["InstaReset"])
	end
end

local MedusaConfig = {
	Enabled = false,
	Radius = 15,
	Delay = 0.15,
	LastUsed = 0,
	RadiusPart = nil
}

local SAFETY_VOID_MARGIN = 18
local SAFETY_MAX_FLOOR_RAY = 4000
local safetyLastGroundedCFrame = nil
local safetyRestoring = false

local function safetyVoidY()
	local ok, value = pcall(function() return workspace.FallenPartsDestroyHeight end)
	if ok and type(value) == "number" then return value end
	return -500
end

local function safetyFiniteNumber(value)
	return type(value) == "number" and value == value and value > -math.huge and value < math.huge
end

safetyPositionIsValid = function(position)
	return typeof(position) == "Vector3"
		and safetyFiniteNumber(position.X)
		and safetyFiniteNumber(position.Y)
		and safetyFiniteNumber(position.Z)
		and position.Y > safetyVoidY() + SAFETY_VOID_MARGIN
end

local function safetyCharacterParts()
	local character = LP.Character
	local humanoid = character and character:FindFirstChildOfClass("Humanoid")
	local root = character and character:FindFirstChild("HumanoidRootPart")
	if not character or not humanoid or humanoid.Health <= 0 or not root then
		return nil, nil, nil
	end
	return character, humanoid, root
end

local function safetyFloorPosition(root, character)
	if not root or not character or not safetyPositionIsValid(root.Position) then return nil end

	local ignore = {character}
	if MedusaConfig and MedusaConfig.RadiusPart then
		table.insert(ignore, MedusaConfig.RadiusPart)
	end

	local humanoid = character:FindFirstChildOfClass("Humanoid")
	local offset = (humanoid and humanoid.HipHeight or 2) + (root.Size.Y / 2) + 0.05
	local origin = root.Position + Vector3.new(0, 5, 0)
	local distanceToVoid = math.max(100, origin.Y - safetyVoidY() + 50)
	local rayDistance = math.min(SAFETY_MAX_FLOOR_RAY, distanceToVoid)
	local hitPosition = nil

	pcall(function()
		local params = RaycastParams.new()
		params.FilterDescendantsInstances = ignore
		params.FilterType = Enum.RaycastFilterType.Exclude
		pcall(function() params.RespectCanCollide = true end)
		local result = workspace:Raycast(origin, Vector3.new(0, -rayDistance, 0), params)
		if result and result.Instance and result.Position then
			hitPosition = result.Position
		end
	end)

	if not hitPosition then
		pcall(function()
			local ray = Ray.new(origin, Vector3.new(0, -rayDistance, 0))
			local part, position = workspace:FindPartOnRayWithIgnoreList(ray, ignore)
			if part and position then hitPosition = position end
		end)
	end

	if not hitPosition then return nil end
	local landing = Vector3.new(root.Position.X, hitPosition.Y + offset, root.Position.Z)
	if not safetyPositionIsValid(landing) then return nil end
	return landing
end

local function safetyTeleport(root, humanoid, destination, preserveYaw)
	if not root or not root.Parent or not humanoid or humanoid.Health <= 0 then return false end
	if not safetyPositionIsValid(destination) then return false end

	local yaw = 0
	if preserveYaw ~= false then
		local _, currentYaw, _ = root.CFrame:ToOrientation()
		yaw = currentYaw
	end

	root.AssemblyLinearVelocity = Vector3.zero
	root.AssemblyAngularVelocity = Vector3.zero
	root.CFrame = CFrame.new(destination) * CFrame.Angles(0, yaw, 0)
	root.AssemblyLinearVelocity = Vector3.zero
	root.AssemblyAngularVelocity = Vector3.zero
	pcall(function() humanoid.PlatformStand = false end)
	return true
end

local function safetyTeleportToFloor(character, humanoid, root)
	local landing = safetyFloorPosition(root, character)
	if not landing then
		root.AssemblyLinearVelocity = Vector3.zero
		root.AssemblyAngularVelocity = Vector3.zero
		return false
	end
	return safetyTeleport(root, humanoid, landing, true)
end

RunService.Heartbeat:Connect(function()
	local character, humanoid, root = safetyCharacterParts()
	if not character then return end

	if safetyPositionIsValid(root.Position)
		and humanoid.FloorMaterial ~= Enum.Material.Air
		and root.AssemblyLinearVelocity.Magnitude < 180 then
		safetyLastGroundedCFrame = root.CFrame
	end

	local riskyMovement = State.dropActive
		or State.dropBrainrotActive
		or autoTPDownEnabled
		or State.tpBatEnabled
		or State.autoBatToggled
		or State.autoBatV2Enabled

	if riskyMovement and not safetyPositionIsValid(root.Position) and not safetyRestoring then
		safetyRestoring = true
		root.AssemblyLinearVelocity = Vector3.zero
		root.AssemblyAngularVelocity = Vector3.zero
		if safetyLastGroundedCFrame and safetyPositionIsValid(safetyLastGroundedCFrame.Position) then
			root.CFrame = safetyLastGroundedCFrame + Vector3.new(0, 2, 0)
		end
		task.defer(function() safetyRestoring = false end)
	end
end)

local function showDiscordInProgressBar()
	if not progressPct or not progressFill then return end

	local originalText = progressPct.Text
	local originalColor = progressPct.TextColor3
	local originalSize = progressPct.TextSize
	local originalAlign = progressPct.TextXAlignment

	progressPct.Text = "NIGHT #3.VS  ðŸ‘ºÂ·  Dominando!!!"
	progressPct.TextColor3 = Color3.fromRGB(255, 40, 50)
	progressPct.TextSize = 13
	progressPct.TextXAlignment = Enum.TextXAlignment.Center
	progressPct.ZIndex = 12

	if progressRadLbl then progressRadLbl.Visible = false end

	task.delay(4, function()
		if progressPct then
			progressPct.Text = originalText or "0%"
			progressPct.TextColor3 = originalColor or Color3.fromRGB(200,200,230)
			progressPct.TextSize = originalSize or 11
			progressPct.TextXAlignment = originalAlign or Enum.TextXAlignment.Left
			progressPct.ZIndex = 5
		end
		if progressRadLbl then progressRadLbl.Visible = true end
	end)
end

local function stopAutoLeft()
	if alConn then alConn:Disconnect(); alConn = nil end
	alPhase = 1
	local char = LP.Character
	if char then local hum = char:FindFirstChildOfClass("Humanoid"); if hum then hum:Move(Vector3.zero, false) end end
end

local function stopAutoRight()
	if arConn then arConn:Disconnect(); arConn = nil end
	arPhase = 1
	local char = LP.Character
	if char then local hum = char:FindFirstChildOfClass("Humanoid"); if hum then hum:Move(Vector3.zero, false) end end
end

-- ============================================================
--  AUTO LEFT / RIGHT (con exclusiÃ³n de TP Bat)
-- ============================================================
local function startAutoLeft()
	if State.tpBatEnabled then
		State._setTPBatEnabled(false)
	end

	if alConn then alConn:Disconnect() end
	alPhase = 1
	alConn = RunService.Heartbeat:Connect(function()
		if not State.autoLeftEnabled then return end
		local char = LP.Character; if not char then return end
		local hrp2 = char:FindFirstChild("HumanoidRootPart")
		local hum = char:FindFirstChildOfClass("Humanoid")
		if not hrp2 or not hum then return end
		local spd = getProfileNormalSpeed()
		if alPhase == 1 then
			local tgt = Vector3.new(AP.L1.X, hrp2.Position.Y, AP.L1.Z)
			if (tgt - hrp2.Position).Magnitude < 1 then
				alPhase = 2
				local d = AP.L2 - hrp2.Position; local mv = Vector3.new(d.X,0,d.Z).Unit
				hum:Move(mv,false); hrp2.AssemblyLinearVelocity = Vector3.new(mv.X*spd, hrp2.AssemblyLinearVelocity.Y, mv.Z*spd); return
			end
			local d = AP.L1 - hrp2.Position; local mv = Vector3.new(d.X,0,d.Z).Unit
			hum:Move(mv,false); hrp2.AssemblyLinearVelocity = Vector3.new(mv.X*spd, hrp2.AssemblyLinearVelocity.Y, mv.Z*spd)
		elseif alPhase == 2 then
			local tgt = Vector3.new(AP.L2.X, hrp2.Position.Y, AP.L2.Z)
			if (tgt - hrp2.Position).Magnitude < 1 then
				hum:Move(Vector3.zero,false); hrp2.AssemblyLinearVelocity = Vector3.zero
				State.autoLeftEnabled = false
				if alConn then alConn:Disconnect(); alConn = nil end
				alPhase = 1
				if autoLeftSetVisual then autoLeftSetVisual(false) end
				if (AP.L_FACE - hrp2.Position).Magnitude > 0.01 then
					hrp2.CFrame = CFrame.new(hrp2.Position, Vector3.new(AP.L_FACE.X, hrp2.Position.Y, AP.L_FACE.Z))
				end
				return
			end
			local d = AP.L2 - hrp2.Position; local mv = Vector3.new(d.X,0,d.Z).Unit
			hum:Move(mv,false); hrp2.AssemblyLinearVelocity = Vector3.new(mv.X*spd, hrp2.AssemblyLinearVelocity.Y, mv.Z*spd)
		end
	end)
end

local function startAutoRight()
	if State.tpBatEnabled then
		State._setTPBatEnabled(false)
	end

	if arConn then arConn:Disconnect() end
	arPhase = 1
	arConn = RunService.Heartbeat:Connect(function()
		if not State.autoRightEnabled then return end
		local char = LP.Character; if not char then return end
		local hrp2 = char:FindFirstChild("HumanoidRootPart")
		local hum = char:FindFirstChildOfClass("Humanoid")
		if not hrp2 or not hum then return end
		local spd = getProfileNormalSpeed()
		if arPhase == 1 then
			local tgt = Vector3.new(AP.R1.X, hrp2.Position.Y, AP.R1.Z)
			if (tgt - hrp2.Position).Magnitude < 1 then
				arPhase = 2
				local d = AP.R2 - hrp2.Position; local mv = Vector3.new(d.X,0,d.Z).Unit
				hum:Move(mv,false); hrp2.AssemblyLinearVelocity = Vector3.new(mv.X*spd, hrp2.AssemblyLinearVelocity.Y, mv.Z*spd); return
			end
			local d = AP.R1 - hrp2.Position; local mv = Vector3.new(d.X,0,d.Z).Unit
			hum:Move(mv,false); hrp2.AssemblyLinearVelocity = Vector3.new(mv.X*spd, hrp2.AssemblyLinearVelocity.Y, mv.Z*spd)
		elseif arPhase == 2 then
			local tgt = Vector3.new(AP.R2.X, hrp2.Position.Y, AP.R2.Z)
			if (tgt - hrp2.Position).Magnitude < 1 then
				hum:Move(Vector3.zero,false); hrp2.AssemblyLinearVelocity = Vector3.zero
				State.autoRightEnabled = false
				if arConn then arConn:Disconnect(); arConn = nil end
				arPhase = 1
				if autoRightSetVisual then autoRightSetVisual(false) end
				if (AP.R_FACE - hrp2.Position).Magnitude > 0.01 then
					hrp2.CFrame = CFrame.new(hrp2.Position, Vector3.new(AP.R_FACE.X, hrp2.Position.Y, AP.R_FACE.Z))
				end
				return
			end
			local d = AP.R2 - hrp2.Position; local mv = Vector3.new(d.X,0,d.Z).Unit
			hum:Move(mv,false); hrp2.AssemblyLinearVelocity = Vector3.new(mv.X*spd, hrp2.AssemblyLinearVelocity.Y, mv.Z*spd)
		end
	end)
end

-- SECCIÃ“N 5: FUNCIONES DE DROP Y TP DOWN
local DROP_ASCEND_DURATION = 0.2
local DROP_ASCEND_SPEED = 150
local _tpDownActive = false

local function runDrop()
	if not State._manualDropRequest then return end
	State._manualDropRequest = false
	if State.dropActive then return end
	local char = LP.Character; if not char then return end
	local root = char:FindFirstChild("HumanoidRootPart"); if not root then return end
	State.dropActive = true
	local t0 = tick()
	State.dropConn = RunService.Heartbeat:Connect(function()
		local r = char and char:FindFirstChild("HumanoidRootPart")
		if not r then 
			if State.dropConn then State.dropConn:Disconnect(); State.dropConn = nil end
			State.dropActive = false
			return 
		end
		
		pcall(function()
			if not _tpDownActive then
				local hum = char:FindFirstChildOfClass("Humanoid")
				if hum and hum.FloorMaterial == Enum.Material.Air and r.Position.Y >= autoTPDownHeight then
					r.CFrame = CFrame.new(Vector3.new(r.Position.X, -6.84, r.Position.Z))
						* CFrame.Angles(0, select(2, r.CFrame:ToEulerAnglesYXZ()), 0)
					r.AssemblyLinearVelocity = Vector3.zero
				end
			end
		end)

		if tick() - t0 >= DROP_ASCEND_DURATION then
			if State.dropConn then State.dropConn:Disconnect(); State.dropConn = nil end
			local rp = RaycastParams.new()
			rp.FilterDescendantsInstances = {char}
			rp.FilterType = Enum.RaycastFilterType.Exclude
			local rr = workspace:Raycast(r.Position, Vector3.new(0, -2000, 0), rp)
			if rr then
				local hum2 = char:FindFirstChildOfClass("Humanoid")
				local off = (hum2 and hum2.HipHeight or 2) + (r.Size.Y / 2)
				r.CFrame = CFrame.new(r.Position.X, rr.Position.Y + off, r.Position.Z)
				r.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
			end
			State.dropActive = false
			return
		end
		r.AssemblyLinearVelocity = Vector3.new(r.AssemblyLinearVelocity.X, DROP_ASCEND_SPEED, r.AssemblyLinearVelocity.Z)
	end)
end

local _tpDownActive = false
local function runTPDown()
	if _tpDownActive then return end
	_tpDownActive = true
	pcall(function()
		local character, humanoid, root = safetyCharacterParts()
		if character then safetyTeleportToFloor(character, humanoid, root) end
	end)
	_tpDownActive = false
end

State._tpBatHittingCooldown = false
State._tpBatHRP = nil
State._tpBatH = nil

State._tpBatGetTool = function()
	local char = LP.Character
	if not char then return nil end

	local bat = char:FindFirstChild("Bat")
	if bat then return bat end

	local backpack = LP:FindFirstChild("Backpack")
	if backpack then
		bat = backpack:FindFirstChild("Bat")
		if bat then
			bat.Parent = char
			return bat
		end
	end

	return nil
end

State._tpBatTryHit = function()
	if State._tpBatHittingCooldown then return end
	State._tpBatHittingCooldown = true

	pcall(function()
		local bat = State._tpBatGetTool()
		if bat then
			bat:Activate()

			local remoteEvent = bat:FindFirstChildWhichIsA("RemoteEvent")
			if remoteEvent then
				remoteEvent:FireServer()
			end

			local remoteFunction = bat:FindFirstChildWhichIsA("RemoteFunction")
			if remoteFunction then
				pcall(function()
					remoteFunction:InvokeServer()
				end)
			end
		end
	end)

	task.delay(0.08, function()
		State._tpBatHittingCooldown = false
	end)
end

State._tpBatClosest = function()
	if not State._tpBatHRP then return nil, math.huge end

	local closest, closestDistance = nil, math.huge
	for _, player in pairs(Players:GetPlayers()) do
		if player ~= LP and player.Character then
			local targetRoot = player.Character:FindFirstChild("HumanoidRootPart")
			if targetRoot then
				local distance = (State._tpBatHRP.Position - targetRoot.Position).Magnitude
				if distance < closestDistance then
					closestDistance = distance
					closest = player
				end
			end
		end
	end

	return closest, closestDistance
end

-- ============================================================
--  TP BAT (con desactivaciÃ³n de Auto Left/Right y Bat V1/V2)
-- ============================================================
State._setTPBatEnabled = function(on)
	on = on == true

	if on then
		if State.autoLeftEnabled then
			State.autoLeftEnabled = false
			stopAutoLeft()
			if autoLeftSetVisual then autoLeftSetVisual(false) end
		end
		if State.autoRightEnabled then
			State.autoRightEnabled = false
			stopAutoRight()
			if autoRightSetVisual then autoRightSetVisual(false) end
		end
		if State.autoBatToggled then
			State.autoBatToggled = false
			if autoBatSetVisual then autoBatSetVisual(false) end
			stopBatAimbot()
		end
		if State.autoBatV2Enabled then
			State.autoBatV2Enabled = false
			if autoBatV2SetVisual then autoBatV2SetVisual(false) end
			if mobileBatV2SetActive then mobileBatV2SetActive(false) end
			stopBatAimbotV2()
		end
	else
	end

	State.tpBatEnabled = on
	if State._tpBatSetter then State._tpBatSetter(on) end
	if State._tpBatConfigSetVisual then State._tpBatConfigSetVisual(on) end
end

RunService.Heartbeat:Connect(function()
	if not State.tpBatEnabled then return end

	if not State._tpBatH or not State._tpBatHRP
		or not State._tpBatH.Parent or not State._tpBatHRP.Parent then
		local char = LP.Character
		if char then
			State._tpBatH = char:FindFirstChildOfClass("Humanoid")
			State._tpBatHRP = char:FindFirstChild("HumanoidRootPart")
		end
		if not State._tpBatH or not State._tpBatHRP then return end
	end

	local target = State._tpBatClosest()
	if target and target.Character then
		local targetRoot = target.Character:FindFirstChild("HumanoidRootPart")
		if targetRoot then
			if sethiddenproperty then
				pcall(function()
					sethiddenproperty(State._tpBatHRP, "PhysicsRepRootPart", targetRoot)
				end)
			end

			local targetPosition = targetRoot.Position + Vector3.new(0, 0.9, 0)
			if (State._tpBatHRP.Position - targetPosition).Magnitude > 5 then
				State._tpBatHRP.CFrame = CFrame.new(targetPosition)
			end

			local camera = workspace.CurrentCamera
			if camera then
				camera.CFrame = CFrame.new(camera.CFrame.Position, targetRoot.Position)
			end

			State._tpBatTryHit()
		end
	end
end)

RunService.RenderStepped:Connect(function()
	if not State.tpBatEnabled then return end
	if not State._tpBatH or not State._tpBatHRP then return end
	if not State._tpBatH.Parent or not State._tpBatHRP.Parent then return end

	local target = State._tpBatClosest()
	if target and target.Character then
		local targetRoot = target.Character:FindFirstChild("HumanoidRootPart")
		if targetRoot then
			local camera = workspace.CurrentCamera
			if camera then
				camera.CFrame = CFrame.new(camera.CFrame.Position, targetRoot.Position)
			end
			State._tpBatTryHit()
		end
	end
end)

LP.CharacterAdded:Connect(function(character)
	task.wait(0.2)
	State._tpBatH = character:FindFirstChildOfClass("Humanoid")
	State._tpBatHRP = character:FindFirstChild("HumanoidRootPart")
end)

if LP.Character then
	task.spawn(function()
		task.wait(0.2)
		State._tpBatH = LP.Character and LP.Character:FindFirstChildOfClass("Humanoid")
		State._tpBatHRP = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
	end)
end

local function startAutoTPDown()
	if autoTPDownConn then task.cancel(autoTPDownConn); autoTPDownConn = nil end
	autoTPDownConn = task.spawn(function()
		while autoTPDownEnabled do
			task.wait(0.1)
			pcall(function()
				local char = LP.Character; if not char then return end
				local root = char:FindFirstChild("HumanoidRootPart"); if not root then return end
				local hum = char:FindFirstChildOfClass("Humanoid"); if not hum then return end
				if hum.FloorMaterial ~= Enum.Material.Air then return end
				if root.Position.Y < autoTPDownHeight then return end
				safetyTeleportToFloor(char, hum, root)
			end)
		end
	end)
end

local function stopAutoTPDown()
	autoTPDownEnabled = false
	if autoTPDownConn then task.cancel(autoTPDownConn); autoTPDownConn = nil end
end

local function cursedInstaReset()
	local char = LP.Character
	if not char then return end
	local hrp = char:FindFirstChild("HumanoidRootPart")
	if not hrp then return end

	-- RESET de Ice Hub: conserva X/Z y aplica el impulso vertical observado.
	hrp.AssemblyLinearVelocity = Vector3.new(
		hrp.AssemblyLinearVelocity.X,
		10000000,
		hrp.AssemblyLinearVelocity.Z
	)
end
pcall(function() if _G.NIGHT_registerInstaReset then _G.NIGHT_registerInstaReset(cursedInstaReset) end end)

for _, name in pairs({"FEARV2GUI"}) do
	local old = game:GetService("CoreGui"):FindFirstChild(name)
	if old then old:Destroy() end
	local pg = LP:FindFirstChild("PlayerGui")
	if pg then local o = pg:FindFirstChild(name); if o then o:Destroy() end end
end

-- SECCIÃ“N 6: GUI PRINCIPAL
local function makeDraggable(frame)
	local dragging, dragInput, dragStart, startPos = false, nil, nil, nil
	local moved = false
	frame.Active = true

	local function finishDrag()
		if not dragging then return end
		dragging = false
		dragInput = nil
		if moved then
			moved = false
			if State.requestPositionSave then State.requestPositionSave() end
			if State.requestConfigSave then State.requestConfigSave() end
		end
	end

	frame.InputBegan:Connect(function(inp)
		if uiLocked then return end
		if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			moved = false
			dragInput = inp.UserInputType == Enum.UserInputType.Touch and inp or nil
			dragStart = inp.Position
			startPos = frame.Position
			inp.Changed:Connect(function()
				if inp.UserInputState == Enum.UserInputState.End then finishDrag() end
			end)
		end
	end)

	frame.InputChanged:Connect(function(inp)
		if uiLocked then finishDrag(); return end
		if inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch then
			dragInput = inp
		end
	end)

	UIS.InputChanged:Connect(function(inp)
		if uiLocked then finishDrag(); return end
		if dragging and (inp == dragInput or inp.UserInputType == Enum.UserInputType.MouseMovement) then
			local d = inp.Position - dragStart
			if math.abs(d.X) > 1 or math.abs(d.Y) > 1 then moved = true end
			frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset+d.X, startPos.Y.Scale, startPos.Y.Offset+d.Y)
		end
	end)

	UIS.InputEnded:Connect(function(inp)
		if dragging and (inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch) then
			finishDrag()
		end
	end)
end

local gui = Instance.new("ScreenGui")
gui.Name = "CTDuelsGUI"
gui.ResetOnSpawn = false
gui.DisplayOrder = 10
gui.IgnoreGuiInset = true

gui.DescendantAdded:Connect(function(child)
    task.defer(function() bindPurpleButton(child) end)
end)
task.defer(function()
    for _, child in ipairs(gui:GetDescendants()) do bindPurpleButton(child) end
end)
if not pcall(function() gui.Parent = game:GetService("CoreGui") end) then
	gui.Parent = LP:WaitForChild("PlayerGui")
end

local _C={
	[1]=Color3.fromRGB(0,0,0),
	[2]=Color3.fromRGB(6,6,8),
	[3]=Color3.fromRGB(12,12,14),
	[4]=Color3.fromRGB(235,235,240),
	[5]=Color3.fromRGB(150,150,160),
	[6]=Color3.fromRGB(190,190,200),
	[7]=Color3.fromRGB(250,250,255),
	[8]=Color3.fromRGB(130,130,140),
	[9]=Color3.fromRGB(22,22,26),
	[10]=Color3.fromRGB(18,18,22),
}
local BG=_C[1];local SIDEBAR_BG=_C[2];local CARD_BG=_C[3];local CARD_HOV=_C[4]
local BORDER=_C[5];local BORDER2=_C[6];local WHITE=_C[7];local DIM=_C[8]
local DIM2=_C[9];local KB_BG=_C[10];local INPUT_BG=_C[10]

local function makeDraggableY(guiObject)
    local UserInputService = game:GetService("UserInputService")
    local dragging, dragStart, startPos, moved = false, nil, nil, false
    guiObject.Active = true

    local function finishDrag()
        if not dragging then return end
        dragging = false
        if moved then
            moved = false
            if State.requestPositionSave then State.requestPositionSave() end
            if State.requestConfigSave then State.requestConfigSave() end
        end
    end

    guiObject.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            moved = false
            dragStart = input.Position
            startPos = guiObject.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then finishDrag() end
            end)
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            if math.abs(delta.Y) > 1 then moved = true end
            local newY = startPos.Y.Offset + delta.Y
            local visibleOffset = 375

            local frameHeight = guiObject.AbsoluteSize.Y
            local screenHeight = guiObject.Parent.AbsoluteSize.Y

            local minY = visibleOffset - frameHeight
            local maxY = screenHeight - visibleOffset
            local clampedY = math.clamp(newY, minY, maxY)

            guiObject.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset, startPos.Y.Scale, clampedY)
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
            finishDrag()
        end
    end)
end

local W, H, SW =384, 542, 92
local CORNER = 26

local uiScaleValue = 80
local mainUIScale = nil
local main = Instance.new("Frame", gui)
main.Name = "Main"
main.Size = UDim2.new(0, W, 0, H)
main.Position = UDim2.new(0, 18, 0.5, -271)
main.BackgroundColor3 = BG
main.BorderSizePixel = 0
main.Active = true
main.ClipsDescendants = true
main.Visible = false
main.BackgroundTransparency = 0

local mainCorner = Instance.new("UICorner", main)
mainCorner.CornerRadius = UDim.new(0, CORNER)

local mainStroke = Instance.new("UIStroke", main)
mainStroke.Color = BORDER
mainStroke.Thickness = 1.25
mainStroke.Transparency = 0.08

local premiumInnerBorder = Instance.new("Frame", main)
premiumInnerBorder.Name = "PremiumInnerBorder"
premiumInnerBorder.Size = UDim2.new(1, -8, 1, -8)
premiumInnerBorder.Position = UDim2.new(0, 4, 0, 4)
premiumInnerBorder.BackgroundTransparency = 1
premiumInnerBorder.BorderSizePixel = 0
premiumInnerBorder.ZIndex = 2
local premiumInnerCorner = Instance.new("UICorner", premiumInnerBorder)
premiumInnerCorner.CornerRadius = UDim.new(0, math.max(CORNER - 4, 0))
local premiumInnerStroke = Instance.new("UIStroke", premiumInnerBorder)
premiumInnerStroke.Color = Color3.fromRGB(150,150,160)
premiumInnerStroke.Thickness = 1
premiumInnerStroke.Transparency = 0.48

mainUIScale = Instance.new("UIScale", main)
mainUIScale.Scale = 0.90

local fullUIBackground = Instance.new("ImageLabel", main)
fullUIBackground.Name = "FullUIBackground"
fullUIBackground.Size = UDim2.new(1, -2, 1, -2)
fullUIBackground.Position = UDim2.new(0, 1, 0, 1)
fullUIBackground.BackgroundTransparency = 1
fullUIBackground.BorderSizePixel = 0
fullUIBackground.Image = "rbxassetid://" .. tostring(State.backgroundAssetId)
fullUIBackground.ImageTransparency = 0.08
fullUIBackground.ScaleType = Enum.ScaleType.Crop
fullUIBackground.ZIndex = 1
local fullUIBackgroundCorner = Instance.new("UICorner", fullUIBackground)
fullUIBackgroundCorner.CornerRadius = UDim.new(0, math.max(CORNER - 1, 0))

-- ============================================================
--  EFECTOS DE PARTÃCULAS EN LA UI (ambient + sparkles)
-- ============================================================
do
	local PARTICLE_COLORS = {
		Color3.fromRGB(255, 40, 50),
		Color3.fromRGB(235,235,240),
		Color3.fromRGB(200,200,210),
		Color3.fromRGB(190,190,200),
		Color3.fromRGB(220,220,230),
		Color3.fromRGB(200,200,210),
	}

	local particleLayer = Instance.new("Frame", main)
	particleLayer.Name = "UIParticleLayer"
	particleLayer.Size = UDim2.new(1, 0, 1, 0)
	particleLayer.Position = UDim2.new(0, 0, 0, 0)
	particleLayer.BackgroundTransparency = 1
	particleLayer.BorderSizePixel = 0
	particleLayer.ClipsDescendants = true
	particleLayer.ZIndex = 2
	Instance.new("UICorner", particleLayer).CornerRadius = UDim.new(0, CORNER)

	local activeParticles = {}
	local MAX_PARTICLES = 18
	local particleEnabled = true
	local rng = Random.new()

	local function spawnParticle()
		if not particleEnabled or not main.Visible or not particleLayer.Parent then return end
		if #activeParticles >= MAX_PARTICLES then return end

		local size = rng:NextInteger(2, 5)
		local p = Instance.new("Frame")
		p.Name = "UIParticle"
		p.Size = UDim2.fromOffset(size, size)
		p.BackgroundColor3 = PARTICLE_COLORS[rng:NextInteger(1, #PARTICLE_COLORS)]
		p.BackgroundTransparency = rng:NextNumber(0.15, 0.45)
		p.BorderSizePixel = 0
		p.ZIndex = 3
		p.AnchorPoint = Vector2.new(0.5, 0.5)
		Instance.new("UICorner", p).CornerRadius = UDim.new(1, 0)

		local glow = Instance.new("UIStroke", p)
		glow.Color = p.BackgroundColor3
		glow.Thickness = 1.2
		glow.Transparency = 0.55

		local startX = rng:NextNumber(0.02, 0.98)
		local startY = rng:NextNumber(0.55, 1.05)
		p.Position = UDim2.new(startX, 0, startY, 0)
		p.Parent = particleLayer

		local lifetime = rng:NextNumber(2.8, 5.5)
		local driftX = rng:NextNumber(-0.12, 0.12)
		local riseY = rng:NextNumber(-0.55, -0.28)
		local endX = math.clamp(startX + driftX, 0.01, 0.99)
		local endY = math.clamp(startY + riseY, -0.08, 0.95)
		local endSize = size * rng:NextNumber(0.3, 0.7)

		table.insert(activeParticles, p)

		local fadeIn = TweenService:Create(p, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			BackgroundTransparency = rng:NextNumber(0.05, 0.25)
		})
		local move = TweenService:Create(p, TweenInfo.new(lifetime, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
			Position = UDim2.new(endX, 0, endY, 0),
			Size = UDim2.fromOffset(endSize, endSize),
			BackgroundTransparency = 1
		})
		local glowFade = TweenService:Create(glow, TweenInfo.new(lifetime * 0.9, Enum.EasingStyle.Quad), {
			Transparency = 1
		})

		fadeIn:Play()
		move:Play()
		glowFade:Play()

		task.delay(lifetime + 0.15, function()
			for i = #activeParticles, 1, -1 do
				if activeParticles[i] == p then
					table.remove(activeParticles, i)
					break
				end
			end
			if p and p.Parent then p:Destroy() end
		end)
	end

	task.spawn(function()
		while particleLayer and particleLayer.Parent do
			if main.Visible and particleEnabled then
				spawnParticle()
				if rng:NextNumber() < 0.35 then
					task.wait(0.08)
					spawnParticle()
				end
			end
			task.wait(rng:NextNumber(0.22, 0.55))
		end
	end)

	local function burstParticles(count)
		count = count or 10
		for i = 1, count do
			task.delay(i * 0.04, spawnParticle)
		end
	end

	State._uiParticleBurst = burstParticles
	State._uiParticleEnabled = function(on)
		particleEnabled = on == true
		if not particleEnabled then
			for _, p in ipairs(activeParticles) do
				if p and p.Parent then p:Destroy() end
			end
			activeParticles = {}
		end
	end

	task.defer(function()
		task.wait(0.6)
		if main.Visible then burstParticles(12) end
	end)
end

State._tabBgImages = State._tabBgImages or {}

State.applyBackgroundImage = function(assetId, shouldSave)
	assetId = tostring(assetId or "")
	local valid = false
	for _, id in ipairs(State.backgroundAssetIds) do
		if id == assetId then valid = true; break end
	end
	if not valid then assetId = State.backgroundAssetIds[1] end

	State.backgroundAssetId = assetId
	if fullUIBackground and fullUIBackground.Parent then
		fullUIBackground.Image = "rbxassetid://" .. tostring(assetId)
		fullUIBackground.ImageTransparency = 0.08
		fullUIBackground.Visible = true
	end

	-- Aplicar la misma foto de fondo a los botones laterales (tabs del sidebar)
	local idStr = tostring(assetId)
	local imgUrl = "rbxthumb://type=Asset&id=" .. idStr .. "&w=420&h=420"
	for _, img in pairs(State._tabBgImages) do
		if img and img.Parent then
			img.Image = imgUrl
			img.ImageTransparency = 0.28
			img.Visible = true
			-- fallback si rbxthumb no carga
			task.defer(function()
				if img and img.Parent and (img.Image == "" or img.IsLoaded == false) then
					img.Image = "rbxassetid://" .. idStr
				end
			end)
		end
	end

	for id, visual in pairs(State.imageChoiceVisuals) do
		local selected = id == assetId
		if visual.stroke then
			visual.stroke.Color = selected and WHITE or BORDER
			visual.stroke.Thickness = selected and 2.2 or 1
		end
		if visual.badge then
			visual.badge.Text = selected and ("âœ“ " .. tostring(visual.index)) or tostring(visual.index)
			visual.badge.BackgroundColor3 = selected and WHITE or Color3.fromRGB(14,14,16)
			visual.badge.TextColor3 = selected and BG or WHITE
		end
	end

	if shouldSave and State.requestConfigSave then
		State.requestConfigSave()
	end
end

local topbar = Instance.new("Frame", main)
topbar.Size = UDim2.new(1, 0, 0, 48)
topbar.BackgroundColor3 = SIDEBAR_BG
topbar.BackgroundTransparency = 0.32
topbar.BorderSizePixel = 0
topbar.ZIndex = 10
Instance.new("UICorner", topbar).CornerRadius = UDim.new(0, CORNER)
local topPatch = Instance.new("Frame", topbar)
topPatch.Size = UDim2.new(1, 0, 0, CORNER)
topPatch.Position = UDim2.new(0, 0, 1, -CORNER)
topPatch.BackgroundColor3 = SIDEBAR_BG
topPatch.BackgroundTransparency = 0.32
topPatch.BorderSizePixel = 0
topPatch.ZIndex = 9
local topDiv = Instance.new("Frame", topbar)
topDiv.Size = UDim2.new(1, 0, 0, 1)
topDiv.Position = UDim2.new(0, 0, 1, -1)
topDiv.BackgroundColor3 = BORDER
topDiv.BorderSizePixel = 0
topDiv.ZIndex = 11

local premiumTopLine = Instance.new("Frame", topbar)
premiumTopLine.Name = "PremiumTopLine"
premiumTopLine.Size = UDim2.new(1, -28, 0, 2)
premiumTopLine.Position = UDim2.new(0, 14, 0, 3)
premiumTopLine.BackgroundColor3 = WHITE
premiumTopLine.BorderSizePixel = 0
premiumTopLine.ZIndex = 14
local premiumTopCorner = Instance.new("UICorner", premiumTopLine)
premiumTopCorner.CornerRadius = UDim.new(1, 0)
local premiumTopGradient = Instance.new("UIGradient", premiumTopLine)
premiumTopGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(8,8,10)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 40, 50)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(8,8,10))
})
premiumTopGradient.Transparency = NumberSequence.new({
    NumberSequenceKeypoint.new(0, 0.55),
    NumberSequenceKeypoint.new(0.5, 0.02),
    NumberSequenceKeypoint.new(1, 0.55)
})

local titleLbl = Instance.new("TextLabel", topbar)
titleLbl.Size = UDim2.new(0, 190, 1, 0)
titleLbl.Position = UDim2.new(0, 17, 0, -3)
titleLbl.BackgroundTransparency = 1
titleLbl.Text = "NIGHT #3.VS  ðŸ‘º"
titleLbl.TextColor3 = WHITE
titleLbl.Font = Enum.Font.GothamBlack
titleLbl.TextSize = 15
titleLbl.TextXAlignment = Enum.TextXAlignment.Left
titleLbl.ZIndex = 12

local verLbl = Instance.new("TextLabel", topbar)
verLbl.Size = UDim2.new(0, 240, 0, 14)
verLbl.Position = UDim2.new(0, 18, 0, 28)
verLbl.BackgroundTransparency = 1
verLbl.Text = "ã…¤ã…¤ã…¤ã…¤ã…¤ã…¤ã…¤ã…¤ã…¤ã…¤ã…¤ã…¤ NIGHT #3.VS Â· Vs Dominando!!!"
verLbl.TextColor3 = DIM
verLbl.Font = Enum.Font.Gotham
verLbl.TextSize = 8
verLbl.TextXAlignment = Enum.TextXAlignment.Left
verLbl.ZIndex = 12

local minBtn = Instance.new("TextButton", topbar)
minBtn.Size = UDim2.new(0, 26, 0, 26)
minBtn.Position = UDim2.new(1, -36, 0.5, -13)
minBtn.BackgroundColor3 = KB_BG
minBtn.BorderSizePixel = 0
minBtn.Text = "â€“"
minBtn.TextColor3 = WHITE
minBtn.Font = Enum.Font.GothamBlack
minBtn.TextSize = 16
minBtn.ZIndex = 13
Instance.new("UICorner", minBtn).CornerRadius = UDim.new(1, 0)
Instance.new("UIStroke", minBtn).Color = BORDER
minBtn.MouseEnter:Connect(function() TweenService:Create(minBtn, TweenInfo.new(0.1), {BackgroundColor3=CARD_HOV}):Play() end)
minBtn.MouseLeave:Connect(function() TweenService:Create(minBtn, TweenInfo.new(0.1), {BackgroundColor3=KB_BG}):Play() end)

do
	local dragging = false
	local dragInput = nil
	local dragStart = nil
	local startPosition = nil
	local moved = false

	local dragZone = Instance.new("TextButton", topbar)
	dragZone.Name = "TopbarDragZone"
	dragZone.Size = UDim2.new(1, -48, 1, 0)
	dragZone.Position = UDim2.new(0, 0, 0, 0)
	dragZone.BackgroundTransparency = 1
	dragZone.BorderSizePixel = 0
	dragZone.Text = ""
	dragZone.AutoButtonColor = false
	dragZone.Active = true
	dragZone.ZIndex = 13

	local function finishDrag()
		if not dragging then return end
		dragging = false
		dragInput = nil
		if moved then
			moved = false
			if State.requestPositionSave then State.requestPositionSave() end
			if State.requestConfigSave then State.requestConfigSave() end
		end
	end

	dragZone.InputBegan:Connect(function(input)
		if uiLocked then return end
		if input.UserInputType ~= Enum.UserInputType.MouseButton1
		and input.UserInputType ~= Enum.UserInputType.Touch then return end

		dragging = true
		moved = false
		dragInput = input.UserInputType == Enum.UserInputType.Touch and input or nil
		dragStart = input.Position
		startPosition = main.Position

		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				finishDrag()
			end
		end)
	end)

	dragZone.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement
		or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end)

	UIS.InputChanged:Connect(function(input)
		if uiLocked then finishDrag(); return end
		if not dragging then return end
		if input ~= dragInput and input.UserInputType ~= Enum.UserInputType.MouseMovement then return end

		local delta = input.Position - dragStart

		if math.abs(delta.X) > 1 or math.abs(delta.Y) > 1 then moved = true end
		main.Position = UDim2.new(
			startPosition.X.Scale, startPosition.X.Offset + delta.X,
			startPosition.Y.Scale, startPosition.Y.Offset + delta.Y
		)
	end)

	UIS.InputEnded:Connect(function(input)
		if dragging and (input.UserInputType == Enum.UserInputType.MouseButton1
		or input.UserInputType == Enum.UserInputType.Touch) then
			finishDrag()
		end
	end)
end

local sidebar = Instance.new("Frame", main)
sidebar.Size = UDim2.new(0, SW, 1, -48)
sidebar.Position = UDim2.new(0, 0, 0, 48)
sidebar.BackgroundColor3 = SIDEBAR_BG
sidebar.BackgroundTransparency = 0.32
sidebar.BorderSizePixel = 0
sidebar.ZIndex = 5
sidebar.ClipsDescendants = true
do local _sc=Instance.new("UICorner",sidebar); _sc.CornerRadius=UDim.new(0,CORNER) end
do local _st=Instance.new("Frame",main); _st.Size=UDim2.new(0,SW,0,CORNER); _st.Position=UDim2.new(0,0,0,48); _st.BackgroundColor3=SIDEBAR_BG; _st.BackgroundTransparency=0.32; _st.BorderSizePixel=0; _st.ZIndex=4 end
do local _sd=Instance.new("Frame",sidebar); _sd.Size=UDim2.new(0,1,1,0); _sd.Position=UDim2.new(1,-1,0,0); _sd.BackgroundColor3=BORDER; _sd.BorderSizePixel=0; _sd.ZIndex=6 end

local content = Instance.new("Frame", main)
content.Name = "ContentArea"
content.Size = UDim2.new(1, -(SW + 1), 1, -48 - CORNER)
content.Position = UDim2.new(0, SW + 1, 0, 48)
content.BackgroundColor3 = BG
content.BackgroundTransparency = 1
content.BorderSizePixel = 0
content.ClipsDescendants = true
content.ZIndex = 100

local mini = Instance.new("TextButton", gui)
mini.Name = "CTDuelsMini"
mini.Size = UDim2.new(0, 90, 0, 32)
mini.Position = UDim2.new(0, 20, 0, 70)
mini.BackgroundColor3 = BG
mini.BorderSizePixel = 0
mini.Text = "MENU"
mini.TextColor3 = WHITE
mini.Font = Enum.Font.GothamBold
mini.TextSize = 11
mini.TextXAlignment = Enum.TextXAlignment.Center
mini.ZIndex = 20
mini.Visible = true
Instance.new("UICorner", mini).CornerRadius = UDim.new(0, 16)
local miniStroke = Instance.new("UIStroke", mini)
miniStroke.Color = Color3.fromRGB(255, 40, 50)
miniStroke.Thickness = 1.5

makeDraggable(mini)
mini.InputEnded:Connect(function(inp)
	if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
		if State.requestConfigSave then State.requestConfigSave() end
	end
end)

local function showGui()
    main.Visible = true
    mini.Visible = false
    State.guiVisible = true

    main.BackgroundTransparency = 0
    mainUIScale.Scale = 0.85

    TweenService:Create(main, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {BackgroundTransparency = 0}):Play()
    TweenService:Create(mainUIScale, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Scale = uiScaleValue / 100}):Play()

    if State._uiParticleBurst then
        task.defer(function() State._uiParticleBurst(10) end)
    end
end

local function hideGui()
    TweenService:Create(main, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {BackgroundTransparency = 1}):Play()
    TweenService:Create(mainUIScale, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {Scale = 0.85}):Play()

    task.delay(0.2, function()
        main.Visible = false
        mini.Visible = true
        State.guiVisible = false
    end)
end

minBtn.MouseButton1Click:Connect(hideGui)
mini.MouseButton1Click:Connect(showGui)
mini.MouseEnter:Connect(function() TweenService:Create(mini,TweenInfo.new(0.1),{BackgroundColor3=CARD_HOV}):Play() end)
mini.MouseLeave:Connect(function() TweenService:Create(mini,TweenInfo.new(0.1),{BackgroundColor3=BG}):Play() end)

local tabs = {}
local tabPages = {}
local activeTabName = nil
local tabDefs = {
	{name="Speed"},
	{name="Bat Aimbot"},
	{name="Mechanics"},
	{name="Movement"},
	{name="Performance"},
	{name="Settings"},
	{name="Background"},
	{name="Songs"},
	{name="Animations"},
	{name="Keybinds"},
}
local switchTab
local pageLOs = {}

local tabListFrame = Instance.new("ScrollingFrame", sidebar)
tabListFrame.Size = UDim2.new(1, 0, 1, 0)
tabListFrame.Position = UDim2.new(0, 0, 0, 0)
tabListFrame.BackgroundTransparency = 1
tabListFrame.BorderSizePixel = 0
tabListFrame.ZIndex = 6
tabListFrame.ScrollBarThickness = 3
tabListFrame.ScrollBarImageColor3 = Color3.fromRGB(255, 40, 50)
tabListFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
tabListFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
tabListFrame.ScrollingDirection = Enum.ScrollingDirection.Y
tabListFrame.ElasticBehavior = Enum.ElasticBehavior.Never

local tabLL = Instance.new("UIListLayout", tabListFrame)
tabLL.SortOrder = Enum.SortOrder.LayoutOrder
tabLL.Padding = UDim.new(0, 8)
local tabPad = Instance.new("UIPadding", tabListFrame)
tabPad.PaddingTop = UDim.new(0, 18)
tabPad.PaddingBottom = UDim.new(0, 18)
tabPad.PaddingLeft = UDim.new(0, 8)
tabPad.PaddingRight = UDim.new(0, 8)

local ACTIVE_TAB_BG  = CARD_HOV
local ACTIVE_TAB_TXT = WHITE
local IDLE_TAB_BG    = CARD_BG
local IDLE_TAB_TXT   = WHITE

switchTab = function(name)
	activeTabName = name
	for _, td in ipairs(tabDefs) do
		local t = tabs[td.name]
		local isA = td.name == name
		TweenService:Create(t.frame, TweenInfo.new(0.14), {
			BackgroundColor3 = isA and ACTIVE_TAB_BG or IDLE_TAB_BG,
			BackgroundTransparency = isA and 0.35 or 0.55
		}):Play()
		TweenService:Create(t.lbl, TweenInfo.new(0.14), {
			TextColor3 = isA and ACTIVE_TAB_TXT or IDLE_TAB_TXT
		}):Play()
		if t.mark then
			TweenService:Create(t.mark, TweenInfo.new(0.14), {
				BackgroundTransparency = isA and 0.02 or 1
			}):Play()
		end
		if t.overlay then
			TweenService:Create(t.overlay, TweenInfo.new(0.14), {
				BackgroundTransparency = isA and 0.78 or 0.62
			}):Play()
		end
		if t.bgImg then
			TweenService:Create(t.bgImg, TweenInfo.new(0.14), {
				ImageTransparency = isA and 0.18 or 0.28
			}):Play()
		end
		tabPages[td.name].Visible = isA
	end
end

for i, td in ipairs(tabDefs) do
	local btn = Instance.new("TextButton", tabListFrame)
	btn.Size = UDim2.new(1, 0, 0, 44)
	btn.BackgroundColor3 = IDLE_TAB_BG
	btn.BackgroundTransparency = 0.55
	btn.BorderSizePixel = 0
	btn.Text = ""
	btn.LayoutOrder = i
	btn.ZIndex = 7
	btn.ClipsDescendants = true
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 11)
	local bSt = Instance.new("UIStroke", btn)
	bSt.Color = BORDER
	bSt.Thickness = 1

	-- Foto de fondo del background seleccionado en cada botÃ³n lateral (mÃ¡s visible)
	local idStr0 = tostring(State.backgroundAssetId or "139887397490573")
	local tabBgImg = Instance.new("ImageLabel", btn)
	tabBgImg.Name = "TabBackgroundImage"
	tabBgImg.Size = UDim2.new(1, 0, 1, 0)
	tabBgImg.Position = UDim2.new(0, 0, 0, 0)
	tabBgImg.BackgroundTransparency = 1
	tabBgImg.BorderSizePixel = 0
	tabBgImg.Image = "rbxthumb://type=Asset&id=" .. idStr0 .. "&w=420&h=420"
	tabBgImg.ImageTransparency = 0.28
	tabBgImg.ScaleType = Enum.ScaleType.Crop
	tabBgImg.ZIndex = 8
	Instance.new("UICorner", tabBgImg).CornerRadius = UDim.new(0, 11)
	task.defer(function()
		if tabBgImg and tabBgImg.Parent and (tabBgImg.Image == "" or tabBgImg.IsLoaded == false) then
			tabBgImg.Image = "rbxassetid://" .. idStr0
		end
	end)
	State._tabBgImages = State._tabBgImages or {}
	table.insert(State._tabBgImages, tabBgImg)

	-- Overlay oscuro para legibilidad del texto
	local tabOverlay = Instance.new("Frame", btn)
	tabOverlay.Name = "TabDarkOverlay"
	tabOverlay.Size = UDim2.new(1, 0, 1, 0)
	tabOverlay.BackgroundColor3 = Color3.fromRGB(8, 14, 28)
	tabOverlay.BackgroundTransparency = 0.62
	tabOverlay.BorderSizePixel = 0
	tabOverlay.ZIndex = 8
	Instance.new("UICorner", tabOverlay).CornerRadius = UDim.new(0, 11)

	local lbl = Instance.new("TextLabel", btn)
	lbl.Size = UDim2.new(1, 0, 1, 0)
	lbl.Position = UDim2.new(0, 0, 0, 0)
	lbl.BackgroundTransparency = 1
	lbl.Text = td.name
	lbl.TextColor3 = IDLE_TAB_TXT
	lbl.Font = Enum.Font.GothamBold
	lbl.TextSize = (td.name == "Performance" or td.name == "Background") and 8 or 9
	lbl.TextXAlignment = Enum.TextXAlignment.Center
	lbl.TextWrapped = false
	lbl.TextTruncate = Enum.TextTruncate.AtEnd
	lbl.ZIndex = 11
	local activeMark = Instance.new("Frame", btn)
	activeMark.Name = "ActiveMark"
	activeMark.Size = UDim2.new(0, 3, 0, 14)
	activeMark.Position = UDim2.new(0, 3, 0.5, -7)
	activeMark.BackgroundColor3 = WHITE
	activeMark.BackgroundTransparency = 1
	activeMark.BorderSizePixel = 0
	activeMark.ZIndex = 12
	Instance.new("UICorner", activeMark).CornerRadius = UDim.new(1, 0)

	tabs[td.name] = {frame=btn, lbl=lbl, mark=activeMark, bgImg=tabBgImg, overlay=tabOverlay}

	local page = Instance.new("ScrollingFrame", content)
	page.Size = UDim2.new(1, 0, 1, 0)
	page.BackgroundColor3 = BG
	page.BackgroundTransparency = 1
	page.BorderSizePixel = 0
	page.ScrollBarThickness = 3
	page.ScrollBarImageColor3 = BORDER
	page.AutomaticCanvasSize = Enum.AutomaticSize.Y
	page.CanvasSize = UDim2.new(0, 0, 0, 0)
	page.Visible = false
	page.ZIndex = 3
	local pll = Instance.new("UIListLayout", page)
	pll.SortOrder = Enum.SortOrder.LayoutOrder
	pll.Padding = UDim.new(0, 7)
	local pp = Instance.new("UIPadding", page)
	pp.PaddingLeft = UDim.new(0, 13)
	pp.PaddingRight = UDim.new(0, 13)
	pp.PaddingTop = UDim.new(0, 12)
	pp.PaddingBottom = UDim.new(0, 12)
	tabPages[td.name] = page
	pageLOs[td.name] = 0
	btn.Activated:Connect(function()
		switchTab(td.name)
		if State._uiParticleBurst then State._uiParticleBurst(4) end
	end)
	btn.MouseEnter:Connect(function()
		if activeTabName ~= td.name then
			TweenService:Create(btn, TweenInfo.new(0.1), {BackgroundColor3=ACTIVE_TAB_BG, BackgroundTransparency=0.4}):Play()
			if tabOverlay then TweenService:Create(tabOverlay, TweenInfo.new(0.1), {BackgroundTransparency=0.72}):Play() end
			if tabBgImg then TweenService:Create(tabBgImg, TweenInfo.new(0.1), {ImageTransparency=0.2}):Play() end
		end
	end)
	btn.MouseLeave:Connect(function()
		if activeTabName ~= td.name then
			TweenService:Create(btn, TweenInfo.new(0.1), {BackgroundColor3=IDLE_TAB_BG, BackgroundTransparency=0.55}):Play()
			if tabOverlay then TweenService:Create(tabOverlay, TweenInfo.new(0.1), {BackgroundTransparency=0.62}):Play() end
			if tabBgImg then TweenService:Create(tabBgImg, TweenInfo.new(0.1), {ImageTransparency=0.28}):Play() end
		end
	end)
end

local function lo(tabName) pageLOs[tabName] = pageLOs[tabName] + 1; return pageLOs[tabName] end
local function pg(tabName) return tabPages[tabName] end

local function makeSecHeader(tabName, text)
	local f = Instance.new("Frame", pg(tabName))
	f.Size = UDim2.new(1, 0, 0, 24)
	f.BackgroundTransparency = 1
	f.BorderSizePixel = 0
	f.LayoutOrder = lo(tabName)
	f.ZIndex = 4

	local accent = Instance.new("Frame", f)
	accent.Size = UDim2.new(0, 3, 0, 12)
	accent.Position = UDim2.new(0, 0, 0.5, -6)
	accent.BackgroundColor3 = WHITE
	accent.BorderSizePixel = 0
	accent.ZIndex = 5
	Instance.new("UICorner", accent).CornerRadius = UDim.new(1, 0)

	local t = Instance.new("TextLabel", f)
	t.Size = UDim2.new(1, -12, 0, 16)
	t.Position = UDim2.new(0, 9, 0, 1)
	t.BackgroundTransparency = 1
	t.Text = text:upper()
	t.TextColor3 = WHITE
	t.Font = Enum.Font.GothamBold
	t.TextSize = 8
	t.TextXAlignment = Enum.TextXAlignment.Left
	t.TextWrapped = false
	t.TextTruncate = Enum.TextTruncate.AtEnd
	t.ZIndex = 5

	local line = Instance.new("Frame", f)
	line.Size = UDim2.new(1, -9, 0, 1)
	line.Position = UDim2.new(0, 9, 1, -2)
	line.BackgroundColor3 = BORDER
	line.BackgroundTransparency = 0.25
	line.BorderSizePixel = 0
	line.ZIndex = 4
end

local _unwalkSavedAnimate = nil
local function startUnwalk()
    local c = LP.Character; if not c then return end
    local hum = c:FindFirstChildOfClass("Humanoid")
    if hum then for _,t in ipairs(hum:GetPlayingAnimationTracks()) do pcall(function() t:Stop() end) end end
    local anim = c:FindFirstChild("Animate")
    if anim then _unwalkSavedAnimate = anim:Clone(); anim:Destroy() end
end
local function stopUnwalk()
    local c = LP.Character
    if c then
        local existing = c:FindFirstChild("Animate")
        if not existing then
            local src = game:GetService("StarterPlayer"):FindFirstChildOfClass("StarterCharacterScripts")
            local starterAnim = src and src:FindFirstChild("Animate")
            if starterAnim then starterAnim:Clone().Parent = c
            elseif _unwalkSavedAnimate then _unwalkSavedAnimate:Clone().Parent = c end
        end
    end
    _unwalkSavedAnimate = nil
end

local function baseCard(tabName, h2)
	local c = Instance.new("Frame", pg(tabName))
	c.Size = UDim2.new(1, 0, 0, h2 or 38)
	c.BackgroundColor3 = CARD_BG
	c.BackgroundTransparency = OPTION_TRANSPARENCY
	c.BorderSizePixel = 0
	c.LayoutOrder = lo(tabName)
	c.ZIndex = 4
	Instance.new("UICorner", c).CornerRadius = UDim.new(0, 12)
	local cSt = Instance.new("UIStroke", c)
	cSt.Color = BORDER
	cSt.Thickness = 1
	cSt.Transparency = 0.18

	local sideAccent = Instance.new("Frame", c)
	sideAccent.Name = "VisualAccent"
	sideAccent.Size = UDim2.new(0, 2, 0.54, 0)
	sideAccent.Position = UDim2.new(0, 1, 0.23, 0)
	sideAccent.BackgroundColor3 = BORDER
	sideAccent.BackgroundTransparency = 0.2
	sideAccent.BorderSizePixel = 0
	sideAccent.ZIndex = 5
	Instance.new("UICorner", sideAccent).CornerRadius = UDim.new(1, 0)

	local bottomDetail = Instance.new("Frame", c)
	bottomDetail.Name = "BottomDetail"
	bottomDetail.Size = UDim2.new(1, -24, 0, 1)
	bottomDetail.Position = UDim2.new(0, 12, 1, -1)
	bottomDetail.BackgroundColor3 = Color3.fromRGB(150,150,160)
	bottomDetail.BackgroundTransparency = 0.58
	bottomDetail.BorderSizePixel = 0
	bottomDetail.ZIndex = 5

	c.MouseEnter:Connect(function() TweenService:Create(c, TweenInfo.new(0.1), {BackgroundColor3=CARD_HOV, BackgroundTransparency=OPTION_HOVER_TRANSPARENCY}):Play() end)
	c.MouseLeave:Connect(function() TweenService:Create(c, TweenInfo.new(0.1), {BackgroundColor3=CARD_BG, BackgroundTransparency=OPTION_TRANSPARENCY}):Play() end)
	return c
end

local function cLabel(p, text, x, w, sz, col, font, xa)
	local l = Instance.new("TextLabel", p)
	l.Size = UDim2.new(0, w or 140, 1, 0)
	l.Position = UDim2.new(0, x or 10, 0, 0)
	l.BackgroundTransparency = 1
	l.Text = text
	l.TextColor3 = col or WHITE
	l.Font = font or Enum.Font.GothamBold
	l.TextSize = sz or 11
	l.TextXAlignment = xa or Enum.TextXAlignment.Left
	l.ZIndex = 10
	return l
end

local function makePillToggle(parent, defOn, onToggle)
	local PW, PH = 36, 19
	local pbg = Instance.new("Frame", parent)
	pbg.Size = UDim2.new(0, PW, 0, PH)
	pbg.Position = UDim2.new(1, -(PW+10), 0.5, -PH/2)
	pbg.BackgroundColor3 = defOn and WHITE or DIM2
	pbg.BorderSizePixel = 0
	pbg.ZIndex = 8
	Instance.new("UICorner", pbg).CornerRadius = UDim.new(0, 10)
	local ps = Instance.new("UIStroke", pbg); ps.Color = defOn and WHITE or BORDER2; ps.Thickness = 1
	local dot = Instance.new("Frame", pbg)
	dot.Size = UDim2.new(0, 13, 0, 13)
	dot.Position = defOn and UDim2.new(1, -15, 0.5, -6) or UDim2.new(0, 2, 0.5, -6)
	dot.BackgroundColor3 = defOn and BG or BORDER
	dot.BorderSizePixel = 0
	dot.ZIndex = 9
	Instance.new("UICorner", dot).CornerRadius = UDim.new(1, 0)
	local isOn = defOn or false
	local function setV(on)
		isOn = on
		TweenService:Create(pbg, TweenInfo.new(0.18), {BackgroundColor3=on and WHITE or DIM2}):Play()
		TweenService:Create(ps,  TweenInfo.new(0.18), {Color=on and WHITE or BORDER2}):Play()
		TweenService:Create(dot, TweenInfo.new(0.18, Enum.EasingStyle.Back), {
			Position = on and UDim2.new(1,-15,0.5,-6) or UDim2.new(0,2,0.5,-6),
			BackgroundColor3 = on and BG or BORDER
		}):Play()
	end
	local clk = Instance.new("TextButton", parent)
	clk.Size = UDim2.new(1, 0, 1, 0)
	clk.BackgroundTransparency = 1
	clk.Text = ""
	clk.ZIndex = 6
	clk.MouseButton1Click:Connect(function()
		if _anyKeyListening then return end
		isOn = not isOn; setV(isOn); if onToggle then pcall(onToggle, isOn) end
		if State.requestConfigSave then State.requestConfigSave() end
	end)
	return setV
end

local function makeKB(parent, kbEntry, onChange)
	local b = Instance.new("TextButton", parent)
	b.Size = UDim2.new(0, 44, 0, 20)
	b.BackgroundColor3 = KB_BG
	b.BackgroundTransparency = INPUT_TRANSPARENCY
	b.BorderSizePixel = 0
	local function getDisplayText()
		if kbEntry.gp then return "GP:"..kbEntry.gp.Name
		elseif kbEntry.kb then return kbEntry.kb.Name
		else return "None" end
	end
	b.Text = getDisplayText()
	State._bindButtons = State._bindButtons or {}
	State._bindButtons[kbEntry] = b
	b.TextColor3 = WHITE
	b.Font = Enum.Font.GothamBold
	b.TextSize = 8
	b.ZIndex = 11
	Instance.new("UICorner", b).CornerRadius = UDim.new(0, 10)
	local bs = Instance.new("UIStroke", b); bs.Color = BORDER; bs.Thickness = 1
	local li = false; local lc; local pv = b.Text
	b.MouseButton1Click:Connect(function()
		if li then li=false; _anyKeyListening=false; if lc then lc:Disconnect(); lc=nil end; b.Text=pv; b.TextColor3=WHITE; return end
		pv=b.Text; li=true; _anyKeyListening=true; b.Text="Â·Â·Â·"; b.TextColor3=DIM
		TweenService:Create(bs, TweenInfo.new(0.1), {Color=WHITE}):Play()
		lc = UIS.InputBegan:Connect(function(inp)
			if not li then return end
			local isKb = inp.UserInputType == Enum.UserInputType.Keyboard
			local isGp = string.sub(inp.UserInputType.Name, 1, 7) == "Gamepad"
			if not isKb and not isGp then return end
			if inp.KeyCode == Enum.KeyCode.Escape then
				li=false; _anyKeyListening=false; if lc then lc:Disconnect(); lc=nil end
				b.Text=pv; b.TextColor3=WHITE; TweenService:Create(bs,TweenInfo.new(0.1),{Color=BORDER}):Play(); return
			end
			if isGp then
				kbEntry.gp = inp.KeyCode; kbEntry.kb = nil
				b.Text = "GP:"..inp.KeyCode.Name; pv = b.Text
			else
				kbEntry.kb = inp.KeyCode; kbEntry.gp = nil
				b.Text = inp.KeyCode.Name; pv = b.Text
			end
			b.TextColor3=WHITE
			li=false; _anyKeyListening=false; if lc then lc:Disconnect(); lc=nil end
			TweenService:Create(bs, TweenInfo.new(0.1), {Color=BORDER}):Play()
			if onChange then onChange(inp.KeyCode) end
			if isGp then
				kbEntry.gp = inp.KeyCode; kbEntry.kb = nil
			else
				kbEntry.kb = inp.KeyCode; kbEntry.gp = nil
			end
			if State.requestConfigSave then State.requestConfigSave() end
		end)
	end)
	return b
end

local function rowToggle(tabName, label, sub, defOn, onToggle)
	local c = baseCard(tabName, sub and 58 or 38)
	local titleLabel = cLabel(c, label, 10, 160, 11, WHITE, Enum.Font.GothamBold)
	if sub then
		titleLabel.Size = UDim2.new(0, 160, 0, 18)
		titleLabel.Position = UDim2.new(0, 10, 0, 7)
		local sl = cLabel(c, sub, 10, 170, 9, DIM, Enum.Font.Gotham)
		sl.Size = UDim2.new(0, 170, 0, 13)
		sl.Position = UDim2.new(0, 10, 0, 35)
	end
	return makePillToggle(c, defOn, onToggle)
end

local function rowToggleKB(tabName, label, sub, kbEntry, defOn, onToggle, onKeyChange)
	local c = baseCard(tabName, sub and 58 or 38)
	local titleLabel = cLabel(c, label, 10, 120, 11, WHITE, Enum.Font.GothamBold)
	if sub then
		titleLabel.Size = UDim2.new(0, 120, 0, 18)
		titleLabel.Position = UDim2.new(0, 10, 0, 7)
		local sl = cLabel(c, sub, 10, 150, 9, DIM, Enum.Font.Gotham)
		sl.Size = UDim2.new(0, 150, 0, 13)
		sl.Position = UDim2.new(0, 10, 0, 35)
	end
	local kb = makeKB(c, kbEntry, function(k) if onKeyChange then onKeyChange(k) end end)
	kb.Position = UDim2.new(1, -(44+10+36+8+19), 0.5, -10)
	kb.ZIndex = 11
	local PW, PH = 36, 19
	local pbg = Instance.new("Frame", c)
	pbg.Size = UDim2.new(0, PW, 0, PH)
	pbg.Position = UDim2.new(1, -(PW+10), 0.5, -PH/2)
	pbg.BackgroundColor3 = defOn and WHITE or DIM2
	pbg.BorderSizePixel = 0
	pbg.ZIndex = 8
	Instance.new("UICorner", pbg).CornerRadius = UDim.new(0, 10)
	local ps = Instance.new("UIStroke", pbg); ps.Color = defOn and WHITE or BORDER2; ps.Thickness = 1
	local dot = Instance.new("Frame", pbg)
	dot.Size = UDim2.new(0, 13, 0, 13)
	dot.Position = defOn and UDim2.new(1, -15, 0.5, -6) or UDim2.new(0, 2, 0.5, -6)
	dot.BackgroundColor3 = defOn and BG or BORDER
	dot.BorderSizePixel = 0
	dot.ZIndex = 9
	Instance.new("UICorner", dot).CornerRadius = UDim.new(1, 0)
	local isOn = defOn or false
	local function setV(on)
		isOn = on
		TweenService:Create(pbg, TweenInfo.new(0.18), {BackgroundColor3=on and WHITE or DIM2}):Play()
		TweenService:Create(ps,  TweenInfo.new(0.18), {Color=on and WHITE or BORDER2}):Play()
		TweenService:Create(dot, TweenInfo.new(0.18, Enum.EasingStyle.Back), {
			Position = on and UDim2.new(1,-15,0.5,-6) or UDim2.new(0,2,0.5,-6),
			BackgroundColor3 = on and BG or BORDER
		}):Play()
	end
	local clk = Instance.new("TextButton", c)
	clk.Size = UDim2.new(1, 0, 1, 0)
	clk.BackgroundTransparency = 1
	clk.Text = ""
	clk.ZIndex = 6
	clk.MouseButton1Click:Connect(function()
		if _anyKeyListening then return end
		isOn = not isOn; setV(isOn); if onToggle then pcall(onToggle, isOn) end
		if State.requestConfigSave then State.requestConfigSave() end
	end)
	return setV, kb
end

local function rowKBOnly(tabName, label, sub, kbEntry, onKeyChange)
	local c = baseCard(tabName, sub and 58 or 38)
	local titleLabel = cLabel(c, label, 10, 160, 11, WHITE, Enum.Font.GothamBold)
	if sub then
		titleLabel.Size = UDim2.new(0, 160, 0, 18)
		titleLabel.Position = UDim2.new(0, 10, 0, 7)
		local sl = cLabel(c, sub, 10, 170, 9, DIM, Enum.Font.Gotham)
		sl.Size = UDim2.new(0, 170, 0, 13)
		sl.Position = UDim2.new(0, 10, 0, 35)
	end
	local kb = makeKB(c, kbEntry, function(k) if onKeyChange then onKeyChange(k) end end)
	kb.Position = UDim2.new(1, -(44+10), 0.5, -10)
	kb.ZIndex = 11
	return kb
end


local function rowInput(tabName, label, sub, default, onChange)
	local c = baseCard(tabName, sub and 58 or 38)
	local titleLabel = cLabel(c, label, 10, 130, 11, WHITE, Enum.Font.GothamBold)
	if sub then
		titleLabel.Size = UDim2.new(0, 130, 0, 18)
		titleLabel.Position = UDim2.new(0, 10, 0, 7)
		local sl = cLabel(c, sub, 10, 160, 9, DIM, Enum.Font.Gotham)
		sl.Size = UDim2.new(0, 160, 0, 13)
		sl.Position = UDim2.new(0, 10, 0, 35)
	end
	local box = Instance.new("TextBox", c)
	box.Size = UDim2.new(0, 64, 0, 24)
	box.Position = UDim2.new(1, -74, 0.5, -12)
	box.BackgroundColor3 = INPUT_BG
	box.BackgroundTransparency = INPUT_TRANSPARENCY
	box.BorderSizePixel = 0
	box.Text = tostring(default)
	box.TextColor3 = WHITE
	box.Font = Enum.Font.GothamBold
	box.TextSize = 11
	box.ClearTextOnFocus = false
	box.ZIndex = 11
	Instance.new("UICorner", box).CornerRadius = UDim.new(0, 12)
	local bs = Instance.new("UIStroke", box); bs.Color = BORDER; bs.Thickness = 1; bs.ZIndex = 12
	box.Focused:Connect(function() TweenService:Create(bs, TweenInfo.new(0.1), {Color=WHITE}):Play() end)
	box.FocusLost:Connect(function()
		TweenService:Create(bs, TweenInfo.new(0.1), {Color=BORDER}):Play()
		if onChange then local n = tonumber(box.Text); if n then onChange(n) else box.Text = tostring(default) end end
		if State.requestConfigSave then State.requestConfigSave() end
	end)
	return box
end

local function rowActionBtn(tabName, label, onClick)
	local b = Instance.new("TextButton", pg(tabName))
	b.Size = UDim2.new(1, 0, 0, 36)
	b.BackgroundColor3 = CARD_BG
	b.BackgroundTransparency = OPTION_TRANSPARENCY
	b.BorderSizePixel = 0
	b.Text = label
	b.TextColor3 = WHITE
	b.Font = Enum.Font.GothamBold
	b.TextSize = 11
	b.LayoutOrder = lo(tabName)
	b.ZIndex = 5
	Instance.new("UICorner", b).CornerRadius = UDim.new(0, 14)
	local bSt = Instance.new("UIStroke", b)
	bSt.Color = BORDER
	bSt.Thickness = 1.2

	local pressScale = Instance.new("UIScale", b)
	pressScale.Scale = 1

	b.MouseButton1Click:Connect(function()
		TweenService:Create(pressScale, TweenInfo.new(0.06), {Scale=0.975}):Play()
		TweenService:Create(b, TweenInfo.new(0.08), {BackgroundColor3=CARD_HOV, BackgroundTransparency=OPTION_HOVER_TRANSPARENCY}):Play()
		task.delay(0.08, function()
			if pressScale and pressScale.Parent then
				TweenService:Create(pressScale, TweenInfo.new(0.09, Enum.EasingStyle.Back), {Scale=1}):Play()
			end
		end)
		task.delay(0.15, function()
			if b and b.Parent then
				TweenService:Create(b, TweenInfo.new(0.1), {BackgroundColor3=CARD_BG, BackgroundTransparency=OPTION_TRANSPARENCY}):Play()
			end
		end)
		if onClick then pcall(onClick) end
	end)
	b.MouseEnter:Connect(function() TweenService:Create(b, TweenInfo.new(0.1), {BackgroundColor3=CARD_HOV, BackgroundTransparency=OPTION_HOVER_TRANSPARENCY}):Play() end)
	b.MouseLeave:Connect(function() TweenService:Create(b, TweenInfo.new(0.1), {BackgroundColor3=CARD_BG, BackgroundTransparency=OPTION_TRANSPARENCY}):Play() end)
	return b
end

local function rowCycleSelector(tabName, label, options, defaultValue, onChange)
	local c = baseCard(tabName, 40)
	cLabel(c, label, 10, 110, 11, WHITE, Enum.Font.GothamBold)

	local left = Instance.new("TextButton", c)
	left.Size = UDim2.new(0, 26, 0, 24)
	left.Position = UDim2.new(1, -142, 0.5, -12)
	left.BackgroundColor3 = INPUT_BG
	left.BackgroundTransparency = INPUT_TRANSPARENCY
	left.BorderSizePixel = 0
	left.Text = "â†"
	left.TextColor3 = WHITE
	left.Font = Enum.Font.GothamBlack
	left.TextSize = 15
	left.ZIndex = 12
	Instance.new("UICorner", left).CornerRadius = UDim.new(0, 12)
	local leftStroke = Instance.new("UIStroke", left); leftStroke.Color = BORDER; leftStroke.Thickness = 1

	local valueLabel = Instance.new("TextLabel", c)
	valueLabel.Size = UDim2.new(0, 78, 0, 24)
	valueLabel.Position = UDim2.new(1, -112, 0.5, -12)
	valueLabel.BackgroundColor3 = INPUT_BG
	valueLabel.BackgroundTransparency = INPUT_TRANSPARENCY
	valueLabel.BorderSizePixel = 0
	valueLabel.TextColor3 = WHITE
	valueLabel.Font = Enum.Font.GothamBold
	valueLabel.TextSize = 9
	valueLabel.TextXAlignment = Enum.TextXAlignment.Center
	valueLabel.ZIndex = 11
	Instance.new("UICorner", valueLabel).CornerRadius = UDim.new(0, 12)
	local valueStroke = Instance.new("UIStroke", valueLabel); valueStroke.Color = BORDER; valueStroke.Thickness = 1

	local right = Instance.new("TextButton", c)
	right.Size = UDim2.new(0, 26, 0, 24)
	right.Position = UDim2.new(1, -30, 0.5, -12)
	right.BackgroundColor3 = INPUT_BG
	right.BackgroundTransparency = INPUT_TRANSPARENCY
	right.BorderSizePixel = 0
	right.Text = "â†’"
	right.TextColor3 = WHITE
	right.Font = Enum.Font.GothamBlack
	right.TextSize = 15
	right.ZIndex = 12
	Instance.new("UICorner", right).CornerRadius = UDim.new(0, 12)
	local rightStroke = Instance.new("UIStroke", right); rightStroke.Color = BORDER; rightStroke.Thickness = 1

	local index = 1
	for i, option in ipairs(options) do
		if option == defaultValue then index = i; break end
	end

	local function setValue(value, fireCallback)
		if type(value) == "number" then
			index = ((math.floor(value) - 1) % #options) + 1
		else
			for i, option in ipairs(options) do
				if option == value then index = i; break end
			end
		end
		valueLabel.Text = options[index]
		if fireCallback and onChange then pcall(onChange, options[index], index) end
		return options[index]
	end

	local function move(direction)
		setValue(index + direction, true)
		if State.requestConfigSave then State.requestConfigSave() end
	end

	left.Activated:Connect(function() move(-1) end)
	right.Activated:Connect(function() move(1) end)
	left.MouseEnter:Connect(function() TweenService:Create(left, TweenInfo.new(0.1), {BackgroundTransparency=0.05}):Play() end)
	left.MouseLeave:Connect(function() TweenService:Create(left, TweenInfo.new(0.1), {BackgroundTransparency=INPUT_TRANSPARENCY}):Play() end)
	right.MouseEnter:Connect(function() TweenService:Create(right, TweenInfo.new(0.1), {BackgroundTransparency=0.05}):Play() end)
	right.MouseLeave:Connect(function() TweenService:Create(right, TweenInfo.new(0.1), {BackgroundTransparency=INPUT_TRANSPARENCY}):Play() end)

	setValue(defaultValue, false)
	return setValue, function() return options[index] end
end

-- SECCIÃ“N 7: PESTAÃ‘A SPEED Y AUTO CARRY
do
makeSecHeader("Speed", "Speed Configuration")

do
	local c = baseCard("Speed", 48)
	cLabel(c, "Speed Profile", 10, 92, 11, WHITE, Enum.Font.GothamBold)

	local holder = Instance.new("Frame", c)
	holder.Name = "SpeedProfileSelector"
	holder.Size = UDim2.new(0, 150, 0, 28)
	holder.Position = UDim2.new(1, -160, 0.5, -14)
	holder.BackgroundTransparency = 1
	holder.BorderSizePixel = 0
	holder.ZIndex = 12

	local layout = Instance.new("UIListLayout", holder)
	layout.FillDirection = Enum.FillDirection.Horizontal
	layout.HorizontalAlignment = Enum.HorizontalAlignment.Right
	layout.VerticalAlignment = Enum.VerticalAlignment.Center
	layout.Padding = UDim.new(0, 6)

	local function makeProfileButton(label)
		local b = Instance.new("TextButton", holder)
		b.Name = label .. "Profile"
		b.Size = UDim2.new(0, 72, 0, 28)
		b.BackgroundColor3 = CARD_BG
		b.BackgroundTransparency = 0.12
		b.BorderSizePixel = 0
		b.Text = string.upper(label)
		b.TextColor3 = DIM
		b.TextSize = 10
		b.Font = Enum.Font.GothamBold
		b.AutoButtonColor = false
		b.ZIndex = 13
		Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
		local stroke = Instance.new("UIStroke", b)
		stroke.Color = Color3.fromRGB(150,150,160)
		stroke.Thickness = 1
		stroke.Transparency = 0.3
		return b, stroke
	end

	local normalProfileBtn, normalProfileStroke = makeProfileButton("Normal")
	local laggerProfileBtn, laggerProfileStroke = makeProfileButton("Lagger")

	local function refreshProfileVisual()
		local normalActive = State.speedProfile ~= "Lagger"
		TweenService:Create(normalProfileBtn, TweenInfo.new(0.12), {
			BackgroundColor3 = normalActive and Color3.fromRGB(255, 40, 50) or CARD_BG,
			TextColor3 = normalActive and WHITE or DIM,
			BackgroundTransparency = normalActive and 0.02 or 0.12
		}):Play()
		TweenService:Create(laggerProfileBtn, TweenInfo.new(0.12), {
			BackgroundColor3 = not normalActive and Color3.fromRGB(255, 40, 50) or CARD_BG,
			TextColor3 = not normalActive and WHITE or DIM,
			BackgroundTransparency = not normalActive and 0.02 or 0.12
		}):Play()
		normalProfileStroke.Color = normalActive and Color3.fromRGB(255, 40, 50) or Color3.fromRGB(150,150,160)
		laggerProfileStroke.Color = not normalActive and Color3.fromRGB(255, 40, 50) or Color3.fromRGB(150,150,160)
	end

	local function selectProfile(profile)
		State.speedProfile = profile == "Lagger" and "Lagger" or "Normal"
		refreshProfileVisual()
		if normalBox then
			normalBox.Text = tostring(State.speedProfile == "Lagger" and State.profileLaggerNormalSpeed or NS)
		end
		if carryBox then
			carryBox.Text = tostring(State.speedProfile == "Lagger" and State.profileLaggerCarrySpeed or CS)
		end
		if modeValLbl then
			if State.laggerToggled then
				modeValLbl.Text = laggerPhase == 2 and "Lagger 2" or "Lagger 1"
			elseif State.speedToggled then
				modeValLbl.Text = State.speedProfile == "Lagger" and ("Carry Â· " .. tostring(State.profileLaggerCarrySpeed)) or "Carry"
			else
				modeValLbl.Text = State.speedProfile == "Lagger" and ("Lagger Â· " .. tostring(State.profileLaggerNormalSpeed)) or "Normal"
			end
		end
		if State.requestConfigSave then State.requestConfigSave() end
	end

	normalProfileBtn.Activated:Connect(function() selectProfile("Normal") end)
	laggerProfileBtn.Activated:Connect(function() selectProfile("Lagger") end)

	State._refreshSpeedProfileVisual = refreshProfileVisual
	State._selectSpeedProfile = selectProfile
	refreshProfileVisual()
end

normalBox = rowInput("Speed", "Normal Speed", nil, NS, function(v)
	if v > 0 and v <= 500 then
		if State.speedProfile == "Lagger" then
			State.profileLaggerNormalSpeed = v
		else
			NS = v
		end
		if State.requestConfigSave then State.requestConfigSave() end
	end
end)
carryBox = rowInput("Speed", "Carry Speed", nil, CS, function(v)
	if v > 0 and v <= 500 then
		if State.speedProfile == "Lagger" then
			State.profileLaggerCarrySpeed = v
		else
			CS = v
			_G.CarrySpeedValue = v
		end
		if State.requestConfigSave then State.requestConfigSave() end
	end
end)
laggerBox = rowInput("Speed", "Lagger 1", nil, LS, function(v) if v>0 and v<=500 then LS=v end end)
laggerBox2 = rowInput("Speed", "Lagger 2", nil, LS2, function(v) if v>0 and v<=500 then LS2=v end end)

-- ===== TOGGLE AUTO CARRY (AHORA PERSISTE) =====
do
    local sv
    sv = rowToggle("Speed", "Auto Carry", "Se activa carry automÃ¡ticamente al agarrar el Brainrot", State.autoCarryEnabled,
    function(on)
        State.autoCarryEnabled = on
        if State.requestConfigSave then State.requestConfigSave() end
    end)
    State.autoCarrySetVisual = sv
end

do
	local c = baseCard("Speed", 38)
	cLabel(c, "Mode", 10, 80, 11, WHITE, Enum.Font.GothamBold)
	modeValLbl = cLabel(c, "Normal", 88, 80, 10, DIM, Enum.Font.GothamBold, Enum.TextXAlignment.Center)
	local kb = makeKB(c, KB.Speed, function(k) end)
	kb.Position = UDim2.new(1, -(44+10), 0.5, -10)
	kb.ZIndex = 11
	local clk = Instance.new("TextButton", c)
	clk.Size = UDim2.new(0.65, 0, 1, 0)
	clk.BackgroundTransparency = 1
	clk.Text = ""
	clk.ZIndex = 6
	clk.Active = true
	clk.Activated:Connect(function()
		if _anyKeyListening then return end
		State.speedToggled = not State.speedToggled
		if State.speedToggled then
			State.laggerToggled = false
			if mobileLaggerSetActive then mobileLaggerSetActive(false) end
		end
		if mobileSpeedSetActive then mobileSpeedSetActive(State.speedToggled) end
		modeValLbl.Text = State.laggerToggled and "Lagger" or (State.speedToggled and (State.speedProfile == "Lagger" and ("Carry Â· " .. tostring(State.profileLaggerCarrySpeed)) or "Carry") or (State.speedProfile == "Lagger" and ("Lagger Â· " .. tostring(State.profileLaggerNormalSpeed)) or "Normal"))
		if State.requestConfigSave then State.requestConfigSave() end
	end)
end

do
	local c = baseCard("Speed", 38)
	cLabel(c, "Lagger Mode", 10, 120, 11, WHITE, Enum.Font.GothamBold)
	local kb = makeKB(c, KB.Lagger, function(k) KB.Lagger.kb = k end)
	kb.Position = UDim2.new(1, -(44+10), 0.5, -10)
	kb.ZIndex = 11
	local clk = Instance.new("TextButton", c)
	clk.Size = UDim2.new(0.65, 0, 1, 0)
	clk.BackgroundTransparency = 1
	clk.Text = ""
	clk.ZIndex = 6
	clk.Active = true
	clk.Activated:Connect(function()
		if _anyKeyListening then return end
		State.laggerToggled = not State.laggerToggled
		if State.laggerToggled then
			State.speedToggled = false
			if mobileSpeedSetActive then mobileSpeedSetActive(false) end
		end
		modeValLbl.Text = State.laggerToggled and "Lagger" or (State.speedToggled and (State.speedProfile == "Lagger" and ("Carry Â· " .. tostring(State.profileLaggerCarrySpeed)) or "Carry") or (State.speedProfile == "Lagger" and ("Lagger Â· " .. tostring(State.profileLaggerNormalSpeed)) or "Normal"))
		if mobileLaggerSetActive then mobileLaggerSetActive(State.laggerToggled) end
		if State.requestConfigSave then State.requestConfigSave() end
	end)
end

makeSecHeader("Bat Aimbot", "Bat Combat V1 & V2")
do
	local sv
	sv, _ = rowToggleKB("Bat Aimbot", "Auto Bat V1", "Modo predictivo", KB.AutoBat, false,
	function(on)
		State.autoBatToggled = on
		if on then
			if State.autoLeftEnabled then State.autoLeftEnabled = false; if autoLeftSetVisual then autoLeftSetVisual(false) end; stopAutoLeft() end
			if State.autoRightEnabled then State.autoRightEnabled = false; if autoRightSetVisual then autoRightSetVisual(false) end; stopAutoRight() end
			if State.autoBatV2Enabled then
				State.autoBatV2Enabled = false
				if autoBatV2SetVisual then autoBatV2SetVisual(false) end
				if mobileBatV2SetActive then mobileBatV2SetActive(false) end
				stopBatAimbotV2()
			end
			if State.tpBatEnabled then State._setTPBatEnabled(false) end
			startBatAimbot()
		else
			stopBatAimbot()
		end
		if mobileBatV1SetActive then mobileBatV1SetActive(on) end
	end,
	function(k) KB.AutoBat.kb = k end)
	autoBatSetVisual = sv
	setAutoBat = sv
end

do
	local sv
	sv, _ = rowToggleKB("Bat Aimbot", "bat v2", "VersiÃ³n avanzada ", KB.AutoBatV2, false,
	function(on)
		State.autoBatV2Enabled = on
		if on then
			if State.autoLeftEnabled then State.autoLeftEnabled = false; if autoLeftSetVisual then autoLeftSetVisual(false) end; stopAutoLeft() end
			if State.autoRightEnabled then State.autoRightEnabled = false; if autoRightSetVisual then autoRightSetVisual(false) end; stopAutoRight() end
			if State.autoBatToggled then
				State.autoBatToggled = false
				if autoBatSetVisual then autoBatSetVisual(false) end
				stopBatAimbot()
			end
			if State.tpBatEnabled then State._setTPBatEnabled(false) end
			if startBatAimbotV2 then startBatAimbotV2() end
		else
			if stopBatAimbotV2 then stopBatAimbotV2() end
		end
		if mobileBatV2SetActive then mobileBatV2SetActive(on) end
	end,
	function() end)
	autoBatV2SetVisual = sv
	setAutoBatV2 = sv
end

State._setTPBatEnabled = function(on)
	on = on == true

	if on then
		if State.autoLeftEnabled then
			State.autoLeftEnabled = false
			stopAutoLeft()
			if autoLeftSetVisual then autoLeftSetVisual(false) end
		end
		if State.autoRightEnabled then
			State.autoRightEnabled = false
			stopAutoRight()
			if autoRightSetVisual then autoRightSetVisual(false) end
		end
		if State.autoBatToggled then
			State.autoBatToggled = false
			if autoBatSetVisual then autoBatSetVisual(false) end
			stopBatAimbot()
		end
		if State.autoBatV2Enabled then
			State.autoBatV2Enabled = false
			if autoBatV2SetVisual then autoBatV2SetVisual(false) end
			if mobileBatV2SetActive then mobileBatV2SetActive(false) end
			stopBatAimbotV2()
		end
	else
	end

	State.tpBatEnabled = on
	if State._tpBatSetter then State._tpBatSetter(on) end
	if State._tpBatConfigSetVisual then State._tpBatConfigSetVisual(on) end
end

State._tpBatConfigSetVisual = rowToggleKB("Bat Aimbot", "TP BAT", "Teleport y golpe automÃ¡tico", KB.TPBat, false,
function(on)
	State._setTPBatEnabled(on)
	if State._tpBatSetter then State._tpBatSetter(on) end
end,
function() end)

makeSecHeader("Mechanics", "Game Mechanics")

if not KB.InstaReset then KB.InstaReset = {kb=nil, gp=nil} end

local cInsta = baseCard("Mechanics", 48)
cInsta.LayoutOrder = lo("Mechanics")
cLabel(cInsta, "Insta Reset", 10, 120, 11, WHITE, Enum.Font.GothamBold)
local slInsta = cLabel(cInsta, "Reset InstantÃ¡neo", 10, 150, 9, DIM, Enum.Font.Gotham)
slInsta.Size = UDim2.new(0, 150, 0, 13); slInsta.Position = UDim2.new(0, 10, 0, 24)

local plusBtn = Instance.new("TextButton", cInsta)
plusBtn.Size = UDim2.new(0, 20, 0, 20)
plusBtn.Position = UDim2.new(1, -(44+10+36+8+20+4), 0.5, -10)
plusBtn.BackgroundColor3 = KB_BG
plusBtn.BorderSizePixel = 0
plusBtn.Text = "+"
plusBtn.TextColor3 = WHITE
plusBtn.Font = Enum.Font.GothamBold
plusBtn.TextSize = 14
plusBtn.ZIndex = 11
Instance.new("UICorner", plusBtn).CornerRadius = UDim.new(0, 10)
local pbs = Instance.new("UIStroke", plusBtn); pbs.Color = BORDER; pbs.Thickness = 1
plusBtn.MouseButton1Click:Connect(function()
	TweenService:Create(plusBtn, TweenInfo.new(0.1), {BackgroundColor3=CARD_HOV}):Play()
	task.delay(0.1, function() TweenService:Create(plusBtn, TweenInfo.new(0.1), {BackgroundColor3=KB_BG}):Play() end)

	if btnInstaReset then
		btnInstaReset.Visible = not btnInstaReset.Visible
		if State.requestConfigSave then State.requestConfigSave() end
	end
end)

local kbInsta = makeKB(cInsta, KB.InstaReset, function() end)
kbInsta.Position = UDim2.new(1, -(44+10+36+8), 0.5, -10)
kbInsta.ZIndex = 11

local setInstaToggleVisual
setInstaToggleVisual = makePillToggle(cInsta, false, function(on)
	State.instaResetEnabled = on
	if on then
		if btnInstaReset then
			TweenService:Create(btnInstaReset, TweenInfo.new(0.08), {BackgroundColor3=WHITE, TextColor3=BG}):Play()
			task.delay(0.22, function()
				TweenService:Create(btnInstaReset, TweenInfo.new(0.15), {BackgroundColor3=BG, TextColor3=WHITE}):Play()
			end)
		end

		task.spawn(cursedInstaReset)

		task.wait(0.2)
		if setInstaToggleVisual then setInstaToggleVisual(false) end
	end
end)

setInfJump       = rowToggle("Mechanics", "Infinite Jump",  nil, false, function(on) State.infJumpEnabled = on end)
setSuperJump     = rowToggle("Mechanics", "Infinite Jump Hold",     nil, false, function(on) State.superJumpEnabled = on end)
setLinieVisual   = rowToggle("Mechanics", "Linia ESP", nil, false, function(on) State.linieEnabled = on end)
setAntiRag       = rowToggle("Mechanics", "Anti Ragdoll",   nil, false, function(on) State.antiRagdollEnabled=on; if on then startAntiRagdoll() else stopAntiRagdoll() end end)
setUnwalkToggle  = rowToggle("Mechanics", "Unwalk",         nil, false, function(on) State.unwalkEnabled=on; if on then startUnwalk() else stopUnwalk() end end)
setMedusaCounter = rowToggle("Mechanics", "Medusa Counter", nil, false, function(on) State.medusaCounterEnabled=on; if on then setupMedusaCounter(LP.Character) else stopMedusaCounter() end end)
setBatCounter = rowToggle("Mechanics", "Bat Counter",    nil, false, function(on) State.batCounterEnabled=on; if on then startBatCounter() else stopBatCounter() end end)

setAutoMedusaVisual = rowToggle("Mechanics", "Auto Medusa", "Uso automÃ¡tico y predictivo", false, function(on)
	MedusaConfig.Enabled = on
end)

rowToggle("Mechanics", "Medusa Reset", "Resetea al ser petrificado", false, function(on)
	pcall(function() if _G.NIGHT_setMedusaReset then _G.NIGHT_setMedusaReset(on) end end)
	State.autoResetEnabled = on
	if State.requestConfigSave then State.requestConfigSave() end
end)
setNinoTimeVisual = rowToggle("Mechanics", "Nino time", "Contador de stun de 3 segundos", false, function(on)
	setNinoTime(on)
	if State.requestConfigSave then State.requestConfigSave() end
end)

rowInput("Mechanics", "Medusa Radius", "Rango de detecciÃ³n", MedusaConfig.Radius, function(v)
	MedusaConfig.Radius = v
	if MedusaConfig.RadiusPart then
		MedusaConfig.RadiusPart.Size = Vector3.new(0.2, MedusaConfig.Radius*2, MedusaConfig.Radius*2)
	end
end)

rowInput("Mechanics", "Medusa Delay", "Spam Delay", MedusaConfig.Delay, function(v)
	MedusaConfig.Delay = v
end)

RunService.Heartbeat:Connect(function()
    if not State.superJumpEnabled then return end
    local c = LP.Character
    if not c then return end
    local root = c:FindFirstChild("HumanoidRootPart")
    local hum = c:FindFirstChildOfClass("Humanoid")
    if not root or not hum then return end

    local isJumpHeld = UIS:IsKeyDown(Enum.KeyCode.Space) or (hum.Jump == true)

    if isJumpHeld and root.Velocity.Y < 35 then
        root.Velocity = Vector3.new(root.Velocity.X, 55, root.Velocity.Z)
    end

    if root.Velocity.Y < -120 then
        root.Velocity = Vector3.new(root.Velocity.X, -120, root.Velocity.Z)
    end
end)

makeSecHeader("Movement", "Movement & Teleport")
rowKBOnly("Movement", "TP Down", "Teleport to floor", KB.TPDown, function(k) KB.TPDown.kb=k end)
do
	local sv
	sv, _ = rowToggleKB("Movement", "Auto Left", nil, KB.AutoLeft, false,
	function(on)
		State.autoLeftEnabled = on
		if on then
			if State.autoRightEnabled then State.autoRightEnabled=false; if autoRightSetVisual then autoRightSetVisual(false) end; stopAutoRight() end
			if State.autoBatToggled then State.autoBatToggled=false; if autoBatSetVisual then autoBatSetVisual(false) end; stopBatAimbot() end
			if State.autoBatV2Enabled then
				State.autoBatV2Enabled = false
				if autoBatV2SetVisual then autoBatV2SetVisual(false) end
				if mobileBatV2SetActive then mobileBatV2SetActive(false) end
				stopBatAimbotV2()
			end
			if State.tpBatEnabled then State._setTPBatEnabled(false) end
			local char = LP.Character
			local hum = char and char:FindFirstChildOfClass("Humanoid")
			local hrp = char and char:FindFirstChild("HumanoidRootPart")
			if hum and hrp and hum.WalkSpeed > 0 and not hrp.Anchored then
				startAutoLeft()
			end
		else stopAutoLeft() end
		if mobileAutoLeftSetActive then mobileAutoLeftSetActive(on) end
	end, function(k) KB.AutoLeft.kb=k end)
	autoLeftSetVisual = sv
end
do
	local sv
	sv, _ = rowToggleKB("Movement", "Auto Right", nil, KB.AutoRight, false,
	function(on)
		State.autoRightEnabled = on
		if on then
			if State.autoLeftEnabled then State.autoLeftEnabled=false; if autoLeftSetVisual then autoLeftSetVisual(false) end; stopAutoLeft() end
			if State.autoBatToggled then State.autoBatToggled=false; if autoBatSetVisual then autoBatSetVisual(false) end; stopBatAimbot() end
			if State.autoBatV2Enabled then State.autoBatV2Enabled=false; if autoBatV2SetVisual then autoBatV2SetVisual(false) end; stopBatAimbotV2() end
			if State.tpBatEnabled then State._setTPBatEnabled(false) end
			local char = LP.Character
			local hum = char and char:FindFirstChildOfClass("Humanoid")
			local hrp = char and char:FindFirstChild("HumanoidRootPart")
			if hum and hrp and hum.WalkSpeed > 0 and not hrp.Anchored then
				startAutoRight()
			end
		else stopAutoRight() end
		if mobileAutoRightSetActive then mobileAutoRightSetActive(on) end
	end, function(k) KB.AutoRight.kb=k end)
	autoRightSetVisual = sv
end
rowKBOnly("Movement", "Drop",    nil, KB.Drop,   function(k) KB.Drop.kb=k end)

do
	setAutoTPDownVisual = rowToggle("Movement", "Auto TP Down", nil, false, function(on)
		autoTPDownEnabled = on
		if mobileAutoTPSetActive then mobileAutoTPSetActive(on) end
		if on then startAutoTPDown() else stopAutoTPDown() end
	end)
	rowInput("Movement", "TP Down Height", nil, autoTPDownHeight, function(v)
		autoTPDownHeight = math.clamp(v, 0, 500)
	end)
end

makeSecHeader("Performance", "Performance")

-- ============================================================
--  ELIMINADO EL TOGGLE DE HITBOX FOLLOWER
-- ============================================================

do
	local _Lighting = game:GetService("Lighting")
	local _antiLagConn = nil

	local function applyAntiLag(instance)
		if instance:IsA("ParticleEmitter") then
			instance.Enabled = false
		elseif instance:IsA("Decal") then
			instance.Transparency = 1
		elseif instance:IsA("BasePart") then
			instance.Material = Enum.Material.Plastic
			instance.Reflectance = 0
			instance.CastShadow = false
		end
	end

	local function optimizeLighting()
		_Lighting.GlobalShadows = false
		_Lighting.FogEnd = 9e9
		_Lighting.Brightness = 1
		_Lighting.EnvironmentDiffuseScale = 0
		_Lighting.EnvironmentSpecularScale = 0
		for _, child in pairs(_Lighting:GetChildren()) do
			if child:IsA("BloomEffect") or child:IsA("BlurEffect") or child:IsA("SunRaysEffect") then
				child.Enabled = false
			end
		end
	end

	local function enableAntiLag()
		optimizeLighting()
		for _, desc in pairs(workspace:GetDescendants()) do
			applyAntiLag(desc)
			if desc:IsA("Accessory") then desc:Destroy() end
		end
		if _antiLagConn then _antiLagConn:Disconnect() end
		_antiLagConn = workspace.DescendantAdded:Connect(function(desc)
			applyAntiLag(desc)
			if desc:IsA("Accessory") then desc:Destroy() end
		end)
	end

	local function disableAntiLag()
		if _antiLagConn then _antiLagConn:Disconnect(); _antiLagConn = nil end
	end

	setAntiLag = function(on)
		State.antiLagEnabled = on
		if on then enableAntiLag() else disableAntiLag() end
	end
	local setAntiLagVisual = rowToggle("Performance", "Anti Lag", nil, false, function(on) setAntiLag(on) end)
	local rawSetAntiLag = setAntiLag
	setAntiLag = function(on) setAntiLagVisual(on); rawSetAntiLag(on) end
end

do
	local connection = nil
	local function rawSet(on)
		State.stretchRezEnabled = on
		if on then
			workspace.CurrentCamera.FieldOfView = 120
			if connection then connection:Disconnect() end
			connection = RunService.RenderStepped:Connect(function()
				if not State.stretchRezEnabled then
					if connection then connection:Disconnect(); connection = nil end
					return
				end
				workspace.CurrentCamera.FieldOfView = 120
			end)
		else
			if connection then connection:Disconnect(); connection = nil end
			workspace.CurrentCamera.FieldOfView = 70
		end
	end
	local visual = rowToggle("Performance", "Stretch Rez", nil, false, function(on) rawSet(on) end)
	setStretchRez = function(on) visual(on); rawSet(on) end
end

do
	local connection = nil
	local function removeFromCharacter(character)
		if not character then return end
		for _, obj in ipairs(character:GetDescendants()) do
			if obj:IsA("Accessory") or obj:IsA("Hat") then
				pcall(function() obj:Destroy() end)
			end
		end
	end
	local function rawSet(on)
		State.removeAccessoriesEnabled = on
		if on then
			for _, player in pairs(Players:GetPlayers()) do
				removeFromCharacter(player.Character)
			end
			if not connection then
				connection = Players.PlayerAdded:Connect(function(player)
					player.CharacterAdded:Connect(function(character)
						task.wait(0.5)
						if State.removeAccessoriesEnabled then removeFromCharacter(character) end
					end)
				end)
			end
		else
			if connection then connection:Disconnect(); connection = nil end
		end
	end
	local visual = rowToggle("Performance", "Remove Accessories", nil, false, function(on) rawSet(on) end)
	setRemoveAccessories = function(on) visual(on); rawSet(on) end
end

do
	local Lighting = game:GetService("Lighting")
	local defaults = {
		Brightness = Lighting.Brightness,
		ClockTime = Lighting.ClockTime,
		ExposureCompensation = Lighting.ExposureCompensation,
		OutdoorAmbient = Lighting.OutdoorAmbient,
		Ambient = Lighting.Ambient,
		FogColor = Lighting.FogColor,
	}
	local styles = {
		{name="Off"},
		{name="Galaxy", tint=Color3.fromRGB(255, 40, 50), ambient=Color3.fromRGB(15, 40, 80), atmosphere=Color3.fromRGB(150,150,160), decay=Color3.fromRGB(10, 25, 50)},
		{name="Aurora", tint=Color3.fromRGB(190,190,200), ambient=Color3.fromRGB(20, 50, 90), atmosphere=Color3.fromRGB(255, 40, 50), decay=Color3.fromRGB(15, 35, 70)},
		{name="Green", tint=Color3.fromRGB(165,255,165), ambient=Color3.fromRGB(35,92,42), atmosphere=Color3.fromRGB(78,232,98), decay=Color3.fromRGB(14,48,20)},
		{name="Blue", tint=Color3.fromRGB(57,198,255), ambient=Color3.fromRGB(12,58,118), atmosphere=Color3.fromRGB(27,148,255), decay=Color3.fromRGB(15,30,76)},
		{name="Red", tint=Color3.fromRGB(255,80,80), ambient=Color3.fromRGB(120,20,40), atmosphere=Color3.fromRGB(200,50,50), decay=Color3.fromRGB(100,20,30)},
		{name="Pink", tint=Color3.fromRGB(255,175,228), ambient=Color3.fromRGB(120,38,90), atmosphere=Color3.fromRGB(255,98,195), decay=Color3.fromRGB(62,14,48)},
		{name="Orange", tint=Color3.fromRGB(255,195,125), ambient=Color3.fromRGB(18,58,130), atmosphere=Color3.fromRGB(18,135,255), decay=Color3.fromRGB(6,28,68)},
		{name="Cyan", tint=Color3.fromRGB(145,255,255), ambient=Color3.fromRGB(8,95,105), atmosphere=Color3.fromRGB(20,225,240), decay=Color3.fromRGB(8,48,58)},
	}
	local function findStyle(name)
		for _, style in ipairs(styles) do
			if style.name == name then return style end
		end
		return styles[1]
	end
	local function clearSky()
		for _, name in ipairs({"GalaxySky", "CryonColorSky", "CryonSkyTint", "CryonSkyAtmosphere", "CryonSkyBloom"}) do
			local object = Lighting:FindFirstChild(name)
			if object then object:Destroy() end
		end
	end
	local function apply(styleName)
		local style = findStyle(styleName)
		clearSky()
		State.skyStyle = style.name
		State.darkModeEnabled = style.name ~= "Off"
		if style.name == "Off" then
			Lighting.Brightness = defaults.Brightness
			Lighting.ClockTime = defaults.ClockTime
			Lighting.ExposureCompensation = defaults.ExposureCompensation
			Lighting.OutdoorAmbient = defaults.OutdoorAmbient
			Lighting.Ambient = defaults.Ambient
			Lighting.FogColor = defaults.FogColor
			return style.name
		end
		local sky = Instance.new("Sky")
		sky.Name = "CryonColorSky"
		sky.SkyboxBk = "rbxassetid://159454299"
		sky.SkyboxDn = "rbxassetid://159454296"
		sky.SkyboxFt = "rbxassetid://159454293"
		sky.SkyboxLf = "rbxassetid://159454286"
		sky.SkyboxRt = "rbxassetid://159454289"
		sky.SkyboxUp = "rbxassetid://159454291"
		sky.StarCount = 3000
		sky.Parent = Lighting
		local correction = Instance.new("ColorCorrectionEffect")
		correction.Name = "CryonSkyTint"
		correction.TintColor = style.tint
		correction.Brightness = 0.05
		correction.Contrast = 0.16
		correction.Saturation = 0.12
		correction.Parent = Lighting
		local atmosphere = Instance.new("Atmosphere")
		atmosphere.Name = "CryonSkyAtmosphere"
		atmosphere.Color = style.atmosphere
		atmosphere.Decay = style.decay
		atmosphere.Density = 0.20
		atmosphere.Offset = 0.05
		atmosphere.Glare = style.name == "Aurora" and 0.42 or 0.2
		atmosphere.Haze = style.name == "Aurora" and 1.55 or 0.85
		atmosphere.Parent = Lighting
		local bloom = Instance.new("BloomEffect")
		bloom.Name = "CryonSkyBloom"
		bloom.Intensity = style.name == "Aurora" and 0.62 or 0.42
		bloom.Size = 28
		bloom.Threshold = 1.05
		bloom.Parent = Lighting
		Lighting.Brightness = 1.45
		Lighting.ClockTime = 0
		Lighting.ExposureCompensation = 0.10
		Lighting.OutdoorAmbient = style.ambient
		Lighting.Ambient = style.ambient:Lerp(Color3.fromRGB(12, 12, 12), 0.16)
		Lighting.FogColor = style.atmosphere:Lerp(Color3.fromRGB(8, 8, 8), 0.05)
		return style.name
	end
	local names = {}
	for _, style in ipairs(styles) do table.insert(names, style.name) end
	setSkySelectorVisual = rowCycleSelector("Performance", "Sky Color", names, State.skyStyle or "Off", function(styleName)
		apply(styleName)
	end)
	setSkyStyle = function(styleName)
		local applied = apply(styleName)
		if setSkySelectorVisual then setSkySelectorVisual(applied, false) end
		return applied
	end
	setDarkMode = function(on)
		return setSkyStyle(on and ((State.skyStyle and State.skyStyle ~= "Off") and State.skyStyle or "Galaxy") or "Off")
	end
end

setNoIntroToggle = rowToggle("Performance", "No Intro", "Desactiva la intro al volver a ejecutar", State.noIntro == true, function(on)
    State.noIntro = on == true
    State.introEnabled = not State.noIntro
    if State.requestConfigSave then State.requestConfigSave() else pcall(saveConfig) end
end)

makeSecHeader("Settings", "Interface & Binds")

uiScaleBox = rowInput("Settings", "UI Scale", nil, uiScaleValue, function(v)
	local n = math.clamp(math.floor(v + 0.5), 50, 150)
	uiScaleValue = n
	if mainUIScale then mainUIScale.Scale = n / 100 end
	if uiScaleBox then uiScaleBox.Text = tostring(n) end
	if State.requestConfigSave then State.requestConfigSave() else pcall(saveConfig) end
end)

buttonsSizeBox = rowInput("Settings", "Buttons Size", "0 = mÃ­nimo â€¢ 100 = mÃ¡ximo", State.buttonsSizeValue, function(v)
	local n = math.clamp(math.floor(v + 0.5), 0, 100)
	applyMobileButtonsSize(n)
	if buttonsSizeBox then buttonsSizeBox.Text = tostring(n) end
	if State.requestConfigSave then State.requestConfigSave() else pcall(saveConfig) end
end)

State._buttonsShapeSelectorVisual = rowCycleSelector(
	"Settings",
	"Buttons Shape",
	{"Circle", "Normal", "Square", "Rectangle"},
	State.buttonsShape,
	function(shapeName)
		applyMobileButtonsShape(shapeName)
	end
)

rowKBOnly("Settings", "Hide / Show GUI", nil, KB.GuiHide, function(k) KB.GuiHide.kb=k end)

setHideButtonsVisual = rowToggle("Settings", "Hide Buttons", "Oculta todos los botones flotantes", false, function(on)
	State.hideButtonsEnabled = on
	local visible = not on

	if MobilePanel then MobilePanel.Visible = visible end
	for _, mobileBtn in pairs(mobileButtonsByName) do
		if mobileBtn and mobileBtn.Parent then
			mobileBtn.Visible = visible
		end
	end

	if btnBatV2 then btnBatV2.Visible = visible end
	if btnInstaReset then btnInstaReset.Visible = visible end
	if State.requestConfigSave then State.requestConfigSave() else pcall(saveConfig) end
end)

setLockUIVisual = rowToggle("Settings", "Lock UI", nil, false, function(on)
	uiLocked = on
	if State.requestConfigSave then State.requestConfigSave() else pcall(saveConfig) end
end)

makeSecHeader("Songs", "Songs")

do
	local songParent = game:GetService("CoreGui")
	local starterGui = game:GetService("StarterGui")
	local assetFunction = getcustomasset or getsynasset

	local function notifySong(title, message)
		warn("[CT Duels " .. string.upper(title) .. "] " .. tostring(message))
		pcall(function()
			starterGui:SetCore("SendNotification", {
				Title = title,
				Text = tostring(message),
				Duration = 6
			})
		end)
	end

	local function fileExists(path)
		if type(isfile) ~= "function" then
			return false
		end
		local ok, exists = pcall(isfile, path)
		return ok and exists == true
	end

	local function validAudio(data)
		if type(data) ~= "string" or #data < 2048 then
			return false
		end
		local header = data:sub(1, 256):lower()
		return not (
			header:find("<html", 1, true)
			or header:find("<!doctype", 1, true)
			or header:find("access denied", 1, true)
			or header:find("not found", 1, true)
			or header:find("error", 1, true)
		)
	end

	local function downloadAudio(url, path)
		if type(writefile) ~= "function" then
			return false, "writefile no estÃ¡ disponible"
		end

		local data, lastError
		local requestFunction = request
			or http_request
			or (syn and syn.request)
			or (fluxus and fluxus.request)

		if type(requestFunction) == "function" then
			local ok, response = pcall(requestFunction, {
				Url = url,
				Method = "GET",
				Headers = {
					["User-Agent"] = "Mozilla/5.0",
					["Accept"] = "audio/mpeg,audio/*;q=0.9,*/*;q=0.8"
				}
			})
			if ok and type(response) == "table" then
				local code = tonumber(response.StatusCode or response.Status or response.status_code) or 0
				local body = response.Body or response.body
				if (code == 0 or (code >= 200 and code < 300)) and validAudio(body) then
					data = body
				else
					lastError = "respuesta HTTP invÃ¡lida (" .. tostring(code) .. ")"
				end
			elseif not ok then
				lastError = tostring(response)
			end
		end

		if not data then
			local ok, result = pcall(function()
				return game:HttpGet(url, true)
			end)
			if ok and validAudio(result) then
				data = result
			elseif not ok then
				lastError = tostring(result)
			elseif not lastError then
				lastError = "el enlace no devolviÃ³ un MP3 vÃ¡lido"
			end
		end

		if not data then
			return false, lastError or "no se pudo descargar el audio"
		end

		local ok, err = pcall(writefile, path, data)
		if not ok then
			return false, tostring(err)
		end
		return true
	end

	local function addSong(config)
		local sound
		local wantedOn = false
		local preparing = false
		local started = false
		local loadedConnection

		local function destroySound()
			if loadedConnection then
				loadedConnection:Disconnect()
				loadedConnection = nil
			end
			if sound then
				pcall(function() sound:Destroy() end)
				sound = nil
			end
			started = false
		end

		local function createSound()
			if type(assetFunction) ~= "function" then
				return false, "getcustomasset/getsynasset no estÃ¡ disponible"
			end

			local ok, assetId = pcall(assetFunction, config.file)
			if not ok or type(assetId) ~= "string" or assetId == "" then
				return false, "el archivo local todavÃ­a no estÃ¡ disponible"
			end

			destroySound()
			sound = Instance.new("Sound")
			sound.Name = config.soundName
			sound.SoundId = assetId
			sound.Volume = config.volume
			sound.Looped = true
			sound.Parent = songParent

			if config.startAt and config.startAt > 0 then
				pcall(function() sound.TimePosition = config.startAt end)
				loadedConnection = sound.Loaded:Connect(function()
					if loadedConnection then
						loadedConnection:Disconnect()
						loadedConnection = nil
					end
					if sound and sound.Parent then
						pcall(function() sound.TimePosition = config.startAt end)
					end
				end)
			end
			return true
		end

		local function playNow()
			if not sound or not sound.Parent then
				return
			end
			if started then
				local ok = pcall(function() sound:Resume() end)
				if not ok then
					pcall(function() sound:Play() end)
				end
			else
				if config.startAt and config.startAt > 0 then
					pcall(function() sound.TimePosition = config.startAt end)
				end
				pcall(function() sound:Play() end)
				started = true
			end
		end

		local function prepare()
			if sound and sound.Parent then
				if wantedOn then playNow() end
				return
			end
			if preparing then return end
			preparing = true

			local alreadyDownloaded = fileExists(config.file)
			local created = select(1, createSound())

			if not created then
				if not alreadyDownloaded then
					notifySong(config.title, "Descargando " .. config.title .. " por primera vez...")
				end
				local downloaded, downloadError = downloadAudio(config.url, config.file)
				if not downloaded then
					preparing = false
					if config.notifications then
						notifySong(config.title, "No se pudo descargar: " .. tostring(downloadError))
					else
						warn("[CT Duels SONGS] " .. config.title .. ": " .. tostring(downloadError))
					end
					return
				end
				local okCreate, createError = createSound()
				if not okCreate then
					preparing = false
					if config.notifications then
						notifySong(config.title, tostring(createError))
					else
						warn("[CT Duels SONGS] " .. config.title .. ": " .. tostring(createError))
					end
					return
				end
			end

			preparing = false
			if wantedOn then playNow() end
		end

		if fileExists(config.file) then
			task.defer(function()
				if not sound then
					createSound()
				end
			end)
		end

		rowToggle("Songs", config.title, nil, false, function(on)
			wantedOn = on
			if on then
				if sound and sound.Parent then
					playNow()
				else
					task.spawn(prepare)
				end
			elseif sound then
				pcall(function() sound:Pause() end)
			end
		end)
	end

	local songs = {
		{
			title = "Tuff Song",
			url = "https://files.catbox.moe/rvf2vy.mp3",
			file = "tuffsong.mp3",
			soundName = "CTDuels_TuffSong",
			volume = 0.75
		},
		{
			title = "orula",
			url = "https://files.catbox.moe/v20ko9.mp3",
			file = "friosong.mp3",
			soundName = "CTDuels_Orula",
			volume = 0.85
		},
		{
			title = "X.O.X.O",
			url = "https://files.catbox.moe/jghp0f.mp3",
			file = "xoxosong.mp3",
			soundName = "CTDuels_XOXO",
			volume = 0.75
		},
		{
			title = "beretta",
			url = "https://file.garden/algLafWA1jk8WMfK/Beretta%20-%20video%20oficial(MP3_160K).mp3",
			file = "overseer_beretta_filegarden.mp3",
			soundName = "CTDuels_Beretta",
			volume = 0.75,
			startAt = 10,
			notifications = true
		},
		{
			title = "to the O",
			url = "https://file.garden/algLafWA1jk8WMfK/King%20Von%20-%20Took%20Her%20To%20The%20O%20(Lyrics)(MP3_160K).mp3",
			file = "overseer_to_the_o_filegarden.mp3",
			soundName = "CTDuels_ToTheO",
			volume = 0.75,
			notifications = true
		},
		{
			title = "LAJA",
			url = "https://file.garden/algLafWA1jk8WMfK/LAJA%20-%20NADIE%20TA%20FRIO%20(Letra)(MP3_160K).mp3",
			file = "overseer_laja_nadie_ta_frio_filegarden.mp3",
			soundName = "CTDuels_LAJA",
			volume = 0.75,
			notifications = true
		},
		{
			title = "HORA 0",
			url = "https://file.garden/algLafWA1jk8WMfK/Myke%20Towers%20-%20HORA%20CERO%20(Lyrics)(MP3_160K).mp3",
			file = "overseer_hora_0_filegarden.mp3",
			soundName = "CTDuels_HORA_0",
			volume = 0.75,
			notifications = true
		},
		{
			title = "Lucid Dreams",
			url = "https://file.garden/algLafWA1jk8WMfK/Lucid%20Dreams%20-%20Clean%20-%20Juice%20WRLD(MP3_160K).mp3",
			file = "overseer_lucid_dreams_filegarden.mp3",
			soundName = "CTDuels_LucidDreams",
			volume = 0.75,
			notifications = true
		}
	}

	for _, config in ipairs(songs) do
		addSong(config)
	end
end

local saveBtn; saveBtn = rowActionBtn("Settings", "Save Config", function()
	if saveConfig then
		local ok, saved = pcall(saveConfig, saveBtn)
		if (not ok or saved ~= true) and State._lastSaveError then
			warn("[CT Duels AUTO SAVE] " .. tostring(State._lastSaveError))
		end
	elseif State.savePositionBackup then
		local saved = State.savePositionBackup()
		if saveBtn and saveBtn.Parent then
			local previous = saveBtn.Text
			saveBtn.Text = saved and "Positions Saved!" or "Save Failed!"
			task.delay(1.5, function()
				if saveBtn and saveBtn.Parent then saveBtn.Text = previous end
			end)
		end
	end
end)
rowActionBtn("Settings", "Reset Mobile Buttons", function()
    if resetMobileButtons then
        resetMobileButtons()
    end
    if pbFrame then
        pbFrame.Position = UDim2.new(0.5, -150, 0, 80)
    end
    if setAutoGrabLocked then
        setAutoGrabLocked(false, true)
    end
    if setAutoGrab then
        setAutoGrab(false)
    end
end)

end

State.buildBackgroundPage = function()
	makeSecHeader("Background", "Background Images")

	local infoCard = baseCard("Background", 46)
	cLabel(infoCard, "Choose a background", 10, 250, 11, WHITE, Enum.Font.GothamBold)
	local infoSub = cLabel(infoCard, "Tap an image to apply and save it", 10, 280, 9, DIM, Enum.Font.Gotham)
	infoSub.Size = UDim2.new(1, -20, 0, 14)
	infoSub.Position = UDim2.new(0, 10, 0, 25)

	local totalBgs = #State.backgroundAssetIds
	local rows = math.ceil(totalBgs / 2)
	local gridH = rows * 88 + 8

	local grid = Instance.new("Frame", pg("Background"))
	grid.Name = "BackgroundImageGrid"
	grid.Size = UDim2.new(1, -4, 0, gridH)
	grid.BackgroundTransparency = 1
	grid.BorderSizePixel = 0
	grid.ClipsDescendants = false
	grid.LayoutOrder = lo("Background")
	grid.ZIndex = 4

	local layout = Instance.new("UIGridLayout", grid)
	layout.SortOrder = Enum.SortOrder.LayoutOrder
	layout.FillDirection = Enum.FillDirection.Horizontal
	layout.FillDirectionMaxCells = 2
	layout.CellSize = UDim2.new(0.5, -5, 0, 80)
	layout.CellPadding = UDim2.new(0, 8, 0, 8)
	layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	layout.VerticalAlignment = Enum.VerticalAlignment.Top

	for index, assetId in ipairs(State.backgroundAssetIds) do
		local thumb = Instance.new("ImageButton", grid)
		thumb.Name = "BackgroundImage" .. tostring(index)
		thumb.LayoutOrder = index
		thumb.BackgroundColor3 = Color3.fromRGB(18, 32, 55)
		thumb.BackgroundTransparency = 0.05
		thumb.BorderSizePixel = 0
		thumb.AutoButtonColor = false
		thumb.ClipsDescendants = true
		-- rbxthumb carga mejor la preview en el tab
		local idStr = tostring(assetId)
		thumb.Image = "rbxthumb://type=Asset&id=" .. idStr .. "&w=420&h=420"
		thumb.ImageTransparency = 0
		thumb.ScaleType = Enum.ScaleType.Crop
		-- fallback si rbxthumb falla
		task.defer(function()
			if thumb and thumb.Parent and (thumb.Image == "" or thumb.IsLoaded == false) then
				thumb.Image = "rbxassetid://" .. idStr
			end
		end)
		thumb.ZIndex = 6
		Instance.new("UICorner", thumb).CornerRadius = UDim.new(0, 12)

		local thumbStroke = Instance.new("UIStroke", thumb)
		thumbStroke.Color = BORDER
		thumbStroke.Thickness = 1

		local badge = Instance.new("TextLabel", thumb)
		badge.AnchorPoint = Vector2.new(1, 1)
		badge.Size = UDim2.new(0, 28, 0, 18)
		badge.Position = UDim2.new(1, -5, 1, -5)
		badge.BackgroundColor3 = Color3.fromRGB(12, 22, 40)
		badge.BackgroundTransparency = 0.08
		badge.BorderSizePixel = 0
		badge.Text = tostring(index)
		badge.TextColor3 = WHITE
		badge.Font = Enum.Font.GothamBlack
		badge.TextSize = 9
		badge.ZIndex = 8
		Instance.new("UICorner", badge).CornerRadius = UDim.new(1, 0)

		State.imageChoiceVisuals[assetId] = {stroke=thumbStroke, badge=badge, index=index}
		thumb.Activated:Connect(function()
			State.applyBackgroundImage(assetId, true)
		end)
	end

	State.applyBackgroundImage(State.backgroundAssetId, false)
end
State.buildBackgroundPage()
State.buildBackgroundPage = nil

-- ============================================================
--  APARTADO: IMÃGENES PARA LOS BOTONES MÃ“VILES
--  Usa exactamente los mismos assetIds que el selector de fondo
-- ============================================================
makeSecHeader("Background", "Button Images")
do
	local btnNames = {
		{"Drop", "Drop"},
		{"AutoLeft", "Auto Left"},
		{"AutoRight", "Auto Right"},
		{"AutoBat", "Bat Aimbot"},
		{"Speed", "Carry Spd"},
		{"Lagger", "Lagger"},
		{"TPDown", "TP Down"},
		{"TPBat", "TP Bat"},
		{"AutoTP", "Auto TP"},
		{"Taunt", "Taunt"},
		{"MusicPad", "Music Pad"},
		{"BatV2", "Bat V2"},
		{"InstaReset", "Insta Reset"},
	}

	-- Opciones legibles + mapa a assetId reales del script
	local imageOptions = {"None"}
	local optionToId = {["None"] = ""}
	local idToOption = {[""] = "None"}

	local function addOption(label, assetId)
		table.insert(imageOptions, label)
		optionToId[label] = tostring(assetId)
		idToOption[tostring(assetId)] = label
	end

	addOption("Default BG", State.backgroundAssetId or "139887397490573")
	for i, id in ipairs(State.backgroundAssetIds) do
		addOption("Image " .. i, id)
	end

	local infoCard = baseCard("Background", 40)
	cLabel(infoCard, "ImÃ¡genes en botones mÃ³viles", 10, 260, 11, WHITE, Enum.Font.GothamBold)
	local infoSub = cLabel(infoCard, "Usa las mismas imÃ¡genes del selector de fondo", 10, 280, 9, DIM, Enum.Font.Gotham)
	infoSub.Size = UDim2.new(1, -20, 0, 14)
	infoSub.Position = UDim2.new(0, 10, 0, 22)

	for _, pair in ipairs(btnNames) do
		local internalName, displayName = pair[1], pair[2]
		local savedId = State.buttonImages[internalName] or ""
		local currentLabel = idToOption[tostring(savedId)] or "None"

		rowCycleSelector("Background", displayName, imageOptions, currentLabel, function(selected)
			local assetId = optionToId[selected] or ""
			setMobileButtonImage(internalName, assetId)
		end)
	end
end

makeSecHeader("Animations", "Animation Packs")
State._animPackSelectorVisual = rowCycleSelector("Animations", "Anim Pack", {"Normal","Adidas Sports","Adidas Community","Adidas Aura","Wicked Popular","Elder","Zombie","Mage","Catwalk Glam","Astronaut","Werewolf","Superhero","Toy","No Boundaries","NFL","Amazon Unboxed","Vampire","Ninja","Robot","Levitation","Stylish","Bubbly","Cartoon"}, "Normal", function(name)
	pcall(function()
		if _G.NIGHT_applyAnimationPack then
			_G.NIGHT_applyAnimationPack(name) -- "Normal" / "Off" restaura animaciones por defecto
		end
	end)
	if State.requestConfigSave then State.requestConfigSave() end
end)

makeSecHeader("Animations", "Skins")
State._skinPackSelectorVisual = rowCycleSelector("Animations", "Skin Pack", {"Off","Korblox","Headless","Both"}, "Off", function(name)
	pcall(function() if _G.NIGHT_applySkin then _G.NIGHT_applySkin(name) end end)
	if State.requestConfigSave then State.requestConfigSave() end
end)

makeSecHeader("Animations", "Anti Die")
rowToggle("Animations", "Anti Die", "Previene la muerte", false, function(on)
	pcall(function() if _G.NIGHT_setAntiDie then _G.NIGHT_setAntiDie(on) end end)
end)

makeSecHeader("Animations", "Pack Accessory")
State._accessoryPackSelectorVisual = rowCycleSelector(
	"Animations",
	"Pack Accessory",
	_G.NIGHT_ACCESSORY_PACK_ORDER or {"Off","Bleed 1","Bleed 2","Bleed 3"},
	"Off",
	function(name)
		pcall(function()
			if _G.NIGHT_applyAccessoryPack then
				_G.NIGHT_applyAccessoryPack(name)
			end
		end)
		if State.requestConfigSave then State.requestConfigSave() end
	end
)

makeSecHeader("Animations", "Music")
do
	local musicOpts = _G.NIGHT_musicNames or {"Off","Tryhard","Tryhard 2","Tryhard Def","XD","67","3AM","Beretta","Brasil","Brasil 2","Migizin"}
	State._musicPackSelectorVisual = rowCycleSelector("Animations", "Music Pack", musicOpts, "Off", function(name)
		pcall(function() if _G.NIGHT_musicPlay then _G.NIGHT_musicPlay(name) end end)
		if State.requestConfigSave then State.requestConfigSave() end
	end)
	if not KB.MusicPC then KB.MusicPC = {kb = Enum.KeyCode.M, gp = nil} end
	if not KB.MusicPad then KB.MusicPad = {kb = nil, gp = Enum.KeyCode.DPadUp} end
end


makeSecHeader("Keybinds", "Botones laterales Â· PC + Control")
do
	local dkb = _G.NIGHT_rowDualKB
	local function r(label, entry)
		if dkb then
			dkb(baseCard, cLabel, WHITE, DIM, KB_BG, INPUT_TRANSPARENCY, BORDER, UIS, TweenService, State, "Keybinds", label, entry)
		end
	end
	if not KB.Taunt then KB.Taunt = {kb=nil, gp=nil} end
	r("Carry Speed", KB.Speed)
	r("Lagger", KB.Lagger)
	r("Drop BR", KB.Drop)
	r("TP Down", KB.TPDown)
	r("Auto Left", KB.AutoLeft)
	r("Auto Right", KB.AutoRight)
	r("Auto Bat V1", KB.AutoBat)
	r("Bat V2", KB.AutoBatV2)
	r("TP Bat", KB.TPBat)
	r("Insta Reset", KB.InstaReset)
	r("Taunt", KB.Taunt)
	r("Music", KB.MusicPC)
	r("Hide GUI", KB.GuiHide)
end


-- SECCIÃ“N 8: BOTONES MÃ“VILES
do
    	local BTN_SIZE = 60
	local BTN_GAP  = 12
	local PADDING  = 6
	MobilePanel = Instance.new("Frame")
	MobilePanel.Name = "MobileButtonsPanel"
	MobilePanel.Size = UDim2.new(0, PADDING * 2 + 3 * BTN_SIZE + 2 * BTN_GAP, 0, PADDING * 2 + 4 * BTN_SIZE + 3 * BTN_GAP)
	MobilePanel.Position = UDim2.new(1, -140, 0, 10)
	MobilePanel.BackgroundColor3 = Color3.fromRGB(16,16,18)
	MobilePanel.BackgroundTransparency = 1
	MobilePanel.BorderSizePixel = 0
	MobilePanel.ZIndex = 1
	MobilePanel.Parent = gui

	local Q_OFF      = Color3.fromRGB(12, 12, 10)
	local Q_ON       = Color3.fromRGB(220, 20, 30)
	local Q_TEXT_OFF = Color3.fromRGB(220, 200, 80)

	State._purpleAnimatedButtons = State._purpleAnimatedButtons or {}
	State._purpleAnimationPeriod = 5.5

	local purpleTextPalette = {
		Color3.fromRGB(16,16,18),
		Color3.fromRGB(255, 40, 50),
		Color3.fromRGB(180,180,190),
		Color3.fromRGB(220, 20, 30),
		Color3.fromRGB(210,210,220),
		Color3.fromRGB(180,180,190),
	}

	local function checkSpeedAndDropBeforeAction(stateCheckName, actionCallback)
		task.spawn(function()
			local char = LP.Character
			local hum = char and char:FindFirstChildOfClass("Humanoid")
			
			if hum then
				if hum.WalkSpeed < 20 then
					if State[stateCheckName] and actionCallback then
						actionCallback()
					end
					return
				end
				
				while hum and hum.WalkSpeed >= 20 and hum.WalkSpeed <= 24 and State[stateCheckName] do
					task.wait(0.5) 
					
					char = LP.Character
					hum = char and char:FindFirstChildOfClass("Humanoid")
				end
				
				if hum and hum.WalkSpeed >= 30 and State[stateCheckName] and actionCallback then
					actionCallback()
				end
			end
		end)
	end

	local function paletteColor(palette, progress)
		local count = #palette
		if count == 0 then return Color3.fromRGB(230,230,235) end
		if count == 1 then return palette[1] end
		progress = progress % 1
		local scaled = progress * count
		local index = math.floor(scaled) + 1
		local nextIndex = (index % count) + 1
		local alpha = scaled - math.floor(scaled)
		alpha = alpha * alpha * (3 - 2 * alpha)
		return palette[index]:Lerp(palette[nextIndex], alpha)
	end

	State._registerPurpleAnimatedButton = function(button)
		if not button then return end
		button:SetAttribute("PurpleActive", false)
		button:SetAttribute("PurpleFlash", false)
		button.BackgroundColor3 = Q_OFF
		button.TextColor3 = Q_TEXT_OFF
		State._purpleAnimatedButtons[button] = {
			background = button.BackgroundColor3,
			text = button.TextColor3,
		}
	end

	if not State._purpleAnimationStarted then
		State._purpleAnimationStarted = true
		task.spawn(function()
			local lastClock = os.clock()
			while gui and gui.Parent do
				local now = os.clock()
				local dt = math.min(now - lastClock, 0.1)
				lastClock = now
				local progress = (now / State._purpleAnimationPeriod) % 1
				local animatedRed = paletteColor(purpleTextPalette, progress)
				local blend = 1 - math.exp(-dt * 8)

				for button, visual in pairs(State._purpleAnimatedButtons) do
					if button and button.Parent then
						local active = button:GetAttribute("PurpleActive") == true
						local flash = button:GetAttribute("PurpleFlash") == true
						local targetBackground
						local targetText

						if active or flash then
							targetBackground = Q_ON
							targetText = Color3.fromRGB(200,200,210)
						else
							targetBackground = Q_OFF
							targetText = Q_TEXT_OFF
						end

						visual.background = visual.background:Lerp(targetBackground, blend)
						visual.text = visual.text:Lerp(targetText, blend)
						button.BackgroundColor3 = visual.background
						button.TextColor3 = visual.text
					else
						State._purpleAnimatedButtons[button] = nil
					end
				end

				RunService.RenderStepped:Wait()
			end
		end)
	end

	State._blueShineLabels = State._blueShineLabels or {}
	State._blueShineGradients = State._blueShineGradients or {}

	local function attachBlueTextShine(button)
		if not button or button:FindFirstChild("BlueTextShine") then return end

		button.TextTransparency = 1

		local shineText = Instance.new("TextLabel")
		shineText.Name = "BlueTextShine"
		shineText.BackgroundTransparency = 1
		shineText.BorderSizePixel = 0
		shineText.Size = UDim2.fromScale(1, 1)
		shineText.Position = UDim2.fromScale(0, 0)
		shineText.Text = button.Text
		shineText.TextColor3 = Color3.fromRGB(255, 255, 255)
		shineText.TextTransparency = 0
		shineText.TextScaled = button.TextScaled
		shineText.TextSize = button.TextSize
		shineText.Font = button.Font
		shineText.TextWrapped = button.TextWrapped
		shineText.LineHeight = button.LineHeight
		shineText.TextXAlignment = button.TextXAlignment
		shineText.TextYAlignment = button.TextYAlignment
		shineText.ZIndex = button.ZIndex + 1
		shineText.Active = false
		shineText.Selectable = false
		shineText.Parent = button

		local shineGradient = Instance.new("UIGradient")
		shineGradient.Name = "CleanBlueShine"
		shineGradient.Rotation = 0
		shineGradient.Offset = Vector2.new(-1.25, 0)
		shineGradient.Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0.00, Color3.fromRGB(220, 20, 30)),
			ColorSequenceKeypoint.new(0.38, Color3.fromRGB(16,16,18)),
			ColorSequenceKeypoint.new(0.50, Color3.fromRGB(255, 40, 50)),
			ColorSequenceKeypoint.new(0.62, Color3.fromRGB(16,16,18)),
			ColorSequenceKeypoint.new(1.00, Color3.fromRGB(220, 20, 30)),
		})
		shineGradient.Parent = shineText

		State._blueShineLabels[button] = shineText
		State._blueShineGradients[button] = shineGradient

		button:GetPropertyChangedSignal("Text"):Connect(function()
			if shineText.Parent then shineText.Text = button.Text end
		end)
		button:GetPropertyChangedSignal("Visible"):Connect(function()

			if shineText.Parent then shineText.Visible = button.Visible end
		end)
		button:GetPropertyChangedSignal("TextSize"):Connect(function()
			if shineText.Parent then shineText.TextSize = button.TextSize end
		end)
		button:GetPropertyChangedSignal("ZIndex"):Connect(function()
			if shineText.Parent then shineText.ZIndex = button.ZIndex + 1 end
		end)
	end

	if not State._blueShineSequenceStarted then
		State._blueShineSequenceStarted = true
		task.spawn(function()
			while gui and gui.Parent do
				local animatedAny = false
				for button, gradient in pairs(State._blueShineGradients) do
					if not (gui and gui.Parent) then break end
					if button and button.Parent and gradient and gradient.Parent and button.Visible then
						animatedAny = true
						gradient.Offset = Vector2.new(-1.25, 0)
						local tween = TweenService:Create(
							gradient,
							TweenInfo.new(1.45, Enum.EasingStyle.Linear, Enum.EasingDirection.Out),
							{Offset = Vector2.new(1.25, 0)}
						)
						tween:Play()
						tween.Completed:Wait()
						task.wait(0.06)
					elseif button and not button.Parent then
						State._blueShineLabels[button] = nil
						State._blueShineGradients[button] = nil
					end
				end
				if not animatedAny then task.wait(0.5) else task.wait(0.8) end
			end
		end)
	end

	local function createMobileButton(name, displayText, col, row, isToggle, onAction)
		local xPos = PADDING + col * (BTN_SIZE + BTN_GAP)
		local yPos = PADDING + row * (BTN_SIZE + BTN_GAP)

		local btn = Instance.new("TextButton")
		btn.Name = "Btn_" .. name
		btn.Size = UDim2.new(0, BTN_SIZE, 0, BTN_SIZE)
		local defaultPos = UDim2.new(1, -140 + xPos, 0, 10 + yPos)
		btn.Position = defaultPos
		btn.BackgroundColor3 = Q_OFF
		btn.Text = displayText
		btn.TextColor3 = Q_TEXT_OFF
		btn.TextScaled = false; btn.TextSize = 11
		btn.Font = Enum.Font.GothamBold
		btn.TextWrapped = true; btn.LineHeight = 1.2
		btn.BorderSizePixel = 0; btn.AutoButtonColor = false
		btn.ZIndex = -1
		btn.Parent = gui
		State._registerPurpleAnimatedButton(btn)
		attachBlueTextShine(btn)
		mobileButtonsByName[name] = btn
		mobileButtonDefaultPositions[name] = defaultPos
		makeDraggable(btn)
		btn.InputEnded:Connect(function(inp)
			if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
				if State.requestConfigSave then State.requestConfigSave() end
			end
		end)
		Instance.new("UICorner", btn).Name = "ButtonShapeCorner"

		-- Imagen de fondo del botÃ³n (usa los mismos assets del script)
		ensureButtonImageLabel(btn)
		if State.buttonImages[name] and State.buttonImages[name] ~= "" then
			applyImageToMobileButton(btn, State.buttonImages[name])
		end

		local mobileStroke = Instance.new("UIStroke")
		mobileStroke.Name = "BlueOuterStroke"
		mobileStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		mobileStroke.Color = Color3.fromRGB(220,220,230)
		mobileStroke.Thickness = 0.9
		mobileStroke.Transparency = 0.22
		mobileStroke.LineJoinMode = Enum.LineJoinMode.Round
		mobileStroke.Parent = btn

		applyMobileButtonsSize(State.buttonsSizeValue)

		local isOn = false
		local function setter(s)
			isOn = s
			btn:SetAttribute("PurpleActive", s == true)
		end

		local function flash()
			btn:SetAttribute("PurpleFlash", true)
			task.delay(0.35, function()
				if btn and btn.Parent then
					btn:SetAttribute("PurpleFlash", false)
				end
			end)
		end

		btn.Activated:Connect(function()
			if isToggle then
				isOn = not isOn; setter(isOn)
				if onAction then onAction(isOn) end
			else
				flash()
				if onAction then onAction() end
			end
			if State.requestConfigSave then State.requestConfigSave() end
		end)

		return btn, setter
	end

	createMobileButton("Drop", "DROP\nBR", 0, 0, false, function() State._manualDropRequest = true; task.spawn(runDrop) end)

	-- TAUNT: NIGHT #3.VS ON TOP 
	local _tauntBusy = false
	local function doNightTaunt()
		if _tauntBusy then return end
		_tauntBusy = true
		local msg = "NIGHT #3.VS ON TOP ðŸ‘ºðŸ†"
		pcall(function()
			local TextChatService = game:GetService("TextChatService")
			local channel = TextChatService:FindFirstChild("TextChannels")
			channel = channel and (channel:FindFirstChild("RBXGeneral") or channel:FindFirstChildWhichIsA("TextChannel"))
			if channel and channel.SendAsync then
				channel:SendAsync(msg)
				return
			end
		end)
		pcall(function()
			local chat = game:GetService("Chat")
			if chat and chat.SubmitMessage then
				chat:SubmitMessage(msg, "All")
			end
		end)
		pcall(function()
			local rep = game:GetService("ReplicatedStorage")
			local ev = rep:FindFirstChild("DefaultChatSystemChatEvents")
			ev = ev and ev:FindFirstChild("SayMessageRequest")
			if ev then ev:FireServer(msg, "All") end
		end)
		task.delay(1.2, function() _tauntBusy = false end)
	end
	createMobileButton("Taunt", "TAUNT NIGHT #3.VS ðŸ‘‘", 1, 5, false, function()
		task.spawn(doNightTaunt)
	end)


	createMobileButton("MusicPad", "MUSIC\nPAD", 1, 6, false, function()
		pcall(function() if _G.NIGHT_musicCycle then _G.NIGHT_musicCycle() end end)
	end)
	btnBatV2 = Instance.new("TextButton")
	btnBatV2.Name = "Btn_BatnV2"
	btnBatV2.Size = UDim2.new(0, BTN_SIZE, 0, BTN_SIZE)
	btnBatV2.Position = UDim2.new(1, -140 - BTN_SIZE - BTN_GAP, 0, 10 + PADDING)
	btnBatV2.BackgroundColor3 = Q_OFF
	btnBatV2.Text = "BAT V2"
	btnBatV2.TextColor3 = Q_TEXT_OFF
	btnBatV2.TextScaled = false; btnBatV2.TextSize = 11
	btnBatV2.Font = Enum.Font.GothamBold
	btnBatV2.TextWrapped = true; btnBatV2.LineHeight = 1.2
	btnBatV2.BorderSizePixel = 0; btnAutoButtonColor = false
	btnBatV2.ZIndex = 1
	btnBatV2.Parent = gui
	State._registerPurpleAnimatedButton(btnBatV2)
	attachBlueTextShine(btnBatV2)
	Instance.new("UICorner", btnBatV2).Name = "ButtonShapeCorner"
	ensureButtonImageLabel(btnBatV2)
	if State.buttonImages["BatV2"] and State.buttonImages["BatV2"] ~= "" then
		applyImageToMobileButton(btnBatV2, State.buttonImages["BatV2"])
	end
	local batV2Stroke = Instance.new("UIStroke")
	batV2Stroke.Name = "BlueOuterStroke"
	batV2Stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	batV2Stroke.Color = Color3.fromRGB(220,220,230)
	batV2Stroke.Thickness = 0.9
	batV2Stroke.Transparency = 0.22
	batV2Stroke.LineJoinMode = Enum.LineJoinMode.Round
	batV2Stroke.Parent = btnBatV2
	applyMobileButtonsSize(State.buttonsSizeValue)

	makeDraggable(btnBatV2)
	btnBatV2.InputEnded:Connect(function(inp)
		if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
			if State.requestConfigSave then State.requestConfigSave() end
		end
	end)

	State._batV2On = false
	State._setBatV2Visual = function(s)
		State._batV2On = s
		btnBatV2:SetAttribute("PurpleActive", s == true)
		if autoBatV2SetVisual then autoBatV2SetVisual(s) end
	end

	btnBatV2.Activated:Connect(function()
		State._batV2On = not State._batV2On
		State._setBatV2Visual(State._batV2On)
		State.autoBatV2Enabled = State._batV2On
		
		if _G.setRagdollTpState then _G.setRagdollTpState(not State._batV2On) end

		if State._batV2On then
			if State.autoLeftEnabled then State.autoLeftEnabled = false; if autoLeftSetVisual then autoLeftSetVisual(false) end; stopAutoLeft() end
			if State.autoRightEnabled then State.autoRightEnabled = false; if autoRightSetVisual then autoRightSetVisual(false) end; stopAutoRight() end
			if State.autoBatToggled then
				State.autoBatToggled = false
				if autoBatSetVisual then autoBatSetVisual(false) end
				stopBatAimbot()
			end
			if State.tpBatEnabled then State._setTPBatEnabled(false) end
			checkSpeedAndDropBeforeAction("autoBatV2Enabled", function()
				if startBatAimbotV2 then startBatAimbotV2() end
			end)
		else
			if stopBatAimbotV2 then stopBatAimbotV2() end
		end
		if State.requestConfigSave then State.requestConfigSave() end
	end)

	local oldAutoBatV2SetVisual = autoBatV2SetVisual
	autoBatV2SetVisual = function(on)
		State._batV2On = on
		btnBatV2:SetAttribute("PurpleActive", on == true)
		if oldAutoBatV2SetVisual then oldAutoBatV2SetVisual(on) end
	end
	mobileBatV2SetActive = function(on) autoBatV2SetVisual(on) end

	btnInstaReset = Instance.new("TextButton")
	btnInstaReset.Name = "Btn_InstaReset"
	btnInstaReset.Size = UDim2.new(0, BTN_SIZE, 0, BTN_SIZE)
	btnInstaReset.Position = UDim2.new(1, -140 - BTN_SIZE - BTN_GAP, 0, 10 + PADDING + BTN_SIZE + BTN_GAP)
	btnInstaReset.BackgroundColor3 = Q_OFF
	btnInstaReset.Text = "INSTA\nRESET"
	btnInstaReset.TextColor3 = Q_TEXT_OFF
	btnInstaReset.TextScaled = false; btnInstaReset.TextSize = 11
	btnInstaReset.Font = Enum.Font.GothamBold
	btnInstaReset.TextWrapped = true; btnInstaReset.LineHeight = 1.2
	btnInstaReset.BorderSizePixel = 0; btnInstaReset.AutoButtonColor = false
	btnInstaReset.ZIndex = 1
	btnInstaReset.Parent = gui
	State._registerPurpleAnimatedButton(btnInstaReset)
	attachBlueTextShine(btnInstaReset)
	Instance.new("UICorner", btnInstaReset).Name = "ButtonShapeCorner"
	ensureButtonImageLabel(btnInstaReset)
	if State.buttonImages["InstaReset"] and State.buttonImages["InstaReset"] ~= "" then
		applyImageToMobileButton(btnInstaReset, State.buttonImages["InstaReset"])
	end
	local instaResetStroke = Instance.new("UIStroke")
	instaResetStroke.Name = "BlueOuterStroke"
	instaResetStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	instaResetStroke.Color = Color3.fromRGB(220,220,230)
	instaResetStroke.Thickness = 0.9
	instaResetStroke.Transparency = 0.22
	instaResetStroke.LineJoinMode = Enum.LineJoinMode.Round
	instaResetStroke.Parent = btnInstaReset
	applyMobileButtonsSize(State.buttonsSizeValue)

	makeDraggable(btnInstaReset)
	btnInstaReset.InputEnded:Connect(function(inp)
		if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
			if State.requestConfigSave then State.requestConfigSave() end
		end
	end)

	btnInstaReset.Activated:Connect(function()
		btnInstaReset:SetAttribute("PurpleFlash", true)
		task.delay(0.35, function()
			if btnInstaReset and btnInstaReset.Parent then
				btnInstaReset:SetAttribute("PurpleFlash", false)
			end
		end)

		if setInstaToggleVisual then
			setInstaToggleVisual(true)
			task.delay(0.2, function() setInstaToggleVisual(false) end)
		end

		task.spawn(cursedInstaReset)
		if State.requestConfigSave then State.requestConfigSave() end
	end)

	resetMobileButtons = function()
		for name, btn in pairs(mobileButtonsByName) do
			local defaultPos = mobileButtonDefaultPositions[name]
			if btn and defaultPos then btn.Position = defaultPos end
		end
		btnBatV2.Position = UDim2.new(1, -140 - BTN_SIZE - BTN_GAP, 0, 10 + PADDING)
		btnInstaReset.Position = UDim2.new(1, -140 - BTN_SIZE - BTN_GAP, 0, 10 + PADDING + BTN_SIZE + BTN_GAP)
		if State.requestPositionSave then State.requestPositionSave() end
		if State.requestConfigSave then State.requestConfigSave() end
	end

	-- Aplicar imÃ¡genes guardadas a todos los botones (mismos assets del script)
	task.defer(function()
		pcall(applyAllButtonImages)
	end)

	do
		local setter = select(2, createMobileButton("AutoLeft", "AUTO\nLEFT", 1, 0, true, function(on)
			State.autoLeftEnabled = on
			if on then
				local requiredTpEnable = false
				if State.autoRightEnabled then State.autoRightEnabled=false; if autoRightSetVisual then autoRightSetVisual(false) end; stopAutoRight() end
				if State.autoBatToggled then 
					State.autoBatToggled=false; 
					if autoBatSetVisual then autoBatSetVisual(false) end; 
					stopBatAimbot()
					requiredTpEnable = true
				end
				if State.autoBatV2Enabled then
					State.autoBatV2Enabled = false
					if autoBatV2SetVisual then autoBatV2SetVisual(false) end
					if mobileBatV2SetActive then mobileBatV2SetActive(false) end
					stopBatAimbotV2()
					requiredTpEnable = true
				end
				if State.tpBatEnabled then State._setTPBatEnabled(false) end

				if requiredTpEnable and _G.setRagdollTpState then _G.setRagdollTpState(true) end

				local char = LP.Character
				local hum = char and char:FindFirstChildOfClass("Humanoid")
				local root = char and char:FindFirstChild("HumanoidRootPart")
				if hum and root and hum.WalkSpeed > 0 and not root.Anchored then 
					checkSpeedAndDropBeforeAction("autoLeftEnabled", function()
						startAutoLeft() 
					end)
				end
			else
				stopAutoLeft()
			end
		end))
		local previous = autoLeftSetVisual
		autoLeftSetVisual = function(on)
			setter(on)
			if previous then previous(on) end
		end
		mobileAutoLeftSetActive = function(on) autoLeftSetVisual(on) end
		if mobileBtnActive then mobileBtnActive.AutoLeft = setter end
		local btn = mobileButtonsByName["AutoLeft"]
		if btn then
			btn.TextColor3 = Color3.fromRGB(255,255,255)
		end
	end

	do
		local setter = select(2, createMobileButton("AutoBat", "BAT\nAIMBOT", 0, 1, true, function(on)
			State.autoBatToggled = on
			
			if _G.setRagdollTpState then _G.setRagdollTpState(not on) end

			if on then
				if State.autoLeftEnabled then State.autoLeftEnabled=false; if autoLeftSetVisual then autoLeftSetVisual(false) end; stopAutoLeft() end
				if State.autoRightEnabled then State.autoRightEnabled=false; if autoRightSetVisual then autoRightSetVisual(false) end; stopAutoRight() end
				if State._batV2On then
					State._batV2On = false
					State._setBatV2Visual(false)
					State.autoBatV2Enabled = false
					if autoBatV2SetVisual then autoBatV2SetVisual(false) end
					if stopBatAimbotV2 then stopBatAimbotV2() end
				end
				if State.tpBatEnabled then State._setTPBatEnabled(false) end
				checkSpeedAndDropBeforeAction("autoBatToggled", function()
					startBatAimbot() 
				end)
			else
				stopBatAimbot()
			end
		end))
		local previous = autoBatSetVisual
		autoBatSetVisual = function(on)
			setter(on)
			if previous then previous(on) end
		end
		mobileBatV1SetActive = function(on) autoBatSetVisual(on) end
		if mobileBtnActive then mobileBtnActive.AutoBat = setter end
	end

	do
		local setter = select(2, createMobileButton("AutoRight", "AUTO\nRIGHT", 1, 1, true, function(on)
			State.autoRightEnabled = on
			if on then
				local requiredTpEnable = false
				if State.autoLeftEnabled then State.autoLeftEnabled=false; if autoLeftSetVisual then autoLeftSetVisual(false) end; stopAutoLeft() end
				if State.autoBatToggled then 
					State.autoBatToggled=false; 
					if autoBatSetVisual then autoBatSetVisual(false) end; 
					stopBatAimbot()
					requiredTpEnable = true
				end
				if State.autoBatV2Enabled then
					State.autoBatV2Enabled = false
					if autoBatV2SetVisual then autoBatV2SetVisual(false) end
					if mobileBatV2SetActive then mobileBatV2SetActive(false) end
					stopBatAimbotV2()
					requiredTpEnable = true
				end
				if State.tpBatEnabled then State._setTPBatEnabled(false) end

				if requiredTpEnable and _G.setRagdollTpState then _G.setRagdollTpState(true) end

				local char = LP.Character
				local hum = char and char:FindFirstChildOfClass("Humanoid")
				local root = char and char:FindFirstChild("HumanoidRootPart")
				if hum and root and hum.WalkSpeed > 0 and not root.Anchored then 
					checkSpeedAndDropBeforeAction("autoRightEnabled", function()
						startAutoRight() 
					end)
				end
			else
				stopAutoRight()
			end
		end))
		local previous = autoRightSetVisual
		autoRightSetVisual = function(on)
			setter(on)
			if previous then previous(on) end
		end
		mobileAutoRightSetActive = function(on) autoRightSetVisual(on) end
		if mobileBtnActive then mobileBtnActive.AutoRight = setter end
		local btn = mobileButtonsByName["AutoRight"]
		if btn then
			btn.TextColor3 = Color3.fromRGB(255,255,255)
		end
	end

	createMobileButton("TPDown", "TP\nDOWN", 0, 2, false, function() task.spawn(runTPDown) end)

	State._tpBatButton, State._tpBatSetter = createMobileButton("TPBat", "TP\nBAT", 0, 4, true, function(on)
		State._setTPBatEnabled(on)
		if State._tpBatConfigSetVisual then State._tpBatConfigSetVisual(on) end
	end)
	State._tpBatSetVisual = function(on)
		State._setTPBatEnabled(on)
		if State._tpBatSetter then State._tpBatSetter(on) end
		if State._tpBatConfigSetVisual then State._tpBatConfigSetVisual(on) end
	end

	do
		local setter = select(2, createMobileButton("Speed", "CARRY\nSPD", 1, 2, true, function(on)
			State.speedToggled = on
			if on then
				State.laggerToggled = false
				laggerPhase = 0
				if mobileLaggerSetActive then mobileLaggerSetActive(false) end
				if modeValLbl then modeValLbl.Text = State.speedProfile == "Lagger" and ("Carry Â· " .. tostring(State.profileLaggerCarrySpeed)) or "Carry" end
			else
				if modeValLbl then modeValLbl.Text = State.speedProfile == "Lagger" and ("Lagger Â· " .. tostring(State.profileLaggerNormalSpeed)) or "Normal" end
			end
		end))
		mobileSpeedSetActive = function(on) setter(on) end
	end

	do
		local setter = select(2, createMobileButton("AutoTP", "AUTO\nTP", 1, 3, true, function(on)
			autoTPDownEnabled = on
			if on then
				if startAutoTPDown then task.spawn(startAutoTPDown) end
			else
				if stopAutoTPDown then stopAutoTPDown() end
			end
		end))
		local previous = setAutoTPDownVisual
		setAutoTPDownVisual = function(on)
			setter(on)
			if previous then previous(on) end
		end
		mobileAutoTPSetActive = function(on) setAutoTPDownVisual(on) end
	end

	do
		local cycle = 0
		local button, setter
		button, setter = createMobileButton("Lagger", "LAGGER\nOff", 0, 3, true, function()
			if cycle == 0 or cycle == 2 then
				cycle = 1
				State.laggerToggled = true
				laggerPhase = 1
				State.speedToggled = false
				if mobileSpeedSetActive then mobileSpeedSetActive(false) end
				if modeValLbl then modeValLbl.Text = "Lagger 1" end
				button.Text = "LAGGER\n1"
				task.defer(function() setter(true) end)
			elseif cycle == 1 then
				cycle = 2
				State.laggerToggled = true
				laggerPhase = 2
				State.speedToggled = false
				if mobileSpeedSetActive then mobileSpeedSetActive(false) end
				if modeValLbl then modeValLbl.Text = "Lagger 2" end
				button.Text = "LAGGER\n2"
				task.defer(function() setter(true) end)
			end
		end)
		mobileLaggerSetActive = function(on)
			if on then
				cycle = (laggerPhase == 2) and 2 or 1
				laggerPhase = cycle
				State.laggerToggled = true
				button.Text = cycle == 2 and "LAGGER\n2" or "LAGGER\n1"
				setter(true)
			else
				cycle = 0
				laggerPhase = 0
				State.laggerToggled = false
				button.Text = "LAGGER\nOff"
				setter(false)
			end
		end
	end

	do
		local wasFrozen = false
		local prevInfJump = false
		local prevSuperJump = false
		local prevSpeedToggle = false

		RunService.Heartbeat:Connect(function()
			local char = LP.Character
			if not char then return end
			local hrp = char:FindFirstChild("HumanoidRootPart")
			local hum = char:FindFirstChildOfClass("Humanoid")
			if not hrp or not hum then return end

			local isCurrentlyFrozen = hrp.Anchored or hum.WalkSpeed == 0

			if isCurrentlyFrozen then
				if State.autoBatV2Enabled or State._batV2On then
					State._batV2On = false
					State._setBatV2Visual(false)
					State.autoBatV2Enabled = false
					if autoBatV2SetVisual then autoBatV2SetVisual(false) end
					if stopBatAimbotV2 then stopBatAimbotV2() end
					if _G.setRagdollTpState then _G.setRagdollTpState(true) end
				end

				if State.autoBatToggled then
					State.autoBatToggled = false
					if autoBatSetVisual then autoBatSetVisual(false) end
					stopBatAimbot()
					if _G.setRagdollTpState then _G.setRagdollTpState(true) end
				end

				if not wasFrozen then
					wasFrozen = true
					prevInfJump = State.infJumpEnabled
					prevSuperJump = State.superJumpEnabled
					prevSpeedToggle = State.speedToggled

					if State.infJumpEnabled then
						State.infJumpEnabled = false
						if setInfJump then setInfJump(false) end
					end
					if State.superJumpEnabled then
						State.superJumpEnabled = false
						if setSuperJump then setSuperJump(false) end
					end
					if State.speedToggled then
						State.speedToggled = false
						if mobileSpeedSetActive then mobileSpeedSetActive(false) end
						if modeValLbl then
							modeValLbl.Text = State.laggerToggled and "Lagger" or (State.speedToggled and (State.speedProfile == "Lagger" and ("Carry Â· " .. tostring(State.profileLaggerCarrySpeed)) or "Carry") or (State.speedProfile == "Lagger" and ("Lagger Â· " .. tostring(State.profileLaggerNormalSpeed)) or "Normal"))
						end
					end

					if State.dropActive then
						if State.dropConn then
							State.dropConn:Disconnect()
							State.dropConn = nil
						end
						State.dropActive = false
					end
					if State.dropBrainrotActive then
						if State.dropBrainrotConn then
							State.dropBrainrotConn:Disconnect()
							State.dropBrainrotConn = nil
						end
						State.dropBrainrotActive = false
					end

					if State.autoLeftEnabled then stopAutoLeft() end
					if State.autoRightEnabled then stopAutoRight() end
				end
			else
				if wasFrozen then
					wasFrozen = false

					if prevInfJump then
						State.infJumpEnabled = true
						if setInfJump then setInfJump(true) end
					end
					if prevSuperJump then
						State.superJumpEnabled = true
						if setSuperJump then setSuperJump(true) end
					end
					if prevSpeedToggle then
						State.speedToggled = true
						if mobileSpeedSetActive then mobileSpeedSetActive(true) end
						if modeValLbl then
							modeValLbl.Text = State.laggerToggled and "Lagger" or (State.speedToggled and (State.speedProfile == "Lagger" and ("Carry Â· " .. tostring(State.profileLaggerCarrySpeed)) or "Carry") or (State.speedProfile == "Lagger" and ("Lagger Â· " .. tostring(State.profileLaggerNormalSpeed)) or "Normal"))
						end
					end

					if State.autoLeftEnabled then startAutoLeft() end
					if State.autoRightEnabled then startAutoRight() end
				end
			end
		end)
	end
end


-- SECCIÃ“N 9: ESP (LÃNEA)
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

local ESP = {}

local function CreateESP(player)
    if player == LocalPlayer then return end
    if ESP[player] then return end

    local Line = Drawing.new("Line")
    Line.Color = Color3.fromRGB(16,16,18)
    Line.Thickness = 0.1
    Line.Transparency = 0.7
    Line.Visible = false

    local Distance = Drawing.new("Text")
    Distance.Color = Color3.fromRGB(230,230,235)
    Distance.Size = 11
    Distance.Center = true
    Distance.Outline = true
    Distance.Visible = false

    ESP[player] = {Line, Distance}
end

for _, v in ipairs(Players:GetPlayers()) do
    CreateESP(v)
end

Players.PlayerAdded:Connect(CreateESP)

Players.PlayerRemoving:Connect(function(player)
    if ESP[player] then
        for _, obj in ipairs(ESP[player]) do
            obj:Remove()
        end
        ESP[player] = nil
    end
    if player.Character then
        local hl = player.Character:FindFirstChild("HologramRed")
        if hl then hl:Destroy() end
    end
end)

RunService.RenderStepped:Connect(function()
    Camera = workspace.CurrentCamera

    for player, objs in pairs(ESP) do
        local char = player.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        local head = char and char:FindFirstChild("Head")

        if State.linieEnabled and hrp and hum and head and hum.Health > 0 then
            local pos, visible = Camera:WorldToViewportPoint(hrp.Position)

            local holo = char:FindFirstChild("HologramRed")
            if not holo then
                holo = Instance.new("Highlight")
                holo.Name = "HologramRed"
                holo.FillColor = Color3.fromRGB(16,16,18)
                holo.FillTransparency = 0.5
                holo.OutlineColor = Color3.fromRGB(255, 40, 50)
                holo.OutlineTransparency = 0.2
                holo.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                holo.Parent = char
            else
                holo.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            end

            if visible then
                local distance = math.floor((hrp.Position - Camera.CFrame.Position).Magnitude)
                local headPos = Camera:WorldToViewportPoint(head.Position + Vector3.new(0, 0.5, 0))
                local feetPos = Camera:WorldToViewportPoint(hrp.Position - Vector3.new(0, 3, 0))
                local height = math.abs(headPos.Y - feetPos.Y)

                objs[1].Visible = true
                objs[1].From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
                objs[1].To = Vector2.new(pos.X, pos.Y)

                objs[2].Visible = true
                objs[2].Position = Vector2.new(pos.X, pos.Y - height / 2 - 16)
                objs[2].Text = distance .. " Studs"

            else
                for _, obj in ipairs(objs) do
                    obj.Visible = false
                end
            end
        else
            if char then
                local hl = char:FindFirstChild("HologramRed")
                if hl then hl:Destroy() end
            end
            for _, obj in ipairs(objs) do
                obj.Visible = false
            end
        end
    end
end)

State._positionConfigFile = "Vereuxv2_positions.json"
State._positionBackupFile = "Vereuxv2_positions.backup.json"
State._positionTempFile = "Vereuxv2_positions.tmp.json"
State._positionSaveRequestId = 0

State._positionSnapshot = function(guiObject)
    if not guiObject then return nil end
    local ok, position = pcall(function() return guiObject.Position end)
    if not ok or not position then return nil end
    return {xs=position.X.Scale, xo=position.X.Offset, ys=position.Y.Scale, yo=position.Y.Offset}
end

State._restoreSavedPosition = function(guiObject, data)
    if not guiObject or type(data) ~= "table" or data.xs == nil then return end
    pcall(function()
        guiObject.Position = UDim2.new(
            tonumber(data.xs) or 0,
            tonumber(data.xo) or 0,
            tonumber(data.ys) or 0,
            tonumber(data.yo) or 0
        )
    end)
end

State.savePositionBackup = function()
    local buttonPositions = {}
    for name, button in pairs(mobileButtonsByName) do
        buttonPositions[name] = State._positionSnapshot(button)
    end

    local payload = {
        version = 2,
        mainPos = State._positionSnapshot(main),
        miniPos = State._positionSnapshot(mini),
        panelPos = State._positionSnapshot(MobilePanel),
        pbPos = State._positionSnapshot(pbFrame),
        batV2Pos = State._positionSnapshot(btnBatV2),
        instaResetPos = State._positionSnapshot(btnInstaReset),
        autoStealBarPos = State._positionSnapshot(State.autoStealBarFrame),
        mobileButtonPositions = buttonPositions,
    }

    local encodedOk, encoded = pcall(function() return HttpService:JSONEncode(payload) end)
    if not encodedOk then return false end

    if encoded == State._lastPositionJson then
        State._positionDirty = false
        return true
    end

    local saved, err = State._atomicJsonSave(
        State._positionConfigFile,
        State._positionBackupFile,
        State._positionTempFile,
        encoded
    )
    if saved then
        State._lastPositionJson = encoded
        State._positionDirty = false
    else
        State._lastSaveError = err
    end
    return saved
end

State.loadPositionBackup = function()
    local mainData, mainRaw = State._readValidJsonFile(State._positionConfigFile)
    local tempData, tempRaw = State._readValidJsonFile(State._positionTempFile)
    local backupData, backupRaw = State._readValidJsonFile(State._positionBackupFile)

    local data, raw, recovered = nil, nil, false
    if type(tempData) == "table" and (type(mainData) ~= "table" or tempRaw ~= mainRaw) then
        data, raw, recovered = tempData, tempRaw, true
    elseif type(mainData) == "table" then
        data, raw = mainData, mainRaw
    elseif type(backupData) == "table" then
        data, raw, recovered = backupData, backupRaw, true
    end

    if type(data) ~= "table" then return false end
    State._lastPositionJson = raw
    State._positionDirty = false

    local function apply()
        State._restoreSavedPosition(main, data.mainPos)
        State._restoreSavedPosition(mini, data.miniPos)
        State._restoreSavedPosition(MobilePanel, data.panelPos)
        State._restoreSavedPosition(pbFrame, data.pbPos)
        State._restoreSavedPosition(btnBatV2, data.batV2Pos)
        State._restoreSavedPosition(btnInstaReset, data.instaResetPos)
        State._restoreSavedPosition(State.autoStealBarFrame, data.autoStealBarPos)
        if type(data.mobileButtonPositions) == "table" then
            for name, positionData in pairs(data.mobileButtonPositions) do
                State._restoreSavedPosition(mobileButtonsByName[name], positionData)
            end
        end
    end

    apply()
    task.delay(0.45, apply)
    task.delay(1.2, apply)

    if recovered and type(raw) == "string" then
        task.defer(function()
            State._atomicJsonSave(
                State._positionConfigFile,
                State._positionBackupFile,
                State._positionTempFile,
                raw
            )
        end)
    end
    return true
end

State.requestPositionSave = function()
    State._positionDirty = true
    State._positionSaveRequestId = State._positionSaveRequestId + 1
    local requestId = State._positionSaveRequestId

    task.delay(0.55, function()
        if requestId ~= State._positionSaveRequestId then return end
        if not State._positionDirty then return end
        local ok, result = pcall(State.savePositionBackup)
        if not ok then State._lastSaveError = tostring(result) end
    end)
end

task.spawn(function()
    task.wait(0.15)
    pcall(State.loadPositionBackup)
end)

-- SECCIÃ“N 10: BAT AIMBOT V2 Y FUNCIONES DE CONTEO
local function getAutoBatTarget()
    local root = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
    if not root then return nil end
    local now = tick()
    if now - _autoBatLastScan <= 0.1 and _autoBatTarget and _autoBatTarget.Parent then
        local hum = _autoBatTarget.Parent:FindFirstChildOfClass("Humanoid")
        local char = _autoBatTarget.Parent
        local hasAntiBat = char:FindFirstChild("Anti-Bat") or char:FindFirstChild("AntiBat") or char:FindFirstChild("Shield")
        if hum and hum.Health > 0 and not hasAntiBat then return _autoBatTarget end
    end
    _autoBatLastScan = now
    _autoBatTarget = nil
    local closest, minDist = nil, math.huge
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LP and plr.Character then
            local tRoot = plr.Character:FindFirstChild("HumanoidRootPart")
            local hum = plr.Character:FindFirstChildOfClass("Humanoid")
            local tChar = plr.Character

            local hasAntiBat = tChar:FindFirstChild("Anti-Bat") or tChar:FindFirstChild("AntiBat") or tChar:FindFirstChild("Shield")

            if tRoot and hum and hum.Health > 0 and not hasAntiBat then
                local dist = (tRoot.Position - root.Position).Magnitude
                if dist < minDist then minDist = dist; closest = tRoot end
            end
        end
    end
    _autoBatTarget = closest
    return _autoBatTarget
end

local LUST_BYPASS_AIMBOT_SPEED = 60
local BAT_V2_FOLLOW_DIST = 1.0
local BAT_V2_HEIGHT_OFFSET = 1.5
local BAT_V2_VERTICAL_OFFSET = 0.0
local BAT_V2_HIT_DIST = 4.5
local BAT_V2_SWING_COOLDOWN = 0.1

local bypassHittingCooldown = false

local function getClosestPlayerV2()
    local char = LP.Character
    if not char then return nil, math.huge end

    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return nil, math.huge end

    local closest, bestDistance = nil, math.huge
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LP and player.Character then
            local targetRoot = player.Character:FindFirstChild("HumanoidRootPart")
            local targetHumanoid = player.Character:FindFirstChildOfClass("Humanoid")
            if targetRoot and targetHumanoid and targetHumanoid.Health > 0 then
                local distance = (root.Position - targetRoot.Position).Magnitude
                if distance < bestDistance then
                    bestDistance = distance
                    closest = player
                end
            end
        end
    end

    return closest, bestDistance
end

local function tryHitBypassBat()
    if bypassHittingCooldown then return end
    bypassHittingCooldown = true

    pcall(function()
        local char = LP.Character
        if not char then return end

        local currentTool = char:FindFirstChildOfClass("Tool")
        if currentTool and not isBatToolLust(currentTool) then
            bypassHittingCooldown = false
            return
        end

        local bat = findBat()
        if bat then
            if bat.Parent ~= char then
                local humanoid = char:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    pcall(function() humanoid:EquipTool(bat) end)
                end
            end

            local remote = bat:FindFirstChildOfClass("RemoteEvent")
            if remote then
                pcall(function() remote:FireServer() end)
            else
                pcall(function() bat:Activate() end)
            end
        end
    end)

    task.delay(BAT_V2_SWING_COOLDOWN, function()
        bypassHittingCooldown = false
    end)
    task.delay(0.2, function()
        if bypassHittingCooldown then
            bypassHittingCooldown = false
        end
    end)
end

startBatAimbotV2 = function()
    if State.tpBatEnabled then
        State._setTPBatEnabled(false)
    end

    if Conns.aimbotV2 then return end
    State.autoBatV2Enabled = true

    Conns.aimbotV2 = RunService.Heartbeat:Connect(function()
        if not State.autoBatV2Enabled then return end

        local char = LP.Character
        if not char then return end

        local root = char:FindFirstChild("HumanoidRootPart")
        local humanoid = char:FindFirstChildOfClass("Humanoid")
        if not root or not humanoid or humanoid.Health <= 0 then return end

        local humanoidState = humanoid:GetState()
        if humanoidState == Enum.HumanoidStateType.Physics
            or humanoidState == Enum.HumanoidStateType.Ragdoll
            or humanoidState == Enum.HumanoidStateType.FallingDown then
            return
        end

        if not char:FindFirstChildOfClass("Tool") then
            local bat = findBat()
            if bat then
                pcall(function() humanoid:EquipTool(bat) end)
            end
        end

        local target = getClosestPlayerV2()
        if target and target.Character then
            local targetRoot = target.Character:FindFirstChild("HumanoidRootPart")
            if targetRoot then
                local targetVelocity = targetRoot.AssemblyLinearVelocity
                local movementDirection = targetVelocity.Magnitude > 0.1
                    and targetVelocity.Unit
                    or targetRoot.CFrame.LookVector

                local offset = movementDirection * BAT_V2_FOLLOW_DIST
                    + Vector3.new(0, BAT_V2_HEIGHT_OFFSET + BAT_V2_VERTICAL_OFFSET, 0)
                local desiredPosition = targetRoot.Position + offset
                local directionToTarget = desiredPosition - root.Position

                local speed = State.batV2Speed or 60
                if directionToTarget.Magnitude > 0.5 then
                    local movementVector = directionToTarget.Unit * speed
                    root.AssemblyLinearVelocity = Vector3.new(
                        movementVector.X,
                        movementVector.Y,
                        movementVector.Z
                    )
                else
                    root.AssemblyLinearVelocity = root.AssemblyLinearVelocity * 0.95
                    if root.AssemblyLinearVelocity.Magnitude < 1 then
                        root.AssemblyLinearVelocity = Vector3.zero
                    end
                end

                if State.autoSwingEnabled
                    and (root.Position - targetRoot.Position).Magnitude <= BAT_V2_HIT_DIST then
                    tryHitBypassBat()
                end
            end
        else
            root.AssemblyLinearVelocity = root.AssemblyLinearVelocity * 0.9
            if root.AssemblyLinearVelocity.Magnitude < 1 then
                root.AssemblyLinearVelocity = Vector3.zero
            end
        end
    end)
end

stopBatAimbotV2 = function()
    State.autoBatV2Enabled = false

    if Conns.aimbotV2 then
        Conns.aimbotV2:Disconnect()
        Conns.aimbotV2 = nil
    end

    local char = LP.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    local humanoid = char and char:FindFirstChildOfClass("Humanoid")

    if humanoid then
        humanoid.AutoRotate = true
        humanoid.PlatformStand = false
        pcall(function()
            humanoid:ChangeState(Enum.HumanoidStateType.Running)
        end)
    end

    if root then
        root.AssemblyLinearVelocity = Vector3.new(0, -0.1, 0)
        root.AssemblyAngularVelocity = Vector3.zero
        pcall(function()
            if sethiddenproperty then
                sethiddenproperty(root, "PhysicsRepRootPart", nil)
            end
        end)
    end

    bypassHittingCooldown = false
    State.lastMoveDir = Vector3.zero
end

-- SECCIÃ“N 11: AUTO STEAL (NIGHT #3.VS) CON PERSISTENCIA
;(function()

local function _isfile(path)
    local checker = State._resolveFileFunction("isfile")
    if type(checker) == "function" then
        local ok, exists = pcall(checker, path)
        if ok then return exists == true end
    end
    local raw = State._safeReadFile(path)
    return type(raw) == "string"
end
local function _readfile(path)
    local raw, err = State._safeReadFile(path)
    if type(raw) ~= "string" then error(err or "readfile failed", 0) end
    return raw
end
local function _writefile(path, data)
    local ok, err = State._safeWriteFile(path, data)
    if not ok then error(err or "writefile failed", 0) end
    return true
end
local getconnections = getconnections or get_signal_cons or getconnects or (syn and syn.get_signal_cons)

local MOVE_KEYS={[Enum.KeyCode.W]=true,[Enum.KeyCode.A]=true,[Enum.KeyCode.S]=true,[Enum.KeyCode.D]=true,
    [Enum.KeyCode.Up]=true,[Enum.KeyCode.Left]=true,[Enum.KeyCode.Down]=true,[Enum.KeyCode.Right]=true}
local PLOT_CACHE_DURATION=2; local PROMPT_CACHE_REFRESH=0.15
local STEAL_COOLDOWN=0.1; local MEDUSA_COOLDOWN=25; local DROP_AUTO_OFF_DELAY=0.15
local CONFIG_FILE="Vereuxv2.json"
State._configTempFile="Vereuxv2.tmp.json"
State._legacyConfigFile="Vereuxv2.json"
State._configBackupFile="Vereuxv2.backup.json"
State._legacyConfigBackupFile="Vereuxvs.backup.json"
State._legacyConfigTempFile="VereuxV2Config.tmp.json"

State.autoLeftPhase=1; State.autoRightPhase=1
State.medusaLastUsed=0; State.medusaDebounce=false; State.medusaCounterEnabled=false
State.batAimbotToggled=false; State.autoSwingEnabled=false
State.hittingCooldown=false
State.batCounterEnabled=false; State.batCounterDebounce=false
State.dropEnabled=false; State._tpInProgress=false
State.lastMoveDir=Vector3.new(0,0,0)
State._prevCarry=CS; State._prevSpeed=false
State.laggerEnabled=false

Conns.autoLeft=nil; Conns.autoRight=nil; Conns.aimbot=nil
Conns.batCounter=nil; Conns.unwalk=nil

local Presets={}
local PRESET_FILE="FEARV2Presets.json"; local LAST_PRESET_FILE="FEARV2LastPreset.json"
local function buildPresetSnapshot()
    return {normalSpeed=NS,carrySpeed=CS,laggerSpeed=LS,stealRadius=Steal.StealRadius,
        infJump=State.infJumpEnabled,
        antiRagdoll=State.antiRagdollEnabled,fpsBoost=State.fpsBoostEnabled,
        medusaCounter=State.medusaCounterEnabled,batCounter=State.batCounterEnabled,
        autoSteal=Steal.AutoStealEnabled,
        skinPack=(function() local ok,n=pcall(function() return _G.NIGHT_getSkin and _G.NIGHT_getSkin() end) return (ok and n) or "Off" end)(),
        medusaReset=State.autoResetEnabled,uiScale=uiScaleValue}
end
local function savePresetsFile()
    local ok,enc=pcall(function() return HttpService:JSONEncode(Presets) end)
    if ok then pcall(function() _writefile(PRESET_FILE,enc) end) end
end
local function loadPresetsFile()
    local hasFile=false; pcall(function() hasFile=_isfile(PRESET_FILE) end)
    if not hasFile then return end
    local raw; pcall(function() raw=_readfile(PRESET_FILE) end)
    if not raw then return end
    local ok,dec=pcall(function() return HttpService:JSONDecode(raw) end)
    if ok and dec then Presets=dec end
end
local function saveLastPresetName(name)
    local ok,enc=pcall(function() return HttpService:JSONEncode({lastPreset=name}) end)
    if ok then pcall(function() _writefile(LAST_PRESET_FILE,enc) end) end
end
local function loadLastPresetName()
    local hasFile=false; pcall(function() hasFile=_isfile(LAST_PRESET_FILE) end)
    if not hasFile then return nil end
    local raw; pcall(function() raw=_readfile(LAST_PRESET_FILE) end)
    if not raw then return nil end
    local ok,dec=pcall(function() return HttpService:JSONDecode(raw) end)
    if ok and dec then return dec.lastPreset end; return nil
end

local function createRadiusPart()
	local p = Instance.new("Part")
	p.Name = "MedusaRadius"
	p.Anchored = true
	p.CanCollide = false
	pcall(function() p.CanQuery = false end)
	p.Transparency = 1
	p.Material = Enum.Material.Neon
	p.Color = Color3.fromRGB(255, 40, 50)
	p.Shape = Enum.PartType.Cylinder
	p.Size = Vector3.new(0.2, MedusaConfig.Radius*2, MedusaConfig.Radius*2)
	p.Parent = workspace
	MedusaConfig.RadiusPart = p
end

local function isMedusaEquipped()
	local char = LP.Character
	if not char then return nil end
	for _, tool in ipairs(char:GetChildren()) do
		if tool:IsA("Tool") and tool.Name == "Medusa's Head" then
			return tool
		end
	end
	return nil
end

RunService.Heartbeat:Connect(function()
	if not MedusaConfig.Enabled then
		if MedusaConfig.RadiusPart then MedusaConfig.RadiusPart.Transparency = 1 end
		return
	end

	local char = LP.Character
	local root = char and char:FindFirstChild("HumanoidRootPart")
	if not root then return end

	if not MedusaConfig.RadiusPart then createRadiusPart() end
	MedusaConfig.RadiusPart.Transparency = 0.7
	MedusaConfig.RadiusPart.CFrame = CFrame.new(root.Position + Vector3.new(0, -2.5, 0)) * CFrame.Angles(0, 0, math.rad(90))

	local tool = isMedusaEquipped()
	if tool and (tick() - MedusaConfig.LastUsed >= MedusaConfig.Delay) then
		for _, plr in ipairs(Players:GetPlayers()) do
			if plr ~= LP and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
				local pRoot = plr.Character.HumanoidRootPart
				if (pRoot.Position - root.Position).Magnitude <= MedusaConfig.Radius then
					tool:Activate()
					MedusaConfig.LastUsed = tick()
					break
				end
			end
		end
	end
end)

local function doTpDown()
    pcall(function()
        local character, humanoid, root = safetyCharacterParts()
        if character then safetyTeleportToFloor(character, humanoid, root) end
    end)
end

local function runDropBrainrot()
        if State.dropBrainrotActive then return end
        local char, hum, root = safetyCharacterParts()
        if not char then return end
        State.dropBrainrotActive=true; local t0=tick()
        State.dropBrainrotConn = RunService.Heartbeat:Connect(function()
                local currentChar=LP.Character
                local r=currentChar and currentChar:FindFirstChild("HumanoidRootPart")
                local currentHum=currentChar and currentChar:FindFirstChildOfClass("Humanoid")
                if not r or not currentHum or currentHum.Health<=0 then
                        if State.dropBrainrotConn then State.dropBrainrotConn:Disconnect(); State.dropBrainrotConn = nil end
                        State.dropBrainrotActive=false
                        return
                end
                if tick()-t0>=DROP_ASCEND_DURATION then
                        if State.dropBrainrotConn then State.dropBrainrotConn:Disconnect(); State.dropBrainrotConn = nil end
                        r.AssemblyLinearVelocity=Vector3.zero
                        r.AssemblyAngularVelocity=Vector3.zero
                        safetyTeleportToFloor(currentChar,currentHum,r)
                        State.dropBrainrotActive=false
                        return
                end
                r.AssemblyLinearVelocity=Vector3.new(r.AssemblyLinearVelocity.X,DROP_ASCEND_SPEED,r.AssemblyLinearVelocity.Z)
        end)
end

local BAT_COUNTER_SLAP_LIST={"Bat","Slap","Iron Slap","Gold Slap","Diamond Slap","Emerald Slap","Ruby Slap","Dark Matter Slap","Flame Slap","Nuclear Slap","Galaxy Slap","Glitched Slap"}
local function findBatForCounter()
    local c=LP.Character; if not c then return nil end
    local bp=LP:FindFirstChildOfClass("Backpack")
    for _,name in ipairs(BAT_COUNTER_SLAP_LIST) do
        local t=c:FindFirstChild(name) or (bp and bp:FindFirstChild(name)); if t then return t end
    end
    for _,ch in ipairs(c:GetChildren()) do if ch:IsA("Tool") and ch.Name:lower():find("bat") then return ch end end
    if bp then for _,ch in ipairs(bp:GetChildren()) do if ch:IsA("Tool") and ch.Name:lower():find("bat") then return ch end end end
    return nil
end
local function swingBatForCounter(bat,char)
    local hum2=char:FindFirstChildOfClass("Humanoid")
    if bat.Parent~=char then if hum2 then pcall(function() hum2:EquipTool(bat) end) end; task.wait(0.05) end
    local remote=bat:FindFirstChildOfClass("RemoteEvent") or bat:FindFirstChildOfClass("RemoteFunction")
    if remote and remote:IsA("RemoteEvent") then
        pcall(function() remote:FireServer() end); task.wait(0.15); pcall(function() remote:FireServer() end)
    else pcall(function() bat:Activate() end); task.wait(0.15); pcall(function() bat:Activate() end) end
end
local function startBatCounter()
    if Conns.batCounter then return end
    Conns.batCounter=RunService.Heartbeat:Connect(function()
        if not State.batCounterEnabled then return end
        if State.batCounterDebounce then return end
        local char=LP.Character; if not char then return end
        local hum2=char:FindFirstChildOfClass("Humanoid"); if not hum2 then return end
        local st=hum2:GetState()
        if st==Enum.HumanoidStateType.Physics or st==Enum.HumanoidStateType.Ragdoll or st==Enum.HumanoidStateType.FallingDown then
            State.batCounterDebounce=true
            task.spawn(function()
                local bat=findBatForCounter()
                if bat then swingBatForCounter(bat,char) end
                task.wait(0.5); State.batCounterDebounce=false
            end)
        end
    end)
end
local function stopBatCounter()
    if Conns.batCounter then Conns.batCounter:Disconnect(); Conns.batCounter=nil end
    State.batCounterDebounce=false
end

local function findMedusa()
    local c=LP.Character; if not c then return nil end
    for _,t in ipairs(c:GetChildren()) do if t:IsA("Tool") then local n=t.Name:lower(); if n:find("medusa") or n:find("head") or n:find("stone") then return t end end end
    local bp=LP:FindFirstChildOfClass("Backpack")
    if bp then for _,t in ipairs(bp:GetChildren()) do if t:IsA("Tool") then local n=t.Name:lower(); if n:find("medusa") or n:find("head") or n:find("stone") then return t end end end end
    return nil
end
local function useMedusaCounter()
    if State.medusaDebounce then return end; if tick()-State.medusaLastUsed<MEDUSA_COOLDOWN then return end
    local c=LP.Character; if not c then return end; State.medusaDebounce=true
    local med=findMedusa(); if not med then State.medusaDebounce=false; return end
    if med.Parent~=c then local hum2=c:FindFirstChildOfClass("Humanoid"); if hum2 then hum2:EquipTool(med) end end
    pcall(function() med:Activate() end); State.medusaLastUsed=tick(); State.medusaDebounce=false
end
local function onAnchorChanged(part) return part:GetPropertyChangedSignal("Anchored"):Connect(function() if part.Anchored and part.Transparency==1 then useMedusaCounter() end end) end
local function setupMedusaCounter(char)
    for _,c2 in pairs(Conns.anchor) do pcall(function() c2:Disconnect() end) end; Conns.anchor={}
    if not char then return end
    for _,part in ipairs(char:GetDescendants()) do if part:IsA("BasePart") then table.insert(Conns.anchor,onAnchorChanged(part)) end end
    table.insert(Conns.anchor,char.DescendantAdded:Connect(function(part) if part:IsA("BasePart") then table.insert(Conns.anchor,onAnchorChanged(part)) end end))
end
local function stopMedusaCounter() for _,c2 in pairs(Conns.anchor) do pcall(function() c2:Disconnect() end) end; Conns.anchor={} end

local function faceSouth() pcall(function() local c=LP.Character; if not c then return end; local root=c:FindFirstChild("HumanoidRootPart"); if root then root.CFrame=CFrame.new(root.Position)*CFrame.Angles(0,0,0) end end) end
local function faceNorth() pcall(function() local c=LP.Character; if not c then return end; local root=c:FindFirstChild("HumanoidRootPart"); if root then root.CFrame=CFrame.new(root.Position)*CFrame.Angles(0,math.rad(180),0) end end) end

local function startAutoLeft()
    if State.tpBatEnabled then
        State._setTPBatEnabled(false)
    end

    if Conns.autoLeft then Conns.autoLeft:Disconnect() end; State.autoLeftPhase=1
    Conns.autoLeft=RunService.Heartbeat:Connect(function()
        if not State.autoLeftEnabled then return end
        local c=LP.Character; if not c then return end
        local root=c:FindFirstChild("HumanoidRootPart"); local hum2=c:FindFirstChildOfClass("Humanoid"); if not root or not hum2 then return end
        local spd=getProfileNormalSpeed()
        if State.autoLeftPhase==1 then
            local tgt=Vector3.new(AP.L1.X,root.Position.Y,AP.L1.Z); if (tgt-root.Position).Magnitude<1 then State.autoLeftPhase=2; local d=(AP.L2-root.Position); local mv=Vector3.new(d.X,0,d.Z).Unit; hum2:Move(mv,false); root.AssemblyLinearVelocity=Vector3.new(mv.X*spd,root.AssemblyLinearVelocity.Y,mv.Z*spd); return end
            local d=(AP.L1-root.Position); local mv=Vector3.new(d.X,0,d.Z).Unit; hum2:Move(mv,false); root.AssemblyLinearVelocity=Vector3.new(mv.X*spd,root.AssemblyLinearVelocity.Y,mv.Z*spd)
        elseif State.autoLeftPhase==2 then
            local tgt=Vector3.new(AP.L2.X,root.Position.Y,AP.L2.Z); if (tgt-root.Position).Magnitude<1 then hum2:Move(Vector3.zero,false); root.AssemblyLinearVelocity=Vector3.zero; State.autoLeftEnabled=false; if Conns.autoLeft then Conns.autoLeft:Disconnect(); Conns.autoLeft=nil end; State.autoLeftPhase=1; if autoLeftSetVisual then autoLeftSetVisual(false) end; faceSouth(); return end
            local d=(AP.L2-root.Position); local mv=Vector3.new(d.X,0,d.Z).Unit; hum2:Move(mv,false); root.AssemblyLinearVelocity=Vector3.new(mv.X*spd,root.AssemblyLinearVelocity.Y,mv.Z*spd)
        end
    end)
end
local function stopAutoLeft()
    if Conns.autoLeft then Conns.autoLeft:Disconnect(); Conns.autoLeft=nil end; State.autoLeftPhase=1
    local c=LP.Character; if c then local hum2=c:FindFirstChildOfClass("Humanoid"); if hum2 then hum2:Move(Vector3.zero,false) end end
end
local function startAutoRight()
    if State.tpBatEnabled then
        State._setTPBatEnabled(false)
    end

    if Conns.autoRight then Conns.autoRight:Disconnect() end; State.autoRightPhase=1
    Conns.autoRight=RunService.Heartbeat:Connect(function()
        if not State.autoRightEnabled then return end
        local c=LP.Character; if not c then return end
        local root=c:FindFirstChild("HumanoidRootPart"); local hum2=c:FindFirstChildOfClass("Humanoid"); if not root or not hum2 then return end
        local spd=getProfileNormalSpeed()
        if State.autoRightPhase==1 then
            local tgt=Vector3.new(AP.R1.X,root.Position.Y,AP.R1.Z); if (tgt-root.Position).Magnitude<1 then State.autoRightPhase=2; local d=(AP.R2-root.Position); local mv=Vector3.new(d.X,0,d.Z).Unit; hum2:Move(mv,false); root.AssemblyLinearVelocity=Vector3.new(mv.X*spd,root.AssemblyLinearVelocity.Y,mv.Z*spd); return end
            local d=(AP.R1-root.Position); local mv=Vector3.new(d.X,0,d.Z).Unit; hum2:Move(mv,false); root.AssemblyLinearVelocity=Vector3.new(mv.X*spd,root.AssemblyLinearVelocity.Y,mv.Z*spd)
        elseif State.autoRightPhase==2 then
            local tgt=Vector3.new(AP.R2.X,root.Position.Y,AP.R2.Z); if (tgt-root.Position).Magnitude<1 then hum2:Move(Vector3.zero,false); root.AssemblyLinearVelocity=Vector3.zero; State.autoRightEnabled=false; if Conns.autoRight then Conns.autoRight:Disconnect(); Conns.autoRight=nil end; State.autoRightPhase=1; if autoRightSetVisual then autoRightSetVisual(false) end; faceNorth(); return end
            local d=(AP.R2-root.Position); local mv=Vector3.new(d.X,0,d.Z).Unit; hum2:Move(mv,false); root.AssemblyLinearVelocity=Vector3.new(mv.X*spd,root.AssemblyLinearVelocity.Y,mv.Z*spd)
        end
    end)
end
local function stopAutoRight()
    if Conns.autoRight then Conns.autoRight:Disconnect(); Conns.autoRight=nil end; State.autoRightPhase=1
    local c=LP.Character; if c then local hum2=c:FindFirstChildOfClass("Humanoid"); if hum2 then hum2:Move(Vector3.zero,false) end end
end

local antiRagdollConn = nil

local function resetAntiRagdollCharacter(char)
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    local root = char and char:FindFirstChild("HumanoidRootPart")
    if not hum or not root or hum.Health <= 0 then return end

    pcall(function()
        hum:ChangeState(Enum.HumanoidStateType.GettingUp)
        hum:ChangeState(Enum.HumanoidStateType.Running)

        root.Velocity = Vector3.zero
        root.RotVelocity = Vector3.zero
        root.AssemblyLinearVelocity = Vector3.zero
        root.AssemblyAngularVelocity = Vector3.zero

        hum.PlatformStand = false
        hum.Sit = false
        hum.AutoRotate = true
        hum.JumpPower = hum.JumpPower > 0 and hum.JumpPower or 50
        hum.WalkSpeed = hum.WalkSpeed > 0 and hum.WalkSpeed or 16

        for _, obj in ipairs(char:GetDescendants()) do
            if obj:IsA("Motor6D") then
                obj.Enabled = true
            elseif obj:IsA("Constraint")
                or obj:IsA("BallSocketConstraint")
                or obj:IsA("HingeConstraint") then
                obj.Enabled = true
            elseif obj:IsA("BasePart") then
                obj.CanCollide = true
                obj.AssemblyLinearVelocity = Vector3.zero
                obj.AssemblyAngularVelocity = Vector3.zero
            end
        end

        workspace.CurrentCamera.CameraSubject = hum

        local playerModule = LP.PlayerScripts:FindFirstChild("PlayerModule")
        if playerModule then
            local controlModule = playerModule:FindFirstChild("ControlModule")
            if controlModule then
                local success, module = pcall(require, controlModule)
                if success and module and module.Enable then
                    module:Enable()
                end
            end
        end
    end)
end

startAntiRagdoll = function()
    if antiRagdollConn then return end

    antiRagdollConn = RunService.Heartbeat:Connect(function()
        if not State.antiRagdollEnabled then return end

        local char = LP.Character
        if not char then return end

        local hum = char:FindFirstChildOfClass("Humanoid")
        if not hum then return end

        local state = hum:GetState()

        if state == Enum.HumanoidStateType.Physics
            or state == Enum.HumanoidStateType.Ragdoll
            or state == Enum.HumanoidStateType.FallingDown
            or state == Enum.HumanoidStateType.Dead
            or hum.PlatformStand == true
            or hum.Sit == true then

            resetAntiRagdollCharacter(char)
        end
    end)
end

stopAntiRagdoll = function()
    if antiRagdollConn then
        antiRagdollConn:Disconnect()
        antiRagdollConn = nil
    end
end

local ContentProvider = game:GetService("ContentProvider")
local Anims = {
    idle1 = "rbxassetid://133806214992291",
    idle2 = "rbxassetid://94970088341563",
    walk = "rbxassetid://707897309",
    run = "rbxassetid://707861613",
    jump = "rbxassetid://116936326516985",
    fall = "rbxassetid://116936326516985",
    climb = "rbxassetid://116936326516985",
    swim = "rbxassetid://116936326516985",
    swimidle = "rbxassetid://116936326516985"
}

task.spawn(function() pcall(function() ContentProvider:PreloadAsync(Anims) end) end)

local function applyAnimPack(char)
    local a = char:FindFirstChild("Animate")
    if not a then return end
    local function s(o, id) if o then o.AnimationId = id end end

    s(a.idle and a.idle.Animation1, Anims.idle1)
    s(a.idle and a.idle.Animation2, Anims.idle2)
    s(a.walk and a.walk.WalkAnim, Anims.walk)
    s(a.run and a.run.RunAnim, Anims.run)
    s(a.jump and a.jump.JumpAnim, Anims.jump)
    s(a.fall and a.fall.FallAnim, Anims.fall)
    s(a.climb and a.climb.ClimbAnim, Anims.climb)
    s(a.swim and a.swim.Swim, Anims.swim)
    s(a.swimidle and a.swimidle.SwimIdle, Anims.swimidle)
end

local animHBConn
function startNuevaAnimacion()
    if animHBConn then animHBConn:Disconnect(); animHBConn = nil end
    local char = LP.Character
    if char then
        applyAnimPack(char)
        local hum2 = char:FindFirstChildOfClass("Humanoid")
        if hum2 then
            for _, t in ipairs(hum2:GetPlayingAnimationTracks()) do t:Stop(0) end
            hum2:ChangeState(Enum.HumanoidStateType.Running)
        end
    end

    animHBConn = RunService.Heartbeat:Connect(function()
        if not State.nuevaAnimacionEnabled then return end
        local c = LP.Character
        if c then applyAnimPack(c) end
    end)
end

function stopNuevaAnimacion()
    if animHBConn then animHBConn:Disconnect(); animHBConn = nil end
end

local applyFPSBoost
applyFPSBoost=function()
    pcall(function() setfpscap(999999999) end)
    local function pO(v) pcall(function()
        if v:IsA("Model") then v.LevelOfDetail=Enum.ModelLevelOfDetail.Disabled; v.ModelStreamingMode=Enum.ModelStreamingMode.Nonatomic
        elseif v:IsA("MeshPart") then v.CastShadow=false; v.DoubleSided=false; v.RenderFidelity=Enum.RenderFidelity.Performance
        elseif v:IsA("BasePart") then v.CastShadow=false; v.Material=Enum.Material.Plastic; v.Reflectance=0
        elseif v:IsA("Decal") or v:IsA("Texture") then v.Transparency=1
        elseif v:IsA("SpecialMesh") then v.TextureId=""
        elseif v:IsA("Fire") or v:IsA("SpotLight") or v:IsA("Smoke") or v:IsA("Sparkles") or v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Beam") then v.Enabled=false
        elseif v:IsA("SurfaceAppearance") or v:IsA("MaterialVariant") then v:Destroy()
        elseif v:IsA("Attachment") then v.Visible=false end
    end) end
    for _,v in pairs(workspace:GetDescendants()) do pO(v) end
    pcall(function()
        local L=game:GetService("Lighting")
        for _,v in pairs(L:GetDescendants()) do pcall(function() if v:IsA("Sky") or v:IsA("Atmosphere") or v:IsA("BloomEffect") or v:IsA("BlurEffect") or v:IsA("SunRaysEffect") or v:IsA("DepthOfFieldEffect") or v:IsA("Clouds") or v:IsA("PostEffect") or v:IsA("ColorCorrectionEffect") then v:Destroy() end end) end
        pcall(function() sethiddenproperty(L,"Technology",Enum.Technology.Legacy) end)
        L.GlobalShadows=false; L.FogEnd=9e9; L.Brightness=0
        local ter=workspace:FindFirstChildOfClass("Terrain")
        if ter then pcall(function() sethiddenproperty(ter,"Decoration",false) end); ter.WaterReflectance=0; ter.WaterTransparency=0.7; ter.WaterWaveSize=0; ter.WaterWaveSpeed=0 end
    end)
    workspace.DescendantAdded:Connect(function(v) if State.fpsBoostEnabled then task.spawn(pO,v) end end)
end

repeat task.wait() until game:IsLoaded()

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UIS = game:GetService("UserInputService")
local LP = Players.LocalPlayer
local plots = workspace:WaitForChild("Plots")

-- ============================================================
--  AUTO STEAL DE NIGHT #3.VS (REEMPLAZADO COMPLETAMENTE)
-- ============================================================
local CONFIG = {
	AUTO_STEAL_ENABLED = true,
	HOLD_MIN = 1.3,
	HOLD_MAX = 2.6,
	ENTRY_DELAY = 0.3,
	COOLDOWN = 0.05,
	STEAL_RANGE = 8,
	PRIME_RANGE = 80
}

local AnimalsData = {}
local syncRemotes = nil
local plotAnimalSync = {caches = {}, connections = {}}
local allAnimalsCache = {}
local PromptMemoryCache = {}
local InternalStealCache = {}
local stealConnection = nil

local StealState = {
	active = false,
	startTime = 0,
	phase = "idle",
	label = "",
	lastResult = "",
	lastResultTime = 0,
	totalSteals = 0,
	failedSteals = 0
}

local function initializeAutoStealSync()
	local ok = pcall(function()
		local Packages = ReplicatedStorage:WaitForChild("Packages", 10)
		local Datas = ReplicatedStorage:WaitForChild("Datas", 10)
		if not Packages or not Datas then return end
		AnimalsData = require(Datas:WaitForChild("Animals"))
		local folder = Packages:WaitForChild("Synchronizer")
		syncRemotes = {
			channelFolder = folder:WaitForChild("Channel"),
			routeRemote = folder:WaitForChild("CommunicationRoute"),
			requestData = folder:FindFirstChild("RequestData")
		}
	end)
	return ok and syncRemotes ~= nil
end

local function splitSyncPath(path)
	if typeof(path) == "table" then return path end
	local out = {}
	for part in string.gmatch(tostring(path), "[^%.]+") do
		table.insert(out, tonumber(part) or part)
	end
	return out
end

local function resolveSyncPath(path, root)
	local current = root
	local parent = nil
	local key = nil
	for _, part in ipairs(splitSyncPath(path)) do
		parent = current
		key = part
		current = current and current[part] or nil
	end
	return current, parent, key
end

local function applyPlotSyncDiff(channelName, packet)
	local cache = plotAnimalSync.caches[channelName]
	if typeof(cache) ~= "table" then return end
	local path, action, a, b = packet[1], packet[2], packet[3], packet[4]
	local current, parent, key = resolveSyncPath(path, cache)
	if action == "Changed" then
		if parent ~= nil then parent[key] = a end
	elseif action == "ArrayInsert" then
		if current ~= nil then table.insert(current, b, a) end
	elseif action == "ArrayRemoved" then
		if current ~= nil then table.remove(current, b) end
	elseif action == "DictionaryInsert" then
		if current ~= nil then current[b] = a end
	elseif action == "DictionaryRemoved" then
		if current ~= nil then current[b] = nil end
	end
end

local function attachPlotChannel(remote)
	if not syncRemotes or plotAnimalSync.connections[remote] then return end
	local channelName = tostring(remote.Name)
	if not plots:FindFirstChild(channelName) then return end
	if syncRemotes.requestData and plotAnimalSync.caches[channelName] == nil then
		local ok, data = pcall(function() return syncRemotes.requestData:InvokeServer(channelName) end)
		plotAnimalSync.caches[channelName] = (ok and typeof(data) == "table") and data or {}
	elseif plotAnimalSync.caches[channelName] == nil then
		plotAnimalSync.caches[channelName] = {}
	end
	plotAnimalSync.connections[remote] = remote.OnClientEvent:Connect(function(queue)
		for _, packet in ipairs(queue) do
			applyPlotSyncDiff(channelName, packet)
		end
	end)
end

local function detachPlotChannel(channelName)
	for remote, conn in pairs(plotAnimalSync.connections) do
		if tostring(remote.Name) == tostring(channelName) then
			conn:Disconnect()
			plotAnimalSync.connections[remote] = nil
			plotAnimalSync.caches[tostring(channelName)] = nil
			break
		end
	end
end

local function startAutoStealSync()
	if not initializeAutoStealSync() then return false end
	for _, child in ipairs(syncRemotes.channelFolder:GetChildren()) do
		if child:IsA("RemoteEvent") then attachPlotChannel(child) end
	end
	syncRemotes.channelFolder.ChildAdded:Connect(function(child)
		if child:IsA("RemoteEvent") then attachPlotChannel(child) end
	end)
	syncRemotes.routeRemote.OnClientEvent:Connect(function(actions)
		for _, action in ipairs(actions) do
			local kind, channelName = action[1], tostring(action[2])
			if not plots:FindFirstChild(channelName) then continue end
			if kind == "ListenerAdded" then
				local remote = syncRemotes.channelFolder:FindFirstChild(channelName)
				if remote and remote:IsA("RemoteEvent") then attachPlotChannel(remote) end
			elseif kind == "ListenerRemoved" then
				detachPlotChannel(channelName)
			end
		end
	end)
	return true
end

local function getPlotChannelData(plotName)
	return plotAnimalSync.caches[plotName]
end

local function getPlotOwner(plot)
	local sign = plot:FindFirstChild("PlotSign")
	local frame = sign and sign:FindFirstChild("SurfaceGui") and sign.SurfaceGui:FindFirstChild("Frame")
	local label = frame and frame:FindFirstChild("TextLabel")
	if not label or label.Text == "Empty Base" then return nil end
	return label.Text:gsub("'s [Bb]ase$", ""):gsub("%s+$", "")
end

local function isMyBaseAnimal(animalData)
	if not animalData or not animalData.plot then return false end
	local plot = plots:FindFirstChild(animalData.plot)
	if not plot then return false end
	return getPlotOwner(plot) == LP.DisplayName
end

local function getAnimalPosition(animalData)
	local plot = plots:FindFirstChild(animalData.plot)
	if not plot then return nil end
	local podiums = plot:FindFirstChild("AnimalPodiums")
	if not podiums then return nil end
	local podium = podiums:FindFirstChild(animalData.slot)
	if not podium then return nil end
	return podium:GetPivot().Position
end

local function findProximityPromptForAnimal(animalData)
	if not animalData then return nil end
	local cached = PromptMemoryCache[animalData.uid]
	if cached and cached.Parent then return cached end
	local plot = plots:FindFirstChild(animalData.plot)
	if not plot then return nil end
	local podiums = plot:FindFirstChild("AnimalPodiums")
	if not podiums then return nil end
	local podium = podiums:FindFirstChild(animalData.slot)
	if not podium then return nil end
	local base = podium:FindFirstChild("Base")
	if not base then return nil end
	local spawn = base:FindFirstChild("Spawn")
	if not spawn then return nil end
	local attach = spawn:FindFirstChild("PromptAttachment")
	if not attach then return nil end
	for _, p in ipairs(attach:GetChildren()) do
		if p:IsA("ProximityPrompt") then
			PromptMemoryCache[animalData.uid] = p
			return p
		end
	end
	return nil
end

local function distToAnimal(animalData)
	local character = LP.Character
	if not character then return math.huge end
	local hrp = character:FindFirstChild("HumanoidRootPart") or character:FindFirstChild("UpperTorso")
	if not hrp then return math.huge end
	local pos = getAnimalPosition(animalData)
	if not pos then return math.huge end
	return (hrp.Position - pos).Magnitude
end

local function pickClosest()
	local character = LP.Character
	if not character then return nil end
	local hrp = character:FindFirstChild("HumanoidRootPart") or character:FindFirstChild("UpperTorso")
	if not hrp then return nil end
	local best, bestDist = nil, math.huge
	for _, animalData in ipairs(allAnimalsCache) do
		if isMyBaseAnimal(animalData) then continue end
		local pos = getAnimalPosition(animalData)
		if not pos then continue end
		local dist = (hrp.Position - pos).Magnitude
		if dist > CONFIG.PRIME_RANGE then continue end
		if dist < bestDist then
			bestDist = dist
			best = animalData
		end
	end
	return best
end

local function buildStealCallbacks(prompt)
	if InternalStealCache[prompt] then return end
	local data = {holdCallbacks = {}, triggerCallbacks = {}, ready = true}
	local ok1, conns1 = false, nil
	if getconnections then ok1, conns1 = pcall(getconnections, prompt.PromptButtonHoldBegan) end
	if ok1 and type(conns1) == "table" then
		for _, conn in ipairs(conns1) do
			if type(conn.Function) == "function" then
				table.insert(data.holdCallbacks, conn.Function)
			end
		end
	end
	local ok2, conns2 = false, nil
	if getconnections then ok2, conns2 = pcall(getconnections, prompt.Triggered) end
	if ok2 and type(conns2) == "table" then
		for _, conn in ipairs(conns2) do
			if type(conn.Function) == "function" then
				table.insert(data.triggerCallbacks, conn.Function)
			end
		end
	end
	if (#data.holdCallbacks > 0) or (#data.triggerCallbacks > 0) then
		InternalStealCache[prompt] = data
	end
end

local function executeStealAsync(prompt, animalData)
	local data = InternalStealCache[prompt]
	if not data or not data.ready then return false end
	data.ready = false
	local label = animalData.name or "Animal"
	StealState.active = true
	StealState.startTime = tick()
	StealState.phase = "holding"
	StealState.label = label
	task.spawn(function()
		for _, fn in ipairs(data.holdCallbacks) do
			task.spawn(fn)
		end
		task.wait(CONFIG.HOLD_MIN)
		StealState.phase = "waitingRange"
		local alreadyInRange = distToAnimal(animalData) <= CONFIG.STEAL_RANGE
		local fired = false
		while true do
			local elapsed = tick() - StealState.startTime
			if elapsed > CONFIG.HOLD_MAX then break end
			if not prompt.Parent then break end
			if distToAnimal(animalData) <= CONFIG.STEAL_RANGE then
				if not alreadyInRange then task.wait(CONFIG.ENTRY_DELAY) end
				for _, fn in ipairs(data.triggerCallbacks) do
					task.spawn(fn)
				end
				fired = true
				break
			end
			task.wait()
		end
		if fired then
			StealState.totalSteals = StealState.totalSteals + 1
			StealState.lastResult = "Stole " .. label
			StealState.phase = "success"
		else
			StealState.failedSteals = StealState.failedSteals + 1
			StealState.lastResult = "Missed window: " .. label
			StealState.phase = "failed"
		end
		StealState.active = false
		StealState.lastResultTime = tick()
		task.wait(CONFIG.COOLDOWN)
		data.ready = true
	end)
	return true
end

local function attemptSteal(prompt, animalData)
	if not prompt or not prompt.Parent then return false end
	buildStealCallbacks(prompt)
	if not InternalStealCache[prompt] then return false end
	return executeStealAsync(prompt, animalData)
end

local function scanAllPlots()
	local newCache = {}
	for _, plot in ipairs(plots:GetChildren()) do
		local cache = getPlotChannelData(plot.Name)
		if not cache then continue end
		local animalList = cache.AnimalList
		if typeof(animalList) ~= "table" then continue end
		for slot, animalData in pairs(animalList) do
			if type(animalData) == "table" then
				local animalName = animalData.Index
				local animalInfo = AnimalsData[animalName]
				if not animalInfo then continue end
				table.insert(newCache, {
					name = animalInfo.DisplayName or animalName,
					plot = plot.Name,
					slot = tostring(slot),
					uid = plot.Name .. "_" .. tostring(slot)
				})
			end
		end
	end
	allAnimalsCache = newCache
	return #allAnimalsCache
end

function startAutoSteal()
	if stealConnection then return end
	stealConnection = RunService.Heartbeat:Connect(function()
		if not CONFIG.AUTO_STEAL_ENABLED then return end
		if StealState.active then return end
		local target = pickClosest()
		if not target then return end
		local prompt = PromptMemoryCache[target.uid]
		if not prompt or not prompt.Parent then
			prompt = findProximityPromptForAnimal(target)
		end
		if prompt then
			attemptSteal(prompt, target)
		end
	end)
end

function stopAutoSteal()
	if not stealConnection then return end
	stealConnection:Disconnect()
	stealConnection = nil
	StealState.active = false
	StealState.phase = "idle"
end

local CoreGui = game:GetService("CoreGui")

local oldGui = CoreGui:FindFirstChild("CandyStealBar")
if oldGui then oldGui:Destroy() end

local gui2 = Instance.new("ScreenGui")
gui2.Name = "CandyStealBar"
gui2.ResetOnSpawn = false
gui2.DisplayOrder = 100
gui2.IgnoreGuiInset = true
gui2.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui2.Parent = CoreGui

local frame = Instance.new("Frame", gui2)
local UIS = game:GetService("UserInputService")
frame.Active = true

local dragging = false
local dragStart
local startPos

frame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch
    or input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = frame.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

UIS.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.Touch
    or input.UserInputType == Enum.UserInputType.MouseMovement) then
        local delta = input.Position - dragStart
        frame.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

UIS.InputEnded:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.Touch
    or input.UserInputType == Enum.UserInputType.MouseButton1) then
        dragging = false
    end
end)

-- ============================================================
-- BARRA DE ROBO CT DUELS (AZUL) CON BOTÃ“N ÃšNICO TOGGLE + RADIUS
-- + MOVIBLE + BOTÃ“N LOCK
-- ============================================================
local pbFrame = Instance.new("Frame", gui2)
pbFrame.Size = UDim2.new(0, 300, 0, 42)
pbFrame.Position = UDim2.new(0.5, -150, 0, 80)
pbFrame.BackgroundColor3 = Color3.fromRGB(6,6,8)
pbFrame.BorderSizePixel = 0
pbFrame.ClipsDescendants = false
pbFrame.Active = true
pbFrame.Selectable = false
pbFrame.ZIndex = 50
Instance.new("UICorner", pbFrame).CornerRadius = UDim.new(0, 12)

-- Estado de lock de la barra Auto Grab
local autoGrabLocked = false
State.autoGrabLocked = false
local lockBtn = nil -- se crea mÃ¡s abajo
local toggleBtn = nil -- se crea mÃ¡s abajo

local pbDragging = false
local pbDragStart = nil
local pbStartPos = nil
local pbIgnoreDragUntil = 0

local function refreshLockBtnVisual()
	if not lockBtn or not lockBtn.Parent then return end
	if autoGrabLocked then
		lockBtn.Text = "LOCK"
		lockBtn.BackgroundColor3 = Color3.fromRGB(255, 40, 50)
		lockBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	else
		lockBtn.Text = "MOVE"
		lockBtn.BackgroundColor3 = Color3.fromRGB(12, 12, 14)
		lockBtn.TextColor3 = Color3.fromRGB(200, 200, 210)
	end
end

local function setAutoGrabLocked(locked, skipSave)
	autoGrabLocked = locked and true or false
	State.autoGrabLocked = autoGrabLocked
	pbDragging = false
	pbDragStart = nil
	pbStartPos = nil
	pbIgnoreDragUntil = tick() + 0.25
	refreshLockBtnVisual()
	if not skipSave and State.requestConfigSave then
		State.requestConfigSave()
	end
end

local function isOverAutoGrabButton(screenPos)
	local ok, objects = pcall(function()
		return UIS:GetGuiObjectsAtPosition(screenPos.X, screenPos.Y)
	end)
	if not ok or type(objects) ~= "table" then return false end
	for _, obj in ipairs(objects) do
		if obj == lockBtn or obj == toggleBtn then
			return true
		end
		if obj and obj:IsA("GuiObject") then
			local n = obj.Name
			if n == "AutoGrabLockBtn" or n == "AutoGrabToggleBtn" then
				return true
			end
		end
	end
	return false
end

pbFrame.InputBegan:Connect(function(input)
	if autoGrabLocked or uiLocked then return end
	if tick() < pbIgnoreDragUntil then return end
	if input.UserInputType ~= Enum.UserInputType.Touch
		and input.UserInputType ~= Enum.UserInputType.MouseButton1 then
		return
	end
	if isOverAutoGrabButton(input.Position) then
		pbDragging = false
		return
	end
	pbDragging = true
	pbDragStart = input.Position
	pbStartPos = pbFrame.Position
end)

UIS.InputChanged:Connect(function(input)
	if not pbDragging or autoGrabLocked or uiLocked then return end
	if input.UserInputType == Enum.UserInputType.Touch
		or input.UserInputType == Enum.UserInputType.MouseMovement then
		local delta = input.Position - pbDragStart
		pbFrame.Position = UDim2.new(
			pbStartPos.X.Scale,
			pbStartPos.X.Offset + delta.X,
			pbStartPos.Y.Scale,
			pbStartPos.Y.Offset + delta.Y
		)
	end
end)

UIS.InputEnded:Connect(function(input)
	if not pbDragging then return end
	if input.UserInputType == Enum.UserInputType.Touch
		or input.UserInputType == Enum.UserInputType.MouseButton1 then
		pbDragging = false
		if State.requestConfigSave then State.requestConfigSave() end
	end
end)

-- Auto Grab photo supplied by the user. The dark overlay keeps the status text readable.
local autoGrabPhoto = Instance.new("ImageLabel", pbFrame)
autoGrabPhoto.Name = "AutoGrabPhoto"
autoGrabPhoto.Size = UDim2.new(1, 0, 1, 0)
autoGrabPhoto.Position = UDim2.new(0, 0, 0, 0)
autoGrabPhoto.BackgroundTransparency = 1
autoGrabPhoto.BorderSizePixel = 0
autoGrabPhoto.Image = "rbxassetid://108199149509537"
autoGrabPhoto.ImageTransparency = 0.42
autoGrabPhoto.ScaleType = Enum.ScaleType.Crop
autoGrabPhoto.ZIndex = -1
Instance.new("UICorner", autoGrabPhoto).CornerRadius = UDim.new(0, 12)

local autoGrabPhotoOverlay = Instance.new("Frame", pbFrame)
autoGrabPhotoOverlay.Name = "AutoGrabPhotoOverlay"
autoGrabPhotoOverlay.Size = UDim2.new(1, 0, 1, 0)
autoGrabPhotoOverlay.Position = UDim2.new(0, 0, 0, 0)
autoGrabPhotoOverlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
autoGrabPhotoOverlay.BackgroundTransparency = 0.48
autoGrabPhotoOverlay.BorderSizePixel = 0
autoGrabPhotoOverlay.ZIndex = 0
Instance.new("UICorner", autoGrabPhotoOverlay).CornerRadius = UDim.new(0, 12)

local pbs = Instance.new("UIStroke", pbFrame)
pbs.Color = Color3.fromRGB(255, 40, 50)
pbs.Thickness = 1.4
pbs.Transparency = 0.1
local pbsGrad = Instance.new("UIGradient", pbs)
pbsGrad.Color = ColorSequence.new(Color3.fromRGB(255, 40, 50), Color3.fromRGB(190,190,200))
pbsGrad.Rotation = 25

local progressStripe = Instance.new("Frame", pbFrame)
progressStripe.Size = UDim2.new(0, 3, 1, -14)
progressStripe.Position = UDim2.new(0, 6, 0, 7)
progressStripe.BackgroundColor3 = Color3.fromRGB(255, 40, 50)
progressStripe.BorderSizePixel = 0
progressStripe.ZIndex = 2
Instance.new("UICorner", progressStripe).CornerRadius = UDim.new(0, 8)

-- Pill del Status
local statusPill = Instance.new("Frame", pbFrame)
statusPill.Size = UDim2.new(0, 78, 0, 20)
statusPill.Position = UDim2.new(0, 14, 0, 5)
statusPill.BackgroundColor3 = Color3.fromRGB(10,10,12)
statusPill.BorderSizePixel = 0
statusPill.ZIndex = 2
Instance.new("UICorner", statusPill).CornerRadius = UDim.new(0, 30)

local progressPillStroke = Instance.new("UIStroke", statusPill)
progressPillStroke.Color = Color3.fromRGB(255, 40, 50)
progressPillStroke.Thickness = 1
progressPillStroke.Transparency = 0.45

local progressDot = Instance.new("Frame", statusPill)
progressDot.Size = UDim2.new(0, 6, 0, 6)
progressDot.Position = UDim2.new(0, 7, 0.5, -3)
progressDot.BackgroundColor3 = Color3.fromRGB(255, 40, 50)
progressDot.BorderSizePixel = 0
progressDot.ZIndex = 2
Instance.new("UICorner", progressDot).CornerRadius = UDim.new(0, 10)

local progressDotGlow = Instance.new("UIStroke", progressDot)
progressDotGlow.Color = Color3.fromRGB(255, 40, 50)
progressDotGlow.Thickness = 2
progressDotGlow.Transparency = 0.4

local progressPct = Instance.new("TextLabel", statusPill)
progressPct.Size = UDim2.new(1, -20, 1, 0)
progressPct.Position = UDim2.new(0, 20, 0, 0)
progressPct.BackgroundTransparency = 1
progressPct.Text = (CONFIG.AUTO_STEAL_ENABLED and "READY" or "IDLE")
progressPct.TextColor3 = Color3.fromRGB(230,230,235)
progressPct.Font = Enum.Font.GothamBlack
progressPct.TextSize = 9
progressPct.TextXAlignment = Enum.TextXAlignment.Left
progressPct.ZIndex = 2

local progressRadLbl = Instance.new("TextLabel", pbFrame)
progressRadLbl.Size = UDim2.new(0, 78, 0, 20)
progressRadLbl.Position = UDim2.new(0, 96, 0, 5)
progressRadLbl.BackgroundTransparency = 1
progressRadLbl.Text = "Radius: " .. tostring(CONFIG.STEAL_RANGE)
progressRadLbl.TextColor3 = Color3.fromRGB(190,190,200)
progressRadLbl.Font = Enum.Font.GothamBlack
progressRadLbl.TextSize = 9
progressRadLbl.TextXAlignment = Enum.TextXAlignment.Center
progressRadLbl.ZIndex = 2

-- BotÃ³n LOCK / MOVE (fija o libera la posiciÃ³n de la barra)
lockBtn = Instance.new("TextButton", pbFrame)
lockBtn.Name = "AutoGrabLockBtn"
lockBtn.Size = UDim2.new(0, 46, 0, 22)
lockBtn.Position = UDim2.new(1, -106, 0, 4)
lockBtn.BorderSizePixel = 0
lockBtn.Font = Enum.Font.GothamBold
lockBtn.TextSize = 10
lockBtn.Text = "MOVE"
lockBtn.BackgroundColor3 = Color3.fromRGB(12, 12, 14)
lockBtn.TextColor3 = Color3.fromRGB(200, 200, 210)
lockBtn.AutoButtonColor = false
lockBtn.Active = true
lockBtn.Selectable = true
lockBtn.ZIndex = 60
Instance.new("UICorner", lockBtn).CornerRadius = UDim.new(0, 8)
local lockStroke = Instance.new("UIStroke", lockBtn)
lockStroke.Thickness = 1.2
lockStroke.Color = Color3.fromRGB(255, 40, 50)
lockStroke.Transparency = 0.35
lockStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

local lastLockToggleAt = 0
local function toggleAutoGrabLock()
	local now = tick()
	if now - lastLockToggleAt < 0.2 then return end
	lastLockToggleAt = now
	pbDragging = false
	pbIgnoreDragUntil = now + 0.25
	setAutoGrabLocked(not autoGrabLocked)
end

-- Solo Activated (cubre PC + mÃ³vil); evita doble toggle
lockBtn.Activated:Connect(toggleAutoGrabLock)
lockBtn.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Touch
		or input.UserInputType == Enum.UserInputType.MouseButton1 then
		pbDragging = false
		pbIgnoreDragUntil = tick() + 0.25
	end
end)

refreshLockBtnVisual()

toggleBtn = Instance.new("TextButton", pbFrame)
toggleBtn.Name = "AutoGrabToggleBtn"
toggleBtn.Size = UDim2.new(0, 44, 0, 22)
toggleBtn.Position = UDim2.new(1, -54, 0, 4)
toggleBtn.BorderSizePixel = 0
toggleBtn.Font = Enum.Font.GothamBold
toggleBtn.TextSize = 10
toggleBtn.Active = true
toggleBtn.Selectable = true
toggleBtn.ZIndex = 60
Instance.new("UICorner", toggleBtn).CornerRadius = UDim.new(0, 8)

local btnStroke = Instance.new("UIStroke", toggleBtn)
btnStroke.Thickness = 1.2
btnStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

local btnGrad = Instance.new("UIGradient", toggleBtn)
btnGrad.Rotation = 90

local function updateButtonUI(enabled)
    if enabled then
        toggleBtn.Text = "STOP"
        toggleBtn.BackgroundColor3 = Color3.fromRGB(255, 40, 50)
        toggleBtn.TextColor3 = Color3.fromRGB(255,255,255)
        btnStroke.Color = Color3.fromRGB(190,190,200)
        btnGrad.Color = ColorSequence.new(Color3.fromRGB(255, 40, 50), Color3.fromRGB(150,150,160))
        
        progressPct.Text = "READY"
        progressPct.TextColor3 = Color3.fromRGB(230,230,235)
    else
        toggleBtn.Text = "START"
        toggleBtn.BackgroundColor3 = Color3.fromRGB(12,12,14)
        toggleBtn.TextColor3 = Color3.fromRGB(180,180,180)
        btnStroke.Color = Color3.fromRGB(40,40,48)
        btnGrad.Color = ColorSequence.new(Color3.fromRGB(16,16,18), Color3.fromRGB(14,14,16))
        
        progressPct.Text = "IDLE"
        progressPct.TextColor3 = Color3.fromRGB(190,190,200)
    end
end

toggleBtn.Activated:Connect(function()
	pbDragging = false
    CONFIG.AUTO_STEAL_ENABLED = not CONFIG.AUTO_STEAL_ENABLED
    
    if CONFIG.AUTO_STEAL_ENABLED then
        pcall(startAutoSteal)
    else
        pcall(stopAutoSteal)
    end
    
    updateButtonUI(CONFIG.AUTO_STEAL_ENABLED)
end)

toggleBtn.InputBegan:Connect(function()
	pbDragging = false
end)

updateButtonUI(CONFIG.AUTO_STEAL_ENABLED)
refreshLockBtnVisual()

local pbg = Instance.new("Frame", pbFrame)
pbg.Size = UDim2.new(1, -28, 0, 7)
pbg.Position = UDim2.new(0, 14, 1, -12)
pbg.BackgroundColor3 = Color3.fromRGB(6,6,8)
pbg.BorderSizePixel = 0
pbg.ZIndex = 2
Instance.new("UICorner", pbg).CornerRadius = UDim.new(0, 30)

local pbgStroke = Instance.new("UIStroke", pbg)
pbgStroke.Color = Color3.fromRGB(150,150,160)
pbgStroke.Thickness = 1
pbgStroke.Transparency = 0.45

local progressFill = Instance.new("Frame", pbg)
progressFill.Size = UDim2.new(0, 0, 1, 0)
progressFill.BackgroundColor3 = Color3.fromRGB(255, 40, 50)
progressFill.BorderSizePixel = 0
progressFill.ZIndex = 2
Instance.new("UICorner", progressFill).CornerRadius = UDim.new(0, 30)

local fillGrad = Instance.new("UIGradient", progressFill)
fillGrad.Color = ColorSequence.new(Color3.fromRGB(255,255,255), Color3.fromRGB(190,190,200))
fillGrad.Transparency = NumberSequence.new({
	NumberSequenceKeypoint.new(0, 0.55),
	NumberSequenceKeypoint.new(1, 0)
})

local progressLastFill = 0

local function updateStealBar(dt)
	local recent = StealState.lastResultTime > 0 and (tick() - StealState.lastResultTime) < 1.4
	local targetPct = 0
	local targetColor = Color3.fromRGB(255, 40, 50)
	local status = CONFIG.AUTO_STEAL_ENABLED and "READY" or "IDLE"

	if StealState.active then
		targetPct = math.clamp((tick() - StealState.startTime) / CONFIG.HOLD_MAX, 0, 1)
		if StealState.phase == "waitingRange" then
			status = "WAITING"
			targetColor = Color3.fromRGB(150,150,160)
		else
			status = "STEALING"
			targetColor = Color3.fromRGB(190,190,200)
		end
	elseif recent then
		local success = StealState.phase == "success" or string.find(StealState.lastResult, "Stole") ~= nil
		targetPct = 1
		status = success and "SUCCESS" or "FAILED"
		targetColor = success and Color3.fromRGB(230,230,235) or Color3.fromRGB(150,150,160)
	elseif CONFIG.AUTO_STEAL_ENABLED then
		local scan = math.sin(tick() * 2.2) * 0.5 + 0.5
		targetPct = scan * 0.75
		status = "SCAN"
		targetColor = Color3.fromRGB(255, 40, 50)
	end

	progressLastFill = progressLastFill + (targetPct - progressLastFill) * math.min((dt or 0.016) * 14, 1)
	progressFill.Size = UDim2.new(progressLastFill, 0, 1, 0)
	progressFill.BackgroundColor3 = progressFill.BackgroundColor3:Lerp(targetColor, math.min((dt or 0.016) * 8, 1))
	progressPct.Text = status
	progressPct.TextColor3 = targetColor
end

RunService.RenderStepped:Connect(updateStealBar)

task.spawn(function()
	if startAutoStealSync() then
		scanAllPlots()
		while task.wait(5) do
			scanAllPlots()
		end
	end
end)

CONFIG.AUTO_STEAL_ENABLED = true
startAutoSteal()
updateButtonUI(true)

print("âœ… Auto Steal ACTIVADO (Bless.vs style)")

RunService.Stepped:Connect(function()
    for _,p in ipairs(Players:GetPlayers()) do
        if p~=LP and p.Character then
            for _,part in ipairs(p.Character:GetChildren()) do
                if part:IsA("BasePart") and part.CanCollide then
                    part.CanCollide = false
                end
            end
        end
    end
end)

-- SECCIÃ“N 12: PERSISTENCIA (SAVE/LOAD) CON AUTO CARRY Y AUTO STEAL
saveConfig = function(btn)
    if State._configLoading or not State._configLoaded then
        State._saveAfterLoad = true
        return false
    end

    if State._configLoadFailed and not btn then
        return false
    end

    if State._saveInProgress then
        State._saveQueued = true
        return false
    end

    State._saveInProgress = true

    local function keySnapshot(entry)
        return {
            kb = entry and entry.kb and entry.kb.Name or nil,
            gp = entry and entry.gp and entry.gp.Name or nil,
        }
    end

    local function positionSnapshot(guiObject)
        if not guiObject then return nil end
        local ok, p = pcall(function() return guiObject.Position end)
        if not ok or not p then return nil end
        return {
            xs = p.X.Scale,
            xo = p.X.Offset,
            ys = p.Y.Scale,
            yo = p.Y.Offset,
        }
    end

    local savedStealRadius = Steal.StealRadius
    local savedAutoStealEnabled = Steal.AutoStealEnabled
    if CONFIG then
        if type(CONFIG.STEAL_RANGE) == "number" then
            savedStealRadius = CONFIG.STEAL_RANGE
        end
        if CONFIG.AUTO_STEAL_ENABLED ~= nil then
            savedAutoStealEnabled = CONFIG.AUTO_STEAL_ENABLED == true
        end
    end

    local cfg = {
        configVersion = 8,

        normalSpeed = NS,
        carrySpeed = CS,
        profileLaggerNormalSpeed = State.profileLaggerNormalSpeed,
        profileLaggerCarrySpeed = State.profileLaggerCarrySpeed,
        speedProfile = State.speedProfile,
        laggerSpeed = LS,
        laggerCarrySpeed = LS2,
        stealRadius = savedStealRadius,
        stealDuration = Steal.StealDuration,

        uiScale = uiScaleValue,
        backgroundAssetId = State.backgroundAssetId,
        animPack = (function()
            local ok, name = pcall(function()
                if _G.NIGHT_getCurrentAnimPack then return _G.NIGHT_getCurrentAnimPack() end
            end)
            if ok and type(name) == "string" and name ~= "" then return name end
            return nil
        end)(),
        musicPack = (function()
            local ok, name = pcall(function()
                if _G.NIGHT_musicGet then return _G.NIGHT_musicGet() end
            end)
            if ok and type(name) == "string" and name ~= "" then return name end
            return "Off"
        end)(),
        skinPack = (function()
            local ok, name = pcall(function()
                if _G.NIGHT_getSkin then return _G.NIGHT_getSkin() end
            end)
            if ok and type(name) == "string" and name ~= "" then return name end
            return "Off"
        end)(),
        accessoryPack = (function()
            local ok, name = pcall(function()
                if _G.NIGHT_getCurrentAccessoryPack then return _G.NIGHT_getCurrentAccessoryPack() end
            end)
            if ok and type(name) == "string" and name ~= "" then return name end
            return "Off"
        end)(),
        musicPCKey = keySnapshot(KB.MusicPC),
        tauntKey = keySnapshot(KB.Taunt),
        musicPadKey = keySnapshot(KB.MusicPad),
        buttonsSize = State.buttonsSizeValue,
        buttonsShape = State.buttonsShape,
        buttonImages = State.buttonImages or {},
        uiLocked = uiLocked,
        autoGrabLocked = State.autoGrabLocked == true,
        guiVisible = State.guiVisible,

        autoLeftKey = keySnapshot(KB.AutoLeft),
        autoRightKey = keySnapshot(KB.AutoRight),
        dropKey = keySnapshot(KB.Drop),
        tpDownKey = keySnapshot(KB.TPDown),
        autoBatKey = keySnapshot(KB.AutoBat),
        autoBatV2Key = keySnapshot(KB.AutoBatV2),
        instaResetKey = keySnapshot(KB.InstaReset),
        tpBatKey = keySnapshot(KB.TPBat),
        speedKey = keySnapshot(KB.Speed),
        laggerKey = keySnapshot(KB.Lagger),
        guiHideKey = keySnapshot(KB.GuiHide),

        infJump = State.infJumpEnabled,
        superJump = State.superJumpEnabled,
        antiRagdoll = State.antiRagdollEnabled,
        fpsBoost = State.fpsBoostEnabled,
        medusaCounter = State.medusaCounterEnabled,
        ninoTime = ninoTimeEnabled,
        batCounter = State.batCounterEnabled,
        autoStealEnabled = savedAutoStealEnabled,
        unwalkEnabled = State.unwalkEnabled,
        desyncEnabled = State.desyncEnabled,
        autoSwing = State.autoSwingEnabled,
        autoBatToggled = State.autoBatToggled,
        autoBatV2Toggled = State.autoBatV2Enabled,
        tpBatEnabled = State.tpBatEnabled,
        stretchRez = State.stretchRezEnabled,
        removeAccessories = State.removeAccessoriesEnabled,
        antiLag = State.antiLagEnabled,
        darkMode = State.darkModeEnabled,
        skyStyle = State.skyStyle,
        noIntro = State.noIntro == true,
        introEnabled = State.noIntro ~= true,
        selectedIntroMusic = State.selectedIntroMusic,
        autoTPDown = autoTPDownEnabled,
        autoTPDownHeight = autoTPDownHeight,

        speedToggled = State.speedToggled,
        laggerMode = State.laggerToggled,
        laggerPhase = laggerPhase,

        linieEnabled = State.linieEnabled,
        autoMedusaEnabled = MedusaConfig and MedusaConfig.Enabled or nil,
        medusaRadius = MedusaConfig and MedusaConfig.Radius or nil,
        medusaDelay = MedusaConfig and MedusaConfig.Delay or nil,
        nuevaAnimacion = State.nuevaAnimacionEnabled,
        instaReset = State.instaResetEnabled,
        instaResetVisible = btnInstaReset and btnInstaReset.Visible or nil,
        hideButtons = State.hideButtonsEnabled,

        autoCarryEnabled = State.autoCarryEnabled,

        batV1Speed = State.batV1Speed,
        batV2Speed = State.batV2Speed,

        panelPos = positionSnapshot(MobilePanel),
        mobileButtonPositions = (function()
            local positions = {}
            for name, mobileBtn in pairs(mobileButtonsByName) do
                positions[name] = positionSnapshot(mobileBtn)
            end
            return positions
        end)(),
        mainPos = positionSnapshot(main),
        miniPos = positionSnapshot(mini),
        pbPos = positionSnapshot(pbFrame),
        batV2Pos = positionSnapshot(btnBatV2),
        instaResetPos = positionSnapshot(btnInstaReset),
        autoStealBarPos = positionSnapshot(frame),
    }

    local encodeOk, encoded = pcall(function()
        return HttpService:JSONEncode(cfg)
    end)

    local saved = false
    if encodeOk and encoded then
        if not btn and encoded == State._lastConfigJson then
            State._configDirty = false
            State._saveInProgress = false
            State._saveQueued = false
            return true
        end

        local atomicOk, atomicResult, atomicErr = pcall(function()
            return State._atomicJsonSave(
                CONFIG_FILE,
                State._configBackupFile,
                State._configTempFile,
                encoded
            )
        end)

        saved = atomicOk and atomicResult == true
        if saved then
            State._lastConfigJson = encoded
            State._lastSaveError = nil
            State._configLoadFailed = false
            State._allowInitialConfigCreation = false

            if State.savePositionBackup then pcall(State.savePositionBackup) end

            State._configDirty = false
        else
            State._lastConfigJson = nil
            State._lastSaveError = tostring((atomicOk and atomicErr) or atomicResult or "No se pudo escribir la configuraciÃ³n")
            warn("[CT Duels AUTO SAVE] " .. State._lastSaveError)
        end
    else
        State._lastSaveError = "No se pudo convertir la configuraciÃ³n a JSON"
    end

    State._saveInProgress = false

    if btn and btn.Parent then
        local previousText = btn.Text
        btn.Text = saved and "Saved!" or "Failed!"
        task.delay(1.5, function()
            if btn and btn.Parent then btn.Text = previousText end
        end)
    end

    if State._saveQueued then
        State._saveQueued = false
        if State.requestConfigSave then State.requestConfigSave() end
    end

    return saved
end

loadConfig = function()
    local function readConfigFile(path)
        local decoded, raw = State._readValidJsonFile(path)
        if type(decoded) ~= "table" then return nil, raw end
        return decoded, raw
    end

    local mainCfg, mainRaw = readConfigFile(CONFIG_FILE)
    local tempCfg, tempRaw = readConfigFile(State._configTempFile)
    local backupCfg, backupRaw = readConfigFile(State._configBackupFile)
    local legacyCfg, legacyRaw = readConfigFile(State._legacyConfigFile)
    local legacyTempCfg, legacyTempRaw = readConfigFile(State._legacyConfigTempFile)
    local legacyBackupCfg, legacyBackupRaw = readConfigFile(State._legacyConfigBackupFile)

    local cfg, raw = nil, nil
    local loadedFromBackup = false
    local loadedFromLegacy = false
    local loadedFromTemp = false

    if type(tempCfg) == "table" and (type(mainCfg) ~= "table" or tempRaw ~= mainRaw) then
        cfg, raw = tempCfg, tempRaw
        loadedFromTemp = true
    elseif type(mainCfg) == "table" then
        cfg, raw = mainCfg, mainRaw
    elseif type(backupCfg) == "table" then
        cfg, raw = backupCfg, backupRaw
        loadedFromBackup = true
    elseif type(legacyTempCfg) == "table" and (type(legacyCfg) ~= "table" or legacyTempRaw ~= legacyRaw) then
        cfg, raw = legacyTempCfg, legacyTempRaw
        loadedFromLegacy = true
        loadedFromTemp = true
    elseif type(legacyCfg) == "table" then
        cfg, raw = legacyCfg, legacyRaw
        loadedFromLegacy = true
    elseif type(legacyBackupCfg) == "table" then
        cfg, raw = legacyBackupCfg, legacyBackupRaw
        loadedFromLegacy = true
        loadedFromBackup = true
    end

    local hadAnyConfigFile = false
    for _, path in ipairs({
        CONFIG_FILE,
        State._configTempFile,
        State._configBackupFile,
        State._legacyConfigFile,
        State._legacyConfigTempFile,
        State._legacyConfigBackupFile,
    }) do
        local exists = false
        pcall(function() exists = _isfile(path) end)
        if exists then hadAnyConfigFile = true break end
    end

    if not cfg then
        State._configLoaded = true
        State._configLoadFailed = hadAnyConfigFile
        State._allowInitialConfigCreation = not hadAnyConfigFile
        State._saveAfterLoad = false
        State._lastSaveError = hadAnyConfigFile and "Se encontraron configuraciones daÃ±adas; no se sobrescribieron" or nil
        if State.loadPositionBackup then pcall(State.loadPositionBackup) end
        return false
    end

    State._configLoading = true
    State._configLoadFailed = false
    State._allowInitialConfigCreation = false

    local applyOk = pcall(function()
        if type(cfg.normalSpeed) == "number" then
            NS = cfg.normalSpeed
            if normalBox then normalBox.Text = tostring(NS) end
        end
        if type(cfg.carrySpeed) == "number" then
            CS = cfg.carrySpeed
            if carryBox then carryBox.Text = tostring(CS) end
        end
        if type(cfg.profileLaggerNormalSpeed) == "number" then
            State.profileLaggerNormalSpeed = cfg.profileLaggerNormalSpeed
        end
        if type(cfg.profileLaggerCarrySpeed) == "number" then
            State.profileLaggerCarrySpeed = cfg.profileLaggerCarrySpeed
        end
        if type(cfg.laggerSpeed) == "number" then
            LS = cfg.laggerSpeed
            if laggerBox then laggerBox.Text = tostring(LS) end
        end
        if type(cfg.laggerCarrySpeed) == "number" then
            LS2 = cfg.laggerCarrySpeed
            if laggerBox2 then laggerBox2.Text = tostring(LS2) end
        end

        if type(cfg.uiScale) == "number" then
            uiScaleValue = math.clamp(math.floor(cfg.uiScale + 0.5), 50, 150)
            if mainUIScale then mainUIScale.Scale = uiScaleValue / 100 end
            if uiScaleBox then uiScaleBox.Text = tostring(uiScaleValue) end
        end

        if cfg.backgroundAssetId and State.applyBackgroundImage then
            State.applyBackgroundImage(cfg.backgroundAssetId, false)
        elseif State.applyBackgroundImage then
            State.applyBackgroundImage(State.backgroundAssetId, false)
        end

        if type(cfg.animPack) == "string" and cfg.animPack ~= "" and cfg.animPack ~= "Off" and cfg.animPack ~= "Normal" and cfg.animPack ~= "Default" then
            pcall(function()
                if _G.NIGHT_setCurrentAnimPack then _G.NIGHT_setCurrentAnimPack(cfg.animPack) end
                if _G.NIGHT_applyAnimationPack then _G.NIGHT_applyAnimationPack(cfg.animPack) end
            end)
            if State._animPackSelectorVisual then
                pcall(function() State._animPackSelectorVisual(cfg.animPack, false) end)
            end
        elseif cfg.animPack == "Off" or cfg.animPack == "Normal" or cfg.animPack == "Default" or cfg.animPack == nil then
            pcall(function()
                if _G.NIGHT_applyAnimationPack then _G.NIGHT_applyAnimationPack("Normal") end
                if _G.NIGHT_setCurrentAnimPack then _G.NIGHT_setCurrentAnimPack(nil) end
            end)
            if State._animPackSelectorVisual then
                pcall(function() State._animPackSelectorVisual("Normal", false) end)
            end
        end

        if type(cfg.musicPack) == "string" and cfg.musicPack ~= "" then
            pcall(function()
                if _G.NIGHT_musicPlay then _G.NIGHT_musicPlay(cfg.musicPack) end
            end)
            if State._musicPackSelectorVisual then
                pcall(function() State._musicPackSelectorVisual(cfg.musicPack, false) end)
            end
        end

        if type(cfg.skinPack) == "string" and cfg.skinPack ~= "" then
            local skinName = cfg.skinPack
            pcall(function()
                if _G.NIGHT_applySkin then _G.NIGHT_applySkin(skinName) end
            end)
            if State._skinPackSelectorVisual then
                pcall(function() State._skinPackSelectorVisual(skinName, false) end)
            end
            -- Reaplicar tras un momento por si el personaje aÃºn no estÃ¡ listo
            task.delay(0.6, function()
                pcall(function()
                    if _G.NIGHT_applySkin then _G.NIGHT_applySkin(skinName) end
                end)
            end)
            task.delay(1.5, function()
                pcall(function()
                    if _G.NIGHT_applySkin then _G.NIGHT_applySkin(skinName) end
                end)
            end)
        end

        if type(cfg.accessoryPack) == "string" and cfg.accessoryPack ~= "" then
            local accName = cfg.accessoryPack
            pcall(function()
                if _G.NIGHT_setCurrentAccessoryPack then _G.NIGHT_setCurrentAccessoryPack(accName) end
                if _G.NIGHT_applyAccessoryPack then _G.NIGHT_applyAccessoryPack(accName) end
            end)
            if State._accessoryPackSelectorVisual then
                pcall(function() State._accessoryPackSelectorVisual(accName, false) end)
            end
            task.delay(0.8, function()
                pcall(function()
                    if _G.NIGHT_applyAccessoryPack then _G.NIGHT_applyAccessoryPack(accName) end
                end)
            end)
            task.delay(1.6, function()
                pcall(function()
                    if _G.NIGHT_applyAccessoryPack then _G.NIGHT_applyAccessoryPack(accName) end
                end)
            end)
        end

        if type(cfg.buttonsSize) == "number" then
            State.buttonsSizeValue = math.clamp(math.floor(cfg.buttonsSize + 0.5), 0, 100)
        end
        if cfg.buttonsShape ~= nil then
            State.buttonsShape = normalizeMobileButtonsShape(cfg.buttonsShape)
        end
        applyMobileButtonsSize(State.buttonsSizeValue)
        if buttonsSizeBox then buttonsSizeBox.Text = tostring(State.buttonsSizeValue) end
        if State._buttonsShapeSelectorVisual then
            State._buttonsShapeSelectorVisual(State.buttonsShape, false)
        end

        -- Cargar imÃ¡genes de botones (mismos assets del script)
        if type(cfg.buttonImages) == "table" then
            State.buttonImages = cfg.buttonImages
            task.defer(function()
                pcall(applyAllButtonImages)
            end)
        end

        if cfg.uiLocked ~= nil then
            uiLocked = cfg.uiLocked == true
            if setLockUIVisual then setLockUIVisual(uiLocked) end
        end

        if cfg.autoGrabLocked ~= nil then
            pcall(function()
                setAutoGrabLocked(cfg.autoGrabLocked == true, true)
            end)
        end

        if cfg.guiVisible ~= nil then
            State.guiVisible = cfg.guiVisible == true
            if main then main.Visible = State.guiVisible end
            if mini then mini.Visible = not State.guiVisible end
        end

        if cfg.selectedIntroMusic ~= nil then
            State.selectedIntroMusic = cfg.selectedIntroMusic
            if getgenv and getgenv().FEARV2MusicBtn then
                getgenv().FEARV2MusicBtn.Text = "Music " .. tostring(State.selectedIntroMusic)
            end
        end
        if cfg.noIntro ~= nil then
            State.noIntro = cfg.noIntro == true
        elseif cfg.introEnabled ~= nil then
            State.noIntro = cfg.introEnabled ~= true
        end
        State.introEnabled = not State.noIntro
        if setNoIntroToggle then setNoIntroToggle(State.noIntro, false) end
        if setIntroToggle then setIntroToggle(State.introEnabled, false) end

        if type(cfg.autoTPDownHeight) == "number" then
            autoTPDownHeight = math.clamp(cfg.autoTPDownHeight, 0, 500)
        end
        if cfg.autoTPDown ~= nil then
            autoTPDownEnabled = cfg.autoTPDown == true
            if setAutoTPDownVisual then setAutoTPDownVisual(autoTPDownEnabled) end
            if autoTPDownEnabled then startAutoTPDown() else stopAutoTPDown() end
        end

        local savedRadius = cfg.stealRadius or cfg.grabRadius
        if savedRadius == 61 or savedRadius == 63 then
            savedRadius = 10
        end
        if type(savedRadius) == "number" then
            -- Cap the saved value so an older config cannot restore a larger Auto Grab range.
            savedRadius = math.min(savedRadius, 8)
            Steal.StealRadius = savedRadius
            if progressRadLbl then progressRadLbl.Text = "Radius: " .. tostring(savedRadius) end
            if radValBtn then radValBtn.Text = tostring(savedRadius) end
            if radBox then radBox.Text = tostring(savedRadius) end
            if CONFIG then CONFIG.STEAL_RANGE = savedRadius end
        end
        if type(cfg.stealDuration) == "number" then
            Steal.StealDuration = cfg.stealDuration
            if durValBtn then durValBtn.Text = tostring(Steal.StealDuration) end
        end

        if MedusaConfig then
            if type(cfg.medusaRadius) == "number" then
                MedusaConfig.Radius = cfg.medusaRadius
                if MedusaConfig.RadiusPart then
                    MedusaConfig.RadiusPart.Size = Vector3.new(0.2, MedusaConfig.Radius * 2, MedusaConfig.Radius * 2)
                end
            end
            if type(cfg.medusaDelay) == "number" then
                MedusaConfig.Delay = cfg.medusaDelay
            end
        end

        local function loadKey(entry, data)
            if not entry or type(data) ~= "table" then return end
            entry.kb = nil
            entry.gp = nil
            if data.kb and Enum.KeyCode[data.kb] then entry.kb = Enum.KeyCode[data.kb] end
            if data.gp and Enum.KeyCode[data.gp] then entry.gp = Enum.KeyCode[data.gp] end

            if State._bindButtons and State._bindButtons[entry] then
                State._bindButtons[entry].Text =
                    entry.gp and ("GP:" .. entry.gp.Name)
                    or (entry.kb and entry.kb.Name or "None")
            end
        end

        loadKey(KB.AutoLeft, cfg.autoLeftKey)
        loadKey(KB.AutoRight, cfg.autoRightKey)
        loadKey(KB.Drop, cfg.dropKey)
        loadKey(KB.TPDown, cfg.tpDownKey)
        loadKey(KB.AutoBat, cfg.autoBatKey)
        loadKey(KB.AutoBatV2, cfg.autoBatV2Key)
        loadKey(KB.InstaReset, cfg.instaResetKey)
        loadKey(KB.TPBat, cfg.tpBatKey)
        loadKey(KB.Speed, cfg.speedKey)
        loadKey(KB.Lagger, cfg.laggerKey)
        loadKey(KB.GuiHide, cfg.guiHideKey)
        loadKey(KB.MusicPC, cfg.musicPCKey)
        loadKey(KB.MusicPad, cfg.musicPadKey)
        loadKey(KB.Taunt, cfg.tauntKey)

        if cfg.infJump ~= nil then
            State.infJumpEnabled = cfg.infJump == true
            if setInfJump then setInfJump(State.infJumpEnabled) end
        end
        if cfg.superJump ~= nil then
            State.superJumpEnabled = cfg.superJump == true
            if setSuperJump then setSuperJump(State.superJumpEnabled) end
        end
        if cfg.antiRagdoll ~= nil then
            State.antiRagdollEnabled = cfg.antiRagdoll == true
            if setAntiRag then setAntiRag(State.antiRagdollEnabled) end
            if State.antiRagdollEnabled then startAntiRagdoll() else stopAntiRagdoll() end
        end
        if cfg.fpsBoost ~= nil then
            State.fpsBoostEnabled = cfg.fpsBoost == true
            if setFps then setFps(State.fpsBoostEnabled) end
            if State.fpsBoostEnabled then pcall(applyFPSBoost) end
        end
        if cfg.medusaCounter ~= nil then
            State.medusaCounterEnabled = cfg.medusaCounter == true
            if setMedusaCounter then setMedusaCounter(State.medusaCounterEnabled) end
            if State.medusaCounterEnabled then setupMedusaCounter(LP.Character) else stopMedusaCounter() end
            if cfg.medusaReset ~= nil then
                State.autoResetEnabled = cfg.medusaReset == true
                pcall(function() if _G.NIGHT_setMedusaReset then _G.NIGHT_setMedusaReset(State.autoResetEnabled) end end)
            end
        end
        if cfg.ninoTime ~= nil then setNinoTime(cfg.ninoTime == true) end
        if cfg.batCounter ~= nil then
            State.batCounterEnabled = cfg.batCounter == true
            if setBatCounter then setBatCounter(State.batCounterEnabled) end
            if State.batCounterEnabled then startBatCounter() else stopBatCounter() end
        end
        if cfg.autoStealEnabled ~= nil then
            local autoStealOn = cfg.autoStealEnabled == true
            Steal.AutoStealEnabled = autoStealOn
            if CONFIG then CONFIG.AUTO_STEAL_ENABLED = autoStealOn end
            if setAutoGrab then setAutoGrab(autoStealOn) end

            if progressPct then progressPct.Text = autoStealOn and "READY" or "IDLE" end
            if toggleBtn then
                if autoStealOn then
                    toggleBtn.Text = "STOP"
                    toggleBtn.BackgroundColor3 = Color3.fromRGB(255, 40, 50)
                    toggleBtn.TextColor3 = Color3.fromRGB(255,255,255)
                    btnStroke.Color = Color3.fromRGB(190,190,200)
                    btnGrad.Color = ColorSequence.new(Color3.fromRGB(255, 40, 50), Color3.fromRGB(150,150,160))
                else
                    toggleBtn.Text = "START"
                    toggleBtn.BackgroundColor3 = Color3.fromRGB(12,12,14)
                    toggleBtn.TextColor3 = Color3.fromRGB(180,180,180)
                    btnStroke.Color = Color3.fromRGB(40,40,48)
                    btnGrad.Color = ColorSequence.new(Color3.fromRGB(16,16,18), Color3.fromRGB(14,14,16))
                end
            end

            if autoStealOn then pcall(startAutoSteal) else pcall(stopAutoSteal) end
        end
        if cfg.autoSwing ~= nil then
            State.autoSwingEnabled = cfg.autoSwing == true
            if setAutoSwingVisual then setAutoSwingVisual(State.autoSwingEnabled) end
        end
        if cfg.unwalkEnabled ~= nil then
            State.unwalkEnabled = cfg.unwalkEnabled == true
            if setUnwalkToggle then setUnwalkToggle(State.unwalkEnabled) end
            if State.unwalkEnabled then startUnwalk() else stopUnwalk() end
        end

        if cfg.stretchRez ~= nil and setStretchRez then
            State.stretchRezEnabled = cfg.stretchRez == true
            setStretchRez(State.stretchRezEnabled)
        end
        if cfg.removeAccessories ~= nil and setRemoveAccessories then
            State.removeAccessoriesEnabled = cfg.removeAccessories == true
            setRemoveAccessories(State.removeAccessoriesEnabled)
        end
        if cfg.antiLag ~= nil and setAntiLag then
            State.antiLagEnabled = cfg.antiLag == true
            setAntiLag(State.antiLagEnabled)
        end

        if cfg.skyStyle ~= nil and setSkyStyle then
            setSkyStyle(cfg.skyStyle)
        elseif cfg.darkMode ~= nil and setDarkMode then
            setDarkMode(cfg.darkMode == true)
        end

        if cfg.desyncEnabled ~= nil then
            State.desyncEnabled = cfg.desyncEnabled == true
            task.defer(function()
                if setDesync then setDesync(State.desyncEnabled) end
                if saDesync then saDesync(State.desyncEnabled) end
                if State.desyncEnabled and startDesyncSession then startDesyncSession() end
            end)
        end

        if cfg.linieEnabled ~= nil then
            State.linieEnabled = cfg.linieEnabled == true
            if setLinieVisual then setLinieVisual(State.linieEnabled) end
        end
        if cfg.autoMedusaEnabled ~= nil then
            if MedusaConfig then MedusaConfig.Enabled = cfg.autoMedusaEnabled == true end
            if setAutoMedusaVisual then setAutoMedusaVisual(cfg.autoMedusaEnabled == true) end
        end

        if cfg.nuevaAnimacion ~= nil then
            State.nuevaAnimacionEnabled = cfg.nuevaAnimacion == true
            if setNuevaAnimacionVisual then setNuevaAnimacionVisual(State.nuevaAnimacionEnabled) end
            if State.nuevaAnimacionEnabled then
                task.defer(startNuevaAnimacion)
            else
                task.defer(stopNuevaAnimacion)
            end
        end

        local savedInstaReset = cfg.instaReset
        if savedInstaReset == nil then savedInstaReset = cfg.instaResetEnabled end
        if savedInstaReset ~= nil then
            State.instaResetEnabled = savedInstaReset == true
            if setInstaToggleVisual then setInstaToggleVisual(State.instaResetEnabled) end
        end

        if cfg.hideButtons ~= nil then
            State.hideButtonsEnabled = cfg.hideButtons == true
            if setHideButtonsVisual then setHideButtonsVisual(State.hideButtonsEnabled) end

            local visible = not State.hideButtonsEnabled
            if MobilePanel then MobilePanel.Visible = visible end
            for _, mobileBtn in pairs(mobileButtonsByName) do
                if mobileBtn then mobileBtn.Visible = visible end
            end
            if btnBatV2 then btnBatV2.Visible = visible end
            if btnInstaReset then
                btnInstaReset.Visible = visible and (cfg.instaResetVisible ~= false)
            end
        elseif cfg.instaResetVisible ~= nil and btnInstaReset then
            btnInstaReset.Visible = cfg.instaResetVisible == true
        end

        State.speedProfile = cfg.speedProfile == "Lagger" and "Lagger" or "Normal"
        if State._refreshSpeedProfileVisual then State._refreshSpeedProfileVisual() end
        if normalBox then
            normalBox.Text = tostring(State.speedProfile == "Lagger" and State.profileLaggerNormalSpeed or NS)
        end
        if carryBox then
            carryBox.Text = tostring(State.speedProfile == "Lagger" and State.profileLaggerCarrySpeed or CS)
        end

        State.speedToggled = cfg.speedToggled == true
        State.laggerToggled = cfg.laggerMode == true
        laggerPhase = tonumber(cfg.laggerPhase) or (State.laggerToggled and 1 or 0)
        laggerPhase = math.clamp(math.floor(laggerPhase), 0, 2)

        if State.laggerToggled then
            State.speedToggled = false
        elseif laggerPhase ~= 0 then
            laggerPhase = 0
        end

        if mobileSpeedSetActive then mobileSpeedSetActive(State.speedToggled) end
        if mobileLaggerSetActive then mobileLaggerSetActive(State.laggerToggled) end
        if modeValLbl then
            modeValLbl.Text =
                laggerPhase == 2 and "Lagger Carry"
                or (State.laggerToggled and "Lagger")
                or (State.speedToggled and (State.speedProfile == "Lagger" and ("Carry Â· " .. tostring(State.profileLaggerCarrySpeed)) or "Carry"))
                or (State.speedProfile == "Lagger" and ("Lagger Â· " .. tostring(State.profileLaggerNormalSpeed)) or "Normal")
        end

        State._setTPBatEnabled(cfg.tpBatEnabled == true)
        if State._tpBatSetVisual then State._tpBatSetVisual(State.tpBatEnabled) end
        if State._tpBatConfigSetVisual then State._tpBatConfigSetVisual(State.tpBatEnabled) end

        local autoBatV1 = cfg.autoBatToggled == true
        local autoBatV2 = cfg.autoBatV2Toggled == true
        if autoBatV1 then autoBatV2 = false end

        State.autoBatToggled = autoBatV1
        State.autoBatV2Enabled = autoBatV2

        if autoBatSetVisual then autoBatSetVisual(State.autoBatToggled) end
        if autoBatV2SetVisual then autoBatV2SetVisual(State.autoBatV2Enabled) end
        if State.autoBatToggled then
            task.defer(startBatAimbot)
        elseif State.autoBatV2Enabled then
            task.defer(startBatAimbotV2)
        else
            pcall(stopBatAimbot)
            if stopBatAimbotV2 then pcall(stopBatAimbotV2) end
        end

        if type(cfg.batV1Speed) == "number" then
            State.batV1Speed = cfg.batV1Speed
            if batV1SpeedBox then batV1SpeedBox.Text = tostring(State.batV1Speed) end
        end
        if type(cfg.batV2Speed) == "number" then
            State.batV2Speed = cfg.batV2Speed
            if batV2SpeedBox then batV2SpeedBox.Text = tostring(State.batV2Speed) end
        end

        if cfg.autoCarryEnabled ~= nil then
            State.autoCarryEnabled = cfg.autoCarryEnabled == true
            if State.autoCarrySetVisual then
                State.autoCarrySetVisual(State.autoCarryEnabled)
            end
        end

        local function restorePosition(guiObject, data)
            if guiObject and type(data) == "table" and data.xs ~= nil then
                guiObject.Position = UDim2.new(
                    data.xs,
                    data.xo or 0,
                    data.ys or 0,
                    data.yo or 0
                )
            end
        end

        local function restoreSavedPositions()
            restorePosition(main, cfg.mainPos)
            restorePosition(mini, cfg.miniPos)
            restorePosition(MobilePanel, cfg.panelPos)

            if type(cfg.mobileButtonPositions) == "table" then
                for name, positionData in pairs(cfg.mobileButtonPositions) do
                    restorePosition(mobileButtonsByName[name], positionData)
                end
            end

            restorePosition(pbFrame, cfg.pbPos)
            restorePosition(btnBatV2, cfg.batV2Pos)
            restorePosition(btnInstaReset, cfg.instaResetPos)
            restorePosition(frame, cfg.autoStealBarPos)
        end

        restoreSavedPositions()
        task.delay(0.7, restoreSavedPositions)
        task.delay(1.35, function()
            restoreSavedPositions()
            task.defer(function()
                if State.loadPositionBackup and not State._positionDirty then
                    pcall(State.loadPositionBackup)
                end
            end)
        end)
    end)

    State._configLoading = false
    State._configLoaded = true
    State._configLoadFailed = not applyOk

    if applyOk then
        State._lastConfigJson = raw
        State._lastSaveError = nil
        State._configDirty = false
    else
        State._lastSaveError = "La configuraciÃ³n se leyÃ³, pero no se pudo aplicar; no serÃ¡ sobrescrita"
    end

    local pendingSave = State._saveAfterLoad
    State._saveAfterLoad = false

    if applyOk and (loadedFromBackup or loadedFromLegacy or loadedFromTemp or pendingSave) then
        if loadedFromBackup or loadedFromLegacy or loadedFromTemp then State._lastConfigJson = nil end
        State.requestConfigSave()
    end

    return applyOk
end

State._otherSpeedLabels = State._otherSpeedLabels or {}
State._otherSpeedConnections = State._otherSpeedConnections or {}

State._attachOtherSpeedBillboard = function(player, character)
    if not player or player == LP or not character then return end

    task.spawn(function()
        local head = character:WaitForChild("Head", 8)
        local root = character:WaitForChild("HumanoidRootPart", 8)
        local humanoid = character:FindFirstChildOfClass("Humanoid") or character:WaitForChild("Humanoid", 8)
        if not head or not root or not humanoid then return end

        local old = head:FindFirstChild("CRYONOtherSpeedBB")
        if old then old:Destroy() end

        local bb = Instance.new("BillboardGui")
        bb.Name = "CRYONOtherSpeedBB"
        bb.Adornee = head
        bb.Parent = head
        bb.Size = UDim2.new(0, 180, 0, 36)
        bb.StudsOffset = Vector3.new(0, 3, 0)
        bb.AlwaysOnTop = true
        bb.LightInfluence = 0
        bb.MaxDistance = 1000

        local label = Instance.new("TextLabel")
        label.Name = "OtherSpeedBillLbl"
        label.Parent = bb
        label.Size = UDim2.new(1, 0, 1, 0)
        label.BackgroundTransparency = 1
        label.Text = "0.0"
        label.TextColor3 = Color3.fromRGB(255, 40, 50)
        label.Font = Enum.Font.GothamBlack
        label.TextScaled = true
        label.TextStrokeTransparency = 0
        label.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)

        State._otherSpeedLabels[player] = {
            label = label,
            root = root,
            humanoid = humanoid,
        }
    end)
end

State._setupOtherPlayerBillboard = function(player)
    if not player or player == LP then return end

    local previousConnection = State._otherSpeedConnections[player]
    if previousConnection then
        pcall(function() previousConnection:Disconnect() end)
    end

    State._otherSpeedConnections[player] = player.CharacterAdded:Connect(function(character)
        State._attachOtherSpeedBillboard(player, character)
    end)

    if player.Character then
        State._attachOtherSpeedBillboard(player, player.Character)
    end
end

task.spawn(function()
    for _, otherPlayer in ipairs(Players:GetPlayers()) do
        State._setupOtherPlayerBillboard(otherPlayer)
    end
end)

Players.PlayerAdded:Connect(function(player)
    State._setupOtherPlayerBillboard(player)
end)

Players.PlayerRemoving:Connect(function(player)
    local connection = State._otherSpeedConnections[player]
    if connection then pcall(function() connection:Disconnect() end) end
    State._otherSpeedConnections[player] = nil
    State._otherSpeedLabels[player] = nil
end)

task.spawn(function()
    while gui and gui.Parent do
        for player, data in pairs(State._otherSpeedLabels) do
            local label = data and data.label
            local root = data and data.root
            local humanoid = data and data.humanoid

            if player.Parent and label and label.Parent and root and root.Parent and humanoid and humanoid.Health > 0 then
                local velocity = root.AssemblyLinearVelocity
                local horizontalSpeed = Vector3.new(velocity.X, 0, velocity.Z).Magnitude
                label.Text = string.format("%.1f", horizontalSpeed)
                label.Visible = true
            elseif label and label.Parent then
                label.Visible = false
            end
        end
        task.wait(0.08)
    end
end)

local h,hrp,speedLbl
local function setupChar(char)
    task.wait(0.1)
    h=char:WaitForChild("Humanoid",5)
    hrp=char:WaitForChild("HumanoidRootPart",5)
    if not h or not hrp then return end

    restartMovement()

    local head=char:FindFirstChild("Head")
    if head then
        local oldBB=head:FindFirstChild("FEARV2MobileBB"); if oldBB then oldBB:Destroy() end
        local bb=Instance.new("BillboardGui",head); bb.Name="FEARV2MobileBB"
        bb.Size=UDim2.new(0,160,0,24); bb.StudsOffset=Vector3.new(0,3,0); bb.AlwaysOnTop=true
        speedLbl=Instance.new("TextLabel",bb); speedLbl.Name="SpeedBillLbl"
        speedLbl.Size=UDim2.new(0,160,0,24); speedLbl.Position=UDim2.new(0,0,0,0); speedLbl.BackgroundTransparency=1
        speedLbl.Text="0.0"; speedLbl.TextColor3=Color3.fromRGB(255, 40, 50)
        speedLbl.Font=Enum.Font.GothamBlack; speedLbl.TextScaled=true
        speedLbl.TextStrokeTransparency=0; speedLbl.TextStrokeColor3=Color3.fromRGB(0, 0, 0)
    end


    if State.unwalkEnabled then task.wait(0.3); startUnwalk() end
    stopAntiRagdoll()
    if State.antiRagdollEnabled then task.wait(0.5); startAntiRagdoll() end

    if State.medusaCounterEnabled then setupMedusaCounter(char) end

    if State.autoBatToggled then stopBatAimbot(); task.wait(0.2); pcall(startBatAimbot) end
    if State.batCounterEnabled then task.wait(0.3); startBatCounter() end
    if Steal.AutoStealEnabled then pcall(stopAutoSteal); task.wait(0.5); pcall(startAutoSteal) end
end

LP.CharacterAdded:Connect(setupChar)
if LP.Character then task.spawn(function() setupChar(LP.Character) end) end

RunService.Stepped:Connect(function()
    for _,p in ipairs(Players:GetPlayers()) do
        if p~=LP and p.Character then
            for _,part in ipairs(p.Character:GetChildren()) do
                if part:IsA("BasePart") and part.CanCollide then
                    part.CanCollide = false
                end
            end
        end
    end
end)

UIS.JumpRequest:Connect(function()
    if not State.infJumpEnabled then return end
    local c=LP.Character; if not c then return end; local root=c:FindFirstChild("HumanoidRootPart")
    if root then root.Velocity=Vector3.new(root.Velocity.X,55,root.Velocity.Z) end
end)

-- ============================================================================
--  MOVIMIENTO AL ESTILO YSLEM + NEW ERA (ENCAPSULADO Y REINICIO AUTOMÃTICO)
--  Carry Speed: mÃ©todo de message (3) â€“ spoof AssemblyLinearVelocity + PreSimulation
-- ============================================================================
local moveConn = nil
local speedEnabled = true

-- â”€â”€ Variables para el sistema Yslem (Normal / Lagger) â”€â”€â”€â”€
local yslemActive = false
local batV2Active = false
local _lv = nil
local _lv_att = nil
local _ownerWatchConn = nil
local ownTimer = 0
local ownInterval = 0.8 + math.random() * 0.4

-- â”€â”€ Carry Speed (message 3 style) â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
local spoofedVelocity = Vector3.zero
local carryVelocityConn = nil

-- Hooks de spoof (solo una vez; executor: hookmetamethod / newcclosure / checkcaller)
pcall(function()
    if not (hookmetamethod and newcclosure and checkcaller) then return end
    local oldIndex
    oldIndex = hookmetamethod(game, "__index", newcclosure(function(self, key)
        if not checkcaller() and (key == "AssemblyLinearVelocity" or key == "Velocity") then
            if typeof(self) == "Instance" and self:IsA("BasePart") and self.Name == "HumanoidRootPart" and self:IsDescendantOf(LP.Character) then
                return spoofedVelocity
            end
        end
        return oldIndex(self, key)
    end))

    local oldNewIndex
    oldNewIndex = hookmetamethod(game, "__newindex", newcclosure(function(self, key, value)
        if not checkcaller() and (key == "AssemblyLinearVelocity" or key == "Velocity") then
            if typeof(self) == "Instance" and self:IsA("BasePart") and self.Name == "HumanoidRootPart" and self:IsDescendantOf(LP.Character) then
                spoofedVelocity = value
                return
            end
        end
        return oldNewIndex(self, key, value)
    end))
end)

local function applyCarryVelocitySpeed(speed)
    if not State.speedToggled or State.laggerToggled then return end
    if State.autoBatToggled or State.autoLeftEnabled or State.autoRightEnabled or batV2Active then return end
    if State._tpInProgress then return end

    local char = LP.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    local root = char and char:FindFirstChild("HumanoidRootPart")
    if not char or not hum or not root or hum.Health <= 0 then return end

    local dir = hum.MoveDirection
    if dir.Magnitude > 0.05 then
        pcall(function()
            if root.SetNetworkOwner then root:SetNetworkOwner(LP) end
        end)
        local unit = dir.Unit
        spoofedVelocity = Vector3.new(unit.X * 16, root.AssemblyLinearVelocity.Y, unit.Z * 16)
        root.AssemblyLinearVelocity = Vector3.new(unit.X * speed, root.AssemblyLinearVelocity.Y, unit.Z * speed)
        State.lastMoveDir = unit
    else
        if State.antiRagdollEnabled and State.lastMoveDir and State.lastMoveDir.Magnitude > 0 then
            local anyHeld = false
            for key in pairs(MOVE_KEYS) do
                if UIS:IsKeyDown(key) then anyHeld = true; break end
            end
            if anyHeld then
                local unit = State.lastMoveDir
                spoofedVelocity = Vector3.new(unit.X * 16, root.AssemblyLinearVelocity.Y, unit.Z * 16)
                root.AssemblyLinearVelocity = Vector3.new(unit.X * speed, root.AssemblyLinearVelocity.Y, unit.Z * speed)
                return
            end
        end
        spoofedVelocity = Vector3.new(0, root.AssemblyLinearVelocity.Y, 0)
    end
end

local function startCarryVelocity()
    if carryVelocityConn then return end
    carryVelocityConn = RunService.PreSimulation:Connect(function()
        local spd = getProfileCarrySpeed()
        applyCarryVelocitySpeed(spd)
    end)
end

local function stopCarryVelocity()
    if carryVelocityConn then
        pcall(function() carryVelocityConn:Disconnect() end)
        carryVelocityConn = nil
    end
end

local function cleanLV()
    if _lv then pcall(function() _lv:Destroy() end); _lv = nil end
    if _lv_att then pcall(function() _lv_att:Destroy() end); _lv_att = nil end
end

local function setupLV(hrp)
    cleanLV()
    local att = Instance.new("Attachment", hrp)
    att.Name = "_YS_A"
    local lv = Instance.new("LinearVelocity", hrp)
    lv.Name = "_YS_LV"
    lv.Attachment0 = att
    lv.VelocityConstraintMode = Enum.VelocityConstraintMode.Plane
    lv.PrimaryTangentAxis = Vector3.new(1, 0, 0)
    lv.SecondaryTangentAxis = Vector3.new(0, 0, 1)
    lv.MaxForce = math.huge
    lv.PlaneVelocity = Vector2.zero
    lv.RelativeTo = Enum.ActuatorRelativeTo.World
    _lv_att = att
    _lv = lv
end

local function claimOwn(hrp)
    pcall(function() hrp:SetNetworkOwner(LP) end)
end

local function startOwnerWatch(hrp)
    if _ownerWatchConn then pcall(function() _ownerWatchConn:Disconnect() end) end
    _ownerWatchConn = hrp:GetPropertyChangedSignal("ReceiveAge"):Connect(function()
        if yslemActive then task.defer(function() claimOwn(hrp) end) end
    end)
end

-- Yslem (LinearVelocity) solo para Normal / Lagger; Carry usa el mÃ©todo de message (3)
local function updateYslemState()
    local usingCarryMethod = State.speedToggled and not State.laggerToggled
    local shouldBeActive = speedEnabled
        and not usingCarryMethod
        and not State.autoBatToggled
        and not State.autoLeftEnabled
        and not State.autoRightEnabled
        and not batV2Active

    if shouldBeActive == yslemActive then return end

    yslemActive = shouldBeActive
    if yslemActive then
        if hrp then
            setupLV(hrp)
            claimOwn(hrp)
            startOwnerWatch(hrp)
        end
    else
        cleanLV()
        if _ownerWatchConn then pcall(function() _ownerWatchConn:Disconnect() end); _ownerWatchConn = nil end
    end
end

local function startMovement()
    if moveConn then moveConn:Disconnect(); moveConn = nil end
    moveConn = RunService.RenderStepped:Connect(function()
        if not (h and hrp) then return end
        if State._tpInProgress then return end

        updateYslemState()

        -- Asegurar PreSimulation de Carry activo cuando toca
        if State.speedToggled and not State.laggerToggled then
            startCarryVelocity()
        else
            stopCarryVelocity()
        end

        pcall(function()
            if speedLbl then
                local hspd = Vector3.new(hrp.Velocity.X, 0, hrp.Velocity.Z).Magnitude
                speedLbl.Text = string.format("%.1f", hspd)
            end
        end)
    end)
end

local heartbeatConn = nil
local function startYslemHeartbeat()
    if heartbeatConn then return end
    heartbeatConn = RunService.Heartbeat:Connect(function(dt)
        -- Si Carry estÃ¡ activo (mÃ©todo message 3), no aplicar LinearVelocity
        if State.speedToggled and not State.laggerToggled then
            if _lv then _lv.PlaneVelocity = Vector2.zero end
            return
        end

        if not yslemActive then
            if _lv then _lv.PlaneVelocity = Vector2.zero end
            return
        end

        if not (h and hrp) then return end

        ownTimer = ownTimer + dt
        if ownTimer >= ownInterval then
            claimOwn(hrp)
            ownTimer = 0
            ownInterval = 0.8 + math.random() * 0.4
        end

        if not _lv or _lv.Parent ~= hrp then setupLV(hrp) end

        local md = h.MoveDirection
        local spd = State.laggerToggled
            and (laggerPhase == 2 and LS2 or LS)
            or getProfileNormalSpeed()

        if spd == 0 then
            _lv.PlaneVelocity = Vector2.zero
        elseif md.Magnitude > 0 then
            local dir = md.Unit
            State.lastMoveDir = dir
            _lv.PlaneVelocity = Vector2.new(dir.X * spd, dir.Z * spd)
        elseif State.antiRagdollEnabled and State.lastMoveDir.Magnitude > 0 then
            local anyHeld = false
            for key in pairs(MOVE_KEYS) do
                if UIS:IsKeyDown(key) then anyHeld = true; break end
            end
            if anyHeld then
                local dir = State.lastMoveDir
                _lv.PlaneVelocity = Vector2.new(dir.X * spd, dir.Z * spd)
            else
                _lv.PlaneVelocity = Vector2.zero
            end
        else
            _lv.PlaneVelocity = Vector2.zero
        end
    end)
end

local function stopMovement()
    if moveConn then moveConn:Disconnect(); moveConn = nil end
    if heartbeatConn then heartbeatConn:Disconnect(); heartbeatConn = nil end
    stopCarryVelocity()
    cleanLV()
    if _ownerWatchConn then pcall(function() _ownerWatchConn:Disconnect() end); _ownerWatchConn = nil end
    yslemActive = false
end

local function restartMovement()
    stopMovement()
    startMovement()
    startYslemHeartbeat()
    if State.speedToggled and not State.laggerToggled then
        startCarryVelocity()
    end
end

startMovement()
startYslemHeartbeat()
if State.speedToggled and not State.laggerToggled then
    startCarryVelocity()
end

local oldStartAutoLeft = startAutoLeft
local oldStopAutoLeft = stopAutoLeft
startAutoLeft = function()
    oldStartAutoLeft()
    restartMovement()
end
stopAutoLeft = function()
    oldStopAutoLeft()
    restartMovement()
end

local oldStartAutoRight = startAutoRight
local oldStopAutoRight = stopAutoRight
startAutoRight = function()
    oldStartAutoRight()
    restartMovement()
end
stopAutoRight = function()
    oldStopAutoRight()
    restartMovement()
end

local oldStartBat = startBatAimbot
local oldStopBat = stopBatAimbot
startBatAimbot = function()
    oldStartBat()
    restartMovement()
end
stopBatAimbot = function()
    oldStopBat()
    restartMovement()
end

local oldStartBatV2 = startBatAimbotV2
local oldStopBatV2 = stopBatAimbotV2
startBatAimbotV2 = function()
    batV2Active = true
    oldStartBatV2()
    restartMovement()
end
stopBatAimbotV2 = function()
    batV2Active = false
    oldStopBatV2()
    restartMovement()
end

-- ============================================================================

UIS.InputBegan:Connect(function(inp,gp)
    if _anyKeyListening then return end
    if gp and string.sub(inp.UserInputType.Name, 1, 7) ~= "Gamepad" then return end
    local kc=inp.KeyCode; if kc==Enum.KeyCode.Unknown then return end
    if kbMatch(KB.Speed,kc) then
        State.laggerToggled = false; laggerPhase = 0
        State.speedToggled = not State.speedToggled
        if mobileLaggerSetActive then mobileLaggerSetActive(false) end
        if modeValLbl then modeValLbl.Text = State.speedToggled and "Carry" or "Normal" end
    elseif kbMatch(KB.AutoLeft,kc) then
        State.autoLeftEnabled=not State.autoLeftEnabled
        if State.autoLeftEnabled and State.autoBatToggled then State.autoBatToggled=false; stopBatAimbot(); if autoBatSetVisual then autoBatSetVisual(false) end end
        if State.autoLeftEnabled and State.tpBatEnabled then State._setTPBatEnabled(false) end
        if State.autoLeftEnabled then startAutoLeft() else stopAutoLeft() end
        if autoLeftSetVisual then autoLeftSetVisual(State.autoLeftEnabled) end
    elseif kbMatch(KB.AutoRight,kc) then
        State.autoRightEnabled=not State.autoRightEnabled
        if State.autoRightEnabled and State.autoBatToggled then State.autoBatToggled=false; stopBatAimbot(); if autoBatSetVisual then autoBatSetVisual(false) end end
        if State.autoRightEnabled and State.tpBatEnabled then State._setTPBatEnabled(false) end
        if State.autoRightEnabled then startAutoRight() else stopAutoRight() end
        if autoRightSetVisual then autoRightSetVisual(State.autoRightEnabled) end
    elseif kbMatch(KB.Drop,kc) then
        if not State.dropActive then State._manualDropRequest = true; task.spawn(runDrop) end
    elseif kbMatch(KB.TPDown,kc) then
        task.spawn(doTpDown)
    elseif kbMatch(KB.Lagger,kc) then
        if laggerPhase == 1 then
            laggerPhase = 2; State.laggerToggled = true; State.speedToggled = false
            if mobileLaggerSetActive then mobileLaggerSetActive(true) end
            if modeValLbl then modeValLbl.Text = "Lagger 2" end
        else
            laggerPhase = 1; State.laggerToggled = true; State.speedToggled = false
            if mobileSpeedSetActive then mobileSpeedSetActive(false) end
            if mobileLaggerSetActive then mobileLaggerSetActive(true) end
            if modeValLbl then modeValLbl.Text = "Lagger 1" end
        end
    elseif kbMatch(KB.AutoBat,kc) then
        State.autoBatToggled=not State.autoBatToggled
        if State.autoBatToggled then
            if State.autoLeftEnabled then State.autoLeftEnabled=false; stopAutoLeft(); if autoLeftSetVisual then autoLeftSetVisual(false) end end
            if State.autoRightEnabled then State.autoRightEnabled=false; stopAutoRight(); if autoRightSetVisual then autoRightSetVisual(false) end end
            if State.tpBatEnabled then State._setTPBatEnabled(false) end
            pcall(startBatAimbot)
        else stopBatAimbot() end
        if autoBatSetVisual then autoBatSetVisual(State.autoBatToggled) end
    elseif kbMatch(KB.AutoBatV2,kc) then
        State.autoBatV2Enabled = not State.autoBatV2Enabled
        if State.autoBatV2Enabled then
            if State.autoLeftEnabled then State.autoLeftEnabled=false; stopAutoLeft(); if autoLeftSetVisual then autoLeftSetVisual(false) end end
            if State.autoRightEnabled then State.autoRightEnabled=false; stopAutoRight(); if autoRightSetVisual then autoRightSetVisual(false) end end
            if State.autoBatToggled then State.autoBatToggled=false; stopBatAimbot(); if autoBatSetVisual then autoBatSetVisual(false) end end
            if State.tpBatEnabled then State._setTPBatEnabled(false) end
            if startBatAimbotV2 then startBatAimbotV2() end
        else
            if stopBatAimbotV2 then stopBatAimbotV2() end
        end
        if autoBatV2SetVisual then autoBatV2SetVisual(State.autoBatV2Enabled) end
    elseif kbMatch(KB.TPBat,kc) then
        State._setTPBatEnabled(not State.tpBatEnabled)
        if State._tpBatSetVisual then State._tpBatSetVisual(State.tpBatEnabled) end
    elseif kbMatch(KB.InstaReset,kc) then
        task.spawn(cursedInstaReset)
        if btnInstaReset and btnInstaReset.Parent then
            btnInstaReset:SetAttribute("PurpleFlash", true)
            task.delay(0.35, function() if btnInstaReset and btnInstaReset.Parent then btnInstaReset:SetAttribute("PurpleFlash", false) end end)
        end
        if setInstaToggleVisual then
            setInstaToggleVisual(true)
            task.delay(0.2, function() if setInstaToggleVisual then setInstaToggleVisual(false) end end)
        end
    elseif kbMatch(KB.GuiHide,kc) then
        State.guiVisible=not State.guiVisible
        pcall(function() main.Visible=State.guiVisible end)
        pcall(function() mini.Visible=not State.guiVisible end)
    elseif (KB.MusicPC and kbMatch(KB.MusicPC,kc)) or (KB.MusicPad and kbMatch(KB.MusicPad,kc)) then
        pcall(function()
            if _G.NIGHT_musicCycle then _G.NIGHT_musicCycle() end
        end)
        if State.requestConfigSave then State.requestConfigSave() end
    elseif KB.Taunt and kbMatch(KB.Taunt,kc) then
        pcall(function()
            local btn = mobileButtonsByName and mobileButtonsByName["Taunt"]
            if btn then btn:Activate() end
        end)
    end

    if State.requestConfigSave then State.requestConfigSave() end
end)

loadPresetsFile()

task.spawn(function()
    local lastPresetName = loadLastPresetName()
    if lastPresetName and lastPresetName ~= "" then
        for _, preset in ipairs(Presets) do
            if preset.name == lastPresetName then
                pcall(function() applyPreset(preset.data) end)
                break
            end
        end
    end

    task.wait(0.2)
    local loaded = loadConfig()

    -- Ya no forzamos la barra arriba: se puede mover y se guarda la posiciÃ³n.
    -- Si no hay posiciÃ³n guardada, queda en el centro superior por defecto.

    task.wait(0.5)
    if not loaded and State._allowInitialConfigCreation then
        pcall(saveConfig)
    end
end)

Players.LocalPlayer.AncestryChanged:Connect(function(_, parent)
    if parent == nil and State._configLoaded and not State._configLoadFailed then
        if State._configDirty then pcall(saveConfig) end
        if State._positionDirty and State.savePositionBackup then
            pcall(State.savePositionBackup)
        end
    end
end)

pcall(function()
    game:BindToClose(function()
        if State._configLoaded and not State._configLoadFailed then
            if State._configDirty then pcall(saveConfig) end
            if State._positionDirty and State.savePositionBackup then
                pcall(State.savePositionBackup)
            end
        end
    end)
end)

-- ============================================================
--  AUTO CARRY â€“ Monitoreo de velocidad (20-25) con condiciÃ³n de Lagger
-- ============================================================
task.spawn(function()
    while gui and gui.Parent do
        task.wait(0.5)
        if State.autoCarryEnabled and not State.laggerToggled then
            local char = LP.Character
            if char then
                local hum = char:FindFirstChildOfClass("Humanoid")
                if hum then
                    local ws = hum.WalkSpeed
                    if ws >= 20 and ws <= 25 and not State.speedToggled then
                        State.speedToggled = true
                        if mobileSpeedSetActive then mobileSpeedSetActive(true) end
                        if modeValLbl then
                            modeValLbl.Text = State.speedProfile == "Lagger" and ("Carry Â· " .. tostring(State.profileLaggerCarrySpeed)) or "Carry"
                        end
                    end
                end
            end
        end
    end
end)

-- ===== NUEVAS CASILLAS PARA VELOCIDAD DE BAT V1 Y V2 =====
local batV1SpeedBox = rowInput("Bat Aimbot", "Bat V1 Speed", "Velocidad de persecuciÃ³n", State.batV1Speed, function(v)
	if v > 0 and v <= 500 then
		State.batV1Speed = v
		if State.requestConfigSave then State.requestConfigSave() end
	end
end)

local batV2SpeedBox = rowInput("Bat Aimbot", "Bat V2 Speed", "Velocidad de persecuciÃ³n", State.batV2Speed, function(v)
	if v > 0 and v <= 500 then
		State.batV2Speed = v
		if State.requestConfigSave then State.requestConfigSave() end
	end
end)

print("[ðŸŒ€ CT Duels] Loaded (Bless.vs edition) con Auto Carry, Lagger y Velocidades de Bat configurables!")

end)()
end)()
