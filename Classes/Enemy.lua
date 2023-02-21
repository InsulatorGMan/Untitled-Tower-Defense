local ReplicatedStorage = game:GetService('ReplicatedStorage')
local Shared = ReplicatedStorage.Shared
local Assets = ReplicatedStorage.Assets
--
local Enemy = {}

-- Main Method
function Enemy:New(Name)

    local Success, Fail = pcall(function()
    
        if Name and WaypointsFolder then

            if Assets.Enemies[Name] then

                local EnemyModule = require(Assets.Enemies[Name]:FindFirstChild('Stats'))
                local EnemyAnimations = Assets.Enemies[Name]:FindFirstChild('Animations')

                local newEnemy = Assets.Enemies[Name]:FindFirstChild('Model'):Clone()
                newEnemy.Name = Name
                newEnemy.Humanoid.WalkSpeed = EnemyModule.WalkSpeed
                newEnemy.Humanoid.Health = EnemyModule.Health
                newEnemy.Humanoid.MaxHeath = EnemyModule.Health
                
                -- Send Animation Request to client
                Shared.Events.AnimateClient:FireAllClients(newEnemy.Humanoid, EnemyAnimations["Walk"])

                local Waypoints = _G.Map.Waypoints
                newEnemy:MoveTo(Waypoints["1"].Position)

                for i = 1, #Waypoints:GetChildren() do

                    newEnemy.Humanoid:MoveTo(Waypoints[i].Position)
                    newEnemy.Humanoid.MoveToFinished:Wait()

                end

            else

                error('Invalid Enemy')

            end

        else

            error('Invalid Parameters')

        end
    
    end)

end

return Enemy