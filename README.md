-- 🔥 PVP GOD MODE SAFE VERSION

local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local player = Players.LocalPlayer

-- =========================
-- 🎮 GRÁFICO MÍNIMO
-- =========================

pcall(function()
	settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
end)

Lighting.GlobalShadows = false
Lighting.FogEnd = 9e9
Lighting.Brightness = 2

-- =========================
-- 💀 ESCONDE PROPS (SEM DESTRUIR)
-- =========================

local function isPlayerCharacter(obj)
	return obj:FindFirstChildOfClass("Humanoid") ~= nil
end

for _,v in pairs(workspace:GetDescendants()) do
	
	-- Mantém jogadores
	if v:IsA("Model") and isPlayerCharacter(v) then
		continue
	end
	
	if v:IsA("BasePart") then
		if not v:IsDescendantOf(player.Character) then
			
			-- Mantém chão grande
			if v.Anchored and v.Size.Magnitude > 25 then
				v.Material = Enum.Material.SmoothPlastic
				v.CastShadow = false
			else
				v.Transparency = 1
				v.CanCollide = false
				v.CastShadow = false
			end
		end
	end
	
	if v:IsA("Decal") or v:IsA("Texture") then
		v.Transparency = 1
	end
	
	if v:IsA("ParticleEmitter")
	or v:IsA("Trail")
	or v:IsA("Smoke")
	or v:IsA("Fire") then
		v.Enabled = false
	end
	
end

print("🔥 PVP SAFE MODE ATIVADO 🔥")
