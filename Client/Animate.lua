local ReplicatedStorage = game:GetService('ReplicatedStorage')
local Shared = ReplicatedStorage.Shared
local Assets = ReplicatedStorage.Assets

Shared.Events.AnimateClient.OnClientEvent:Connect(function(Humanoid, Animation)

    local Anim = Humanoid:LoadAnimation(Animation)

    Anim.Looped = true
    Anim:Play()

end)