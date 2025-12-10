-- Sprint Mechanic LocalScript
-- Place this script in StarterPlayer > StarterCharacterScripts
-- This script allows players to sprint by holding the Shift key with a stamina system

local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- Configuration
local SPRINT_KEY = Enum.KeyCode.LeftShift
local NORMAL_SPEED = 16
local SPRINT_SPEED = 28
local MAX_STAMINA = 100
local STAMINA_DRAIN_RATE = 10
local STAMINA_REGEN_RATE = 15
local STAMINA_REGEN_DELAY = 1

-- Variables
local player = game.Players.LocalPlayer
local character = script.Parent
local humanoid = character:WaitForChild("Humanoid")

local isSprinting = false
local sprintKeyPressed = false
local currentStamina = MAX_STAMINA
local staminaRegenTimer = 0
local canSprint = true

-- Function to update sprint state
local function updateSprint()
	if sprintKeyPressed and currentStamina > 0 and canSprint then
		isSprinting = true
		humanoid.WalkSpeed = SPRINT_SPEED
	else
		isSprinting = false
		humanoid.WalkSpeed = NORMAL_SPEED
	end
end

-- Handle sprint key press
local function onInputBegan(input, gameProcessed)
	if gameProcessed then return end
	
	if input.KeyCode == SPRINT_KEY then
		sprintKeyPressed = true
		updateSprint()
	end
end

-- Handle sprint key release
local function onInputEnded(input, gameProcessed)
	if input.KeyCode == SPRINT_KEY then
		sprintKeyPressed = false
		updateSprint()
	end
end

-- Stamina management system
local function manageStamina(deltaTime)
	if isSprinting then
		-- Drain stamina while sprinting
		currentStamina = math.max(0, currentStamina - (STAMINA_DRAIN_RATE * deltaTime))
		staminaRegenTimer = STAMINA_REGEN_DELAY
		
		-- Stop sprinting if stamina depletes
		if currentStamina <= 0 then
			canSprint = false
			updateSprint()
		end
	else
		-- Regenerate stamina when not sprinting
		if staminaRegenTimer > 0 then
			staminaRegenTimer = math.max(0, staminaRegenTimer - deltaTime)
		else
			currentStamina = math.min(MAX_STAMINA, currentStamina + (STAMINA_REGEN_RATE * deltaTime))
			
			-- Allow sprinting again once stamina is above 20%
			if currentStamina >= MAX_STAMINA * 0.2 then
				canSprint = true
			end
		end
	end
end

-- Initialize humanoid speed
humanoid.WalkSpeed = NORMAL_SPEED

-- Connect input events
UserInputService.InputBegan:Connect(onInputBegan)
UserInputService.InputEnded:Connect(onInputEnded)

-- Connect stamina management to game loop
RunService.RenderStepped:Connect(manageStamina)

-- Handle character respawn
humanoid.Died:Connect(function()
	currentStamina = MAX_STAMINA
	isSprinting = false
	sprintKeyPressed = false
	canSprint = true
end)

-- Optional: Print stamina for debugging (remove or comment out in production)
-- RunService.RenderStepped:Connect(function()
-- 	print("Stamina: " .. math.floor(currentStamina))
-- end)
