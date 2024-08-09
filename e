-- Local Script for Toggleable Infinite Jump

local player = game.Players.LocalPlayer
local userInputService = game:GetService("UserInputService")
local jumpPower = 50 -- Adjust the jump power as needed
local infiniteJumpEnabled = false -- Track whether infinite jump is enabled

-- Function to enable infinite jumping
local function enableInfiniteJump()
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:WaitForChild("Humanoid")

    -- Function to handle jumping
    local function onJumpRequest()
        if infiniteJumpEnabled and humanoid and humanoid.Health > 0 then
            humanoid:ChangeState(Enum.HumanoidStateType.Physics)
            humanoid:Move(Vector3.new(0, jumpPower, 0))
        end
    end

    -- Connect the jump function to the humanoid's Jumping event
    humanoid.Jumping:Connect(onJumpRequest)

    -- Handle key press to toggle infinite jumping
    userInputService.InputBegan:Connect(function(input, gameProcessed)
        if not gameProcessed then
            if input.KeyCode == Enum.KeyCode.Space then
                onJumpRequest()
            elseif input.KeyCode == Enum.KeyCode.F then
                infiniteJumpEnabled = not infiniteJumpEnabled
                if infiniteJumpEnabled then
                    print("Infinite Jump Enabled")
                else
                    print("Infinite Jump Disabled")
                end
            end
        end
    end)
end

-- Call the function to start listening for inputs
enableInfiniteJump()
