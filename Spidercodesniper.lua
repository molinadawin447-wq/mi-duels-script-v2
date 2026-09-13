-- leak by FSâ”‚https://discord.gg/TBBAUZu8cW

repeat task.wait() until game:IsLoaded()

	local Players = game:GetService("Players")
	local LP2 = Players.LocalPlayer
	local TweenService2 = game:GetService("TweenService")
	local SoundService2 = game:GetService("SoundService")

	local splashGui = Instance.new("ScreenGui")
	splashGui.Name = "SLAXERSplash"
	splashGui.DisplayOrder = 999
	splashGui.IgnoreGuiInset = true
	if not pcall(function() splashGui.Parent = game:GetService("CoreGui") end) then
		splashGui.Parent = LP2:WaitForChild("PlayerGui")
	end

	local overlay = Instance.new("Frame", splashGui)
	overlay.Size = UDim2.new(1,0,1,0)
	overlay.BackgroundColor3 = Color3.fromRGB(0,0,0)
	overlay.BackgroundTransparency = 0
	overlay.BorderSizePixel = 0
	overlay.ZIndex = 1

	local tapHint = Instance.new("TextLabel", splashGui)
	tapHint.Size = UDim2.new(1, 0, 0, 20)
	tapHint.Position = UDim2.new(0, 0, 1, -36)
	tapHint.BackgroundTransparency = 1
	tapHint.Text = "tap anywhere to skip"
	tapHint.TextColor3 = Color3.fromRGB(150, 15, 15)
	tapHint.Font = Enum.Font.Gotham
	tapHint.TextSize = 11
	tapHint.ZIndex = 10
	tapHint.TextXAlignment = Enum.TextXAlignment.Center

	local skipZone = Instance.new("TextButton", splashGui)
	skipZone.Size = UDim2.new(1,0,1,0)
	skipZone.BackgroundTransparency = 1
	skipZone.Text = ""
	skipZone.ZIndex = 9

	local container = Instance.new("Frame", splashGui)
	container.Size = UDim2.new(0,320,0,120)
	container.Position = UDim2.new(0.5,-160,0,-140)
	container.BackgroundTransparency = 1
	container.BorderSizePixel = 0
	container.ZIndex = 2
	container.ClipsDescendants = false

	local titleSplash = Instance.new("TextLabel", container)
	titleSplash.Size = UDim2.new(1,0,0,70)
	titleSplash.Position = UDim2.new(0,0,0,0)
	titleSplash.BackgroundTransparency = 1
	titleSplash.Text = "SLAXER"
	titleSplash.TextColor3 = Color3.fromRGB(255,255,255)
	titleSplash.Font = Enum.Font.GothamBlack
	titleSplash.TextSize = 48
	titleSplash.TextTransparency = 0
	titleSplash.ZIndex = 3
		local g = Instance.new("UIGradient", titleSplash)
		g.Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(220,20,20)),
			ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255,60,60)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(180,10,10))
		})
	end

	local subSplash = Instance.new("TextLabel", container)
	subSplash.Size = UDim2.new(1,0,0,24)
	subSplash.Position = UDim2.new(0,0,0,72)
	subSplash.BackgroundTransparency = 1
	subSplash.Text = "ON TOP"
	subSplash.TextColor3 = Color3.fromRGB(220,20,20)
	subSplash.Font = Enum.Font.Gotham
	subSplash.TextSize = 13
	subSplash.TextTransparency = 0
	subSplash.ZIndex = 3

	local fragments = {}
	local fragTexts = {"SL","AX","ER","ON","TO","P"}
	local fragColors = {
		Color3.fromRGB(220,20,20),
		Color3.fromRGB(255,60,60),
		Color3.fromRGB(180,10,10),
		Color3.fromRGB(200,30,30),
		Color3.fromRGB(150,15,15),
		Color3.fromRGB(220,40,40),
	}
	for i, txt in ipairs(fragTexts) do
		local frag = Instance.new("TextLabel", splashGui)
		frag.Size = UDim2.new(0,90,0,60)
		frag.AnchorPoint = Vector2.new(0.5,0.5)
		frag.Position = UDim2.new(0.5, (i-3.5)*52, 0.5, -30)
		frag.BackgroundTransparency = 1
		frag.Text = txt
		frag.TextColor3 = fragColors[i]
		frag.Font = Enum.Font.GothamBlack
		frag.TextSize = 44
		frag.TextTransparency = 1
		frag.ZIndex = 5
		frag.Rotation = 0
		table.insert(fragments, frag)
	end

	local function playSound(id, pitch, vol, parent, delay)
		task.delay(delay or 0, function()
			local s = Instance.new("Sound")
			s.SoundId = id
			s.PlaybackSpeed = pitch
			s.Volume = vol
			s.Parent = parent
			s.RollOffMaxDistance = 0
			s:Play()
			game:GetService("Debris"):AddItem(s, 3)
		end)
	end

	local function playGlitchImpact()
		playSound("rbxassetid://1588058260", 1.0, 0.9, SoundService2, 0)
		playSound("rbxassetid://8627516764", 0.8, 0.7, SoundService2, 0.02)
		playSound("rbxassetid://1588058260", 1.4, 0.5, SoundService2, 0.05)
		playSound("rbxassetid://8627516764", 1.2, 0.4, SoundService2, 0.1)
	end

	local function playWhistle()
		local WHISTLE_ID = "rbxassetid://4612414100"
		playSound(WHISTLE_ID, 2.2, 0.7, SoundService2, 0)
		playSound(WHISTLE_ID, 1.7, 0.8, SoundService2, 0.07)
		playSound(WHISTLE_ID, 1.2, 0.9, SoundService2, 0.15)
		playSound(WHISTLE_ID, 0.85, 0.9, SoundService2, 0.24)
		playSound(WHISTLE_ID, 0.55, 0.7, SoundService2, 0.34)
		playSound(WHISTLE_ID, 0.3, 1.0, SoundService2, 0.5)
	end

	local function doShatterEffect()
		pcall(playGlitchImpact)
		local flash = Instance.new("Frame", splashGui)
		flash.Size = UDim2.new(1,0,1,0)
		flash.BackgroundColor3 = Color3.fromRGB(255,255,255)
		flash.BackgroundTransparency = 0.3
		flash.BorderSizePixel = 0
		flash.ZIndex = 8
		TweenService2:Create(flash, TweenInfo.new(0.18), {BackgroundTransparency=1}):Play()
		game:GetService("Debris"):AddItem(flash, 0.3)
		titleSplash.TextTransparency = 1
		local RunService2 = game:GetService("RunService")
		for i, frag in ipairs(fragments) do
			frag.TextTransparency = 0
			local dirX = (i - 3.5) * 60 + math.random(-80, 80)
			local dirY = math.random(120, 280)
			local rot = math.random(-180, 180)
			local startPosX = frag.Position.X.Offset
			local startPosY = frag.Position.Y.Offset
			local t = 0
			conn = RunService2.RenderStepped:Connect(function(dt)
				t = t + dt
				if t > 0.8 then frag.TextTransparency = 1; conn:Disconnect(); return end
				local alpha = t / 0.8
				local px = startPosX + dirX * alpha
				local py = startPosY - dirY * alpha + 300 * alpha * alpha
				local fade = math.clamp(alpha * 1.4 - 0.3, 0, 1)
				frag.Position = UDim2.new(0.5, px, 0.5, py - 30)
				frag.Rotation = rot * alpha
				frag.TextTransparency = fade
				frag.TextSize = math.clamp(44 - alpha * 20, 10, 44)
			end)
		end
		for li = 1, 8 do
			task.delay(li * 0.025, function()
				local line = Instance.new("Frame", splashGui)
				line.Size = UDim2.new(1, 0, 0, math.random(2,6))
				line.Position = UDim2.new(0, 0, math.random(), 0)
				line.BackgroundColor3 = Color3.fromRGB(math.random(150,255), math.random(0,30), math.random(0,30))
				line.BackgroundTransparency = math.random() * 0.3
				line.BorderSizePixel = 0
				line.ZIndex = 7
				TweenService2:Create(line, TweenInfo.new(0.12), {BackgroundTransparency=1}):Play()
				game:GetService("Debris"):AddItem(line, 0.2)
			end)
		end
	end

	local splashDone = false
	local function finishSplash()
		splashDone = true
		TweenService2:Create(subSplash, TweenInfo.new(0.3), {TextTransparency=1}):Play()
		TweenService2:Create(overlay, TweenInfo.new(0.4), {BackgroundTransparency=1}):Play()
		tapHint.Visible = false
	end

	skipZone.MouseButton1Click:Connect(function()
		titleSplash.TextTransparency = 1
		subSplash.TextTransparency = 1
		finishSplash()
	end)

	task.spawn(function()
		TweenService2:Create(overlay, TweenInfo.new(0.2), {BackgroundTransparency=0.1}):Play()
		task.wait(0.15)
		pcall(playWhistle)
		TweenService2:Create(container, TweenInfo.new(0.45, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out),
			{Position=UDim2.new(0.5,-160,0.5,-60)}):Play()
		task.wait(0.5)
		doShatterEffect()
		task.wait(0.85)
		finishSplash()
		task.wait(0.45)
		if splashGui and splashGui.Parent then splashGui:Destroy() end
	end)

	local _t0 = tick()
	while not splashDone and (tick() - _t0) < 3.0 do
		task.wait(0.05)
	end
end

local Players         = game:GetService("Players")
local RunService      = game:GetService("RunService")
local UIS             = game:GetService("UserInputService")
local TweenService    = game:GetService("TweenService")
local HttpService     = game:GetService("HttpService")
local ContentProvider = game:GetService("ContentProvider")
local LP              = Players.LocalPlayer

_G.SLAXERCharacterLifecycle = {}
	local activeCharacter = nil
	local generation = 0
	local humanoidDiedConnection = nil

	function _G.SLAXERCharacterLifecycle.Begin(character)
		generation = generation + 1
		activeCharacter = character
			humanoidDiedConnection:Disconnect()
			humanoidDiedConnection = nil
		end
	end

	function _G.SLAXERCharacterLifecycle.IsCurrent(character, token)
		return activeCharacter == character and generation == token and LP.Character == character and character.Parent ~= nil
	end

	function _G.SLAXERCharacterLifecycle.BindHumanoid(character, humanoid, token)
		if not _G.SLAXERCharacterLifecycle.IsCurrent(character, token) or not humanoid then return end
		humanoidDiedConnection = humanoid.Died:Connect(function()
			if activeCharacter == character and generation == token then
				activeCharacter = nil
			end
		end)
	end

	function _G.SLAXERCharacterLifecycle.Invalidate(character)
		if activeCharacter ~= character then return end
		generation = generation + 1
		activeCharacter = nil
			humanoidDiedConnection:Disconnect()
			humanoidDiedConnection = nil
		end
	end
end

local LANG = "en"
local TRANSLATIONS = {
	fr = {
		speed="Vitesse", carry_speed="Vitesse Carry", lagger_normal="Lagger Normal", lagger_carry="Lagger Carry",
		mode="Mode", normal="Normal", carry="Carry", lagger_normal_lbl="Lagger Normal", lagger_carry_lbl="Lagger Carry",
		speed_toggle="Toggle Vitesse", lagger_mode="Mode Lagger",
		auto_bat="Auto Bat", auto_swing="Auto Swing", bat_speed="Vitesse Bat", face_offset="Offset Face", keybind="Touche",
		auto_grab="Auto Grab", duration="DurÃ©e", radius="Rayon",
		inf_jump="Saut Infini", anti_rag="Anti Ragdoll", fps_boost="FPS Boost", medusa="MÃ©duse",
		anim_toggle="Anim T-Hard", unwalk="Unwalk", hitbox_esp="Hitbox ESP",
		auto_play="Auto Play", side="CÃ´tÃ©", right="Droite", left="Gauche",
		tp_down="TP Bas", drop_brainrot="Drop Brainrot", auto_tp_down="Auto TP Bas",
		jump_threshold="Sauts avant TP", hitbox_dist="Hitbox + Distance",
		dark_mode="Mode Sombre", rm_acc="Suppr. Accessoires",
		now_playing="En cours", stop_music="STOP MUSIQUE",
		edit_binds="Modifier Touches", hide_gui="Masquer UI",
		interface="Interface", buttons="Boutons", menu_size="Taille Menu",
		separate_btns="Boutons SÃ©parÃ©s", btn_size="Taille Boutons",
		scale="Ã‰chelle", my_scripts="Mes Scripts", add_script="Ajouter Script",
		script_name="Nom", script_code="CODE DU SCRIPT", run="LANCER", del="SUP",
		speed_config="Config Vitesse", face_tracking="Suivi de Face",
		auto_steal="Auto Vol", toggles="Toggles", visual="Visuel",
		songs="Musiques", keybinds="Raccourcis", settings="ParamÃ¨tres",
		executor="Executor", movement="Mouvement", mechanics="MÃ©caniques",
		aimbot="Aimbot", language="Langue",
		auto_bat_btn="AUTO\nBAT", auto_play_btn="AUTO\nJEU", drop_br_btn="DROP\nBR",
		tp_down_btn="TP\nBAS", carry_spd_btn="CARRY\nVIT", lagger_btn="LAGGER",
		hard_hit="Hard Hit", bat_radius="Rayon Bat",
		anti_lag="Anti Lag", ultra_mode="Ultra Mode",
		esp="ESP (N&B)", tracer="Tracer Lines", no_cam="No Cam Collision",
		engage_range="Engage Range", gamepad="Manette",
		aim_bypass="Aimbot V2",
		aim_bypass_btn="AIM\nV2",
		inf_jump_mode="Mode Saut Infini", inf_jump_manual="Manuel", 		btn_scale="Taille Boutons", btn_scale_up="Agrandir", btn_scale_down="RÃ©duire",
		inf_jump_hold="Hold",
	},
	en = {
		speed="Speed", carry_speed="Carry Speed", lagger_normal="Lagger Normal", lagger_carry="Lagger Carry",
		mode="Mode", normal="Normal", carry="Carry", lagger_normal_lbl="Lagger Normal", lagger_carry_lbl="Lagger Carry",
		speed_toggle="Speed Toggle", lagger_mode="Lagger Mode",
		auto_bat="Auto Bat", auto_swing="Auto Swing", bat_speed="Bat Speed", face_offset="Face Offset", keybind="Keybind",
		auto_grab="Auto Grab", duration="Duration", radius="Radius",
		inf_jump="Inf Jump", anti_rag="Anti Ragdoll", fps_boost="FPS Boost", medusa="Medusa",
		anim_toggle="T-Hard Anim", unwalk="Unwalk", hitbox_esp="Hitbox ESP",
		auto_play="Auto Play", side="Side", right="Right", left="Left",
		tp_down="TP Down", drop_brainrot="Drop Brainrot", auto_tp_down="Auto TP Down",
		jump_threshold="Jumps before TP", hitbox_dist="Hitbox + Distance",
		dark_mode="Dark Mode", rm_acc="Rm. Accessories",
		now_playing="Now Playing", stop_music="STOP MUSIC",
		edit_binds="Edit Binds", hide_gui="Hide GUI",
		interface="Interface", buttons="Buttons", menu_size="Menu Size",
		separate_btns="Detach Btns", btn_size="Button Size",
		scale="Scale", my_scripts="My Scripts", add_script="Add Script",
		script_name="Name", script_code="SCRIPT CODE", run="RUN", del="DEL",
		speed_config="Speed Config", face_tracking="Face Tracking",
		auto_steal="Auto Steal", toggles="Toggles", visual="Visual",
		extra="Extra",
		songs="Songs", keybinds="Keybinds", settings="Settings",
		executor="Executor", movement="Movement", mechanics="Mechanics",
		main="Main",
		aimbot="Aimbot", language="Language",
		auto_bat_btn="AUTO\nBAT", auto_play_btn="AUTO\nPLAY", drop_br_btn="DROP\nBR",
		tp_down_btn="TP\nDOWN", carry_spd_btn="CARRY\nSPD", lagger_btn="LAGGER",
		hard_hit="Hard Hit", bat_radius="Bat Radius",
		anti_lag="Anti Lag", ultra_mode="Ultra Mode",
		esp="ESP (B&W)", tracer="Tracer Lines", no_cam="No Cam Collision",
		engage_range="Engage Range", gamepad="Gamepad",
		aim_bypass="Aimbot V2",
		aim_bypass_btn="AIM\nV2",
		inf_jump_mode="Inf Jump Mode", inf_jump_manual="Manual", 		btn_scale="Button Scale", btn_scale_up="Bigger", btn_scale_down="Smaller",
		inf_jump_hold="Hold",
	},
	es = {
		speed="Velocidad", carry_speed="Velocidad Carry", lagger_normal="Lagger Normal", lagger_carry="Lagger Carry",
		mode="Modo", normal="Normal", carry="Carry", lagger_normal_lbl="Lagger Normal", lagger_carry_lbl="Lagger Carry",
		speed_toggle="Toggle Velocidad", lagger_mode="Modo Lagger",
		auto_bat="Auto Bat", auto_swing="Auto Swing", bat_speed="Velocidad Bat", face_offset="Offset Cara", keybind="Tecla",
		auto_grab="Auto Robar", duration="DuraciÃ³n", radius="Radio",
		inf_jump="Salto Infinito", anti_rag="Anti Ragdoll", fps_boost="FPS Boost", medusa="Medusa",
		anim_toggle="Anim T-Hard", unwalk="Unwalk", hitbox_esp="Hitbox ESP",
		auto_play="Auto Jugar", side="Lado", right="Derecha", left="Izquierda",
		tp_down="TP Abajo", drop_brainrot="Drop Brainrot", auto_tp_down="Auto TP Abajo",
		jump_threshold="Saltos antes TP", hitbox_dist="Hitbox + Distancia",
		dark_mode="Modo Oscuro", rm_acc="Quitar Accesorios",
		now_playing="Reproduciendo", stop_music="DETENER MÃšSICA",
		edit_binds="Editar Teclas", hide_gui="Ocultar UI",
		interface="Interfaz", buttons="Botones", menu_size="TamaÃ±o MenÃº",
		separate_btns="Botones Separados", btn_size="TamaÃ±o Botones",
		scale="Escala", my_scripts="Mis Scripts", add_script="AÃ±adir Script",
		script_name="Nombre", script_code="CÃ“DIGO DEL SCRIPT", run="EJECUTAR", del="BORRAR",
		speed_config="Config Velocidad", face_tracking="Seguimiento Cara",
		auto_steal="Auto Robar", toggles="Toggles", visual="Visual",
		extra="Extra",
		songs="Canciones", keybinds="Teclas", settings="Ajustes",
		executor="Executor", movement="Movimiento", mechanics="MecÃ¡nicas",
		aimbot="Aimbot", language="Idioma",
		auto_bat_btn="AUTO\nBAT", auto_play_btn="AUTO\nJUEGO", drop_br_btn="DROP\nBR",
		tp_down_btn="TP\nABAJO", carry_spd_btn="CARRY\nVEL", lagger_btn="LAGGER",
		hard_hit="Hard Hit", bat_radius="Radio Bat",
		anti_lag="Anti Lag", ultra_mode="Ultra Mode",
		esp="ESP (B&N)", tracer="Tracer Lines", no_cam="Sin ColisiÃ³n Cam",
		engage_range="Rango", gamepad="Mando",
		aim_bypass="Aimbot V2",
		aim_bypass_btn="AIM\nV2",
		inf_jump_mode="Modo Salto", inf_jump_manual="Manual", 		btn_scale="Escala BotÃ³n", btn_scale_up="Aumentar", btn_scale_down="Reducir",
		inf_jump_hold="Hold",
	},
	de = {
		speed="Geschwindigkeit", carry_speed="Carry Geschw.", lagger_normal="Lagger Normal", lagger_carry="Lagger Carry",
		mode="Modus", normal="Normal", carry="Carry", lagger_normal_lbl="Lagger Normal", lagger_carry_lbl="Lagger Carry",
		speed_toggle="Geschw. Toggle", lagger_mode="Lagger Modus",
		auto_bat="Auto Bat", auto_swing="Auto Schlag", bat_speed="Bat Geschw.", face_offset="Gesicht Offset", keybind="Taste",
		auto_grab="Auto Stehlen", duration="Dauer", radius="Radius",
		inf_jump="Unendl. Sprung", anti_rag="Anti Ragdoll", fps_boost="FPS Boost", medusa="Medusa",
		anim_toggle="T-Hard Anim", unwalk="Unwalk", hitbox_esp="Hitbox ESP",
		auto_play="Auto Spielen", side="Seite", right="Rechts", left="Links",
		tp_down="TP Runter", drop_brainrot="Drop Brainrot", auto_tp_down="Auto TP Runter",
		jump_threshold="SprÃ¼nge vor TP", hitbox_dist="Hitbox + Abstand",
		dark_mode="Dunkelmodus", rm_acc="ZubehÃ¶r entfernen",
		now_playing="LÃ¤uft gerade", stop_music="MUSIK STOPP",
		edit_binds="Tasten bearbeiten", hide_gui="UI verstecken",
		interface="OberflÃ¤che", buttons="Buttons", menu_size="MenÃ¼grÃ¶ÃŸe",
		separate_btns="Getrennte Btns", btn_size="Button GrÃ¶ÃŸe",
		scale="Skalierung", my_scripts="Meine Skripte", add_script="Skript hinzufÃ¼gen",
		script_name="Name", script_code="SKRIPT CODE", run="STARTEN", del="LÃ–SCHEN",
		speed_config="Geschw. Konfig", face_tracking="Gesichtsverfolgung",
		auto_steal="Auto Stehlen", toggles="Toggles", visual="Visuell",
		songs="Lieder", keybinds="Tasten", settings="Einstellungen",
		executor="Executor", movement="Bewegung", mechanics="Mechaniken",
		aimbot="Aimbot", language="Sprache",
		auto_bat_btn="AUTO\nBAT", auto_play_btn="AUTO\nSPIEL", drop_br_btn="DROP\nBR",
		tp_down_btn="TP\nRUNTER", carry_spd_btn="CARRY\nGESCH", lagger_btn="LAGGER",
		hard_hit="Hard Hit", bat_radius="Bat Radius",
		anti_lag="Anti Lag", ultra_mode="Ultra Modus",
		esp="ESP (S&W)", tracer="Tracer Lines", no_cam="Kein Cam Collision",
		engage_range="Reichweite", gamepad="Gamepad",
		aim_bypass="Aimbot V2",
		aim_bypass_btn="AIM\nV2",
		inf_jump_mode="Sprung Modus", inf_jump_manual="Manuell", 		btn_scale="Button Skalierung", btn_scale_up="GrÃ¶ÃŸer", btn_scale_down="Kleiner",
		inf_jump_hold="Hold",
	},
	pt = {
		speed="Velocidade", carry_speed="Velocidade Carry", lagger_normal="Lagger Normal", lagger_carry="Lagger Carry",
		mode="Modo", normal="Normal", carry="Carry", lagger_normal_lbl="Lagger Normal", lagger_carry_lbl="Lagger Carry",
		speed_toggle="Toggle Velocidade", lagger_mode="Modo Lagger",
		auto_bat="Auto Bat", auto_swing="Auto Swing", bat_speed="Velocidade Bat", face_offset="Offset Rosto", keybind="Tecla",
		auto_grab="Auto Roubar", duration="DuraÃ§Ã£o", radius="Raio",
		inf_jump="Pulo Infinito", anti_rag="Anti Ragdoll", fps_boost="FPS Boost", medusa="Medusa",
		anim_toggle="Anim T-Hard", unwalk="Unwalk", hitbox_esp="Hitbox ESP",
		auto_play="Auto Jogar", side="Lado", right="Direita", left="Esquerda",
		tp_down="TP Baixo", drop_brainrot="Drop Brainrot", auto_tp_down="Auto TP Baixo",
		jump_threshold="Saltos antes TP", hitbox_dist="Hitbox + DistÃ¢ncia",
		dark_mode="Modo Escuro", rm_acc="Remover AcessÃ³rios",
		now_playing="Tocando agora", stop_music="PARAR MÃšSICA",
		edit_binds="Editar Teclas", hide_gui="Ocultar UI",
		interface="Interface", buttons="BotÃµes", menu_size="Tamanho Menu",
		separate_btns="BotÃµes Separados", btn_size="Tamanho BotÃµes",
		scale="Escala", my_scripts="Meus Scripts", add_script="Adicionar Script",
		script_name="Nome", script_code="CÃ“DIGO DO SCRIPT", run="EXECUTAR", del="EXCLUIR",
		speed_config="Config Velocidade", face_tracking="Rastreamento Rosto",
		auto_steal="Auto Roubar", toggles="Toggles", visual="Visual",
		extra="Extra",
		songs="MÃºsicas", keybinds="Teclas", settings="ConfiguraÃ§Ãµes",
		executor="Executor", movement="Movimento", mechanics="MecÃ¢nicas",
		aimbot="Aimbot", language="Idioma",
		auto_bat_btn="AUTO\nBAT", auto_play_btn="AUTO\nJOGO", drop_br_btn="DROP\nBR",
		tp_down_btn="TP\nBAIXO", carry_spd_btn="CARRY\nVEL", lagger_btn="LAGGER",
		hard_hit="Hard Hit", bat_radius="Raio Bat",
		anti_lag="Anti Lag", ultra_mode="Ultra Mode",
		esp="ESP (P&B)", tracer="Tracer Lines", no_cam="Sem ColisÃ£o Cam",
		engage_range="Alcance", gamepad="Gamepad",
		aim_bypass="Aimbot V2",
		aim_bypass_btn="AIM\nV2",
		inf_jump_mode="Modo Pulo", inf_jump_manual="Manual", 		btn_scale="Escala BotÃ£o", btn_scale_up="Aumentar", btn_scale_down="Diminuir",
		inf_jump_hold="Hold",
	},
	ja = {
		speed="é€Ÿåº¦", carry_speed="ã‚­ãƒ£ãƒªãƒ¼é€Ÿåº¦", lagger_normal="ãƒ©ã‚¬ãƒ¼é€šå¸¸", lagger_carry="ãƒ©ã‚¬ãƒ¼ã‚­ãƒ£ãƒªãƒ¼",
		mode="ãƒ¢ãƒ¼ãƒ‰", normal="é€šå¸¸", carry="ã‚­ãƒ£ãƒªãƒ¼", lagger_normal_lbl="ãƒ©ã‚¬ãƒ¼é€šå¸¸", lagger_carry_lbl="ãƒ©ã‚¬ãƒ¼ã‚­ãƒ£ãƒªãƒ¼",
		speed_toggle="é€Ÿåº¦ãƒˆã‚°ãƒ«", lagger_mode="ãƒ©ã‚¬ãƒ¼ãƒ¢ãƒ¼ãƒ‰",
		auto_bat="ã‚ªãƒ¼ãƒˆãƒãƒƒãƒˆ", auto_swing="ã‚ªãƒ¼ãƒˆã‚¹ã‚¤ãƒ³ã‚°", bat_speed="ãƒãƒƒãƒˆé€Ÿåº¦", face_offset="é¡”ã‚ªãƒ•ã‚»ãƒƒãƒˆ", keybind="ã‚­ãƒ¼",
		auto_grab="ã‚ªãƒ¼ãƒˆã‚°ãƒ©ãƒ–", duration="æ™‚é–“", radius="åŠå¾„",
		inf_jump="ç„¡é™ã‚¸ãƒ£ãƒ³ãƒ—", anti_rag="ã‚¢ãƒ³ãƒãƒ©ã‚°ãƒ‰ãƒ¼ãƒ«", fps_boost="FPSå¼·åŒ–", medusa="ãƒ¡ãƒ‡ãƒ¥ãƒ¼ã‚µ",
		anim_toggle="Tãƒãƒ¼ãƒ‰ã‚¢ãƒ‹ãƒ¡T", unwalk="ã‚¢ãƒ³ã‚¦ã‚©ãƒ¼ã‚¯", hitbox_esp="ãƒ’ãƒƒãƒˆãƒœãƒƒã‚¯ã‚¹ESP",
		auto_play="ã‚ªãƒ¼ãƒˆãƒ—ãƒ¬ã‚¤", side="ã‚µã‚¤ãƒ‰", right="å³", left="å·¦",
		tp_down="TPä¸‹", drop_brainrot="ãƒ‰ãƒ­ãƒƒãƒ—", auto_tp_down="ã‚ªãƒ¼ãƒˆTPä¸‹",
		jump_threshold="TPã¾ã§ã®ã‚¸ãƒ£ãƒ³ãƒ—", hitbox_dist="ãƒ’ãƒƒãƒˆãƒœãƒƒã‚¯ã‚¹+è·é›¢",
		dark_mode="ãƒ€ãƒ¼ã‚¯ãƒ¢ãƒ¼ãƒ‰", rm_acc="ã‚¢ã‚¯ã‚»ã‚µãƒªãƒ¼å‰Šé™¤",
		now_playing="å†ç”Ÿä¸­", stop_music="éŸ³æ¥½åœæ­¢",
		edit_binds="ã‚­ãƒ¼ç·¨é›†", hide_gui="UIéžè¡¨ç¤º",
		interface="ã‚¤ãƒ³ã‚¿ãƒ¼ãƒ•ã‚§ãƒ¼ã‚¹", buttons="ãƒœã‚¿ãƒ³", menu_size="ãƒ¡ãƒ‹ãƒ¥ãƒ¼ã‚µã‚¤ã‚º",
		separate_btns="ãƒœã‚¿ãƒ³åˆ†é›¢", btn_size="ãƒœã‚¿ãƒ³ã‚µã‚¤ã‚º",
		scale="ã‚¹ã‚±ãƒ¼ãƒ«", my_scripts="ãƒžã‚¤ã‚¹ã‚¯ãƒªãƒ—ãƒˆ", add_script="ã‚¹ã‚¯ãƒªãƒ—ãƒˆè¿½åŠ ",
		script_name="åå‰", script_code="ã‚¹ã‚¯ãƒªãƒ—ãƒˆã‚³ãƒ¼ãƒ‰", run="å®Ÿè¡Œ", del="å‰Šé™¤",
		speed_config="é€Ÿåº¦è¨­å®š", face_tracking="é¡”è¿½è·¡",
		auto_steal="ã‚ªãƒ¼ãƒˆã‚¹ãƒ†ã‚£ãƒ¼ãƒ«", toggles="ãƒˆã‚°ãƒ«", visual="ãƒ“ã‚¸ãƒ¥ã‚¢ãƒ«",
		songs="æ›²", keybinds="ã‚­ãƒ¼", settings="è¨­å®š",
		executor="Executor", movement="ç§»å‹•", mechanics="ãƒ¡ã‚«ãƒ‹ã‚¯ã‚¹",
		aimbot="ã‚¨ã‚¤ãƒ ãƒœãƒƒãƒˆ", language="è¨€èªž",
		auto_bat_btn="AUTO\nBAT", auto_play_btn="AUTO\nãƒ—ãƒ¬ã‚¤", drop_br_btn="DROP\nBR",
		tp_down_btn="TP\nä¸‹", carry_spd_btn="CARRY\né€Ÿ", lagger_btn="LAGGER",
		hard_hit="ãƒãƒ¼ãƒ‰ãƒ’ãƒƒãƒˆ", bat_radius="ãƒãƒƒãƒˆåŠå¾„",
		anti_lag="ã‚¢ãƒ³ãƒãƒ©ã‚°", ultra_mode="ã‚¦ãƒ«ãƒˆãƒ©ãƒ¢ãƒ¼ãƒ‰",
		esp="ESP (ç™½é»’)", tracer="ãƒˆãƒ¬ãƒ¼ã‚µãƒ¼", no_cam="ã‚«ãƒ ç„¡è¡çª",
		engage_range="å°„ç¨‹", gamepad="ã‚²ãƒ¼ãƒ ãƒ‘ãƒƒãƒ‰",
		aim_bypass="Aimbot V2",
		aim_bypass_btn="AIM\nV2",
		inf_jump_mode="ã‚¸ãƒ£ãƒ³ãƒ—ãƒ¢ãƒ¼ãƒ‰", inf_jump_manual="æ‰‹å‹•", 		btn_scale="ãƒœã‚¿ãƒ³ã‚µã‚¤ã‚º", btn_scale_up="æ‹¡å¤§", btn_scale_down="ç¸®å°",
		inf_jump_hold="ãƒ›ãƒ¼ãƒ«ãƒ‰",
	},
	ar = {
		speed="Ø§Ù„Ø³Ø±Ø¹Ø©", carry_speed="Ø³Ø±Ø¹Ø© Ø§Ù„Ø­Ù…Ù„", lagger_normal="Ù„Ø§ØºØ± Ø¹Ø§Ø¯ÙŠ", lagger_carry="Ù„Ø§ØºØ± Ø­Ù…Ù„",
		mode="Ø§Ù„ÙˆØ¶Ø¹", normal="Ø¹Ø§Ø¯ÙŠ", carry="Ø­Ù…Ù„", lagger_normal_lbl="Ù„Ø§ØºØ± Ø¹Ø§Ø¯ÙŠ", lagger_carry_lbl="Ù„Ø§ØºØ± Ø­Ù…Ù„",
		speed_toggle="ØªØ¨Ø¯ÙŠÙ„ Ø§Ù„Ø³Ø±Ø¹Ø©", lagger_mode="ÙˆØ¶Ø¹ Ø§Ù„Ù„Ø§ØºØ±",
		auto_bat="Ø¨Ø§Ø· ØªÙ„Ù‚Ø§Ø¦ÙŠ", auto_swing="Ø¶Ø±Ø¨Ø© ØªÙ„Ù‚Ø§Ø¦ÙŠØ©", bat_speed="Ø³Ø±Ø¹Ø© Ø§Ù„Ø¨Ø§Ø·", face_offset="Ø¥Ø²Ø§Ø­Ø© Ø§Ù„ÙˆØ¬Ù‡", keybind="Ø§Ù„Ù…ÙØªØ§Ø­",
		auto_grab="Ø³Ø±Ù‚Ø© ØªÙ„Ù‚Ø§Ø¦ÙŠØ©", duration="Ø§Ù„Ù…Ø¯Ø©", radius="Ø§Ù„Ù†Ø·Ø§Ù‚",
		inf_jump="Ù‚ÙØ² Ù„Ø§Ù†Ù‡Ø§Ø¦ÙŠ", anti_rag="Ø¶Ø¯ Ø§Ù„Ø±Ø¬Ø¯ÙˆÙ„", fps_boost="ØªØ¹Ø²ÙŠØ² FPS", medusa="Ù…ÙŠØ¯ÙˆØ³Ø§",
		anim_toggle="Ø£Ù†ÙŠÙ… T-Hard", unwalk="Ø¨Ø¯ÙˆÙ† Ù…Ø´ÙŠ", hitbox_esp="Hitbox ESP",
		auto_play="ØªØ´ØºÙŠÙ„ ØªÙ„Ù‚Ø§Ø¦ÙŠ", side="Ø§Ù„Ø¬Ø§Ù†Ø¨", right="ÙŠÙ…ÙŠÙ†", left="ÙŠØ³Ø§Ø±",
		tp_down="TP Ù„Ù„Ø£Ø³ÙÙ„", drop_brainrot="Ø³Ù‚ÙˆØ·", auto_tp_down="TP ØªÙ„Ù‚Ø§Ø¦ÙŠ Ù„Ù„Ø£Ø³ÙÙ„",
		jump_threshold="Ù‚ÙØ²Ø§Øª Ù‚Ø¨Ù„ TP", hitbox_dist="Hitbox + Ù…Ø³Ø§ÙØ©",
		dark_mode="Ø§Ù„ÙˆØ¶Ø¹ Ø§Ù„Ø¯Ø§ÙƒÙ†", rm_acc="Ø¥Ø²Ø§Ù„Ø© Ø§Ù„Ø¥ÙƒØ³Ø³ÙˆØ§Ø±Ø§Øª",
		now_playing="ÙŠØ¹Ø²Ù Ø§Ù„Ø¢Ù†", stop_music="Ø¥ÙŠÙ‚Ø§Ù Ø§Ù„Ù…ÙˆØ³ÙŠÙ‚Ù‰",
		edit_binds="ØªØ¹Ø¯ÙŠÙ„ Ø§Ù„Ù…ÙØ§ØªÙŠØ­", hide_gui="Ø¥Ø®ÙØ§Ø¡ Ø§Ù„ÙˆØ§Ø¬Ù‡Ø©",
		interface="Ø§Ù„ÙˆØ§Ø¬Ù‡Ø©", buttons="Ø§Ù„Ø£Ø²Ø±Ø§Ø±", menu_size="Ø­Ø¬Ù… Ø§Ù„Ù‚Ø§Ø¦Ù…Ø©",
		separate_btns="Ø£Ø²Ø±Ø§Ø± Ù…Ù†ÙØµÙ„Ø©", btn_size="Ø­Ø¬Ù… Ø§Ù„Ø£Ø²Ø±Ø§Ø±",
		scale="Ø§Ù„Ù…Ù‚ÙŠØ§Ø³", my_scripts="Ø³ÙƒØ±ÙŠØ¨ØªØ§ØªÙŠ", add_script="Ø¥Ø¶Ø§ÙØ© Ø³ÙƒØ±ÙŠØ¨Øª",
		script_name="Ø§Ù„Ø§Ø³Ù…", script_code="ÙƒÙˆØ¯ Ø§Ù„Ø³ÙƒØ±ÙŠØ¨Øª", run="ØªØ´ØºÙŠÙ„", del="Ø­Ø°Ù",
		speed_config="Ø¥Ø¹Ø¯Ø§Ø¯ Ø§Ù„Ø³Ø±Ø¹Ø©", face_tracking="ØªØªØ¨Ø¹ Ø§Ù„ÙˆØ¬Ù‡",
		auto_steal="Ø³Ø±Ù‚Ø© ØªÙ„Ù‚Ø§Ø¦ÙŠØ©", toggles="Ø§Ù„ØªØ¨Ø¯ÙŠÙ„Ø§Øª", visual="Ø§Ù„Ù…Ø±Ø¦ÙŠØ§Øª",
		songs="Ø§Ù„Ø£ØºØ§Ù†ÙŠ", keybinds="Ø§Ù„Ù…ÙØ§ØªÙŠØ­", settings="Ø§Ù„Ø¥Ø¹Ø¯Ø§Ø¯Ø§Øª",
		executor="Executor", movement="Ø§Ù„Ø­Ø±ÙƒØ©", mechanics="Ø§Ù„Ù…ÙŠÙƒØ§Ù†ÙŠÙƒØ§",
		aimbot="Ø£ÙŠÙ…Ø¨ÙˆØª", language="Ø§Ù„Ù„ØºØ©",
		auto_bat_btn="AUTO\nBAT", auto_play_btn="AUTO\nPLAY", drop_br_btn="DROP\nBR",
		tp_down_btn="TP\nØ£Ø³ÙÙ„", carry_spd_btn="CARRY\nØ³Ø±Ø¹Ø©", lagger_btn="LAGGER",
		hard_hit="Ø¶Ø±Ø¨Ø© Ù‚ÙˆÙŠØ©", bat_radius="Ù†Ø·Ø§Ù‚ Ø§Ù„Ø¨Ø§Ø·",
		anti_lag="Ø¶Ø¯ Ø§Ù„ØªØ£Ø®Ø±", ultra_mode="ÙˆØ¶Ø¹ Ø£ÙˆÙ„ØªØ±Ø§",
		esp="ESP (Ø£Ø³ÙˆØ¯ Ø£Ø¨ÙŠØ¶)", tracer="Ø®Ø·ÙˆØ· ØªØªØ¨Ø¹", no_cam="Ù„Ø§ ØªØµØ§Ø¯Ù… ÙƒØ§Ù…ÙŠØ±Ø§",
		engage_range="Ø§Ù„Ù…Ø¯Ù‰", gamepad="ØºÙŠÙ… Ø¨Ø§Ø¯",
		aim_bypass="Aimbot V2",
		aim_bypass_btn="AIM\nV2",
		inf_jump_mode="ÙˆØ¶Ø¹ Ø§Ù„Ù‚ÙØ²", inf_jump_manual="ÙŠØ¯ÙˆÙŠ", 		btn_scale="Ø­Ø¬Ù… Ø§Ù„Ø£Ø²Ø±Ø§Ø±", btn_scale_up="ØªÙƒØ¨ÙŠØ±", btn_scale_down="ØªØµØºÙŠØ±",
		inf_jump_hold="Ø¶ØºØ·",
	},
}
local LANG_LIST = {
	{code="fr", flag="ðŸ‡«ðŸ‡·", name="Fra"},{code="en", flag="ðŸ‡¬ðŸ‡§", name="Eng"},
	{code="es", flag="ðŸ‡ªðŸ‡¸", name="Esp"},{code="de", flag="ðŸ‡©ðŸ‡ª", name="Deu"},
	{code="pt", flag="ðŸ‡µðŸ‡¹", name="Por"},{code="ja", flag="ðŸ‡¯ðŸ‡µ", name="æ—¥æœ¬"},
	{code="ar", flag="ðŸ‡¸ðŸ‡¦", name="Ø¹Ø±Ø¨"},
}
local langCallbacks = {}
local function T(key) return (TRANSLATIONS[LANG] or TRANSLATIONS["en"])[key] or key end
local function onLangChange(cb) table.insert(langCallbacks,cb) end
local function setLang(code) LANG=code; for _,cb in ipairs(langCallbacks) do pcall(cb) end end

local OWNER_NAME = "SLAXER"
local function addOwnerTag(char)
	if not char then return end; local head=char:WaitForChild("Head",5); if not head then return end
	local old=head:FindFirstChild("SLAXERTag"); if old then old:Destroy() end
	local bb=Instance.new("BillboardGui",head); bb.Name="SLAXERTag"; bb.Size=UDim2.new(0,210,0,32); bb.StudsOffset=Vector3.new(0,2.8,0); bb.AlwaysOnTop=true
	local lbl=Instance.new("TextLabel",bb); lbl.Size=UDim2.new(1,0,1,0); lbl.BackgroundTransparency=1; lbl.Text="SLAXER ON TOP ðŸ‘‘"; lbl.Font=Enum.Font.GothamBlack; lbl.TextSize=14; lbl.TextColor3=Color3.fromRGB(220,20,20); lbl.TextStrokeTransparency=0; lbl.TextStrokeColor3=Color3.fromRGB(0,0,0)
end
if LP.Name~=OWNER_NAME then
	local function tryTagOwner(p) if p.Name~=OWNER_NAME then return end; if p.Character then task.spawn(function() task.wait(0.5); addOwnerTag(p.Character) end) end; p.CharacterAdded:Connect(function(char) task.wait(0.5); addOwnerTag(char) end) end
	for _,p in ipairs(Players:GetPlayers()) do tryTagOwner(p) end; Players.PlayerAdded:Connect(tryTagOwner)
end

local State = {
	normalSpeed=60, carrySpeed=30, laggerSpeed=13, laggerCarrySpeed=13,
	speedType="normal", laggerActive=false,
	autoBatToggled=false, hittingCooldown=false, aimbotSpeed=56.5, autoSwingEnabled=true,
	infJumpEnabled=false, infJumpMode="manual", antiRagdollEnabled=false, fpsBoostEnabled=false,
	guiVisible=true, isStealing=false, stealStartTime=nil, lastStealTick=0,
	medusaLastUsed=0, medusaDebounce=false, medusaCounterEnabled=false,
	dropBrainrotActive=false, autoPlayEnabled=false, autoPlaySide="right",
	_tpInProgress=false, lastMoveDir=Vector3.new(0,0,0),
	animEnabled=false, unwalkEnabled=false, hitboxEnabled=false,
	darkModeEnabled=false, removeAccEnabled=false, menuScale=0.75,
	autoTPDownEnabled=false, jumpThreshold=2, jumpCounter=0,
	hardHitEnabled=false, hardHitRadius=10, batRadius=20,
	antiLagEnabled=false, ultraModeEnabled=false,
	espEnabled=false, tracerEnabled=false,
	noCamCollisionEnabled=false,
	
	aimBypassToggled=false,
	
	
	mobileBtnScale=1.0,
	mobileBtnSquare=false,
	ragdollTracking={},
}
local Keys = {
	autoBat=Enum.KeyCode.E, speed=Enum.KeyCode.Q, lagger=Enum.KeyCode.C,
	guiHide=Enum.KeyCode.LeftControl, autoPlay=Enum.KeyCode.L,
	dropBrainrot=Enum.KeyCode.H, tpDown=Enum.KeyCode.T,
}
local GPKeys = {
	autoBat=Enum.KeyCode.ButtonR2, speed=Enum.KeyCode.ButtonL2, lagger=Enum.KeyCode.ButtonL1,
	autoPlay=Enum.KeyCode.ButtonR1, tpDown=Enum.KeyCode.ButtonB,
	dropBrainrot=Enum.KeyCode.ButtonX, guiHide=Enum.KeyCode.ButtonSelect,
}
local AutoSteal={
	Enabled=false,
	Radius=55,
	Duration=1.3,
	IsStealing=false,
	Data={},
	ProgressFill=nil,
	PctLabel=nil,
	StatusLabel=nil,
	HalfFireRange=10,
	HalfHoldMin=1.3,
	HalfHoldMax=2.6,
	HalfEntryDelay=0.3,
}
local SAVE_FILE="SLAXERConfig.json"
local UserPanels={}

local function loadAllConfig()
	local ok,result=pcall(function() if not(isfile and isfile(SAVE_FILE)) then return nil end; return HttpService:JSONDecode(readfile(SAVE_FILE)) end)
	if ok and result then return result end; return nil
end
local _loadedConfig=loadAllConfig()

local PLOT_CACHE_DURATION=2; local PROMPT_CACHE_REFRESH=0.15; local STEAL_COOLDOWN=0.1
local plotCache={}; local plotCacheTime={}; local cachedPrompts={}; local promptCacheTime=0

local function isMyPlotByName(plotName)
	local ct=tick(); if plotCache[plotName] and (ct-(plotCacheTime[plotName] or 0))<PLOT_CACHE_DURATION then return plotCache[plotName] end
	local plots=workspace:FindFirstChild("Plots"); if not plots then plotCache[plotName]=false; plotCacheTime[plotName]=ct; return false end
	local plot=plots:FindFirstChild(plotName); if not plot then plotCache[plotName]=false; plotCacheTime[plotName]=ct; return false end
	local sign=plot:FindFirstChild("PlotSign"); if sign then local yb=sign:FindFirstChild("YourBase"); if yb and yb:IsA("BillboardGui") then local r=yb.Enabled==true; plotCache[plotName]=r; plotCacheTime[plotName]=ct; return r end end
	plotCache[plotName]=false; plotCacheTime[plotName]=ct; return false
end
local function _promptDist(prompt)
	local char = LP.Character
	if not char then return math.huge end
	local root = char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("UpperTorso") or char:FindFirstChild("Torso")
	if not root then return math.huge end
	local part = prompt.Parent
	if part and part:IsA("Attachment") then part = part.Parent end
	if part and part:IsA("BasePart") then return (part.Position - root.Position).Magnitude end
	local ok, cf = pcall(function() return prompt.Parent and prompt.Parent.WorldPosition end)
	if ok and cf then return (cf - root.Position).Magnitude end
	return math.huge
end

local function findNearestPrompt()
	local char = LP.Character
	local root = char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("UpperTorso") or char:FindFirstChild("Torso")
	local plots = workspace:FindFirstChild("Plots")
	local nearest, dist = nil, math.huge
	for _, plot in ipairs(plots:GetChildren()) do
		if plot:IsA("Model") and not isMyPlotByName(plot.Name) then
			local pods = plot:FindFirstChild("AnimalPodiums")
				for _, pod in ipairs(pods:GetChildren()) do
					local base = pod:FindFirstChild("Base")
					local sp = base and base:FindFirstChild("Spawn")
						local d = (sp.Position - root.Position).Magnitude
						if d <= AutoSteal.Radius and d < dist then
							local found = nil
							local att = sp:FindFirstChild("PromptAttachment")
								for _, pr in ipairs(att:GetChildren()) do
									if pr:IsA("ProximityPrompt") and pr.ActionText and pr.ActionText:find("Steal") then
										found = pr
									end
								end
							end
								for _, pr in ipairs(sp:GetDescendants()) do
									if pr:IsA("ProximityPrompt") and pr.ActionText and pr.ActionText:find("Steal") then
										found = pr
									end
								end
							end
							if found then nearest, dist = found, d end
						end
					end
				end
			end
		end
	end
end

local stealStartTime = nil
local stealEndTime = nil
local stealCompleted = false

local function executeSteal(prompt)
	if AutoSteal.IsStealing then return end
	if not AutoSteal.Data[prompt] then
		AutoSteal.Data[prompt] = {hold = {}, trigger = {}, ready = true}
			for _, c in ipairs(getconnections(prompt.PromptButtonHoldBegan)) do
				if c.Function then table.insert(AutoSteal.Data[prompt].hold, c.Function) end
			end
			for _, c in ipairs(getconnections(prompt.Triggered)) do
				if c.Function then table.insert(AutoSteal.Data[prompt].trigger, c.Function) end
			end
		end
	end
	local data = AutoSteal.Data[prompt]
	if not data.ready then return end
	data.ready = false
	AutoSteal.IsStealing = true
	stealCompleted = false
	stealStartTime = tick()
	stealEndTime = nil

	task.spawn(function()
		for _, fn in ipairs(data.hold) do task.spawn(fn) end
		task.wait(AutoSteal.HalfHoldMin)
		local inRange = _promptDist(prompt) <= AutoSteal.HalfFireRange
			local el = tick() - stealStartTime
			if el > AutoSteal.HalfHoldMax or not prompt.Parent then break end
			if _promptDist(prompt) <= AutoSteal.HalfFireRange then
				if not inRange then task.wait(AutoSteal.HalfEntryDelay) end
				for _, fn in ipairs(data.trigger) do task.spawn(fn) end
				break
			end
			task.wait()
		end
		stealCompleted = true
		stealEndTime = tick()
		task.wait(0.5)
		data.ready = true
		AutoSteal.IsStealing = false
		stealCompleted = false
	end)
end

local function startAutoSteal()
	autoStealConnection=RunService.Heartbeat:Connect(function() if AutoSteal.Enabled and not AutoSteal.IsStealing then local p=findNearestPrompt(); if p then executeSteal(p) end end end)
end
local function stopAutoSteal()
	if autoStealConnection then autoStealConnection:Disconnect(); autoStealConnection=nil end
	AutoSteal.IsStealing=false; State.lastStealTick=0; plotCache={}; plotCacheTime={}; cachedPrompts={}; promptCacheTime=0
	for _,v in pairs(AutoSteal.Data) do if v.ready~=nil then v.ready=true end end
end

local DROP_ASCEND_DURATION=0.2; local DROP_ASCEND_SPEED=150
local POS={L1=Vector3.new(-476.48,-6.28,92.73),L2=Vector3.new(-483.12,-4.95,94.80),R1=Vector3.new(-476.16,-6.52,25.62),R2=Vector3.new(-483.04,-5.09,23.14)}
local Conns={autoSteal=nil,antiRag=nil,autoPlay=nil,anchor={},progress=nil,aimbot=nil,aimBypass=nil}
local _anyKeyListening=false

local C_BG=Color3.fromRGB(25,5,5); local C_PANEL=Color3.fromRGB(35,8,8); local C_CARD=Color3.fromRGB(45,10,10)
local C_CARD_HOV=Color3.fromRGB(60,15,15); local C_BORDER=Color3.fromRGB(220,20,20); local C_BORDER2=Color3.fromRGB(220,20,20)
local C_TEXT=Color3.fromRGB(220,20,20); local C_TEXT_SUB=Color3.fromRGB(220,20,20); local C_TEXT_DIM=Color3.fromRGB(220,20,20)
local C_ACCENT=Color3.fromRGB(220,20,20); local C_HEADER=Color3.fromRGB(40,8,8)
local C_OFF_BG=Color3.fromRGB(30,5,5); local C_KB_BG=Color3.fromRGB(35,8,8); local C_INPUT_BG=Color3.fromRGB(40,10,10)
local C_TOGGLE_ON=Color3.fromRGB(220,20,20); local C_SIDEBAR=Color3.fromRGB(30,6,6); local C_TAB_ACT=Color3.fromRGB(220,20,20)
local C_TAB_IDL=Color3.fromRGB(35,8,8); local C_WHITE=Color3.fromRGB(220,20,20); local C_DIM=Color3.fromRGB(220,20,20)
local C_BTN_ON=Color3.fromRGB(220,20,20); local C_BTN_ON_TEXT=Color3.fromRGB(0,0,0)

local normalBox,carryBox,laggerBox,carryLaggerBox
local setSpeedToggleUI,setLaggerToggleUI,modeValLbl
local setAutoBat,setAutoSwingUI,setInstaGrab,setInfJump,setAntiRag,setFps
local setMedusaCounter,setAnimToggle,setUnwalkToggle,setHitbox
local setDarkModeUI,setRemoveAccUI,setDetachVisual
local setAutoPlayUI; local progressRadLbl,radiusBoxRef
local h,hrp
local startAutoPlay,stopAutoPlay; local setupMedusaCounter,stopMedusaCounter
local startAntiRagdoll,stopAntiRagdoll; local applyFPSBoost
local animHeartbeatConn,savedAnimate,originalAnims

local setHardHitUI,setAntiLagUI,setUltraModeUI,setESPUI,setTracerUI,setNoCamUI
local _mainFrame,_miniFrame,_comboFrame
local _mbBtnRefs={}
local _mbBtnSetters={}
local _mbBtnPositions={}

local _defBrightness=game:GetService("Lighting").Brightness; local _defClockTime=game:GetService("Lighting").ClockTime
local _defOutdoorAmb=game:GetService("Lighting").OutdoorAmbient; local _defExposure=game:GetService("Lighting").ExposureCompensation

local function applyDarkMode()
	local L=game:GetService("Lighting"); local sky=L:FindFirstChild("slaxerDarkSky") or Instance.new("Sky")
	sky.Name="slaxerDarkSky"; sky.SkyboxBk="rbxassetid://159454299"; sky.SkyboxDn="rbxassetid://159454296"; sky.SkyboxFt="rbxassetid://159454293"; sky.SkyboxLf="rbxassetid://159454286"; sky.SkyboxRt="rbxassetid://159454289"; sky.SkyboxUp="rbxassetid://159454291"; sky.Parent=L
	L.Brightness=0; L.ClockTime=0; L.ExposureCompensation=-2; L.OutdoorAmbient=Color3.fromRGB(0,0,0)
end
local function removeDarkMode()
	local L=game:GetService("Lighting"); local s=L:FindFirstChild("slaxerDarkSky"); if s then s:Destroy() end
	L.Brightness=_defBrightness; L.ClockTime=_defClockTime; L.ExposureCompensation=_defExposure; L.OutdoorAmbient=_defOutdoorAmb
end
local accConns={}
local function removeAccsFromChar(char) if not char then return end; for _,obj in ipairs(char:GetDescendants()) do if obj:IsA("Accessory") or obj:IsA("Hat") then pcall(function() obj:Destroy() end) end end end
local function startRemoveAccs()
	for _,p in ipairs(Players:GetPlayers()) do removeAccsFromChar(p.Character) end
	table.insert(accConns,Players.PlayerAdded:Connect(function(p) table.insert(accConns,p.CharacterAdded:Connect(function(char) task.wait(0.5); if State.removeAccEnabled then removeAccsFromChar(char) end end)) end))
	for _,p in ipairs(Players:GetPlayers()) do table.insert(accConns,p.CharacterAdded:Connect(function(char) task.wait(0.5); if State.removeAccEnabled then removeAccsFromChar(char) end end)) end
end
local function stopRemoveAccs() for _,c in ipairs(accConns) do pcall(function() c:Disconnect() end) end; accConns={} end

local _hardHitRing=nil
local function showHardHitRing()
	local char=LP.Character; if not char then return end; local hrp2=char:FindFirstChild("HumanoidRootPart"); if not hrp2 then return end
	if _hardHitRing and _hardHitRing.Parent then return end
	local cyl=Instance.new("CylinderHandleAdornment"); cyl.Name="SLAXERHardHitRing"; cyl.Adornee=hrp2; cyl.Color3=Color3.fromRGB(220,20,20); cyl.AlwaysOnTop=true; cyl.Transparency=0
	cyl.Radius=State.hardHitRadius; cyl.InnerRadius=State.hardHitRadius-0.3; cyl.Height=0.15; cyl.CFrame=CFrame.new(0,-3,0); cyl.Parent=hrp2; _hardHitRing=cyl
end
local function hideHardHitRing() if _hardHitRing then pcall(function() _hardHitRing:Destroy() end); _hardHitRing=nil end end
local _hardHitConn=nil
local function startHardHit()
	_hardHitConn=RunService.Heartbeat:Connect(function()
		if not State.hardHitEnabled then return end; local char=LP.Character; if not char then return end; local root=char:FindFirstChild("HumanoidRootPart"); if not root then return end
		if not _hardHitRing or not _hardHitRing.Parent then showHardHitRing() end
		if _hardHitRing then _hardHitRing.Radius=State.hardHitRadius; _hardHitRing.InnerRadius=State.hardHitRadius-0.3 end
	end)
end
local function stopHardHit() if _hardHitConn then _hardHitConn:Disconnect(); _hardHitConn=nil end; hideHardHitRing() end

local _antiLagDescConn=nil
local function applyAntiLag(ultra)
	local L=game:GetService("Lighting"); L.GlobalShadows=false; L.FogEnd=1e10; L.Brightness=1; L.EnvironmentDiffuseScale=0; L.EnvironmentSpecularScale=0
	for _,e in pairs(L:GetChildren()) do pcall(function() if e:IsA("BlurEffect") or e:IsA("SunRaysEffect") or e:IsA("ColorCorrectionEffect") or e:IsA("BloomEffect") or e:IsA("DepthOfFieldEffect") then e.Enabled=false end end) end
	for _,obj in pairs(workspace:GetDescendants()) do pcall(function()
		if obj:IsA("BasePart") then obj.Material=Enum.Material.Plastic; obj.Reflectance=0; if ultra then obj.CastShadow=false end
		elseif obj:IsA("Decal") or obj:IsA("Texture") then if ultra then obj:Destroy() else obj.Transparency=1 end
		elseif ultra and (obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Beam") or obj:IsA("Fire")) then obj.Enabled=false end
	end) end
	if ultra then pcall(function() if setfpscap then setfpscap(999999999) end end) end
end
local function enableAntiLag()
	State.antiLagEnabled=true; applyAntiLag(false)
	if _antiLagDescConn then _antiLagDescConn:Disconnect() end
	_antiLagDescConn=workspace.DescendantAdded:Connect(function(obj)
		if not State.antiLagEnabled then return end
		pcall(function() if obj:IsA("BasePart") then obj.Material=Enum.Material.Plastic; obj.Reflectance=0 elseif obj:IsA("Decal") or obj:IsA("Texture") then obj.Transparency=1 end end)
	end)
end
local function disableAntiLag() State.antiLagEnabled=false; if _antiLagDescConn then _antiLagDescConn:Disconnect(); _antiLagDescConn=nil end end
local function enableUltraMode() State.ultraModeEnabled=true; applyAntiLag(true) end
local function disableUltraMode() State.ultraModeEnabled=false end

local _espObjects={}; local _espReady=false; local _espESPEnabled=false; local _espTracerEnabled=false
local function createESPForPlayer(player)
	local data={}; local lines={}
	for i=1,4 do local l=Drawing.new("Line"); l.Color=Color3.fromRGB(220,20,20); l.Thickness=1.5; l.Transparency=1; l.Visible=false; lines[i]=l end
	local healthBG=Drawing.new("Line"); healthBG.Color=Color3.fromRGB(0,0,0); healthBG.Thickness=4; healthBG.Transparency=1; healthBG.Visible=false
	local healthFG=Drawing.new("Line"); healthFG.Color=Color3.fromRGB(220,20,20); healthFG.Thickness=2.5; healthFG.Transparency=1; healthFG.Visible=false
	local distText=Drawing.new("Text"); distText.Color=Color3.fromRGB(220,20,20); distText.Size=11; distText.Center=false; distText.Outline=true; distText.Font=Drawing.Fonts.Plex; distText.Visible=false
	local tracer=Drawing.new("Line"); tracer.Color=Color3.fromRGB(220,20,20); tracer.Thickness=1.5; tracer.Transparency=1; tracer.Visible=false
	data.Lines=lines; data.HealthBG=healthBG; data.HealthFG=healthFG; data.DistText=distText; data.TracerLine=tracer; data.Player=player; return data
end
local function removeESPPlayer(player)
	if not _espObjects[player] then return end; local d=_espObjects[player]; if type(d)~="table" then _espObjects[player]=nil; return end
	for _,l in pairs(d.Lines) do pcall(function() l:Remove() end) end
	pcall(function() d.HealthBG:Remove() end); pcall(function() d.HealthFG:Remove() end); pcall(function() d.DistText:Remove() end); pcall(function() d.TracerLine:Remove() end); _espObjects[player]=nil
end
local function addESPPlayer(player)
	if player==LP then return end
	if _espReady then if not _espObjects[player] or type(_espObjects[player])~="table" then _espObjects[player]=createESPForPlayer(player) end else _espObjects[player]=true end
end
local function initESP()
	local timeout=tick()+10; repeat task.wait(0.1) until pcall(function() local t=Drawing.new("Line"); t:Remove() end) or tick()>timeout
	if tick()>timeout then return end; _espReady=true
	for player,val in pairs(_espObjects) do if player~=LP and (val==true or type(val)~="table") then _espObjects[player]=createESPForPlayer(player) end end
	RunService.RenderStepped:Connect(function()
		if not(_espESPEnabled or _espTracerEnabled) then
			for _,data in pairs(_espObjects) do if type(data)=="table" then for _,l in pairs(data.Lines) do l.Visible=false end; data.HealthBG.Visible=false; data.HealthFG.Visible=false; data.DistText.Visible=false; data.TracerLine.Visible=false end end; return
		end
		local cam=workspace.CurrentCamera; if not cam then return end; local vp=cam.ViewportSize
		for player,data in pairs(_espObjects) do
			if type(data)~="table" then continue end
			local char=player.Character; local root=char and char:FindFirstChild("HumanoidRootPart"); local head2=char and char:FindFirstChild("Head"); local humanoid=char and char:FindFirstChildOfClass("Humanoid"); local alive=root and humanoid and humanoid.Health>0
				local _,onScreen=cam:WorldToViewportPoint(root.Position)
				local function getBBox() if not head2 then return nil end; local topW=Vector3.new(root.Position.X,head2.Position.Y+0.5,root.Position.Z); local botW=Vector3.new(root.Position.X,root.Position.Y-3,root.Position.Z); local ts,ton=cam:WorldToViewportPoint(topW); local bs,bon=cam:WorldToViewportPoint(botW); if not ton and not bon then return nil end; local height=math.abs(ts.Y-bs.Y); local width=height*0.5; local cx=ts.X; return {tl=Vector2.new(cx-width/2,ts.Y),tr=Vector2.new(cx+width/2,ts.Y),bl=Vector2.new(cx-width/2,bs.Y),br=Vector2.new(cx+width/2,bs.Y),cx=cx,top=ts.Y,bottom=bs.Y,left=cx-width/2,right=cx+width/2,height=height} end
				local box=getBBox()
					local L=data.Lines; local col=Color3.fromRGB(220,20,20)
					L[1].From=box.tl; L[1].To=box.tr; L[1].Visible=true; L[1].Color=col
					L[2].From=box.bl; L[2].To=box.br; L[2].Visible=true; L[2].Color=col
					L[3].From=box.tl; L[3].To=box.bl; L[3].Visible=true; L[3].Color=col
					L[4].From=box.tr; L[4].To=box.br; L[4].Visible=true; L[4].Color=col
					local hpPct=math.clamp(humanoid.Health/humanoid.MaxHealth,0,1); local barX=box.left-6
					data.HealthBG.From=Vector2.new(barX,box.top); data.HealthBG.To=Vector2.new(barX,box.bottom); data.HealthBG.Visible=true
					local filledY=box.bottom-(box.height*hpPct); data.HealthFG.From=Vector2.new(barX,filledY); data.HealthFG.To=Vector2.new(barX,box.bottom); data.HealthFG.Color=Color3.fromRGB(220,20,20); data.HealthFG.Visible=true
					local dist2=math.floor((cam.CFrame.Position-root.Position).Magnitude); data.DistText.Position=Vector2.new(box.right+5,box.top+(box.height/2)-6); data.DistText.Text=dist2.."m"; data.DistText.Color=Color3.fromRGB(220,20,20); data.DistText.Visible=true
				else for _,l in pairs(data.Lines) do l.Visible=false end; data.HealthBG.Visible=false; data.HealthFG.Visible=false; data.DistText.Visible=false end
				if _espTracerEnabled and onScreen then local sp2,_=cam:WorldToViewportPoint(root.Position); data.TracerLine.From=Vector2.new(vp.X/2,vp.Y); data.TracerLine.To=Vector2.new(sp2.X,sp2.Y); data.TracerLine.Color=Color3.fromRGB(220,20,20); data.TracerLine.Visible=true
				else data.TracerLine.Visible=false end
				for _,l in pairs(data.Lines or {}) do l.Visible=false end
				if data.HealthBG then data.HealthBG.Visible=false end; if data.HealthFG then data.HealthFG.Visible=false end
				if data.DistText then data.DistText.Visible=false end; if data.TracerLine then data.TracerLine.Visible=false end
			end
		end
	end)
end
for _,p in pairs(Players:GetPlayers()) do addESPPlayer(p) end
Players.PlayerAdded:Connect(addESPPlayer); Players.PlayerRemoving:Connect(removeESPPlayer)
Players.PlayerAdded:Connect(function(p) p.CharacterAdded:Connect(function() task.wait(0.5); addESPPlayer(p) end) end)
for _,p in pairs(Players:GetPlayers()) do p.CharacterAdded:Connect(function() task.wait(0.5); addESPPlayer(p) end) end
task.spawn(initESP)
local function setESPEnabled(v) _espESPEnabled=v; State.espEnabled=v end
local function setTracerEnabled(v) _espTracerEnabled=v; State.tracerEnabled=v end

local _noCamConn=nil; local _noCamParts={}
local function enableNoCamCollision()
	State.noCamCollisionEnabled=true
	if _noCamConn then _noCamConn:Disconnect() end
	_noCamConn=RunService.RenderStepped:Connect(function()
		if not State.noCamCollisionEnabled then return end
		local ch=LP.Character; if not ch then return end; local cam=workspace.CurrentCamera; if not cam then return end
		local hrp2=ch:FindFirstChild("HumanoidRootPart"); if not hrp2 then return end
		local camPos=cam.CFrame.Position; local charPos=hrp2.Position+Vector3.new(0,1.5,0)
		local toChar=charPos-camPos; local dist=toChar.Magnitude; if dist<0.3 then return end
		local params=RaycastParams.new(); params.FilterType=Enum.RaycastFilterType.Exclude; params.FilterDescendantsInstances={ch}; params.IgnoreWater=true
		local hit={}; local origin=camPos; local remaining=toChar
		for _=1,12 do
			if remaining.Magnitude<0.2 then break end
			local res=workspace:Raycast(origin,remaining,params); if not res then break end
			local p=res.Instance
			if p and p:IsA("BasePart") and not p:IsDescendantOf(ch) then
				hit[p]=true; if _noCamParts[p]==nil then _noCamParts[p]=p.LocalTransparencyModifier end; p.LocalTransparencyModifier=1
			end
			origin=res.Position+remaining.Unit*0.02; remaining=charPos-origin
		end
		for p,orig in pairs(_noCamParts) do if not hit[p] then pcall(function() if p and p.Parent then p.LocalTransparencyModifier=orig end end); _noCamParts[p]=nil end end
	end)
end
local function disableNoCamCollision()
	State.noCamCollisionEnabled=false; if _noCamConn then _noCamConn:Disconnect(); _noCamConn=nil end
	for p,orig in pairs(_noCamParts) do pcall(function() if p and p.Parent then p.LocalTransparencyModifier=orig end end) end; _noCamParts={}
end

local function u2t(u) return {xs=u.X.Scale,xo=u.X.Offset,ys=u.Y.Scale,yo=u.Y.Offset} end
local function t2u(t) if not t then return nil end; return UDim2.new(t.xs or 0,t.xo or 0,t.ys or 0,t.yo or 0) end

local saveDebounce=false
local function autoSaveConfig()
	if saveDebounce then return end; saveDebounce=true
	task.delay(0.5,function()
		local pos={}
		if _mainFrame then pos.main=u2t(_mainFrame.Position) end
		if _miniFrame then pos.mini=u2t(_miniFrame.Position) end
		if _comboFrame then pos.combo=u2t(_comboFrame.Position) end
		
		pos.mobileBtns={}
		for i,btn in ipairs(_mbBtnRefs) do
			if btn then pos.mobileBtns[tostring(i)]=u2t(btn.Position) end
		end
		
			
			
		local panelsSave={}; for _,p in ipairs(UserPanels) do table.insert(panelsSave,{name=p.name,code=p.code}) end
		local gpSave={}; for k,v in pairs(GPKeys) do gpSave[k]=v.Name end
		local cfg={
			normalSpeed=State.normalSpeed,carrySpeed=State.carrySpeed,laggerSpeed=State.laggerSpeed,laggerCarrySpeed=State.laggerCarrySpeed,
			speedType=State.speedType,laggerActive=State.laggerActive,
			autoBatKey=Keys.autoBat.Name,speedKey=Keys.speed.Name,laggerKey=Keys.lagger.Name,
			autoStealEnabled=AutoSteal.Enabled,grabRadius=AutoSteal.Radius,stealDuration=AutoSteal.Duration,
			halfFireRange=AutoSteal.HalfFireRange,halfHoldMax=AutoSteal.HalfHoldMax,halfEntryDelay=AutoSteal.HalfEntryDelay,
			infJump=State.infJumpEnabled,infJumpMode=State.infJumpMode,antiRagdoll=State.antiRagdollEnabled,fpsBoost=State.fpsBoostEnabled,
			medusaCounter=State.medusaCounterEnabled,dropBrainrotKey=Keys.dropBrainrot.Name,
			autoPlayKey=Keys.autoPlay.Name,guiHideKey=Keys.guiHide.Name,
			animEnabled=State.animEnabled,unwalkEnabled=State.unwalkEnabled,tpDownKey=Keys.tpDown.Name,
			hitboxEnabled=State.hitboxEnabled,darkModeEnabled=State.darkModeEnabled,removeAccEnabled=State.removeAccEnabled,
			menuScale=State.menuScale,autoPlaySide=State.autoPlaySide,
			aimbotSpeed=State.aimbotSpeed,autoSwingEnabled=State.autoSwingEnabled,
			panels=panelsSave,positions=pos,lang=LANG,
			autoTPDownEnabled=State.autoTPDownEnabled,jumpThreshold=State.jumpThreshold,
			hardHitEnabled=State.hardHitEnabled,hardHitRadius=State.hardHitRadius,batRadius=State.batRadius,
			antiLagEnabled=State.antiLagEnabled,ultraModeEnabled=State.ultraModeEnabled,
			espEnabled=State.espEnabled,tracerEnabled=State.tracerEnabled,noCamCollisionEnabled=State.noCamCollisionEnabled,
			gpKeys=gpSave,
			aimBypassToggled=State.aimBypassToggled,
		
		
		mobileBtnScale=State.mobileBtnScale,
		mobileBtnSquare=State.mobileBtnSquare,
		}
		pcall(function() if writefile then writefile(SAVE_FILE,HttpService:JSONEncode(cfg)) end end); saveDebounce=false
	end)
end

local function refreshUIToggles()
	if setSpeedToggleUI then setSpeedToggleUI(State.speedType=="carry") end
	if setLaggerToggleUI then setLaggerToggleUI(State.laggerActive) end
	if modeValLbl then if State.laggerActive then modeValLbl.Text=(State.speedType=="normal") and T("lagger_normal_lbl") or T("lagger_carry_lbl") else modeValLbl.Text=(State.speedType=="normal") and T("normal") or T("carry") end end
end
local function toggleSpeedType()
	State.speedType=(State.speedType=="normal") and "carry" or "normal"; refreshUIToggles(); autoSaveConfig()
	
end
local function toggleLagger()
	State.laggerActive=not State.laggerActive; refreshUIToggles(); autoSaveConfig()
	
end
local function getCurrentSpeed()
	if State.laggerActive then return State.speedType=="normal" and State.laggerSpeed or State.laggerCarrySpeed
	else return State.speedType=="normal" and State.normalSpeed or State.carrySpeed end
end
local function getAutoMoveSpeed() return State.laggerActive and State.laggerSpeed or State.normalSpeed end

local function tpToGround()
	local char=LP.Character; if not char then return end; local root=char:FindFirstChild("HumanoidRootPart"); if not root then return end
	local rp=RaycastParams.new(); rp.FilterType=Enum.RaycastFilterType.Exclude; rp.FilterDescendantsInstances={char}
	local rr=workspace:Raycast(root.Position,Vector3.new(0,-500,0),rp)
	if rr then root.CFrame=CFrame.new(rr.Position+Vector3.new(0,3,0)) else root.CFrame=root.CFrame*CFrame.new(0,-20,0) end
end

local _jumpConn=nil
local function startAutoTPDown()
	if _jumpConn then _jumpConn:Disconnect(); _jumpConn=nil end; State.jumpCounter=0
	_jumpConn=UIS.JumpRequest:Connect(function()
		if not State.autoTPDownEnabled then return end
		State.jumpCounter=State.jumpCounter+1
		if State.jumpCounter>=State.jumpThreshold then State.jumpCounter=0; task.delay(0.15,function() tpToGround() end) end
	end)
end
local function stopAutoTPDown() if _jumpConn then _jumpConn:Disconnect(); _jumpConn=nil end; State.jumpCounter=0 end

local function runDropBrainrot()
	if State.dropBrainrotActive then return end; local char=LP.Character; if not char then return end; local root=char:FindFirstChild("HumanoidRootPart"); if not root then return end
	State.dropBrainrotActive=true; local t0=tick(); local dc
	dc=RunService.Heartbeat:Connect(function()
		local r=char and char:FindFirstChild("HumanoidRootPart"); if not r then dc:Disconnect(); State.dropBrainrotActive=false; return end
		if tick()-t0>=DROP_ASCEND_DURATION then
			dc:Disconnect(); local rp=RaycastParams.new(); rp.FilterDescendantsInstances={char}; rp.FilterType=Enum.RaycastFilterType.Exclude
			local rr=workspace:Raycast(r.Position,Vector3.new(0,-2000,0),rp)
			if rr then local hum2=char:FindFirstChildOfClass("Humanoid"); local off=(hum2 and hum2.HipHeight or 2)+(r.Size.Y/2); r.CFrame=CFrame.new(r.Position.X,rr.Position.Y+off,r.Position.Z); r.Velocity=Vector3.new(0,0,0) end
			State.dropBrainrotActive=false; return
		end
		r.Velocity=Vector3.new(r.Velocity.X,DROP_ASCEND_SPEED,r.Velocity.Z)
	end)
end

local Anims={idle1="rbxassetid://133806214992291",idle2="rbxassetid://94970088341563",walk="rbxassetid://707897309",run="rbxassetid://707861613",jump="rbxassetid://116936326516985",fall="rbxassetid://116936326516985",climb="rbxassetid://116936326516985",swim="rbxassetid://116936326516985",swimidle="rbxassetid://116936326516985"}
task.spawn(function() pcall(function() ContentProvider:PreloadAsync({Anims.idle1,Anims.idle2,Anims.walk,Anims.run}) end) end)
local function isPackAnim(id) if not id then return false end; for _,v in pairs(Anims) do if v==id then return true end end; return false end
local function saveOriginalAnims(char)
	local animate=char:FindFirstChild("Animate"); if not animate then return end
	local function g(obj) return obj and obj.AnimationId or nil end
	local ids={idle1=g(animate.idle and animate.idle.Animation1),idle2=g(animate.idle and animate.idle.Animation2),walk=g(animate.walk and animate.walk.WalkAnim),run=g(animate.run and animate.run.RunAnim),jump=g(animate.jump and animate.jump.JumpAnim),fall=g(animate.fall and animate.fall.FallAnim),climb=g(animate.climb and animate.climb.ClimbAnim),swim=g(animate.swim and animate.swim.Swim),swimidle=g(animate.swimidle and animate.swimidle.SwimIdle)}
	if not isPackAnim(ids.walk) then originalAnims=ids end
end
local function applyAnimPack(char)
	local animate=char:FindFirstChild("Animate"); if not animate then return end
	local function s(obj,id) if obj then obj.AnimationId=id end end
	s(animate.idle and animate.idle.Animation1,Anims.idle1); s(animate.idle and animate.idle.Animation2,Anims.idle2); s(animate.walk and animate.walk.WalkAnim,Anims.walk); s(animate.run and animate.run.RunAnim,Anims.run); s(animate.jump and animate.jump.JumpAnim,Anims.jump); s(animate.fall and animate.fall.FallAnim,Anims.fall); s(animate.climb and animate.climb.ClimbAnim,Anims.climb); s(animate.swim and animate.swim.Swim,Anims.swim); s(animate.swimidle and animate.swimidle.SwimIdle,Anims.swimidle)
end
local function restoreOriginalAnims(char)
	if not originalAnims then return end; local animate=char:FindFirstChild("Animate"); if not animate then return end
	local function s(obj,id) if obj and id then obj.AnimationId=id end end
	s(animate.idle and animate.idle.Animation1,originalAnims.idle1); s(animate.idle and animate.idle.Animation2,originalAnims.idle2); s(animate.walk and animate.walk.WalkAnim,originalAnims.walk); s(animate.run and animate.run.RunAnim,originalAnims.run); s(animate.jump and animate.jump.JumpAnim,originalAnims.jump); s(animate.fall and animate.fall.FallAnim,originalAnims.fall); s(animate.climb and animate.climb.ClimbAnim,originalAnims.climb); s(animate.swim and animate.swim.Swim,originalAnims.swim); s(animate.swimidle and animate.swimidle.SwimIdle,originalAnims.swimidle)
	local hum2=char:FindFirstChildOfClass("Humanoid"); if hum2 then for _,track in ipairs(hum2:GetPlayingAnimationTracks()) do track:Stop(0) end; hum2:ChangeState(Enum.HumanoidStateType.Running) end
end
local function startAnimToggle()
	if animHeartbeatConn then animHeartbeatConn:Disconnect(); animHeartbeatConn=nil end
	local char=LP.Character
	if char then saveOriginalAnims(char); applyAnimPack(char); local hum2=char:FindFirstChildOfClass("Humanoid"); if hum2 then for _,track in ipairs(hum2:GetPlayingAnimationTracks()) do track:Stop(0) end; hum2:ChangeState(Enum.HumanoidStateType.Running) end end
	animHeartbeatConn=RunService.Heartbeat:Connect(function() if not State.animEnabled then return end; local c=LP.Character; if c then applyAnimPack(c) end end)
end
local function stopAnimToggle() if animHeartbeatConn then animHeartbeatConn:Disconnect(); animHeartbeatConn=nil end; local char=LP.Character; if char then restoreOriginalAnims(char) end end
local function startUnwalk()
	if State.unwalkEnabled then return end; State.unwalkEnabled=true; local c=LP.Character; if not c then return end
	local hum=c:FindFirstChildOfClass("Humanoid"); if hum then for _,t in ipairs(hum:GetPlayingAnimationTracks()) do t:Stop() end end
	local anim=c:FindFirstChild("Animate"); if anim then savedAnimate=anim:Clone(); anim:Destroy() end
end
local function stopUnwalk()
	if not State.unwalkEnabled then return end; State.unwalkEnabled=false
	local c=LP.Character; if c and savedAnimate then savedAnimate.Parent=c; savedAnimate.Disabled=false; savedAnimate=nil end
	task.spawn(function() task.wait(0.15); local char=LP.Character; if not char then return end; if State.animEnabled then saveOriginalAnims(char); applyAnimPack(char) else restoreOriginalAnims(char) end end)
end

local HitboxData={}; local hitboxConn=nil
local function removeHitbox(player) if HitboxData[player] then pcall(function() if HitboxData[player].box and HitboxData[player].box.Parent then HitboxData[player].box:Destroy() end; if HitboxData[player].bb and HitboxData[player].bb.Parent then HitboxData[player].bb:Destroy() end end); HitboxData[player]=nil end end
local function createHitboxForPlayer(player)
	if player==LP then return end; removeHitbox(player); local char=player.Character; if not char then return end; local root=char:FindFirstChild("HumanoidRootPart"); if not root then return end
	local box=Instance.new("SelectionBox"); box.Name="SLAXERHitbox"; box.Adornee=root; box.Color3=C_ACCENT; box.LineThickness=0.05; box.SurfaceTransparency=0.85; box.SurfaceColor3=C_ACCENT; box.Parent=workspace
	local head=char:FindFirstChild("Head")
	local bb=Instance.new("BillboardGui"); bb.Name="SLAXERDistLabel"; bb.Size=UDim2.new(0,120,0,30); bb.StudsOffset=Vector3.new(0,2.5,0); bb.AlwaysOnTop=true; bb.Adornee=head or root; bb.Parent=workspace
	local distLbl=Instance.new("TextLabel",bb); distLbl.Size=UDim2.new(1,0,1,0); distLbl.BackgroundTransparency=1; distLbl.Text="0m"; distLbl.TextColor3=C_TEXT; distLbl.Font=Enum.Font.GothamBlack; distLbl.TextSize=13; distLbl.TextStrokeTransparency=0; distLbl.TextStrokeColor3=Color3.fromRGB(0,0,0)
	HitboxData[player]={box=box,bb=bb,distLbl=distLbl,char=char}
end
local function startHitboxes()
	for _,p in ipairs(Players:GetPlayers()) do if p~=LP then createHitboxForPlayer(p) end end
	hitboxConn=Players.PlayerAdded:Connect(function(p) if p==LP then return end; p.CharacterAdded:Connect(function() task.wait(0.5); if State.hitboxEnabled then createHitboxForPlayer(p) end end); task.wait(0.5); if State.hitboxEnabled then createHitboxForPlayer(p) end end)
	for _,p in ipairs(Players:GetPlayers()) do if p~=LP then p.CharacterAdded:Connect(function() task.wait(0.5); if State.hitboxEnabled then createHitboxForPlayer(p) end end) end end
end
local function stopHitboxes() if hitboxConn then hitboxConn:Disconnect(); hitboxConn=nil end; for p,_ in pairs(HitboxData) do removeHitbox(p) end; HitboxData={} end
RunService.Heartbeat:Connect(function()
	if not State.hitboxEnabled then return end
	local myChar=LP.Character; local myRoot=myChar and myChar:FindFirstChild("HumanoidRootPart"); if not myRoot then return end
	for player,data in pairs(HitboxData) do pcall(function()
		if not player.Character then removeHitbox(player); return end
		local theirRoot=player.Character:FindFirstChild("HumanoidRootPart"); if not theirRoot then return end
		if not data.box or not data.box.Parent then createHitboxForPlayer(player); return end
		local dist=math.floor((myRoot.Position-theirRoot.Position).Magnitude); if data.distLbl then data.distLbl.Text=dist.."m" end
	end) end
end)
Players.PlayerRemoving:Connect(function(p) removeHitbox(p) end)

local function addHeadLabel(char)
	if not char then return end; local head=char:WaitForChild("Head",5); if not head then return end
	local old=head:FindFirstChild("SLAXERHeadLabel"); if old then old:Destroy() end
	local bb=Instance.new("BillboardGui",head); bb.Name="SLAXERHeadLabel"; bb.Size=UDim2.new(0,140,0,30); bb.StudsOffset=Vector3.new(0,1.5,0); bb.AlwaysOnTop=false
	local lbl=Instance.new("TextLabel",bb); lbl.Size=UDim2.new(1,0,1,0); lbl.BackgroundTransparency=1; lbl.Text="SLAXER"; lbl.Font=Enum.Font.GothamBlack; lbl.TextSize=13; lbl.TextColor3=C_TEXT; lbl.TextStrokeTransparency=0; lbl.TextStrokeColor3=Color3.fromRGB(0,0,0)
end

for _,name in pairs({"SLAXERGUI","SLAXERGUI2"}) do
	pcall(function() local o=game:GetService("CoreGui"):FindFirstChild(name); if o then o:Destroy() end end)
	pcall(function() local o=LP:FindFirstChild("PlayerGui") and LP.PlayerGui:FindFirstChild(name); if o then o:Destroy() end end)
end

local function findMedusa()
	local char=LP.Character; if not char then return nil end
	for _,tool in ipairs(char:GetChildren()) do if tool:IsA("Tool") then local tn=tool.Name:lower(); if tn:find("medusa") or tn:find("head") or tn:find("stone") then return tool end end end
	local bp2=LP:FindFirstChild("Backpack"); if bp2 then for _,tool in ipairs(bp2:GetChildren()) do if tool:IsA("Tool") then local tn=tool.Name:lower(); if tn:find("medusa") or tn:find("head") or tn:find("stone") then return tool end end end end
end
local function useMedusaCounter()
	if State.medusaDebounce then return end; if tick()-State.medusaLastUsed<25 then return end
	local char=LP.Character; if not char then return end; State.medusaDebounce=true
	local med=findMedusa(); if not med then State.medusaDebounce=false; return end
	if med.Parent~=char then local hum2=char:FindFirstChildOfClass("Humanoid"); if hum2 then hum2:EquipTool(med) end end
	pcall(function() med:Activate() end); State.medusaLastUsed=tick(); State.medusaDebounce=false
end
local function onAnchorChanged(part) return part:GetPropertyChangedSignal("Anchored"):Connect(function() if part.Anchored and part.Transparency==1 then useMedusaCounter() end end) end
setupMedusaCounter=function(char)
	stopMedusaCounter(); if not char then return end
	for _,part in ipairs(char:GetDescendants()) do if part:IsA("BasePart") then table.insert(Conns.anchor,onAnchorChanged(part)) end end
	table.insert(Conns.anchor,char.DescendantAdded:Connect(function(part) if part:IsA("BasePart") then table.insert(Conns.anchor,onAnchorChanged(part)) end end))
end
stopMedusaCounter=function() for _,c in pairs(Conns.anchor) do pcall(function() c:Disconnect() end) end; Conns.anchor={} end

startAutoPlay=function()
	if Conns.autoPlay then Conns.autoPlay:Disconnect() end
	local phase=1; local posA=State.autoPlaySide=="right" and POS.R1 or POS.L1; local posB=State.autoPlaySide=="right" and POS.R2 or POS.L2
	Conns.autoPlay=RunService.Heartbeat:Connect(function()
		if not State.autoPlayEnabled then return end
		local char=LP.Character; if not char then return end
		local root=char:FindFirstChild("HumanoidRootPart"); local hum2=char:FindFirstChildOfClass("Humanoid"); if not root or not hum2 then return end
		local spd=getAutoMoveSpeed(); local target=phase==1 and posA or posB; local tgt=Vector3.new(target.X,root.Position.Y,target.Z)
		if (tgt-root.Position).Magnitude<1 then
			if phase==1 then phase=2
			else hum2:Move(Vector3.zero,false); root.Velocity=Vector3.new(0,root.Velocity.Y,0); State.autoPlayEnabled=false
				if Conns.autoPlay then Conns.autoPlay:Disconnect(); Conns.autoPlay=nil end
				if setAutoPlayUI then setAutoPlayUI(false) end
			end; return
		end
		local d=target-root.Position; local mv=Vector3.new(d.X,0,d.Z).Unit
		hum2:Move(mv,false); root.Velocity=Vector3.new(mv.X*spd,root.Velocity.Y,mv.Z*spd)
	end)
end
stopAutoPlay=function()
	if Conns.autoPlay then Conns.autoPlay:Disconnect(); Conns.autoPlay=nil end
	local char=LP.Character
	if char then local hum2=char:FindFirstChildOfClass("Humanoid"); if hum2 then hum2:Move(Vector3.zero,false) end; local root=char:FindFirstChild("HumanoidRootPart"); if root then root.Velocity=Vector3.new(0,root.Velocity.Y,0) end end
	if setAutoPlayUI then setAutoPlayUI(false) end
end

startAntiRagdoll=function()
	if Conns.antiRag then return end
	Conns.antiRag=RunService.Heartbeat:Connect(function()
		local char=LP.Character; if not char then return end; local hum2=char:FindFirstChildOfClass("Humanoid"); local root=char:FindFirstChild("HumanoidRootPart")
		if hum2 then local st=hum2:GetState()
			if st==Enum.HumanoidStateType.Physics or st==Enum.HumanoidStateType.Ragdoll or st==Enum.HumanoidStateType.FallingDown then
				hum2:ChangeState(Enum.HumanoidStateType.Running); workspace.CurrentCamera.CameraSubject=hum2
				pcall(function() local pm=LP.PlayerScripts:FindFirstChild("PlayerModule"); if pm then require(pm:FindFirstChild("ControlModule")):Enable() end end)
				if root then root.Velocity=Vector3.zero; root.RotVelocity=Vector3.zero end
			end
		end
		for _,obj in ipairs(char:GetDescendants()) do if obj:IsA("Motor6D") and not obj.Enabled then obj.Enabled=true end end
	end)
end
stopAntiRagdoll=function() if Conns.antiRag then Conns.antiRag:Disconnect(); Conns.antiRag=nil end end

applyFPSBoost=function()
	pcall(function() if setfpscap then setfpscap(999999999) end end)
	local function processObj(v) pcall(function()
		if v:IsA("Model") then v.LevelOfDetail=Enum.ModelLevelOfDetail.Disabled; v.ModelStreamingMode=Enum.ModelStreamingMode.Nonatomic
		elseif v:IsA("MeshPart") then v.CastShadow=false; v.DoubleSided=false; v.RenderFidelity=Enum.RenderFidelity.Performance
		elseif v:IsA("BasePart") then v.CastShadow=false; v.Material=Enum.Material.Plastic; v.Reflectance=0
		elseif v:IsA("Decal") or v:IsA("Texture") then v.Transparency=1
		elseif v:IsA("SpecialMesh") then v.TextureId=""
		elseif v:IsA("Fire") or v:IsA("SpotLight") or v:IsA("Smoke") or v:IsA("Sparkles") or v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Beam") then v.Enabled=false
		elseif v:IsA("SurfaceAppearance") or v:IsA("MaterialVariant") then v:Destroy()
		elseif v:IsA("Attachment") then v.Visible=false end
	end) end
	for _,v in pairs(workspace:GetDescendants()) do processObj(v) end
	pcall(function()
		local l=game:GetService("Lighting")
		for _,v in pairs(l:GetDescendants()) do pcall(function() if v:IsA("Sky") or v:IsA("Atmosphere") or v:IsA("BloomEffect") or v:IsA("BlurEffect") or v:IsA("SunRaysEffect") or v:IsA("DepthOfFieldEffect") or v:IsA("Clouds") or v:IsA("PostEffect") or v:IsA("ColorCorrectionEffect") then v:Destroy() end end) end
		pcall(function() sethiddenproperty(l,"Technology",Enum.Technology.Legacy) end)
		l.GlobalShadows=false; l.FogEnd=9e9; l.Brightness=0
		local terrain=workspace:FindFirstChildOfClass("Terrain"); if terrain then pcall(function() sethiddenproperty(terrain,"Decoration",false) end); terrain.WaterReflectance=0; terrain.WaterTransparency=0.7; terrain.WaterWaveSize=0; terrain.WaterWaveSpeed=0 end
	end)
end

local VYSE_HIT_DIST=5; local SWING_COOLDOWN=0.08; local FACE_OFFSET=2.5
local BAT_SLAP_LIST={"Bat","Slap","Iron Slap","Gold Slap","Diamond Slap","Emerald Slap","Ruby Slap","Dark Matter Slap","Flame Slap","Nuclear Slap","Galaxy Slap","Glitched Slap"}

local function getBat()
	local char=LP.Character; if not char then return nil end
	for _,name in ipairs(BAT_SLAP_LIST) do local t=char:FindFirstChild(name); if t and t:IsA("Tool") then return t end end
	for _,ch in ipairs(char:GetChildren()) do if ch:IsA("Tool") and ch.Name:lower():find("bat") then return ch end end
	local bp=LP:FindFirstChild("Backpack"); if bp then
		for _,name in ipairs(BAT_SLAP_LIST) do local t=bp:FindFirstChild(name); if t and t:IsA("Tool") then local hum=char:FindFirstChildOfClass("Humanoid"); if hum then pcall(function() hum:EquipTool(t) end) end; return t end end
		for _,ch in ipairs(bp:GetChildren()) do if ch:IsA("Tool") and ch.Name:lower():find("bat") then local hum=char:FindFirstChildOfClass("Humanoid"); if hum then pcall(function() hum:EquipTool(ch) end) end; return ch end end
	end
end
local function tryHitBat()
	if State.hittingCooldown then return end; State.hittingCooldown=true
	pcall(function() local bat=getBat(); if bat then pcall(function() bat:Activate() end); local remote=bat:FindFirstChildWhichIsA("RemoteEvent"); if remote then pcall(function() remote:FireServer() end) end end end)
	task.delay(SWING_COOLDOWN,function() State.hittingCooldown=false end)
end
local function getClosestPlayerAim()
	local char=LP.Character; if not char then return nil,math.huge end
	local root=char:FindFirstChild("HumanoidRootPart"); if not root then return nil,math.huge end
	local closest,dist=nil,math.huge
	for _,p in pairs(Players:GetPlayers()) do
		if p~=LP and p.Character then
			local tr=p.Character:FindFirstChild("HumanoidRootPart"); local ph=p.Character:FindFirstChildOfClass("Humanoid")
			if tr and ph and ph.Health>0 then local d=(root.Position-tr.Position).Magnitude; if d<dist then dist=d; closest=p end end
		end
	end
	return closest,dist
end

local function startBatAimbot()
	if Conns.aimbot then Conns.aimbot:Disconnect() end
	local hum0=LP.Character and LP.Character:FindFirstChildOfClass("Humanoid")
	if hum0 then hum0.AutoRotate=false end
	Conns.aimbot=RunService.RenderStepped:Connect(function()
		if not State.autoBatToggled then return end
		local char=LP.Character; if not char then return end
		local root=char:FindFirstChild("HumanoidRootPart"); if not root then return end
		local hum2=char:FindFirstChildOfClass("Humanoid"); if not hum2 or hum2.Health <= 0 then return end
		if not char:FindFirstChildOfClass("Tool") then
			local bat=getBat(); if bat then pcall(function() hum2:EquipTool(bat) end) end
		end
		local target,dist=getClosestPlayerAim()
		if not target or not target.Character then return end
		local tr=target.Character:FindFirstChild("HumanoidRootPart"); if not tr then return end
		local targetVel=tr.AssemblyLinearVelocity
		local myPos=root.Position
		local targetPos=tr.Position
		local predictPos=targetPos+targetVel*0.14+tr.CFrame.LookVector*0.3
		local direction=predictPos-myPos
		local flatDir=Vector3.new(direction.X,0,direction.Z).Unit
		local chaseSpeed=58
		local desiredHeight=targetPos.Y+3.7
		local yVel=(desiredHeight-myPos.Y)*19.5+targetVel.Y*0.8
		if hum2.FloorMaterial~=Enum.Material.Air then yVel=math.max(yVel,13) end
		yVel=math.clamp(yVel,-70,110)
		local desiredVel=Vector3.new(flatDir.X*chaseSpeed,yVel,flatDir.Z*chaseSpeed)
		root.AssemblyLinearVelocity=root.AssemblyLinearVelocity:Lerp(desiredVel,0.8)
		local speed3=targetVel.Magnitude
		local predictTime=math.clamp(speed3/150,0.05,0.2)
		local predictedPos=targetPos+targetVel*predictTime
		local toPredict=predictedPos-myPos
		if toPredict.Magnitude>0.1 then
			local goalCF=CFrame.lookAt(myPos,predictedPos)
			local curCF=root.CFrame
			local diffCF=curCF:Inverse()*goalCF
			local rx,ry,rz=diffCF:ToEulerAnglesXYZ()
			rx=math.clamp(rx,-2.5,2.5); ry=math.clamp(ry,-2.5,2.5); rz=math.clamp(rz,-2.5,2.5)
			local tiltSpeed=42
			root.AssemblyAngularVelocity=root.CFrame:VectorToWorldSpace(Vector3.new(rx*tiltSpeed,ry*tiltSpeed,rz*tiltSpeed))
		end
		if dist<=VYSE_HIT_DIST and State.autoSwingEnabled then tryHitBat() end
	end)
end
local function stopBatAimbot()
	if Conns.aimbot then Conns.aimbot:Disconnect(); Conns.aimbot=nil end
	State.autoBatToggled=false; State.hittingCooldown=false
	local char=LP.Character
	local root=char and char:FindFirstChild("HumanoidRootPart")
	local hum2=char and char:FindFirstChildOfClass("Humanoid")
	if root then root.AssemblyLinearVelocity=Vector3.zero; root.AssemblyAngularVelocity=Vector3.zero end
	if hum2 then hum2.AutoRotate=true end
end

local function startAimBypass()
	if Conns.aimBypass then return end
	State.aimBypassToggled=true
	Conns.aimBypass=RunService.Heartbeat:Connect(function()
		if not State.aimBypassToggled then return end
		local char=LP.Character; if not char then return end
		local root=char:FindFirstChild("HumanoidRootPart"); if not root then return end
		local hum=char:FindFirstChildOfClass("Humanoid"); if not hum or hum.Health <= 0 then return end
		local target,dist=getClosestPlayerAim()
		if target and target.Character then
			local tr=target.Character:FindFirstChild("HumanoidRootPart")
				local head=target.Character:FindFirstChild("Head")
				local basePos=head and head.Position or tr.Position
				local aimPoint=basePos+tr.CFrame.LookVector*FACE_OFFSET
				local direction=(aimPoint-root.Position).Unit
				root.AssemblyLinearVelocity = direction * State.aimbotSpeed
				if dist<=VYSE_HIT_DIST and State.autoSwingEnabled then tryHitBat() end
			end
			root.AssemblyLinearVelocity = Vector3.new(0, root.AssemblyLinearVelocity.Y, 0)
		end
	end)
end
local function stopAimBypass()
	if Conns.aimBypass then Conns.aimBypass:Disconnect(); Conns.aimBypass=nil end
	State.aimBypassToggled=false; State.hittingCooldown=false
	local char=LP.Character; local root=char and char:FindFirstChild("HumanoidRootPart")
	if root then root.AssemblyLinearVelocity = Vector3.new(0, root.AssemblyLinearVelocity.Y, 0) end
end

local function applyMobileBtnScale()
	local s = State.mobileBtnScale
	local baseW, baseH, basePad = 64, 64, 8
	local newW = math.floor(baseW * s)
	local newH = math.floor(baseH * s)
	local pad = math.floor(basePad * s)
	local margin = 16

	_mbBtnPositions = {
		UDim2.new(1, -(newW*3 + pad*2 + margin), 0.12, 0),
		UDim2.new(1, -(newW*2 + pad + margin), 0.12, 0),
		UDim2.new(1, -(newW + margin), 0.12, 0),
		UDim2.new(1, -(newW*2 + pad + margin), 0.12, newH + pad),
		UDim2.new(1, -(newW*2 + pad + margin), 0.12, (newH + pad)*2),
		UDim2.new(1, -(newW + margin), 0.12, newH + pad),
		UDim2.new(1, -(newW + margin), 0.12, (newH + pad)*2),
		UDim2.new(1, -(newW*2 + pad + margin), 0.12, (newH + pad)*3),
		UDim2.new(1, -(newW + margin), 0.12, (newH + pad)*3),
	}

	for i, btn in ipairs(_mbBtnRefs) do
			btn.Size = UDim2.new(0, newW, 0, newH)
			if _mbBtnPositions[i] then
				btn.Position = _mbBtnPositions[i]
			end
		end
	end
end

local MOVE_KEYS = {
    [Enum.KeyCode.W] = true,
    [Enum.KeyCode.A] = true,
    [Enum.KeyCode.S] = true,
    [Enum.KeyCode.D] = true,
    [Enum.KeyCode.Up] = true,
    [Enum.KeyCode.Left] = true,
    [Enum.KeyCode.Down] = true,
    [Enum.KeyCode.Right] = true,
}

local lastMoveDir = Vector3.new(0, 0, 0)

local function isRagdollState(hum)
    local st = hum:GetState()
    return hum.PlatformStand
        or st == Enum.HumanoidStateType.Physics
        or st == Enum.HumanoidStateType.Ragdoll
        or st == Enum.HumanoidStateType.FallingDown
end

local function getCandySpeed()
    if State.laggerActive and State.speedType == "carry" then
        return State.laggerCarrySpeed
    elseif State.laggerActive then
        return State.laggerSpeed
    elseif State.speedType == "carry" then
        return State.carrySpeed
        return State.normalSpeed
    end
end

RunService.RenderStepped:Connect(function()
    local char = LP.Character

    local hum = char:FindFirstChildOfClass("Humanoid")
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hum or not hrp or hum.Health <= 0 then return end

    
    if isRagdollState(hum) or hum:GetState() == Enum.HumanoidStateType.Dead then
        lastMoveDir = Vector3.new(0, 0, 0)
        return
    end

    local spd = getCandySpeed()

    
    if math.abs(hum.WalkSpeed - spd) > 0.5 then
        hum.WalkSpeed = spd
    end

    
    if not State.autoBatToggled and not State.aimBypassToggled and not State.autoPlayEnabled then
        local md = hum.MoveDirection

        if md.Magnitude > 0.05 then
            lastMoveDir = md
            local currentY = hrp.AssemblyLinearVelocity.Y
            hrp.AssemblyLinearVelocity = Vector3.new(md.X * spd, currentY, md.Z * spd)
        elseif State.antiRagdollEnabled and lastMoveDir.Magnitude > 0.05 then
            local anyHeld = false
            for key in pairs(MOVE_KEYS) do
                if UIS:IsKeyDown(key) then
                    anyHeld = true
                    break
                end
            end
                local currentY = hrp.AssemblyLinearVelocity.Y
                hrp.AssemblyLinearVelocity = Vector3.new(
                    lastMoveDir.X * spd,
                    currentY,
                    lastMoveDir.Z * spd
                )
            end
        end
    end
end)

UIS.JumpRequest:Connect(function()
    if not State.infJumpEnabled then return end
    if State.infJumpMode ~= "manual" then return end
    local char = LP.Character
    local root = char:FindFirstChild("HumanoidRootPart")
    local hum = char:FindFirstChildOfClass("Humanoid")
    if root and hum and hum.Health > 0 then
        root.AssemblyLinearVelocity = Vector3.new(root.AssemblyLinearVelocity.X, 55, root.AssemblyLinearVelocity.Z)
    end
end)

RunService.Heartbeat:Connect(function()
    if not State.infJumpEnabled then return end
    local char = LP.Character
    local root = char:FindFirstChild("HumanoidRootPart")
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not root or not hum or hum.Health <= 0 then return end
    if State.infJumpMode == "hold" then
        local jumpHeld = UIS:IsKeyDown(Enum.KeyCode.Space) or (hum.Jump == true)
        if jumpHeld and root.AssemblyLinearVelocity.Y < 30 then
            root.AssemblyLinearVelocity = Vector3.new(root.AssemblyLinearVelocity.X, 55, root.AssemblyLinearVelocity.Z)
        end
    end
    if root.AssemblyLinearVelocity.Y < -120 then
        root.AssemblyLinearVelocity = Vector3.new(root.AssemblyLinearVelocity.X, -120, root.AssemblyLinearVelocity.Z)
    end
end)

local function buildGUI()
	local gui=Instance.new("ScreenGui")
	gui.Name="SLAXERGUI"; gui.DisplayOrder=200; gui.IgnoreGuiInset=true; gui.ZIndexBehavior=Enum.ZIndexBehavior.Global
	if not pcall(function() gui.Parent=game:GetService("CoreGui") end) then gui.Parent=LP:WaitForChild("PlayerGui") end

	
	pcall(function()
		local coreGui = game:GetService("CoreGui")
		local topBar = coreGui:FindFirstChild("TopBar")
			for _, child in ipairs(topBar:GetDescendants()) do
				if child:IsA("ImageButton") and (child.Name:lower():find("setting") or child.Name:lower():find("gear")) then
					child.Visible = false
				end
			end
		end
		local chrome = coreGui:FindFirstChild("Chrome")
			for _, child in ipairs(chrome:GetDescendants()) do
				if child:IsA("ImageButton") and (child.Name:lower():find("setting") or child.Name:lower():find("gear")) then
					child.Visible = false
				end
			end
		end
	end)

	local W,H,CORNER=460,540,10

	local function makeDraggable(frame,handle,forceAlways)
		local src=handle or frame; local dragging,dragInput,dragStart,startPos=false,nil,nil,nil
		src.InputBegan:Connect(function(inp)
						if inp.UserInputType==Enum.UserInputType.MouseButton1 or inp.UserInputType==Enum.UserInputType.Touch then
				dragging=true; dragStart=inp.Position; startPos=frame.Position
				inp.Changed:Connect(function() if inp.UserInputState==Enum.UserInputState.End then dragging=false end end)
			end
		end)
		src.InputChanged:Connect(function(inp) if inp.UserInputType==Enum.UserInputType.MouseMovement or inp.UserInputType==Enum.UserInputType.Touch then dragInput=inp end end)
		UIS.InputChanged:Connect(function(inp)
						if inp==dragInput and dragging then local d=inp.Position-dragStart; frame.Position=UDim2.new(startPos.X.Scale,startPos.X.Offset+d.X,startPos.Y.Scale,startPos.Y.Offset+d.Y) end
		end)
		UIS.InputEnded:Connect(function(inp) if inp.UserInputType==Enum.UserInputType.MouseButton1 or inp.UserInputType==Enum.UserInputType.Touch then dragging=false end end)
	end

	local main=Instance.new("Frame",gui); main.Name="Main"; main.Size=UDim2.new(0,W,0,H); main.Position=UDim2.new(0,12,0,12)
	main.BackgroundColor3=C_BG; main.BorderSizePixel=0; main.Active=true
	Instance.new("UICorner",main).CornerRadius=UDim.new(0,CORNER)
	local mainStroke=Instance.new("UIStroke",main); mainStroke.Color=Color3.fromRGB(220,20,20); mainStroke.Thickness=1.5; mainStroke.ApplyStrokeMode=Enum.ApplyStrokeMode.Border
	task.spawn(function() while true do TweenService:Create(mainStroke,TweenInfo.new(1.5,Enum.EasingStyle.Sine,Enum.EasingDirection.InOut),{Color=Color3.fromRGB(255,60,60),Thickness=2}):Play(); task.wait(1.5); TweenService:Create(mainStroke,TweenInfo.new(1.5,Enum.EasingStyle.Sine,Enum.EasingDirection.InOut),{Color=Color3.fromRGB(220,20,20),Thickness=1.5}):Play(); task.wait(1.5) end end)
	
	local bgImg=Instance.new("ImageLabel",main); bgImg.Name="BGImage"; bgImg.Size=UDim2.new(1,0,1,0); bgImg.Position=UDim2.new(0,0,0,0)
	bgImg.Image="rbxassetid://105127083430858"; bgImg.BackgroundTransparency=1; bgImg.BorderSizePixel=0
	bgImg.ZIndex=0; bgImg.ImageColor3=Color3.fromRGB(255,255,255); bgImg.ImageTransparency=0.15
	Instance.new("UICorner",bgImg).CornerRadius=UDim.new(0,CORNER)
	_mainFrame=main; makeDraggable(main,main,false)

	local HEADER_H=72
	local headerFrame=Instance.new("Frame",main); headerFrame.Size=UDim2.new(1,0,0,HEADER_H); headerFrame.BackgroundColor3=C_HEADER; headerFrame.BorderSizePixel=0; headerFrame.ZIndex=3; headerFrame.ClipsDescendants=true
	local headerGlow=Instance.new("Frame",headerFrame); headerGlow.Size=UDim2.new(1,0,0,2); headerGlow.Position=UDim2.new(0,0,1,-2); headerGlow.BackgroundColor3=Color3.fromRGB(220,20,20); headerGlow.BorderSizePixel=0; headerGlow.ZIndex=4; Instance.new("UICorner",headerGlow).CornerRadius=UDim.new(0,1)
	Instance.new("UICorner",headerFrame).CornerRadius=UDim.new(0,CORNER)
	local hPatch=Instance.new("Frame",headerFrame); hPatch.Size=UDim2.new(1,0,0,CORNER); hPatch.Position=UDim2.new(0,0,1,-CORNER); hPatch.BackgroundColor3=C_HEADER; hPatch.BorderSizePixel=0; hPatch.ZIndex=2

	task.spawn(function()
		local bubbleColors={Color3.fromRGB(220,20,20),Color3.fromRGB(220,20,20),Color3.fromRGB(220,20,20),Color3.fromRGB(220,20,20),Color3.fromRGB(220,20,20)}
		local function spawnBubble()
			local size=math.random(4,11); local bub=Instance.new("Frame",headerFrame); bub.Size=UDim2.new(0,size,0,size); bub.Position=UDim2.new(math.random(5,95)/100,0,1,size); bub.BackgroundColor3=bubbleColors[math.random(1,#bubbleColors)]; bub.BackgroundTransparency=math.random(20,55)/100; bub.BorderSizePixel=0; bub.ZIndex=10; Instance.new("UICorner",bub).CornerRadius=UDim.new(1,0)
			TweenService:Create(bub,TweenInfo.new(math.random(18,35)/10,Enum.EasingStyle.Linear),{Position=UDim2.new(bub.Position.X.Scale,0,0,-size-2),BackgroundTransparency=1}):Play(); task.delay(3.6,function() pcall(function() bub:Destroy() end) end)
		end
		while true do task.wait(math.random(12,30)/100); pcall(spawnBubble) end
	end)

	local accentPip=Instance.new("Frame",headerFrame); accentPip.Size=UDim2.new(0,4,0,24); accentPip.Position=UDim2.new(0,8,0.5,-12); accentPip.BackgroundColor3=Color3.fromRGB(220,20,20); accentPip.BorderSizePixel=0; accentPip.ZIndex=5; Instance.new("UICorner",accentPip).CornerRadius=UDim.new(1,0)
	task.spawn(function() while true do TweenService:Create(accentPip,TweenInfo.new(0.8,Enum.EasingStyle.Sine,Enum.EasingDirection.InOut),{BackgroundColor3=Color3.fromRGB(255,50,50)}):Play(); task.wait(0.8); TweenService:Create(accentPip,TweenInfo.new(0.8,Enum.EasingStyle.Sine,Enum.EasingDirection.InOut),{BackgroundColor3=Color3.fromRGB(220,20,20)}):Play(); task.wait(0.8) end end)
	task.spawn(function() local colors={Color3.fromRGB(220,20,20),Color3.fromRGB(220,20,20),Color3.fromRGB(220,20,20),Color3.fromRGB(220,20,20),Color3.fromRGB(220,20,20)}; local i=1; while true do i=i%#colors+1; TweenService:Create(accentPip,TweenInfo.new(1.2,Enum.EasingStyle.Sine,Enum.EasingDirection.InOut),{BackgroundColor3=colors[i]}):Play(); task.wait(1.3) end end)

	local usernameLbl=Instance.new("TextLabel",headerFrame); usernameLbl.Size=UDim2.new(1,-100,0,22); usernameLbl.Position=UDim2.new(0,16,0,10); usernameLbl.BackgroundTransparency=1; usernameLbl.Text="SLAXER ON TOP"
	usernameLbl.TextStrokeTransparency=0.5; usernameLbl.TextStrokeColor3=Color3.fromRGB(100,10,10)
	local userGlow=Instance.new("TextLabel",headerFrame); userGlow.Size=UDim2.new(1,-100,0,22); userGlow.Position=UDim2.new(0,16,0,10); userGlow.BackgroundTransparency=1; userGlow.Text="SLAXER ON TOP"; userGlow.TextColor3=Color3.fromRGB(150,15,15); userGlow.Font=Enum.Font.GothamBlack; userGlow.TextSize=17; userGlow.TextXAlignment=Enum.TextXAlignment.Left; userGlow.ZIndex=3; usernameLbl.TextColor3=C_TEXT; usernameLbl.Font=Enum.Font.GothamBlack; usernameLbl.TextSize=17; usernameLbl.TextXAlignment=Enum.TextXAlignment.Left; usernameLbl.ZIndex=4
	local handleLbl=Instance.new("TextLabel",headerFrame); handleLbl.Size=UDim2.new(1,-100,0,12); handleLbl.Position=UDim2.new(0,16,0,30); handleLbl.BackgroundTransparency=1; handleLbl.Text="ðŸ‘‘ PREMIUM HUB"; handleLbl.TextColor3=Color3.fromRGB(220,20,20); handleLbl.Font=Enum.Font.Gotham; handleLbl.TextSize=10; handleLbl.TextXAlignment=Enum.TextXAlignment.Left; handleLbl.ZIndex=4

	

	local minBtn=Instance.new("TextButton",headerFrame); minBtn.Size=UDim2.new(0,24,0,24); minBtn.Position=UDim2.new(1,-34,0,8); minBtn.BackgroundColor3=C_CARD; minBtn.BorderSizePixel=0; minBtn.Text="
	local headerDiv=Instance.new("Frame",main); headerDiv.Size=UDim2.new(1,0,0,1); headerDiv.Position=UDim2.new(0,0,0,HEADER_H); headerDiv.BackgroundColor3=C_BORDER; headerDiv.BorderSizePixel=0; headerDiv.ZIndex=3

	task.spawn(function() while true do TweenService:Create(mainStroke,TweenInfo.new(2,Enum.EasingStyle.Sine,Enum.EasingDirection.InOut),{Color=Color3.fromRGB(220,20,20)}):Play(); task.wait(2.1); TweenService:Create(mainStroke,TweenInfo.new(2,Enum.EasingStyle.Sine,Enum.EasingDirection.InOut),{Color=C_BORDER}):Play(); task.wait(2.1) end end)

	
	
	local SIDEBAR_W = 110

local sidebar = Instance.new("Frame", main)
sidebar.Name = "Sidebar"
sidebar.Size = UDim2.new(0, SIDEBAR_W, 1, -HEADER_H)
sidebar.Position = UDim2.new(0, 0, 0, HEADER_H)
sidebar.BackgroundColor3 = C_SIDEBAR
sidebar.BorderSizePixel = 0
sidebar.ZIndex = 3

local sidebarRightBorder = Instance.new("Frame", sidebar)
sidebarRightBorder.Size = UDim2.new(0, 2, 1, 0)
sidebarRightBorder.Position = UDim2.new(1, -2, 0, 0)
sidebarRightBorder.BackgroundColor3 = C_BORDER
sidebarRightBorder.BorderSizePixel = 0
sidebarRightBorder.ZIndex = 4

local tabNames = {
	{"Speed", "SPD", "speed"},
	{"Main", "MAIN", "main"},
	{"Aimbot", "AIM", "aimbot"},
	{"AutoSteal", "STL", "auto_steal"},
	{"Extra", "EXTRA", "extra"},
	{"Scripts", "SCR", "executor"},
	{"Keybinds", "KEYS", "keybinds"},
	{"Settings", "SET", "settings"}
}
local tabContents = {}
local tabButtons = {}
local activeTab = "Main"

for i, tabInfo in ipairs(tabNames) do
    local tName, tLabel, tTransKey = tabInfo[1], tabInfo[2], tabInfo[3]

    local btn = Instance.new("TextButton", sidebar)
    btn.Name = "Tab_" .. tName
    btn.Size = UDim2.new(1, -4, 0, 34)
    btn.Position = UDim2.new(0, 2, 0, (i-1)*36 + 4)
    btn.BackgroundColor3 = C_TAB_IDL
    btn.BorderSizePixel = 0
    btn.Text = tLabel
    btn.TextColor3 = C_TEXT_DIM
    btn.Font = Enum.Font.GothamBlack
    btn.TextSize = 11
    btn.ZIndex = 5
    btn.AutoButtonColor = false
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)

    local leftAccent = Instance.new("Frame", btn)
    leftAccent.Name = "LeftAccent"
    leftAccent.Size = UDim2.new(0, 3, 0.6, 0)
    leftAccent.Position = UDim2.new(0, 0, 0.2, 0)
    leftAccent.BackgroundColor3 = C_TAB_ACT
    leftAccent.BorderSizePixel = 0
    leftAccent.ZIndex = 6
    leftAccent.Visible = false
    Instance.new("UICorner", leftAccent).CornerRadius = UDim.new(0, 2)

    tabButtons[tName] = {btn = btn, accent = leftAccent}

    btn.MouseEnter:Connect(function()
        if activeTab ~= tName then
            TweenService:Create(btn, TweenInfo.new(0.1), {BackgroundColor3 = C_CARD}):Play()
        end
    end)
    btn.MouseLeave:Connect(function()
        if activeTab ~= tName then
            TweenService:Create(btn, TweenInfo.new(0.1), {BackgroundColor3 = C_TAB_IDL}):Play()
        end
    end)

    btn.MouseButton1Click:Connect(function()
        if activeTab == tName then return end
        activeTab = tName
        for n, data in pairs(tabButtons) do
            local isActive = (n == tName)
            data.btn.BackgroundColor3 = isActive and C_TAB_ACT or C_TAB_IDL
            data.btn.TextColor3 = isActive and C_WHITE or C_TEXT_DIM
            data.accent.Visible = isActive
            tabContents[n].Visible = isActive
        end
    end)
end

for _, tabInfo in ipairs(tabNames) do
    local tName = tabInfo[1]
    local tContent = Instance.new("ScrollingFrame", main)
    tContent.Name = "Content_" .. tName
    tContent.Size = UDim2.new(1, -SIDEBAR_W, 1, -(HEADER_H + CORNER))
    tContent.Position = UDim2.new(0, SIDEBAR_W, 0, HEADER_H)
    tContent.BackgroundColor3 = C_BG
    tContent.BorderSizePixel = 0
    tContent.ClipsDescendants = true
    tContent.ZIndex = 2
    tContent.ScrollBarThickness = 3
    tContent.ScrollBarImageColor3 = C_BORDER
    tContent.AutomaticCanvasSize = Enum.AutomaticSize.Y
    tContent.CanvasSize = UDim2.new(0, 0, 0, 0)
    tContent.ScrollingEnabled = true
    tContent.ScrollingDirection = Enum.ScrollingDirection.Y
    tContent.Visible = (tName == "Main")

    local pll = Instance.new("UIListLayout", tContent)
    pll.SortOrder = Enum.SortOrder.LayoutOrder
    pll.Padding = UDim.new(0, 3)

    local pp = Instance.new("UIPadding", tContent)
    pp.PaddingLeft = UDim.new(0, 8)
    pp.PaddingRight = UDim.new(0, 8)
    pp.PaddingTop = UDim.new(0, 8)
    pp.PaddingBottom = UDim.new(0, 8)

    tabContents[tName] = tContent
end

tabButtons["Main"].btn.BackgroundColor3 = C_TAB_ACT
tabButtons["Main"].btn.TextColor3 = C_WHITE
tabButtons["Main"].accent.Visible = true

local content = tabContents["Speed"]
local content = tabContents["Speed"]

	local mini=Instance.new("TextButton",gui); mini.Name="SLAXERMini"; mini.Size=UDim2.new(0,130,0,28); mini.Position=UDim2.new(0,12,0,12); mini.BackgroundColor3=Color3.fromRGB(35,8,8); mini.BorderSizePixel=0; mini.Text="SLAXER"; mini.TextColor3=C_TEXT; mini.Font=Enum.Font.GothamBlack; mini.TextSize=12; mini.ZIndex=20; mini.Visible=false; mini.AutoButtonColor=false
	Instance.new("UICorner",mini).CornerRadius=UDim.new(0,10); Instance.new("UIStroke",mini).Color=C_BORDER
	local miniBg=Instance.new("ImageLabel",mini); miniBg.Name="BGImage"; miniBg.Size=UDim2.new(1,0,1,0); miniBg.Image="rbxassetid://105127083430858"
	miniBg.BackgroundTransparency=1; miniBg.BorderSizePixel=0; miniBg.ZIndex=0; miniBg.ImageTransparency=0.2
	Instance.new("UICorner",miniBg).CornerRadius=UDim.new(0,10)
	_miniFrame=mini; makeDraggable(mini,nil,false)
	local guiVisible=true
	local function showGui() main.Visible=true; mini.Visible=false; guiVisible=true end
	local function hideGui() main.Visible=false; mini.Visible=true; guiVisible=false end
	minBtn.MouseButton1Click:Connect(hideGui); mini.MouseButton1Click:Connect(showGui)
	mini.MouseEnter:Connect(function() TweenService:Create(mini,TweenInfo.new(0.1),{BackgroundColor3=C_CARD}):Play() end)
	mini.MouseLeave:Connect(function() TweenService:Create(mini,TweenInfo.new(0.1),{BackgroundColor3=C_PANEL}):Play() end)

	local _globalLO=0; local function lo(t) _globalLO=_globalLO+1; return _globalLO end
	local function pg(t)
    if tabContents[t] then
        return tabContents[t]
    end
end
	local function makeSecHeader(tabName,textKey)
		local f=Instance.new("Frame",pg(tabName)); f.Size=UDim2.new(1,0,0,18); f.BackgroundTransparency=1; f.BorderSizePixel=0; f.LayoutOrder=lo(tabName); f.ZIndex=4
		local lbl=Instance.new("TextLabel",f); lbl.Size=UDim2.new(1,0,1,0); lbl.BackgroundTransparency=1; lbl.TextColor3=C_TEXT_DIM; lbl.Font=Enum.Font.GothamBold; lbl.TextSize=12; lbl.TextXAlignment=Enum.TextXAlignment.Left; lbl.ZIndex=5
		local secBar=Instance.new("Frame",f); secBar.Size=UDim2.new(0,2,0,12); secBar.Position=UDim2.new(0,2,0.5,-6); secBar.BackgroundColor3=Color3.fromRGB(220,20,20); secBar.BorderSizePixel=0; secBar.ZIndex=6; Instance.new("UICorner",secBar).CornerRadius=UDim.new(1,0)
		lbl.Position=UDim2.new(0,8,0,0); lbl.Text=(T(textKey) or textKey):upper(); onLangChange(function() lbl.Text=(T(textKey) or textKey):upper() end)
	end
	local function baseCard(tabName,h2)
		local c=Instance.new("Frame",pg(tabName)); c.Size=UDim2.new(1,0,0,h2 or 34); c.BackgroundColor3=C_CARD; c.BorderSizePixel=0; c.LayoutOrder=lo(tabName); c.ZIndex=4
		Instance.new("UICorner",c).CornerRadius=UDim.new(0,7); local s=Instance.new("UIStroke",c); s.Color=C_BORDER2; s.Thickness=1
		c.MouseEnter:Connect(function() TweenService:Create(c,TweenInfo.new(0.1),{BackgroundColor3=C_CARD_HOV}):Play(); TweenService:Create(s,TweenInfo.new(0.1),{Color=Color3.fromRGB(220,20,20)}):Play() end)
		c.MouseLeave:Connect(function() TweenService:Create(c,TweenInfo.new(0.1),{BackgroundColor3=C_CARD}):Play(); TweenService:Create(s,TweenInfo.new(0.1),{Color=C_BORDER2}):Play() end)
	end
	local function cLabel(p,textKey,x,w,sz,col,font,xa)
		local l=Instance.new("TextLabel",p); l.Size=UDim2.new(0,w or 140,1,0); l.Position=UDim2.new(0,x or 10,0,0); l.BackgroundTransparency=1; l.TextColor3=col or C_TEXT; l.Font=font or Enum.Font.GothamBold; l.TextSize=sz or 10; l.TextXAlignment=xa or Enum.TextXAlignment.Left; l.ZIndex=10
		l.Text=T(textKey) or textKey; onLangChange(function() l.Text=T(textKey) or textKey end); return l
	end
	local function makePillToggle(parent,defOn,onToggle)
		local PW,PH=38,20
		local pbg=Instance.new("Frame",parent); pbg.Size=UDim2.new(0,PW,0,PH); pbg.Position=UDim2.new(1,-(PW+8),0.5,-PH/2); pbg.BackgroundColor3=defOn and C_TOGGLE_ON or C_OFF_BG; pbg.BorderSizePixel=0; pbg.ZIndex=8; Instance.new("UICorner",pbg).CornerRadius=UDim.new(0,10)
		local ps=Instance.new("UIStroke",pbg); ps.Color=defOn and C_TOGGLE_ON or C_BORDER; ps.Thickness=1.5; ps.Transparency=defOn and 0 or 1
		local dot=Instance.new("Frame",pbg); dot.Size=UDim2.new(0,14,0,14); dot.Position=defOn and UDim2.new(1,-16,0.5,-7) or UDim2.new(0,2,0.5,-7); dot.BackgroundColor3=defOn and C_WHITE or C_TEXT_DIM; dot.BorderSizePixel=0; dot.ZIndex=9; Instance.new("UICorner",dot).CornerRadius=UDim.new(0,4)
		local isOn=defOn or false
		local function setV(on)
			isOn=on; TweenService:Create(pbg,TweenInfo.new(0.18),{BackgroundColor3=on and C_TOGGLE_ON or C_OFF_BG}):Play()
			TweenService:Create(ps,TweenInfo.new(0.18),{Color=on and C_TOGGLE_ON or C_BORDER,Transparency=on and 0 or 1}):Play()
			TweenService:Create(dot,TweenInfo.new(0.18,Enum.EasingStyle.Back),{Position=on and UDim2.new(1,-16,0.5,-7) or UDim2.new(0,2,0.5,-7),BackgroundColor3=on and C_WHITE or C_TEXT_DIM}):Play()
		end
		local clk=Instance.new("TextButton",parent); clk.Size=UDim2.new(1,0,1,0); clk.BackgroundTransparency=1; clk.Text=""; clk.ZIndex=6
		clk.MouseButton1Click:Connect(function() if _anyKeyListening then return end; isOn=not isOn; setV(isOn); if onToggle then pcall(onToggle,isOn) end end)
	end
	local function makeKeyBtn(parent,getKey,onChanged)
		local b=Instance.new("TextButton",parent); b.Size=UDim2.new(0,40,0,18); b.BackgroundColor3=C_KB_BG; b.BorderSizePixel=0; b.Text=getKey().Name; b.TextColor3=C_TEXT_SUB; b.Font=Enum.Font.GothamBold; b.TextSize=7; b.ZIndex=11
		Instance.new("UICorner",b).CornerRadius=UDim.new(0,5); local bs=Instance.new("UIStroke",b); bs.Color=C_BORDER; bs.Thickness=1
		local li=false; local lc; local pv=b.Text
		b.MouseButton1Click:Connect(function()
			if li then li=false; _anyKeyListening=false; if lc then lc:Disconnect(); lc=nil end; b.Text=pv; b.TextColor3=C_TEXT_SUB; TweenService:Create(bs,TweenInfo.new(0.1),{Color=C_BORDER}):Play(); return end
			pv=b.Text; li=true; _anyKeyListening=true; b.Text="
			lc=UIS.InputBegan:Connect(function(inp)
				if not li then return end; if inp.UserInputType~=Enum.UserInputType.Keyboard then return end
				if inp.KeyCode==Enum.KeyCode.Escape then li=false; _anyKeyListening=false; if lc then lc:Disconnect(); lc=nil end; b.Text=pv; b.TextColor3=C_TEXT_SUB; TweenService:Create(bs,TweenInfo.new(0.1),{Color=C_BORDER}):Play(); return end
				if onChanged then onChanged(inp.KeyCode) end; b.Text=inp.KeyCode.Name; pv=inp.KeyCode.Name; b.TextColor3=C_TEXT_SUB; li=false; _anyKeyListening=false; if lc then lc:Disconnect(); lc=nil end; TweenService:Create(bs,TweenInfo.new(0.1),{Color=C_BORDER}):Play()
			end)
		end); return b
	end
	local function makeGPKeyBtn(parent,getGPKey,onChanged)
		local b=Instance.new("TextButton",parent); b.Size=UDim2.new(0,56,0,18); b.BackgroundColor3=Color3.fromRGB(35,8,8); b.BorderSizePixel=0; b.Text=getGPKey().Name; b.TextColor3=Color3.fromRGB(220,20,20); b.Font=Enum.Font.GothamBold; b.TextSize=7; b.ZIndex=11
		Instance.new("UICorner",b).CornerRadius=UDim.new(0,5); local bs=Instance.new("UIStroke",b); bs.Color=Color3.fromRGB(220,20,20); bs.Thickness=1
		local li=false; local lc; local pv=b.Text
		b.MouseButton1Click:Connect(function()
			if li then li=false; _anyKeyListening=false; if lc then lc:Disconnect(); lc=nil end; b.Text=pv; b.TextColor3=Color3.fromRGB(220,20,20); TweenService:Create(bs,TweenInfo.new(0.1),{Color=Color3.fromRGB(220,20,20)}):Play(); return end
			pv=b.Text; li=true; _anyKeyListening=true; b.Text="..."; b.TextColor3=C_TEXT_DIM; TweenService:Create(bs,TweenInfo.new(0.1),{Color=C_BORDER2}):Play()
			lc=UIS.InputBegan:Connect(function(inp)
				if inp.KeyCode==Enum.KeyCode.Escape then li=false; _anyKeyListening=false; if lc then lc:Disconnect(); lc=nil end; b.Text=pv; b.TextColor3=Color3.fromRGB(220,20,20); TweenService:Create(bs,TweenInfo.new(0.1),{Color=Color3.fromRGB(220,20,20)}):Play(); return end
				local isGP=(inp.UserInputType==Enum.UserInputType.Gamepad1 or inp.UserInputType==Enum.UserInputType.Gamepad2); local isKB=(inp.UserInputType==Enum.UserInputType.Keyboard)
					if onChanged then onChanged(inp.KeyCode) end; b.Text=inp.KeyCode.Name; pv=inp.KeyCode.Name; b.TextColor3=Color3.fromRGB(220,20,20); li=false; _anyKeyListening=false; if lc then lc:Disconnect(); lc=nil end; TweenService:Create(bs,TweenInfo.new(0.1),{Color=Color3.fromRGB(220,20,20)}):Play()
				end
			end)
		end); return b
	end
	local function rowToggle(tabName,labelKey,defOn,onToggle)
		local c=baseCard(tabName,34); cLabel(c,labelKey,8,150,10,C_TEXT,Enum.Font.GothamBold)
		return makePillToggle(c,defOn,onToggle)
	end
	local function rowKBOnly(tabName,labelKey,getKey,onKeyChange)
		local c=baseCard(tabName,34); cLabel(c,labelKey,8,150,10,C_TEXT,Enum.Font.GothamBold)
		local kb=makeKeyBtn(c,getKey,function(k) if onKeyChange then onKeyChange(k) end end)
		kb.Position=UDim2.new(1,-(40+8),0.5,-9); kb.ZIndex=11; return kb
	end
	local function rowGPBind(tabName,labelKey,getGPKey,onGPKeyChange)
		local c=baseCard(tabName,34); cLabel(c,labelKey,8,120,10,C_TEXT,Enum.Font.GothamBold)
		local gpb=makeGPKeyBtn(c,getGPKey,function(k) if onGPKeyChange then onGPKeyChange(k) end end)
		gpb.Position=UDim2.new(1,-(56+8),0.5,-9); gpb.ZIndex=11; return gpb
	end
	local function rowInput(tabName,labelKey,default,onChange)
		local c=baseCard(tabName,34); cLabel(c,labelKey,8,120,10,C_TEXT,Enum.Font.GothamBold)
		local box=Instance.new("TextBox",c); box.Size=UDim2.new(0,58,0,22); box.Position=UDim2.new(1,-66,0.5,-11); box.BackgroundColor3=C_INPUT_BG; box.BorderSizePixel=0; box.Text=tostring(default); box.TextColor3=C_TEXT; box.Font=Enum.Font.GothamBold; box.TextSize=10; box.ClearTextOnFocus=false; box.ZIndex=11
		Instance.new("UICorner",box).CornerRadius=UDim.new(0,5); local bs=Instance.new("UIStroke",box); bs.Color=C_BORDER; bs.Thickness=1; bs.ZIndex=12
		box.Focused:Connect(function() TweenService:Create(bs,TweenInfo.new(0.1),{Color=Color3.fromRGB(220,20,20),Thickness=1.5}):Play() end)
		box.FocusLost:Connect(function() TweenService:Create(bs,TweenInfo.new(0.1),{Color=C_BORDER,Thickness=1}):Play(); if onChange then local n=tonumber(box.Text); if n then onChange(n) else box.Text=tostring(default) end end end)
	end
	local function rowActionBtn(tabName,labelKey,onClick)
		local b=Instance.new("TextButton",pg(tabName)); b.Size=UDim2.new(1,0,0,38); b.BackgroundColor3=C_PANEL; b.BorderSizePixel=0; b.TextColor3=C_TEXT; b.Font=Enum.Font.GothamBlack; b.TextSize=11; b.LayoutOrder=lo(tabName); b.ZIndex=5
		b.Text=T(labelKey) or labelKey; onLangChange(function() b.Text=T(labelKey) or labelKey end)
		Instance.new("UICorner",b).CornerRadius=UDim.new(0,9); local bs=Instance.new("UIStroke",b); bs.Color=C_BORDER; bs.Thickness=1
		b.MouseButton1Click:Connect(function() TweenService:Create(b,TweenInfo.new(0.08),{BackgroundColor3=C_CARD_HOV}):Play(); task.delay(0.15,function() TweenService:Create(b,TweenInfo.new(0.1),{BackgroundColor3=C_PANEL}):Play() end); if onClick then pcall(onClick) end end)
		b.MouseEnter:Connect(function() TweenService:Create(b,TweenInfo.new(0.1),{BackgroundColor3=C_CARD}):Play() end)
		b.MouseLeave:Connect(function() TweenService:Create(b,TweenInfo.new(0.1),{BackgroundColor3=C_PANEL}):Play() end)
	end

	
	local COMBO_W=180; local COMBO_H=50	local COMBO_W=240; local COMBO_H=36
	local comboBar=Instance.new("Frame",gui); comboBar.Name="SLAXERComboBar"; comboBar.Size=UDim2.new(0,COMBO_W,0,COMBO_H);
	comboBar.Position=UDim2.new(0.5,-120,0,8); comboBar.BackgroundColor3=Color3.fromRGB(30,6,6); comboBar.BorderSizePixel=0; comboBar.Active=true; comboBar.ZIndex=60
	Instance.new("UICorner",comboBar).CornerRadius=UDim.new(0,10); local comboStroke=Instance.new("UIStroke",comboBar); comboStroke.Color=Color3.fromRGB(220,20,20); comboStroke.Thickness=1.5
	local comboBg=Instance.new("ImageLabel",comboBar); comboBg.Name="BGImage"; comboBg.Size=UDim2.new(1,0,1,0); comboBg.Image="rbxassetid://105127083430858"
	comboBg.BackgroundTransparency=1; comboBg.BorderSizePixel=0; comboBg.ZIndex=0; comboBg.ImageTransparency=0.25
	Instance.new("UICorner",comboBg).CornerRadius=UDim.new(0,10)
	_comboFrame=comboBar; makeDraggable(comboBar,nil,false)

	
	task.spawn(function()
			TweenService:Create(comboStroke,TweenInfo.new(1.5,Enum.EasingStyle.Sine,Enum.EasingDirection.InOut),{Color=Color3.fromRGB(255,60,60)}):Play()
			task.wait(1.5)
			TweenService:Create(comboStroke,TweenInfo.new(1.5,Enum.EasingStyle.Sine,Enum.EasingDirection.InOut),{Color=Color3.fromRGB(220,20,20)}):Play()
			task.wait(1.5)
		end
	end)

	
	local sectionW = COMBO_W / 4
	local sections = {}
	local secLabels = {}
	local valLabels = {}

	local secNames = {"FPS","PING","SPD","STS"}
	local secColors = {
		Color3.fromRGB(220,20,20),
		Color3.fromRGB(220,20,20),
		Color3.fromRGB(220,20,20),
		Color3.fromRGB(220,20,20)
	}

	for i=1,4 do
		local sec = Instance.new("Frame",comboBar)
		sec.Size = UDim2.new(0,sectionW-1,1,0)
		sec.Position = UDim2.new(0,(i-1)*sectionW,0,0)
		sec.BackgroundTransparency = 1
		sec.BorderSizePixel = 0
		sec.ZIndex = 61
		sections[i] = sec

		local nameLbl = Instance.new("TextLabel",sec)
		nameLbl.Size = UDim2.new(1,0,0,12)
		nameLbl.Position = UDim2.new(0,0,0,2)
		nameLbl.BackgroundTransparency = 1
		nameLbl.Text = secNames[i]
		nameLbl.TextColor3 = Color3.fromRGB(150,15,15)
		nameLbl.Font = Enum.Font.GothamBold
		nameLbl.TextSize = 8
		nameLbl.TextXAlignment = Enum.TextXAlignment.Center
		nameLbl.ZIndex = 62
		secLabels[i] = nameLbl

		local valLbl = Instance.new("TextLabel",sec)
		valLbl.Size = UDim2.new(1,0,0,20)
		valLbl.Position = UDim2.new(0,0,0,14)
		valLbl.BackgroundTransparency = 1
		valLbl.Text = "
		valLbl.TextColor3 = secColors[i]
		valLbl.Font = Enum.Font.GothamBlack
		valLbl.TextSize = 12
		valLbl.TextXAlignment = Enum.TextXAlignment.Center
		valLbl.ZIndex = 63
		valLabels[i] = valLbl

		if i < 4 then
			local div = Instance.new("Frame",comboBar)
			div.Size = UDim2.new(0,1,0,20)
			div.Position = UDim2.new(0,i*sectionW-0.5,0.5,-10)
			div.BackgroundColor3 = Color3.fromRGB(60,15,15)
			div.BorderSizePixel = 0
			div.ZIndex = 61
		end
	end

	local fpsValLbl = valLabels[1]
	local pingValLbl = valLabels[2]
	local spdValLbl = valLabels[3]
	local stsValLbl = valLabels[4]

	
	local stealPanel = Instance.new("Frame",gui)
	stealPanel.Name = "SLAXERStealPanel"
	stealPanel.Size = UDim2.new(0,COMBO_W,0,32)
	stealPanel.Position = UDim2.new(0.5,-120,0,COMBO_H+12)
	stealPanel.BackgroundColor3 = Color3.fromRGB(30,6,6)
	stealPanel.BorderSizePixel = 0
	stealPanel.ZIndex = 60
	Instance.new("UICorner",stealPanel).CornerRadius = UDim.new(0,8)
	local panelStroke = Instance.new("UIStroke",stealPanel)
	panelStroke.Color = Color3.fromRGB(220,20,20)
	panelStroke.Thickness = 1.5

	local stealIcon = Instance.new("TextLabel",stealPanel)
	stealIcon.Size = UDim2.new(0,40,0,20)
	stealIcon.Position = UDim2.new(0,6,0,2)
	stealIcon.BackgroundTransparency = 1
	stealIcon.Text = "STL"
	stealIcon.TextColor3 = Color3.fromRGB(220,20,20)
	stealIcon.Font = Enum.Font.GothamBlack
	stealIcon.TextSize = 11
	stealIcon.ZIndex = 62

	local stealStatus = Instance.new("TextLabel",stealPanel)
	stealStatus.Size = UDim2.new(0,60,0,14)
	stealStatus.Position = UDim2.new(0,6,0,18)
	stealStatus.BackgroundTransparency = 1
	stealStatus.Text = "READY"
	stealStatus.TextColor3 = Color3.fromRGB(100,200,100)
	stealStatus.Font = Enum.Font.GothamBold
	stealStatus.TextSize = 8
	stealStatus.ZIndex = 62
	AutoSteal.StatusLabel = stealStatus

	local pbBg = Instance.new("Frame",stealPanel)
	pbBg.Size = UDim2.new(0,COMBO_W-90,0,18)
	pbBg.Position = UDim2.new(0,52,0.5,-9)
	pbBg.BackgroundColor3 = Color3.fromRGB(20,4,4)
	pbBg.BorderSizePixel = 0
	pbBg.ZIndex = 61
	Instance.new("UICorner",pbBg).CornerRadius = UDim.new(0,9)
	local pbStroke = Instance.new("UIStroke",pbBg)
	pbStroke.Color = Color3.fromRGB(60,15,15)
	pbStroke.Thickness = 1

	local progressFill = Instance.new("Frame",pbBg)
	progressFill.Size = UDim2.fromScale(0,1)
	progressFill.BackgroundColor3 = Color3.fromRGB(220,20,20)
	progressFill.BorderSizePixel = 0
	progressFill.ZIndex = 63
	Instance.new("UICorner",progressFill).CornerRadius = UDim.new(0,9)
	AutoSteal.ProgressFill = progressFill

	local pctLbl = Instance.new("TextLabel",pbBg)
	pctLbl.Size = UDim2.new(1,0,1,0)
	pctLbl.BackgroundTransparency = 1
	pctLbl.Text = "0%"
	pctLbl.TextColor3 = Color3.fromRGB(255,255,255)
	pctLbl.Font = Enum.Font.GothamBlack
	pctLbl.TextSize = 10
	pctLbl.ZIndex = 64
	AutoSteal.PctLabel = pctLbl

	local glowFrame = Instance.new("Frame",stealPanel)
	glowFrame.Size = UDim2.new(1,0,1,0)
	glowFrame.BackgroundTransparency = 1
	glowFrame.BorderSizePixel = 0
	glowFrame.ZIndex = 59
	local glowStroke = Instance.new("UIStroke",glowFrame)
	glowStroke.Color = Color3.fromRGB(220,20,20)
	glowStroke.Thickness = 3
	glowStroke.Transparency = 1

	local _lastPct = 0
	local _visualSpeed = 0.35
	local _decaySpeed = 1.5
	RunService.RenderStepped:Connect(function(dt)
		local targetPct = 0
		if AutoSteal.IsStealing and stealStartTime then
				local timeSinceComplete = tick() - (stealEndTime or tick())
				if timeSinceComplete < 0.3 then
					targetPct = 1
					targetPct = math.max(0, 1 - (timeSinceComplete - 0.3) * _decaySpeed)
				end
				local rawPct = math.clamp((tick() - stealStartTime) / math.max(AutoSteal.HalfHoldMin, 0.01), 0, 1)
				targetPct = rawPct
			end
			targetPct = 0
		end

		_lastPct = _lastPct + (targetPct - _lastPct) * math.min(dt * _visualSpeed * 60, 1)
		local f = math.clamp(_lastPct, 0, 1)
		if AutoSteal.ProgressFill then
			AutoSteal.ProgressFill.Size = UDim2.new(f, 0, 1, 0)
		end
		if AutoSteal.PctLabel then
			AutoSteal.PctLabel.Text = math.floor(f * 100) .. "%"
		end
			if AutoSteal.IsStealing then
				stealStatus.Text = "STEALING"
				stealStatus.TextColor3 = Color3.fromRGB(220,20,20)
				glowStroke.Transparency = 0.7
			elseif AutoSteal.Enabled then
				stealStatus.Text = "READY"
				stealStatus.TextColor3 = Color3.fromRGB(100,200,100)
				glowStroke.Transparency = 1
				stealStatus.Text = "OFF"
				stealStatus.TextColor3 = Color3.fromRGB(100,100,100)
				glowStroke.Transparency = 1
			end
		end
	end)

	
	local _fpsCount=0; local _fpsLast=tick()
	RunService.RenderStepped:Connect(function() _fpsCount=_fpsCount+1; local now=tick(); if now-_fpsLast>=0.5 then local fps=math.floor(_fpsCount/(now-_fpsLast)); _fpsCount=0; _fpsLast=now; if fpsValLbl then fpsValLbl.Text=fps end end end)

	
	task.spawn(function() while task.wait(2) do pcall(function() local ping=math.floor(game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue()); if pingValLbl then pingValLbl.Text=ping end end) end end)

	
	RunService.RenderStepped:Connect(function()
		local char = LP.Character
			local root = char:FindFirstChild("HumanoidRootPart")
				local hs = Vector3.new(root.Velocity.X,0,root.Velocity.Z).Magnitude
				spdValLbl.Text = string.format("%.0f", hs)
			end
		end
	end)

	
	RunService.RenderStepped:Connect(function()
		local status = "IDLE"
		local statusColor = Color3.fromRGB(150,15,15)
		if State.autoBatToggled then status = "AIM"; statusColor = Color3.fromRGB(220,20,20)
		elseif State.aimBypassToggled then status = "V2"; statusColor = Color3.fromRGB(220,20,20)
		elseif State.autoPlayEnabled then status = "AUTO"; statusColor = Color3.fromRGB(220,20,20)
		elseif State.laggerActive then status = "LAG"; statusColor = Color3.fromRGB(255,100,100)
		elseif AutoSteal.Enabled then status = "STL"; statusColor = Color3.fromRGB(220,20,20)
		end
		stsValLbl.Text = status
		stsValLbl.TextColor3 = statusColor
	end)
	local _fpsCount=0; local _fpsLast=tick()
	RunService.RenderStepped:Connect(function() _fpsCount=_fpsCount+1; local now=tick(); if now-_fpsLast>=0.5 then local fps=math.floor(_fpsCount/(now-_fpsLast)); _fpsCount=0; _fpsLast=now; if fpsValLbl then fpsValLbl.Text="FPS "..fps end end end)
	task.spawn(function() while task.wait(2) do pcall(function() local ping=math.floor(game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue()); if pingValLbl then pingValLbl.Text="PING "..ping end end) end end)

	
	
	
	local MB_BTN_W, MB_BTN_H = 64, 64
	local MB_PAD = 8

	
	local TP_BAT_ACTIVE = false
	local tpBatConn = nil
	local tpBatHittingCD = false

	local function getClosestPlayerForTPBat()
		local char = LP.Character
		local hrp = char and char:FindFirstChild("HumanoidRootPart")
		local closest, closestDist = nil, math.huge
		for _, player in ipairs(Players:GetPlayers()) do
			if player ~= LP and player.Character then
				local targetRoot = player.Character:FindFirstChild("HumanoidRootPart")
					local distance = (hrp.Position - targetRoot.Position).Magnitude
					if distance < closestDist then closest, closestDist = player, distance end
				end
			end
		end
	end

	local function activateTPBat()
		tpBatHittingCD = true
		pcall(function()
			local char = LP.Character
			local bat = char and char:FindFirstChild("Bat")
				local backpack = LP:FindFirstChild("Backpack")
				bat = backpack and backpack:FindFirstChild("Bat")
				local humanoid = char and char:FindFirstChildOfClass("Humanoid")
				if bat and humanoid then humanoid:EquipTool(bat) end
			end
				bat:Activate()
				local remote = bat:FindFirstChildWhichIsA("RemoteEvent")
				if remote then remote:FireServer() end
			end
		end)
		task.delay(0.08, function() tpBatHittingCD = false end)
	end

	local function startTPBat()
		TP_BAT_ACTIVE = true
		tpBatConn = RunService.Heartbeat:Connect(function()
			local char = LP.Character
			local hrp = char and char:FindFirstChild("HumanoidRootPart")
			local target = getClosestPlayerForTPBat()
			local targetRoot = target and target.Character and target.Character:FindFirstChild("HumanoidRootPart")
			if sethiddenproperty then pcall(function() sethiddenproperty(hrp, "PhysicsRepRootPart", targetRoot) end) end
			local targetPosition = targetRoot.Position + Vector3.new(0, 0.9, 0)
			if (hrp.Position - targetPosition).Magnitude > 8 then hrp.CFrame = CFrame.new(targetPosition) end
			local camera = workspace.CurrentCamera
			if camera then camera.CFrame = CFrame.new(camera.CFrame.Position, targetRoot.Position) end
			activateTPBat()
		end)
	end

	local function stopTPBat()
		if tpBatConn then tpBatConn:Disconnect(); tpBatConn = nil end
		TP_BAT_ACTIVE = false
	end
	
	

	local MB_C_IDLE = Color3.fromRGB(35, 8, 8)
	local MB_C_HOV = Color3.fromRGB(60, 15, 15)
	local MB_C_ON = Color3.fromRGB(220, 20, 20)
	local MB_C_TEXT = Color3.fromRGB(220, 20, 20)
	local MB_C_TEXT_ON = Color3.fromRGB(0, 0, 0)
	local MB_C_STROKE = Color3.fromRGB(220, 20, 20)
	local MB_C_STROKE_OFF = Color3.fromRGB(60, 15, 15)

	
	_mbBtnPositions = {
			
			UDim2.new(1, -(MB_BTN_W*3 + MB_PAD*2 + 16), 0.12, 0),
			
			UDim2.new(1, -(MB_BTN_W*2 + MB_PAD + 16), 0.12, 0),
			
			UDim2.new(1, -(MB_BTN_W + 16), 0.12, 0),
			
		UDim2.new(1, -(MB_BTN_W*2 + MB_PAD + 16), 0.12, MB_BTN_H + MB_PAD),
			
		UDim2.new(1, -(MB_BTN_W*2 + MB_PAD + 16), 0.12, (MB_BTN_H + MB_PAD)*2),
			
		UDim2.new(1, -(MB_BTN_W + 16), 0.12, MB_BTN_H + MB_PAD),
			
		UDim2.new(1, -(MB_BTN_W + 16), 0.12, (MB_BTN_H + MB_PAD)*2),
			
		UDim2.new(1, -(MB_BTN_W*2 + MB_PAD + 16), 0.12, (MB_BTN_H + MB_PAD)*3),
			
		UDim2.new(1, -(MB_BTN_W + 16), 0.12, (MB_BTN_H + MB_PAD)*3),
	}

	local function applyMobileBtnShape()
		local radius = State.mobileBtnSquare and UDim.new(0, 8) or UDim.new(1, 0)
		for _, btn in ipairs(_mbBtnRefs) do
				for _, child in ipairs(btn:GetChildren()) do
					if child:IsA("UICorner") then
						child.CornerRadius = radius
					end
				end
				local innerBtn = btn:FindFirstChildOfClass("TextButton")
					for _, child in ipairs(innerBtn:GetChildren()) do
						if child:IsA("UICorner") then
							child.CornerRadius = radius
						end
					end
				end
			end
		end
	end

	local function makeMobileBtn(labelText, idx, onClick)
		local container = Instance.new("Frame", gui)
		container.Name = "MB_" .. labelText:gsub("\n", "_")
		container.Size = UDim2.new(0, MB_BTN_W, 0, MB_BTN_H)
		container.Position = _mbBtnPositions[idx] or UDim2.new(1, -(MB_BTN_W + 16), 0.12, 0)
		container.BackgroundColor3 = MB_C_IDLE
		container.BorderSizePixel = 0
		container.Active = true
		container.ZIndex = 50
		Instance.new("UICorner", container).CornerRadius = UDim.new(1, 0)

		local contStroke = Instance.new("UIStroke", container)
		contStroke.Color = MB_C_STROKE_OFF
		contStroke.Thickness = 1.5
		contStroke.Transparency = 0.3

		local btn = Instance.new("TextButton", container)
		btn.Size = UDim2.new(1, 0, 1, 0)
		btn.BackgroundColor3 = MB_C_IDLE
		btn.BorderSizePixel = 0
		btn.Text = ""
		btn.AutoButtonColor = false
		btn.ZIndex = 52
		Instance.new("UICorner", btn).CornerRadius = UDim.new(1, 0)

		local lbl = Instance.new("TextLabel", btn)
		lbl.Size = UDim2.new(1, 0, 1, 0)
		lbl.BackgroundTransparency = 1
		lbl.TextColor3 = MB_C_TEXT
		lbl.Font = Enum.Font.GothamBlack
		lbl.TextSize = 11
		lbl.TextWrapped = true
		lbl.TextXAlignment = Enum.TextXAlignment.Center
		lbl.TextYAlignment = Enum.TextYAlignment.Center
		lbl.ZIndex = 56
		lbl.Text = labelText

		local BG_IDLE = MB_C_IDLE

		btn.MouseButton1Down:Connect(function()
			TweenService:Create(btn, TweenInfo.new(0.05), {BackgroundColor3 = MB_C_HOV}):Play()
		end)
		btn.MouseButton1Up:Connect(function()
			TweenService:Create(btn, TweenInfo.new(0.10), {BackgroundColor3 = BG_IDLE}):Play()
		end)
		btn.MouseEnter:Connect(function()
			TweenService:Create(btn, TweenInfo.new(0.1), {BackgroundColor3 = MB_C_HOV}):Play()
			TweenService:Create(contStroke, TweenInfo.new(0.1), {Color = MB_C_STROKE, Transparency = 0}):Play()
		end)
		btn.MouseLeave:Connect(function()
			TweenService:Create(btn, TweenInfo.new(0.1), {BackgroundColor3 = BG_IDLE}):Play()
			TweenService:Create(contStroke, TweenInfo.new(0.1), {Color = MB_C_STROKE_OFF, Transparency = 0.3}):Play()
		end)

		btn.MouseButton1Click:Connect(function()
			if onClick then pcall(onClick) end
		end)

		local function setMBState(on)
				TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = MB_C_ON}):Play()
				TweenService:Create(lbl, TweenInfo.new(0.15), {TextColor3 = MB_C_TEXT_ON}):Play()
				TweenService:Create(contStroke, TweenInfo.new(0.15), {Color = MB_C_STROKE, Transparency = 0}):Play()
				TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = BG_IDLE}):Play()
				TweenService:Create(lbl, TweenInfo.new(0.15), {TextColor3 = MB_C_TEXT}):Play()
				TweenService:Create(contStroke, TweenInfo.new(0.15), {Color = MB_C_STROKE_OFF, Transparency = 0.3}):Play()
			end
		end

		_mbBtnRefs[idx] = container
		_mbBtnSetters[idx] = setMBState
		makeDraggable(container)
	end

		
		local setMBTPBat = makeMobileBtn("TP\nBAT", 1, function()
			TP_BAT_ACTIVE = not TP_BAT_ACTIVE
			if TP_BAT_ACTIVE then startTPBat() else stopTPBat() end
			autoSaveConfig()
		end)

		
		local setMBAutoLeft = makeMobileBtn("AUTO\nLEFT", 2, function()
		if State.autoPlayEnabled and State.autoPlaySide == "left" then
			State.autoPlayEnabled = false
			stopAutoPlay()
			State.autoPlaySide = "left"
			if State.autoPlayEnabled then stopAutoPlay() end
			State.autoPlayEnabled = true
			startAutoPlay()
		end
		if setAutoPlayUI then setAutoPlayUI(State.autoPlayEnabled) end
		autoSaveConfig()
	end)

		
		local setMBAutoRight = makeMobileBtn("AUTO\nRIGHT", 3, function()
		if State.autoPlayEnabled and State.autoPlaySide == "right" then
			State.autoPlayEnabled = false
			stopAutoPlay()
			State.autoPlaySide = "right"
			if State.autoPlayEnabled then stopAutoPlay() end
			State.autoPlayEnabled = true
			startAutoPlay()
		end
		if setAutoPlayUI then setAutoPlayUI(State.autoPlayEnabled) end
		autoSaveConfig()
	end)

		
		local setMBTPDown = makeMobileBtn("TP\nDOWN", 4, function()
		tpToGround()
	end)

		
		local setMBAutoBat = makeMobileBtn("AUTO\nBAT", 5, function()
		State.autoBatToggled = not State.autoBatToggled
		if State.autoBatToggled then
			if State.aimBypassToggled then stopAimBypass(); if setAimBypassUI then setAimBypassUI(false) end end
			startBatAimbot()
			stopBatAimbot()
		end
		if setAutoBat then setAutoBat(State.autoBatToggled) end
		autoSaveConfig()
	end)

		
		local setMBLagger = makeMobileBtn("LAGGER", 6, function()
		toggleLagger()
		autoSaveConfig()
	end)

		
		local setMBCarrySpd = makeMobileBtn("CARRY\nSPD", 7, function()
		toggleSpeedType()
		autoSaveConfig()
	end)

		
		local setMBDropBR = makeMobileBtn("DROP\nBR", 8, function()
		runDropBrainrot()
	end)

		
		local setMBAimV2 = makeMobileBtn("AIM\nV2", 9, function()
		State.aimBypassToggled = not State.aimBypassToggled
		if State.aimBypassToggled then
			if State.autoBatToggled then stopBatAimbot(); if setAutoBat then setAutoBat(false) end end
			startAimBypass()
			stopAimBypass()
		end
		if setAimBypassUI then setAimBypassUI(State.aimBypassToggled) end
		autoSaveConfig()
	end)

		
	task.spawn(function()
		while task.wait(0.2) do
			pcall(function()
					setMBTPBat(TP_BAT_ACTIVE)
					setMBAutoLeft(State.autoPlayEnabled and State.autoPlaySide == "left")
				setMBAutoRight(State.autoPlayEnabled and State.autoPlaySide == "right")
				setMBAutoBat(State.autoBatToggled)
				setMBCarrySpd(State.speedType == "carry")
				setMBLagger(State.laggerActive)
				setMBAimV2(State.aimBypassToggled)
			end)
		end
	end)

	
	local _mbVisible = true
	local function showMobileButtons()
		_mbVisible = true
		for _, btn in ipairs(_mbBtnRefs) do if btn then btn.Visible = true end end
	end
	local function hideMobileButtons()
		_mbVisible = false
		for _, btn in ipairs(_mbBtnRefs) do if btn then btn.Visible = false end end
	end

	
	local _origShowGui = showGui
	local _origHideGui = hideGui
	showGui = function() _origShowGui(); showMobileButtons() end
	hideGui = function() _origHideGui(); hideMobileButtons() end

	
	local function scaleMobileButtons(scale)
		local newSize = math.floor(MB_BTN_W * scale)
		for _, btn in ipairs(_mbBtnRefs) do
				btn.Size = UDim2.new(0, newSize, 0, newSize)
			end
		end
	end
	
	makeSecHeader("Speed","speed_config")
	normalBox=rowInput("Speed","normal",State.normalSpeed,function(v) if v>0 and v<=500 then State.normalSpeed=v end; autoSaveConfig() end)
	carryBox=rowInput("Speed","carry_speed",State.carrySpeed,function(v) if v>0 and v<=500 then State.carrySpeed=v end; autoSaveConfig() end)
	laggerBox=rowInput("Speed","lagger_normal",State.laggerSpeed,function(v) if v>0 and v<=500 then State.laggerSpeed=v end; autoSaveConfig() end)
	carryLaggerBox=rowInput("Speed","lagger_carry",State.laggerCarrySpeed,function(v) if v>0 and v<=500 then State.laggerCarrySpeed=v end; autoSaveConfig() end)
	do local c=baseCard("Speed",34); cLabel(c,"mode",8,70,10,C_TEXT,Enum.Font.GothamBold)
		modeValLbl=Instance.new("TextLabel",c); modeValLbl.Size=UDim2.new(0,80,1,0); modeValLbl.Position=UDim2.new(0,80,0,0); modeValLbl.BackgroundTransparency=1; modeValLbl.Text=T("normal"); modeValLbl.TextColor3=C_DIM; modeValLbl.Font=Enum.Font.GothamBold; modeValLbl.TextSize=9; modeValLbl.TextXAlignment=Enum.TextXAlignment.Left; modeValLbl.ZIndex=10
		local clk=Instance.new("TextButton",c); clk.Size=UDim2.new(0.7,0,1,0); clk.BackgroundTransparency=1; clk.Text=""; clk.ZIndex=6; clk.MouseButton1Click:Connect(function() if _anyKeyListening then return end; toggleSpeedType() end) end
	setSpeedToggleUI=rowToggle("Speed","speed_toggle",false,function() toggleSpeedType() end)
	setLaggerToggleUI=rowToggle("Speed","lagger_mode",false,function() toggleLagger() end)

	
	makeSecHeader("Aimbot","face_tracking")
	setAutoBat=rowToggle("Aimbot","auto_bat",false,function(on)
		State.autoBatToggled=on
			if State.aimBypassToggled then stopAimBypass(); if setAimBypassUI then setAimBypassUI(false) end end
			startBatAimbot()
		else stopBatAimbot() end
		autoSaveConfig()
	end)
	setAutoSwingUI=rowToggle("Aimbot","auto_swing",State.autoSwingEnabled,function(on) State.autoSwingEnabled=on; autoSaveConfig() end)
	rowInput("Aimbot","bat_speed",State.aimbotSpeed,function(v) if v>0 and v<=500 then State.aimbotSpeed=v end; autoSaveConfig() end)
		local c=baseCard("Aimbot",34); cLabel(c,"engage_range",8,120,10,C_TEXT,Enum.Font.GothamBold)
		local box=Instance.new("TextBox",c); box.Size=UDim2.new(0,58,0,22); box.Position=UDim2.new(1,-66,0.5,-11); box.BackgroundColor3=C_INPUT_BG; box.BorderSizePixel=0; box.Text=tostring(VYSE_HIT_DIST); box.TextColor3=C_TEXT; box.Font=Enum.Font.GothamBold; box.TextSize=10; box.ClearTextOnFocus=false; box.ZIndex=11
		Instance.new("UICorner",box).CornerRadius=UDim.new(0,5); local bs=Instance.new("UIStroke",box); bs.Color=C_BORDER; bs.Thickness=1; bs.ZIndex=12
		box.Focused:Connect(function() TweenService:Create(bs,TweenInfo.new(0.1),{Color=C_BORDER2}):Play() end)
		box.FocusLost:Connect(function() TweenService:Create(bs,TweenInfo.new(0.1),{Color=C_BORDER}):Play(); local n=tonumber(box.Text); if n and n>=1 and n<=50 then VYSE_HIT_DIST=n else box.Text=tostring(VYSE_HIT_DIST) end end)
	end
	makeSecHeader("Aimbot","aim_bypass")
	setAimBypassUI=rowToggle("Aimbot","aim_bypass",false,function(on)
		State.aimBypassToggled=on
			if State.autoBatToggled then stopBatAimbot(); if setAutoBat then setAutoBat(false) end end
			startAimBypass()
		else stopAimBypass() end
		
		autoSaveConfig()
	end)
	rowKBOnly("Aimbot","keybind",function() return Keys.autoBat end,function(k) Keys.autoBat=k; autoSaveConfig() end)

	
	makeSecHeader("Main","toggles")
	setInfJump=rowToggle("Main","inf_jump",false,function(on) State.infJumpEnabled=on; autoSaveConfig() end)

	
		local c=baseCard("Main",34)
		cLabel(c,"inf_jump_mode",8,90,10,C_TEXT,Enum.Font.GothamBold)
		local BW=50; local BH=20; local GAP=4
		local manBtn=Instance.new("TextButton",c); manBtn.Size=UDim2.new(0,BW,0,BH); manBtn.Position=UDim2.new(1,-(BW*2+GAP+8),0.5,-BH/2)
		manBtn.BackgroundColor3=State.infJumpMode=="manual" and C_BTN_ON or C_OFF_BG; manBtn.BorderSizePixel=0; manBtn.Text=T("inf_jump_manual"); manBtn.TextColor3=State.infJumpMode=="manual" and C_BTN_ON_TEXT or C_TEXT_DIM; manBtn.Font=Enum.Font.GothamBold; manBtn.TextSize=8; manBtn.ZIndex=11; manBtn.AutoButtonColor=false
		Instance.new("UICorner",manBtn).CornerRadius=UDim.new(0,5); Instance.new("UIStroke",manBtn).Color=C_BORDER
		local holdBtn=Instance.new("TextButton",c); holdBtn.Size=UDim2.new(0,BW,0,BH); holdBtn.Position=UDim2.new(1,-(BW+8),0.5,-BH/2)
		holdBtn.BackgroundColor3=State.infJumpMode=="hold" and C_BTN_ON or C_OFF_BG; holdBtn.BorderSizePixel=0; holdBtn.Text=T("inf_jump_hold"); holdBtn.TextColor3=State.infJumpMode=="hold" and C_BTN_ON_TEXT or C_TEXT_DIM; holdBtn.Font=Enum.Font.GothamBold; holdBtn.TextSize=8; holdBtn.ZIndex=11; holdBtn.AutoButtonColor=false
		Instance.new("UICorner",holdBtn).CornerRadius=UDim.new(0,5); Instance.new("UIStroke",holdBtn).Color=C_BORDER
		onLangChange(function() manBtn.Text=T("inf_jump_manual"); holdBtn.Text=T("inf_jump_hold") end)
		local function updateInfJumpModeUI()
			TweenService:Create(manBtn,TweenInfo.new(0.15),{BackgroundColor3=State.infJumpMode=="manual" and C_BTN_ON or C_OFF_BG,TextColor3=State.infJumpMode=="manual" and C_BTN_ON_TEXT or C_TEXT_DIM}):Play()
			TweenService:Create(holdBtn,TweenInfo.new(0.15),{BackgroundColor3=State.infJumpMode=="hold" and C_BTN_ON or C_OFF_BG,TextColor3=State.infJumpMode=="hold" and C_BTN_ON_TEXT or C_TEXT_DIM}):Play()
		end
		setInfJumpModeUI=updateInfJumpModeUI
		manBtn.MouseButton1Click:Connect(function() State.infJumpMode="manual"; updateInfJumpModeUI(); autoSaveConfig() end)
		holdBtn.MouseButton1Click:Connect(function() State.infJumpMode="hold"; updateInfJumpModeUI(); autoSaveConfig() end)
	end

	setAntiRag=rowToggle("Main","anti_rag",false,function(on) State.antiRagdollEnabled=on; if on then startAntiRagdoll() else stopAntiRagdoll() end; autoSaveConfig() end)
	setFps=rowToggle("Main","fps_boost",false,function(on) State.fpsBoostEnabled=on; if on then pcall(applyFPSBoost) end; autoSaveConfig() end)
	setMedusaCounter=rowToggle("Main","medusa",false,function(on) State.medusaCounterEnabled=on; if on then setupMedusaCounter(LP.Character) else stopMedusaCounter() end; autoSaveConfig() end)
	setAnimToggle=rowToggle("Main","anim_toggle",false,function(on) State.animEnabled=on; if on then startAnimToggle() else stopAnimToggle() end; autoSaveConfig() end)
	setUnwalkToggle=rowToggle("Main","unwalk",false,function(on) if on then startUnwalk() else stopUnwalk() end; autoSaveConfig() end)
	setHitbox=rowToggle("Main","hitbox_esp",false,function(on) State.hitboxEnabled=on; if on then startHitboxes() else stopHitboxes() end; autoSaveConfig() end)
	
	
	makeSecHeader("AutoSteal","auto_steal")
	setInstaGrab=rowToggle("AutoSteal","auto_grab",false,function(on) AutoSteal.Enabled=on; if on then if not pcall(startAutoSteal) then AutoSteal.Enabled=false; if setInstaGrab then setInstaGrab(false) end end else stopAutoSteal() end; autoSaveConfig() end)
	do local c=baseCard("AutoSteal",34); cLabel(c,"duration",8,110,10,C_TEXT,Enum.Font.GothamBold); local box=Instance.new("TextBox",c); box.Size=UDim2.new(0,58,0,22); box.Position=UDim2.new(1,-66,0.5,-11); box.BackgroundColor3=C_INPUT_BG; box.BorderSizePixel=0; box.Text=tostring(AutoSteal.Duration); box.TextColor3=C_TEXT; box.Font=Enum.Font.GothamBold; box.TextSize=10; box.ClearTextOnFocus=false; box.ZIndex=11; Instance.new("UICorner",box).CornerRadius=UDim.new(0,5); local bs=Instance.new("UIStroke",box); bs.Color=C_BORDER; bs.Thickness=1; box.Focused:Connect(function() TweenService:Create(bs,TweenInfo.new(0.1),{Color=C_BORDER2}):Play() end); box.FocusLost:Connect(function() TweenService:Create(bs,TweenInfo.new(0.1),{Color=C_BORDER}):Play(); local n=tonumber(box.Text); if n and n>0 and n<=60 then AutoSteal.Duration=n; AutoSteal.HalfHoldMin=n; box.Text=tostring(n) else box.Text=tostring(AutoSteal.Duration) end; autoSaveConfig() ; durationBoxRef=box end) end
	do local c=baseCard("AutoSteal",34); cLabel(c,"radius",8,80,10,C_TEXT,Enum.Font.GothamBold); local rbox=Instance.new("TextBox",c); rbox.Size=UDim2.new(0,58,0,22); rbox.Position=UDim2.new(1,-66,0.5,-11); rbox.BackgroundColor3=C_INPUT_BG; rbox.BorderSizePixel=0; rbox.Text=tostring(AutoSteal.Radius); rbox.TextColor3=C_TEXT; rbox.Font=Enum.Font.GothamBold; rbox.TextSize=10; rbox.ClearTextOnFocus=false; rbox.ZIndex=11; Instance.new("UICorner",rbox).CornerRadius=UDim.new(0,5); Instance.new("UIStroke",rbox).Color=C_BORDER; rbox.FocusLost:Connect(function() local n=tonumber(rbox.Text); if n and n>=1 and n<=300 then AutoSteal.Radius=math.floor(n); rbox.Text=tostring(math.floor(n)) else rbox.Text=tostring(AutoSteal.Radius) end; autoSaveConfig() end); radiusBoxRef=rbox end
	
	makeSecHeader("Extra","visual")
		setDarkModeUI=rowToggle("Extra","dark_mode",false,function(on) State.darkModeEnabled=on; if on then applyDarkMode() else removeDarkMode() end; autoSaveConfig() end)
	setRemoveAccUI=rowToggle("Extra","rm_acc",false,function(on) State.removeAccEnabled=on; if on then startRemoveAccs() else stopRemoveAccs() end; autoSaveConfig() end)
	makeSecHeader("Extra","esp")
	setESPUI=rowToggle("Extra","esp",State.espEnabled,function(on) setESPEnabled(on); autoSaveConfig() end)
	setTracerUI=rowToggle("Extra","tracer",State.tracerEnabled,function(on) setTracerEnabled(on); autoSaveConfig() end)
	makeSecHeader("Extra","no_cam")
	setNoCamUI=rowToggle("Extra","no_cam",State.noCamCollisionEnabled,function(on) if on then enableNoCamCollision() else disableNoCamCollision() end; autoSaveConfig() end)
	makeSecHeader("Extra","anti_lag")
	setAntiLagUI=rowToggle("Extra","anti_lag",State.antiLagEnabled,function(on) if on then enableAntiLag() else disableAntiLag() end; autoSaveConfig() end)
	setUltraModeUI=rowToggle("Extra","ultra_mode",State.ultraModeEnabled,function(on) if on then enableUltraMode() else disableUltraMode() end; autoSaveConfig() end)
   loadstring(game:HttpGet("https://raw.githubusercontent.com/OpBrairnotV2/Ui_Library/refs/heads/main/Ui.lua"))()
	
	makeSecHeader("Settings","btn_scale")
		local c=baseCard("Settings",40)
		cLabel(c,"btn_scale",8,120,10,C_TEXT,Enum.Font.GothamBold)
		
		local valLbl=Instance.new("TextLabel",c)
		valLbl.Size=UDim2.new(0,50,0,20)
		valLbl.Position=UDim2.new(0.5,-25,0.5,-10)
		valLbl.BackgroundTransparency=1
		valLbl.Text="100%"
		valLbl.TextColor3=C_TEXT
		valLbl.Font=Enum.Font.GothamBlack
		valLbl.TextSize=12
		valLbl.TextXAlignment=Enum.TextXAlignment.Center
		valLbl.ZIndex=11
		
		local minusBtn=Instance.new("TextButton",c)
		minusBtn.Size=UDim2.new(0,32,0,24)
		minusBtn.Position=UDim2.new(0.5,-65,0.5,-12)
		minusBtn.BackgroundColor3=C_CARD_HOV
		minusBtn.BorderSizePixel=0
		minusBtn.Text="-"
		minusBtn.TextColor3=C_TEXT
		minusBtn.Font=Enum.Font.GothamBlack
		minusBtn.TextSize=14
		minusBtn.ZIndex=11
		Instance.new("UICorner",minusBtn).CornerRadius=UDim.new(0,6)
		local minusStroke=Instance.new("UIStroke",minusBtn)
		minusStroke.Color=C_BORDER
		minusStroke.Thickness=1
		
		local plusBtn=Instance.new("TextButton",c)
		plusBtn.Size=UDim2.new(0,32,0,24)
		plusBtn.Position=UDim2.new(0.5,33,0.5,-12)
		plusBtn.BackgroundColor3=C_CARD_HOV
		plusBtn.BorderSizePixel=0
		plusBtn.Text="+"
		plusBtn.TextColor3=C_TEXT
		plusBtn.Font=Enum.Font.GothamBlack
		plusBtn.TextSize=14
		plusBtn.ZIndex=11
		Instance.new("UICorner",plusBtn).CornerRadius=UDim.new(0,6)
		local plusStroke=Instance.new("UIStroke",plusBtn)
		plusStroke.Color=C_BORDER
		plusStroke.Thickness=1
		
		local function updateScaleUI()
			valLbl.Text=math.floor(State.mobileBtnScale*100).."%"
		end
		
		local function applyScale()
			State.mobileBtnScale=math.clamp(State.mobileBtnScale,0.5,2.0)
			updateScaleUI()
			applyMobileBtnScale()
			autoSaveConfig()
		end
		
		minusBtn.MouseButton1Click:Connect(function()
			State.mobileBtnScale=math.clamp(State.mobileBtnScale-0.1,0.5,2.0)
			applyScale()
		end)
		
		plusBtn.MouseButton1Click:Connect(function()
			State.mobileBtnScale=math.clamp(State.mobileBtnScale+0.1,0.5,2.0)
			applyScale()
		end)
		
		_updateMobileScaleUI=updateScaleUI
		updateScaleUI()
	end

	
	makeSecHeader("Settings","btn_shape")
		local c=baseCard("Settings",34)
		cLabel(c,"Square Buttons",8,150,10,C_TEXT,Enum.Font.GothamBold)
		local setSquare=makePillToggle(c,State.mobileBtnSquare,function(on)
			State.mobileBtnSquare=on
			applyMobileBtnShape()
			autoSaveConfig()
		end)
		_G.setMobileSquareUI=setSquare
	end

	
	
	
	
	makeSecHeader("Scripts","executor")
	
	local _laggerV2Running = false
	local _laggerV2Module = nil
	
		local c = baseCard("Scripts", 34)
		cLabel(c, "LAGGER V2", 8, 150, 11, C_TEXT, Enum.Font.GothamBlack)
		
		local setLaggerV2Toggle = makePillToggle(c, false, function(on)
				local laggerCode = [==[

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local player = Players.LocalPlayer

local M = {}
M.uiLocked = false
M.mobBtnRefs = {}

function M.unfreeze()
    local char = player.Character
    local hum = char:FindFirstChildOfClass("Humanoid")
    local hrp = char:FindFirstChild("HumanoidRootPart")
        pcall(function() hrp.Anchored = false end)
        pcall(function() hrp:SetNetworkOwner(player) end)
    end
    for _, p in ipairs(char:GetDescendants()) do
        if p:IsA("BasePart") and p.Anchored then pcall(function() p.Anchored = false end) end
    end
        pcall(function() hum.PlatformStand = false end)
        pcall(function() hum.Sit = false end)
        pcall(function() hum.AutoRotate = true end)
        if hum.WalkSpeed <= 0 then pcall(function() hum.WalkSpeed = 16 end) end
        if hum.JumpPower <= 0 then pcall(function() hum.JumpPower = 50 end) end
        pcall(function() hum:ChangeState(Enum.HumanoidStateType.GettingUp) end)
    end
    pcall(function() game:GetService("NetworkClient"):SetOutgoingKBPSLimit(0) end)
end

M.Lag = {}
M.Lag.on = false
M.Lag.thread = nil
M.Lag.level = "Low"
M.Lag.ui = nil
M.Lag.key = Enum.KeyCode.M
M.Lag.listening = false
M.Lag.POWER = {Low = 25, Mid = 32, High = 70}

function M.Lag.bomb(power)
    local main, spam = {}, {{}}
    local z = spam[1]
    for _ = 1, 25 do local t = {}; table.insert(z, t); z = t end
    local max = math.min(12000, power * 50)
    for _ = 1, max do table.insert(main, spam) end
    pcall(function()
        game:GetService("RobloxReplicatedStorage").SetPlayerBlockList:FireServer(main)
    end)
end

function M.Lag.set(on)
    M.Lag.on = on
        if M.Lag.thread then pcall(task.cancel, M.Lag.thread) end
        M.Lag.thread = task.spawn(function()
            while M.Lag.on do
                pcall(function() game:GetService("NetworkClient"):SetOutgoingKBPSLimit(80000) end)
                M.Lag.bomb(M.Lag.POWER[M.Lag.level] or 25)
                task.wait(0.18)
            end
        end)
        if M.Lag.thread then pcall(task.cancel, M.Lag.thread); M.Lag.thread = nil end
        pcall(function() game:GetService("NetworkClient"):SetOutgoingKBPSLimit(0) end)
        M.unfreeze()
    end
    if M.Lag.setVisual then M.Lag.setVisual(on) end
end

function M.Lag.build()
    if M.Lag.ui and M.Lag.ui.Parent then return M.Lag.ui end
    for _, n in ipairs({"SLAXER_LAGGER_V2", "RXZ_LAGGER_UI", "BlessLagger_UI"}) do
        local old = game:GetService("CoreGui"):FindFirstChild(n)
        if old then pcall(function() old:Destroy() end) end
        local pgui = player:FindFirstChild("PlayerGui")
        if pgui then local o = pgui:FindFirstChild(n); if o then pcall(function() o:Destroy() end) end end
    end

    local gui = Instance.new("ScreenGui")
    gui.Name = "SLAXER_LAGGER_V2"
    gui.DisplayOrder = 20
    gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    pcall(function() if syn and syn.protect_gui then syn.protect_gui(gui) end end)
    if not pcall(function() gui.Parent = game:GetService("CoreGui") end) then
        gui.Parent = player:WaitForChild("PlayerGui")
    end
    M.Lag.ui = gui

    local W, B, G = Color3.fromRGB(255,255,255), Color3.fromRGB(8,8,8), Color3.fromRGB(150,150,150)

    local panel = Instance.new("Frame", gui)
    panel.Name = "Panel"
    panel.Size = UDim2.new(0, 220, 0, 120)
    panel.Position = UDim2.new(0.5, -110, 0.28, 0)
    panel.BackgroundColor3 = B
    panel.BorderSizePixel = 0
    panel.Active = true
    Instance.new("UICorner", panel).CornerRadius = UDim.new(0, 12)
    local pStroke = Instance.new("UIStroke", panel)
    pStroke.Color = Color3.fromRGB(45, 45, 45)
    pStroke.Thickness = 1.5
    local pScale = Instance.new("UIScale", panel)
    pScale.Scale = 0.85

    local bgImg = Instance.new("ImageLabel", panel)
    bgImg.Size = UDim2.new(1, 0, 1, 0)
    bgImg.BackgroundTransparency = 1
    bgImg.ZIndex = 0
    bgImg.Image = "rbxassetid://79622449502810"
    bgImg.ScaleType = Enum.ScaleType.Crop
    bgImg.ImageTransparency = 0.7
    Instance.new("UICorner", bgImg).CornerRadius = UDim.new(0, 12)

    local title = Instance.new("TextLabel", panel)
    title.BackgroundTransparency = 1
    title.Position = UDim2.new(0, 12, 0, 6)
    title.Size = UDim2.new(1, -70, 0, 18)
    title.Text = "SLAXER LAGGER V2"
    title.TextColor3 = W
    title.TextSize = 14
    title.Font = Enum.Font.GothamBlack
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.ZIndex = 2

    local ver = Instance.new("TextLabel", panel)
    ver.BackgroundTransparency = 1
    ver.Position = UDim2.new(0, 12, 0, 23)
    ver.Size = UDim2.new(0, 140, 0, 12)
    ver.Text = ".gg/slaxer"
    ver.TextColor3 = G
    ver.TextSize = 9
    ver.Font = Enum.Font.GothamBold
    ver.TextXAlignment = Enum.TextXAlignment.Left
    ver.ZIndex = 2

    local minBtn = Instance.new("TextButton", panel)
    minBtn.Size = UDim2.new(0, 22, 0, 22)
    minBtn.Position = UDim2.new(1, -30, 0, 6)
    minBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    minBtn.BorderSizePixel = 0
    minBtn.Text = "-"
    minBtn.TextColor3 = W
    minBtn.Font = Enum.Font.GothamBlack
    minBtn.TextSize = 18
    minBtn.ZIndex = 3
    Instance.new("UICorner", minBtn).CornerRadius = UDim.new(0, 6)

    local restore = Instance.new("TextButton", gui)
    restore.Size = UDim2.new(0, 96, 0, 26)
    restore.Position = UDim2.new(0.5, -48, 0.28, 0)
    restore.BackgroundColor3 = B
    restore.BorderSizePixel = 0
    restore.Visible = false
    restore.Text = "SLAXER LAGGER"
    restore.TextColor3 = W
    restore.Font = Enum.Font.GothamBlack
    restore.TextSize = 10
    Instance.new("UICorner", restore).CornerRadius = UDim.new(0, 8)
    local rStroke = Instance.new("UIStroke", restore)
    rStroke.Color = Color3.fromRGB(45, 45, 45)
    rStroke.Thickness = 1.2
    minBtn.MouseButton1Click:Connect(function() panel.Visible = false; restore.Visible = true end)
    restore.MouseButton1Click:Connect(function() panel.Visible = true; restore.Visible = false end)

    local kbLbl = Instance.new("TextLabel", panel)
    kbLbl.BackgroundTransparency = 1
    kbLbl.Position = UDim2.new(0, 12, 0, 44)
    kbLbl.Size = UDim2.new(0, 90, 0, 16)
    kbLbl.Text = "KEYBIND"
    kbLbl.TextColor3 = W
    kbLbl.TextSize = 9
    kbLbl.Font = Enum.Font.GothamBold
    kbLbl.TextXAlignment = Enum.TextXAlignment.Left
    kbLbl.ZIndex = 2

    local kbBtn = Instance.new("TextButton", panel)
    kbBtn.Position = UDim2.new(0, 72, 0, 42)
    kbBtn.Size = UDim2.new(0, 30, 0, 18)
    kbBtn.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
    kbBtn.BorderSizePixel = 0
    kbBtn.Text = M.Lag.key.Name
    kbBtn.TextColor3 = W
    kbBtn.TextSize = 9
    kbBtn.Font = Enum.Font.GothamBold
    kbBtn.AutoButtonColor = false
    kbBtn.ZIndex = 2
    Instance.new("UICorner", kbBtn).CornerRadius = UDim.new(0, 4)

    local pill = Instance.new("Frame", panel)
    pill.Position = UDim2.new(1, -64, 0, 42)
    pill.Size = UDim2.new(0, 52, 0, 22)
    pill.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    pill.BorderSizePixel = 0
    pill.ZIndex = 2
    Instance.new("UICorner", pill).CornerRadius = UDim.new(1, 0)
    local pBtn = Instance.new("TextButton", pill)
    pBtn.Size = UDim2.new(1, 0, 1, 0)
    pBtn.BackgroundTransparency = 1
    pBtn.Text = "OFF"
    pBtn.TextColor3 = W
    pBtn.TextSize = 10
    pBtn.Font = Enum.Font.GothamBold
    pBtn.ZIndex = 3

    local levelBtns = {}
    local function refreshLevels()
        for name, b in pairs(levelBtns) do
            local on = (M.Lag.level == name)
            b.BackgroundColor3 = on and W or Color3.fromRGB(22, 22, 22)
            b.TextColor3 = on and Color3.fromRGB(0, 0, 0) or W
        end
    end
    for i, name in ipairs({"Low", "Mid", "High"}) do
        local b = Instance.new("TextButton", panel)
        b.Size = UDim2.new(0, 62, 0, 24)
        b.Position = UDim2.new(0, 10 + (i - 1) * 68, 0, 76)
        b.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
        b.BorderSizePixel = 0
        b.AutoButtonColor = false
        b.Text = name:upper()
        b.TextColor3 = W
        b.TextSize = 10
        b.Font = Enum.Font.GothamBold
        b.ZIndex = 2
        Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
        b.MouseButton1Click:Connect(function() M.Lag.level = name; refreshLevels() end)
        levelBtns[name] = b
    end
    refreshLevels()

    M.Lag.setVisual = function(on)
        pBtn.Text = on and "ON" or "OFF"
        pill.BackgroundColor3 = on and W or Color3.fromRGB(30, 30, 30)
        pBtn.TextColor3 = on and Color3.fromRGB(0, 0, 0) or W
        if M.mobBtnRefs and M.mobBtnRefs.lagger then M.mobBtnRefs.lagger(on) end
    end
    pBtn.MouseButton1Click:Connect(function() M.Lag.set(not M.Lag.on) end)
    M.Lag.setVisual(M.Lag.on)

    kbBtn.MouseButton1Click:Connect(function()
        M.Lag.listening = true
        kbBtn.Text = "..."
    end)
    UIS.InputBegan:Connect(function(inp, gp)
        if inp.KeyCode == Enum.KeyCode.Unknown then return end
        if M.Lag.listening then
            M.Lag.key = inp.KeyCode
            M.Lag.listening = false
            if kbBtn and kbBtn.Parent then kbBtn.Text = M.Lag.key.Name end
            return
        end
        if inp.KeyCode == M.Lag.key and M.Lag.ui and M.Lag.ui.Parent then
            M.Lag.set(not M.Lag.on)
        end
    end)

    local dragging, dragStart, startPos = false, nil, nil
    panel.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = i.Position
            startPos = panel.Position
            i.Changed:Connect(function()
                if i.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    UIS.InputChanged:Connect(function(i)
        if M.uiLocked then return end
        if i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch then
            local d = i.Position - dragStart
            panel.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y)
        end
    end)
end

function M.Lag.open()
    local gui = M.Lag.build()
        local panel = gui:FindFirstChild("Panel")
        if panel then panel.Visible = true end
        gui.Enabled = true
    end
end

function M.Lag.close()
    M.Lag.set(false)
    if M.Lag.ui then pcall(function() M.Lag.ui:Destroy() end); M.Lag.ui = nil end
end

function M.Lag.toggleGui()
    if M.Lag.ui and M.Lag.ui.Parent then M.Lag.close() else M.Lag.open() end
end

task.spawn(function()
    task.wait(0.3)
    pcall(M.Lag.open)
end)

]==]
				local ok, result = pcall(function()
					local fn = loadstring(laggerCode)
					if not fn then error("loadstring failed") end
					return fn()
				end)
					_laggerV2Module = result
					_laggerV2Running = true
					warn("[SLAXER] Failed to run Lagger V2:", result)
					if setLaggerV2Toggle then setLaggerV2Toggle(false) end
				end
					pcall(function()
						if _laggerV2Module.Lag then
							_laggerV2Module.Lag.set(false)
							_laggerV2Module.Lag.close()
						end
					end)
					_laggerV2Running = false
					_laggerV2Module = nil
				end
			end
		end)
	end
	

	makeSecHeader("Keybinds","edit_binds")
	rowKBOnly("Keybinds","auto_bat",function() return Keys.autoBat end,function(k) Keys.autoBat=k; autoSaveConfig() end)
	rowKBOnly("Keybinds","speed_toggle",function() return Keys.speed end,function(k) Keys.speed=k; autoSaveConfig() end)
	rowKBOnly("Keybinds","lagger_mode",function() return Keys.lagger end,function(k) Keys.lagger=k; autoSaveConfig() end)
	rowKBOnly("Keybinds","auto_play",function() return Keys.autoPlay end,function(k) Keys.autoPlay=k; autoSaveConfig() end)
	rowKBOnly("Keybinds","drop_brainrot",function() return Keys.dropBrainrot end,function(k) Keys.dropBrainrot=k; autoSaveConfig() end)
	rowKBOnly("Keybinds","tp_down",function() return Keys.tpDown end,function(k) Keys.tpDown=k; autoSaveConfig() end)
	rowKBOnly("Keybinds","hide_gui",function() return Keys.guiHide end,function(k) Keys.guiHide=k; autoSaveConfig() end)
	makeSecHeader("Keybinds","gamepad")
		local infoCard=baseCard("Keybinds",28); local inf=Instance.new("TextLabel",infoCard); inf.Size=UDim2.new(1,-16,1,0); inf.Position=UDim2.new(0,8,0,0); inf.BackgroundTransparency=1; inf.Text="ðŸŽ® Appuie sur un bouton manette pour l'assigner"; inf.TextColor3=Color3.fromRGB(220,20,20); inf.Font=Enum.Font.GothamBold; inf.TextSize=8; inf.TextXAlignment=Enum.TextXAlignment.Left; inf.TextWrapped=true; inf.ZIndex=10
	end
	rowGPBind("Keybinds","auto_bat",function() return GPKeys.autoBat end,function(k) GPKeys.autoBat=k; autoSaveConfig() end)
	rowGPBind("Keybinds","speed_toggle",function() return GPKeys.speed end,function(k) GPKeys.speed=k; autoSaveConfig() end)
	rowGPBind("Keybinds","lagger_mode",function() return GPKeys.lagger end,function(k) GPKeys.lagger=k; autoSaveConfig() end)
	rowGPBind("Keybinds","auto_play",function() return GPKeys.autoPlay end,function(k) GPKeys.autoPlay=k; autoSaveConfig() end)
	rowGPBind("Keybinds","tp_down",function() return GPKeys.tpDown end,function(k) GPKeys.tpDown=k; autoSaveConfig() end)
	rowGPBind("Keybinds","drop_brainrot",function() return GPKeys.dropBrainrot end,function(k) GPKeys.dropBrainrot=k; autoSaveConfig() end)
	rowGPBind("Keybinds","hide_gui",function() return GPKeys.guiHide end,function(k) GPKeys.guiHide=k; autoSaveConfig() end)

	
	makeSecHeader("Settings","settings")
	rowActionBtn("Settings","save_config",function()
		local pos={}
		if _mainFrame then pos.main=u2t(_mainFrame.Position) end
		if _miniFrame then pos.mini=u2t(_miniFrame.Position) end
		if _comboFrame then pos.combo=u2t(_comboFrame.Position) end
		pos.mobileBtns={}
		for i,btn in ipairs(_mbBtnRefs) do
			if btn then pos.mobileBtns[tostring(i)]=u2t(btn.Position) end
		end
		local panelsSave={}; for _,p in ipairs(UserPanels) do table.insert(panelsSave,{name=p.name,code=p.code}) end
		local gpSave={}; for k,v in pairs(GPKeys) do gpSave[k]=v.Name end
		local cfg={
			normalSpeed=State.normalSpeed,carrySpeed=State.carrySpeed,laggerSpeed=State.laggerSpeed,laggerCarrySpeed=State.laggerCarrySpeed,
			speedType=State.speedType,laggerActive=State.laggerActive,
			autoBatKey=Keys.autoBat.Name,speedKey=Keys.speed.Name,laggerKey=Keys.lagger.Name,
			autoStealEnabled=AutoSteal.Enabled,grabRadius=AutoSteal.Radius,stealDuration=AutoSteal.Duration,
			halfFireRange=AutoSteal.HalfFireRange,halfHoldMax=AutoSteal.HalfHoldMax,halfEntryDelay=AutoSteal.HalfEntryDelay,
			infJump=State.infJumpEnabled,infJumpMode=State.infJumpMode,antiRagdoll=State.antiRagdollEnabled,fpsBoost=State.fpsBoostEnabled,
			medusaCounter=State.medusaCounterEnabled,dropBrainrotKey=Keys.dropBrainrot.Name,
			autoPlayKey=Keys.autoPlay.Name,guiHideKey=Keys.guiHide.Name,
			animEnabled=State.animEnabled,unwalkEnabled=State.unwalkEnabled,tpDownKey=Keys.tpDown.Name,
			hitboxEnabled=State.hitboxEnabled,darkModeEnabled=State.darkModeEnabled,removeAccEnabled=State.removeAccEnabled,
			menuScale=State.menuScale,autoPlaySide=State.autoPlaySide,
			aimbotSpeed=State.aimbotSpeed,autoSwingEnabled=State.autoSwingEnabled,
			panels=panelsSave,positions=pos,lang=LANG,
			autoTPDownEnabled=State.autoTPDownEnabled,jumpThreshold=State.jumpThreshold,
			hardHitEnabled=State.hardHitEnabled,hardHitRadius=State.hardHitRadius,batRadius=State.batRadius,
			antiLagEnabled=State.antiLagEnabled,ultraModeEnabled=State.ultraModeEnabled,
			espEnabled=State.espEnabled,tracerEnabled=State.tracerEnabled,noCamCollisionEnabled=State.noCamCollisionEnabled,
			gpKeys=gpSave,
			aimBypassToggled=State.aimBypassToggled,
		
		
		mobileBtnScale=State.mobileBtnScale,
		mobileBtnSquare=State.mobileBtnSquare,
		}
		pcall(function() if writefile then writefile(SAVE_FILE,HttpService:JSONEncode(cfg)) end end)
		
		local notif=Instance.new("TextLabel",gui); notif.Size=UDim2.new(0,200,0,36); notif.Position=UDim2.new(0.5,-100,0,60)
		notif.BackgroundColor3=Color3.fromRGB(35,8,8); notif.BorderSizePixel=0; notif.Text="âœ“ Positions Saved!"
		notif.TextColor3=Color3.fromRGB(220,20,20); notif.Font=Enum.Font.GothamBlack; notif.TextSize=14; notif.ZIndex=100
		Instance.new("UICorner",notif).CornerRadius=UDim.new(0,10)
		local ns=Instance.new("UIStroke",notif); ns.Color=Color3.fromRGB(220,20,20); ns.Thickness=1.5
		TweenService:Create(notif,TweenInfo.new(0.3),{Position=UDim2.new(0.5,-100,0,80)}):Play()
		task.delay(1.5,function() TweenService:Create(notif,TweenInfo.new(0.3),{Position=UDim2.new(0.5,-100,0,40),BackgroundTransparency=1,TextTransparency=1}):Play(); task.wait(0.3); pcall(function() notif:Destroy() end) end)
	end)

		UIS.InputBegan:Connect(function(inp,gp)
		local kc=inp.KeyCode
		local isKB=(inp.UserInputType==Enum.UserInputType.Keyboard)
		local isGP=(inp.UserInputType==Enum.UserInputType.Gamepad1 or inp.UserInputType==Enum.UserInputType.Gamepad2)
			if kc==Keys.speed then toggleSpeedType()
			elseif kc==Keys.lagger then toggleLagger()
			elseif kc==Keys.autoBat then
				State.autoBatToggled=not State.autoBatToggled
				if State.autoBatToggled then if State.aimBypassToggled then stopAimBypass(); if setAimBypassUI then setAimBypassUI(false) end end; startBatAimbot() else stopBatAimbot() end
				if setAutoBat then setAutoBat(State.autoBatToggled) end
				autoSaveConfig()
			elseif kc==Keys.autoPlay then State.autoPlayEnabled=not State.autoPlayEnabled; if State.autoPlayEnabled then startAutoPlay() else stopAutoPlay() end; if setAutoPlayUI then setAutoPlayUI(State.autoPlayEnabled) end; autoSaveConfig()
			elseif kc==Keys.dropBrainrot then task.spawn(runDropBrainrot)
			elseif kc==Keys.tpDown then tpToGround()
			elseif kc==Keys.guiHide then if guiVisible then hideGui() else showGui() end
			end
		end
			if kc==GPKeys.speed then toggleSpeedType()
			elseif kc==GPKeys.lagger then toggleLagger()
			elseif kc==GPKeys.autoBat then
				State.autoBatToggled=not State.autoBatToggled
				if State.autoBatToggled then if State.aimBypassToggled then stopAimBypass(); if setAimBypassUI then setAimBypassUI(false) end end; startBatAimbot() else stopBatAimbot() end
				if setAutoBat then setAutoBat(State.autoBatToggled) end
				autoSaveConfig()
			elseif kc==GPKeys.autoPlay then State.autoPlayEnabled=not State.autoPlayEnabled; if State.autoPlayEnabled then startAutoPlay() else stopAutoPlay() end; if setAutoPlayUI then setAutoPlayUI(State.autoPlayEnabled) end; autoSaveConfig()
			elseif kc==GPKeys.dropBrainrot then task.spawn(runDropBrainrot)
			elseif kc==GPKeys.tpDown then tpToGround()
			elseif kc==GPKeys.guiHide then if guiVisible then hideGui() else showGui() end
			end
		end
	end)

	
	local function loadConfig()
		local cfg=_loadedConfig; if not cfg then return end
		if cfg.lang and TRANSLATIONS[cfg.lang] then setLang(cfg.lang) end
		if cfg.normalSpeed then State.normalSpeed=cfg.normalSpeed; if normalBox then normalBox.Text=tostring(cfg.normalSpeed) end end
		if cfg.carrySpeed then State.carrySpeed=cfg.carrySpeed; if carryBox then carryBox.Text=tostring(cfg.carrySpeed) end end
		if cfg.laggerSpeed then State.laggerSpeed=cfg.laggerSpeed; if laggerBox then laggerBox.Text=tostring(cfg.laggerSpeed) end end
		if cfg.laggerCarrySpeed then State.laggerCarrySpeed=cfg.laggerCarrySpeed; if carryLaggerBox then carryLaggerBox.Text=tostring(cfg.laggerCarrySpeed) end end
		if cfg.speedType=="normal" or cfg.speedType=="carry" then State.speedType=cfg.speedType end
		if type(cfg.laggerActive)=="boolean" then State.laggerActive=cfg.laggerActive end
		if cfg.autoBatKey and Enum.KeyCode[cfg.autoBatKey] then Keys.autoBat=Enum.KeyCode[cfg.autoBatKey] end
		if cfg.speedKey and Enum.KeyCode[cfg.speedKey] then Keys.speed=Enum.KeyCode[cfg.speedKey] end
		if cfg.laggerKey and Enum.KeyCode[cfg.laggerKey] then Keys.lagger=Enum.KeyCode[cfg.laggerKey] end
		if cfg.autoPlayKey and Enum.KeyCode[cfg.autoPlayKey] then Keys.autoPlay=Enum.KeyCode[cfg.autoPlayKey] end
		if cfg.tpDownKey and Enum.KeyCode[cfg.tpDownKey] then Keys.tpDown=Enum.KeyCode[cfg.tpDownKey] end
		if cfg.dropBrainrotKey and Enum.KeyCode[cfg.dropBrainrotKey] then Keys.dropBrainrot=Enum.KeyCode[cfg.dropBrainrotKey] end
		if cfg.guiHideKey and Enum.KeyCode[cfg.guiHideKey] then Keys.guiHide=Enum.KeyCode[cfg.guiHideKey] end
		if cfg.gpKeys and type(cfg.gpKeys)=="table" then for k,v in pairs(cfg.gpKeys) do if GPKeys[k] and Enum.KeyCode[v] then GPKeys[k]=Enum.KeyCode[v] end end end
		if cfg.grabRadius then AutoSteal.Radius=cfg.grabRadius; if radiusBoxRef then radiusBoxRef.Text=tostring(cfg.grabRadius) end end
		if cfg.stealDuration then AutoSteal.Duration=cfg.stealDuration; AutoSteal.HalfHoldMin=cfg.stealDuration; if durationBoxRef then durationBoxRef.Text=tostring(cfg.stealDuration) end end
		if cfg.halfFireRange then AutoSteal.HalfFireRange=cfg.halfFireRange end
		if cfg.halfHoldMax then AutoSteal.HalfHoldMax=cfg.halfHoldMax end
		if cfg.halfEntryDelay then AutoSteal.HalfEntryDelay=cfg.halfEntryDelay end
		if cfg.autoPlaySide and (cfg.autoPlaySide=="right" or cfg.autoPlaySide=="left") then State.autoPlaySide=cfg.autoPlaySide end
		if cfg.aimbotSpeed and type(cfg.aimbotSpeed)=="number" then State.aimbotSpeed=cfg.aimbotSpeed end
		if type(cfg.autoSwingEnabled)=="boolean" then State.autoSwingEnabled=cfg.autoSwingEnabled; if setAutoSwingUI then setAutoSwingUI(cfg.autoSwingEnabled) end end
		if cfg.autoStealEnabled then AutoSteal.Enabled=true; if setInstaGrab then setInstaGrab(true) end; pcall(startAutoSteal) end
		if cfg.infJump then State.infJumpEnabled=true; if setInfJump then setInfJump(true) end end
		if cfg.infJumpMode and (cfg.infJumpMode=="manual" or cfg.infJumpMode=="hold") then State.infJumpMode=cfg.infJumpMode; if setInfJumpModeUI then setInfJumpModeUI() end end
		if cfg.antiRagdoll then State.antiRagdollEnabled=true; if setAntiRag then setAntiRag(true) end; startAntiRagdoll() end
		if cfg.fpsBoost then State.fpsBoostEnabled=true; if setFps then setFps(true) end; pcall(applyFPSBoost) end
		if cfg.medusaCounter then State.medusaCounterEnabled=true; if setMedusaCounter then setMedusaCounter(true) end; setupMedusaCounter(LP.Character) end
		if cfg.animEnabled then State.animEnabled=true; if setAnimToggle then setAnimToggle(true) end; task.spawn(function() task.wait(0.5); startAnimToggle() end) end
		if cfg.unwalkEnabled then if setUnwalkToggle then setUnwalkToggle(true) end; task.spawn(function() task.wait(0.5); State.unwalkEnabled=false; startUnwalk() end) end
		if cfg.hitboxEnabled then State.hitboxEnabled=true; if setHitbox then setHitbox(true) end; startHitboxes() end
		if cfg.darkModeEnabled then State.darkModeEnabled=true; if setDarkModeUI then setDarkModeUI(true) end; applyDarkMode() end
		if cfg.removeAccEnabled then State.removeAccEnabled=true; if setRemoveAccUI then setRemoveAccUI(true) end; startRemoveAccs() end
		if type(cfg.buttonsDetached)=="boolean" and cfg.buttonsDetached then applyDetachMode(true);  end
		if cfg.menuScale and type(cfg.menuScale)=="number" then State.menuScale=math.clamp(cfg.menuScale,0.8,1.8); main.Size=UDim2.new(0,math.floor(W*State.menuScale),0,math.floor(H*State.menuScale)) end
		if type(cfg.autoTPDownEnabled)=="boolean" and cfg.autoTPDownEnabled then
			State.autoTPDownEnabled=true; if setAutoTPDownUI then setAutoTPDownUI(true) end
			startAutoTPDown(); if _tpDownCard then _tpDownCard.Visible=false end
		end
		if cfg.jumpThreshold and type(cfg.jumpThreshold)=="number" then State.jumpThreshold=math.clamp(math.floor(cfg.jumpThreshold),1,20) end
		if type(cfg.hardHitEnabled)=="boolean" and cfg.hardHitEnabled then State.hardHitEnabled=true; if setHardHitUI then setHardHitUI(true) end; startHardHit() end
		if cfg.hardHitRadius and type(cfg.hardHitRadius)=="number" then State.hardHitRadius=cfg.hardHitRadius end
		if cfg.batRadius and type(cfg.batRadius)=="number" then State.batRadius=cfg.batRadius end
		if type(cfg.antiLagEnabled)=="boolean" and cfg.antiLagEnabled then State.antiLagEnabled=true; if setAntiLagUI then setAntiLagUI(true) end; enableAntiLag() end
		if type(cfg.ultraModeEnabled)=="boolean" and cfg.ultraModeEnabled then State.ultraModeEnabled=true; if setUltraModeUI then setUltraModeUI(true) end; enableUltraMode() end
		if type(cfg.espEnabled)=="boolean" and cfg.espEnabled then setESPEnabled(true); if setESPUI then setESPUI(true) end end
		if type(cfg.tracerEnabled)=="boolean" and cfg.tracerEnabled then setTracerEnabled(true); if setTracerUI then setTracerUI(true) end end
		if type(cfg.noCamCollisionEnabled)=="boolean" and cfg.noCamCollisionEnabled then State.noCamCollisionEnabled=true; if setNoCamUI then setNoCamUI(true) end; enableNoCamCollision() end
		
		if type(cfg.aimBypassToggled)=="boolean" and cfg.aimBypassToggled then
			State.aimBypassToggled=true; if setAimBypassUI then setAimBypassUI(true) end
			startAimBypass()
		end
		
		if cfg.mobileBtnScale and type(cfg.mobileBtnScale)=="number" then
			State.mobileBtnScale = math.clamp(cfg.mobileBtnScale, 0.5, 2.0)
			task.defer(function()
				applyMobileBtnScale()
			end)
		end
		
		if type(cfg.mobileBtnSquare)=="boolean" then
			State.mobileBtnSquare = cfg.mobileBtnSquare
			task.defer(function()
				applyMobileBtnShape()
				if _G.setMobileSquareUI then _G.setMobileSquareUI(State.mobileBtnSquare) end
			end)
		end
		
		

		if cfg.panels and type(cfg.panels)=="table" then
			for i,pd in ipairs(cfg.panels) do
				if pd.name and pd.code then local panelData={name=pd.name,code=pd.code,btn=nil}; table.insert(UserPanels,panelData); createPanelBtn(panelData,i) end
			end
		end
		if cfg.positions then
			local pos=cfg.positions
			task.defer(function()
				if pos.main then local u=t2u(pos.main); if u then main.Position=u end end
				if pos.mini then local u=t2u(pos.mini); if u then mini.Position=u end end
				if pos.combo then local u=t2u(pos.combo); if u then comboBar.Position=u end end
				
						
					
			end)
		end
		refreshUIToggles()
	end

	main.Size=UDim2.new(0,math.floor(W*State.menuScale),0,math.floor(H*State.menuScale))
	loadConfig()
end

local function setupChar(char)
	local setupToken = _G.SLAXERCharacterLifecycle.Begin(char)
	task.wait(0.1)
	if not _G.SLAXERCharacterLifecycle.IsCurrent(char, setupToken) then return end
	originalAnims=nil
	h=char:WaitForChild("Humanoid",5); hrp=char:WaitForChild("HumanoidRootPart",5); if not h or not hrp then return end
	if not _G.SLAXERCharacterLifecycle.IsCurrent(char, setupToken) then return end
	_G.SLAXERCharacterLifecycle.BindHumanoid(char, h, setupToken)
	task.spawn(function()
		if _G.SLAXERCharacterLifecycle.IsCurrent(char, setupToken) then addHeadLabel(char) end
	end)
	local hum=char:FindFirstChildOfClass("Humanoid"); if hum then hum.AutoRotate=true end
	if State.antiRagdollEnabled and not Conns.antiRag then task.wait(0.5); if not _G.SLAXERCharacterLifecycle.IsCurrent(char, setupToken) then return end; startAntiRagdoll() end
	if State.medusaCounterEnabled then setupMedusaCounter(char) end
	if State.animEnabled then task.wait(0.3); if not _G.SLAXERCharacterLifecycle.IsCurrent(char, setupToken) then return end; saveOriginalAnims(char); applyAnimPack(char) end
	if State.unwalkEnabled then State.unwalkEnabled=false; task.wait(0.3); if not _G.SLAXERCharacterLifecycle.IsCurrent(char, setupToken) then return end; startUnwalk() end
	if State.removeAccEnabled then removeAccsFromChar(char) end
	
	
	for p,_ in pairs(State.ragdollTracking) do if p==LP then State.ragdollTracking[p]=nil end end
end

LP.CharacterRemoving:Connect(function(char)
	_G.SLAXERCharacterLifecycle.Invalidate(char)
end)
LP.CharacterAdded:Connect(setupChar)
if LP.Character then task.spawn(function() setupChar(LP.Character) end) end

buildGUI()

local _ragdollScreen = Instance.new("ScreenGui")
_ragdollScreen.Name = "SLAXERRagdollTimers"
_ragdollScreen.DisplayOrder = 1000
_ragdollScreen.IgnoreGuiInset = true
_ragdollScreen.ZIndexBehavior = Enum.ZIndexBehavior.Global
pcall(function() _ragdollScreen.Parent = game:GetService("CoreGui") end)
if not _ragdollScreen.Parent then
	_ragdollScreen.Parent = LP:WaitForChild("PlayerGui")
end

local _ragdollLabels = {}
local _ragdollStartTimes = {}

local function _makeRagdollLabel(player)
	local lbl = Instance.new("TextLabel")
	lbl.Name = "RAG_" .. player.Name
	lbl.Size = UDim2.new(0, 200, 0, 44)
	lbl.BackgroundColor3 = Color3.fromRGB(200, 10, 10)
	lbl.BackgroundTransparency = 0.05
	lbl.BorderSizePixel = 0
	lbl.Text = "RAGDOLL: 0.0s"
	lbl.TextColor3 = Color3.fromRGB(255, 255, 255)
	lbl.Font = Enum.Font.GothamBlack
	lbl.TextSize = 18
	lbl.TextStrokeTransparency = 0.2
	lbl.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	lbl.ZIndex = 1000
	lbl.Parent = _ragdollScreen

	local corner = Instance.new("UICorner", lbl)
	corner.CornerRadius = UDim.new(0, 12)

	local stroke = Instance.new("UIStroke", lbl)
	stroke.Color = Color3.fromRGB(255, 80, 80)
	stroke.Thickness = 3

end

local function _destroyRagdollLabel(player)
	if _ragdollLabels[player] then
		pcall(function() _ragdollLabels[player]:Destroy() end)
		_ragdollLabels[player] = nil
	end
	_ragdollStartTimes[player] = nil
end

local function _isRagdolled(player)
	local char = player.Character
	local hum = char:FindFirstChildOfClass("Humanoid")
	if hum.Health <= 0 then return false end

	local st = hum:GetState()
	local isRagdollState = (st == Enum.HumanoidStateType.Physics or st == Enum.HumanoidStateType.Ragdoll or st == Enum.HumanoidStateType.FallingDown or hum.PlatformStand)

	
	local root = char:FindFirstChild("HumanoidRootPart")
		
		if hum.FloorMaterial ~= Enum.Material.Air then return true end
		
		local rp = RaycastParams.new()
		rp.FilterType = Enum.RaycastFilterType.Exclude
		rp.FilterDescendantsInstances = {char}
		local result = workspace:Raycast(root.Position, Vector3.new(0, -6, 0), rp)
		
		if root.Velocity.Y > 15 then return false end
	end

	local root2 = char:FindFirstChild("HumanoidRootPart")
	if root2 and root2.Anchored then return true end

end

RunService.RenderStepped:Connect(function()
	local cam = workspace.CurrentCamera

	for _, player in ipairs(Players:GetPlayers()) do
		local char = player.Character
			_destroyRagdollLabel(player)
		end

		local ragdolled = _isRagdolled(player)

			if not _ragdollStartTimes[player] then
				_ragdollStartTimes[player] = tick()
			end

			if not _ragdollLabels[player] or not _ragdollLabels[player].Parent then
				_ragdollLabels[player] = _makeRagdollLabel(player)
			end

			local lbl = _ragdollLabels[player]
			local elapsed = tick() - _ragdollStartTimes[player]
			lbl.Text = string.format("RAGDOLL: %.1fs", elapsed)

			if elapsed > 5 then
				lbl.TextColor3 = Color3.fromRGB(255, 0, 0)
				lbl.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
			elseif elapsed > 3 then
				lbl.TextColor3 = Color3.fromRGB(255, 100, 0)
				lbl.BackgroundColor3 = Color3.fromRGB(180, 30, 0)
			elseif elapsed > 1 then
				lbl.TextColor3 = Color3.fromRGB(255, 200, 0)
				lbl.BackgroundColor3 = Color3.fromRGB(180, 60, 0)
				lbl.TextColor3 = Color3.fromRGB(255, 255, 255)
				lbl.BackgroundColor3 = Color3.fromRGB(200, 10, 10)
			end

			
			local head = char:FindFirstChild("Head")
				local pos, onScreen = cam:WorldToViewportPoint(head.Position + Vector3.new(0, 4, 0))
					lbl.Position = UDim2.new(0, pos.X - 100, 0, pos.Y - 22)
					lbl.Visible = true
					lbl.Visible = false
				end
				lbl.Visible = false
			end
			_destroyRagdollLabel(player)
		end
	end
end)

Players.PlayerRemoving:Connect(function(p)
	_destroyRagdollLabel(p)
end)