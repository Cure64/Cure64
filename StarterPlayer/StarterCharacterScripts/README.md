# Sprint Mechanic LocalScript

A robust sprint mechanic for Roblox games with a stamina system.

## Features

- **Sprint Key**: Press and hold Left Shift to sprint
- **Speed Boost**: Increases movement speed from 16 to 28 studs/second
- **Stamina System**: 
  - 100 stamina points maximum
  - Drains at 10 points/second while sprinting
  - Regenerates at 15 points/second after 1 second delay
  - Cannot sprint below 0 stamina
  - Can sprint again once stamina reaches 20%
- **Smooth Transitions**: Instant speed changes for responsive gameplay
- **Respawn Handling**: Stamina resets to full on character death

## Installation

1. Open your Roblox game in Roblox Studio
2. In the Explorer panel, navigate to `StarterPlayer`
3. If `StarterCharacterScripts` doesn't exist, create it inside `StarterPlayer`
4. Copy the `SprintMechanic.lua` script into `StarterCharacterScripts`
5. Test your game!

## Configuration

You can customize the sprint mechanic by modifying these values at the top of the script:

```lua
local SPRINT_KEY = Enum.KeyCode.LeftShift  -- The key used to sprint
local NORMAL_SPEED = 16                     -- Default walking speed
local SPRINT_SPEED = 28                     -- Speed while sprinting
local MAX_STAMINA = 100                     -- Maximum stamina amount
local STAMINA_DRAIN_RATE = 10               -- Stamina used per second while sprinting
local STAMINA_REGEN_RATE = 15               -- Stamina recovered per second
local STAMINA_REGEN_DELAY = 1               -- Seconds to wait before regenerating
```

## How It Works

1. The script waits for the character and humanoid to load
2. When the player presses the sprint key, it checks if stamina is available
3. While sprinting, the humanoid's WalkSpeed increases and stamina drains
4. When the key is released or stamina depletes, speed returns to normal
5. Stamina regenerates automatically after a short delay

## Debugging

To see stamina values in real-time, uncomment these lines at the end of the script:

```lua
RunService.RenderStepped:Connect(function()
    print("Stamina: " .. math.floor(currentStamina))
end)
```

## Compatibility

- Works with Roblox's standard Humanoid system
- Compatible with other movement scripts (as long as they don't override WalkSpeed)
- LocalScript - runs on the client for responsive input

## Notes

- The script automatically handles character respawns
- Stamina system prevents infinite sprinting
- Input is ignored when typing in chat or other UI elements (gameProcessed check)
