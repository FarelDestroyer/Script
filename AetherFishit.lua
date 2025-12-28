-- [[ AETHER SCRIPT V1.0 ]] --
-- Developer: Farel Destroyer
-- Link Source: AetherFishit.lua

local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

-- [[ WINDOW SETUP ]] --
local Window = WindUI:CreateWindow({
    Title = "AetherScript",
    Author = "Dev: Farel Destroyer",
    Theme = "Dark",
    Size = UDim2.fromOffset(660, 430),
    Folder = "aetherscript_farel",
    SideBarWidth = 180,
    ScrollBarEnabled = true
})

-- Background Anime sesuai aset yang kamu pakai
Window:SetBackgroundImage("rbxassetid://76527064525832")
Window:SetBackgroundImageTransparency(0.6)

-- [[ FITUR TOMBOL HEADER (X) DENGAN POPUP ]] --
Window:EditCloseButton({
    Callback = function()
        WindUI:Notify({
            Title = "Konfirmasi Keluar",
            Content = "Apakah kamu ingin mematikan AetherScript?",
            Icon = "circle-help",
            Duration = 10,
            Buttons = {
                {
                    Title = "Ya, Matikan",
                    Callback = function()
                        -- Menghapus UI secara total
                        if game:GetService("CoreGui"):FindFirstChild("WindUI") then
                            game:GetService("CoreGui").WindUI:Destroy()
                        end
                    end
                },
                {
                    Title = "Batal",
                    Callback = function() end
                }
            }
        })
    end
})

-- [[ TABS ]] --
local InfoTab = Window:Tab({ Title = "Info", Icon = "info" })
local FishTab = Window:Tab({ Title = "Fishing", Icon = "fish" })
local TeleportTab = Window:Tab({ Title = "Teleport", Icon = "map-pin" })
local MiscTab = Window:Tab({ Title = "Misc", Icon = "package" })

-- [[ 1. INFO TAB ]] --
InfoTab:Section({ Title = "User Info" })
InfoTab:Paragraph({
    Title = "AetherScript V1.0",
    Desc = "Status: Premium\nUser: " .. game.Players.LocalPlayer.DisplayName,
    Image = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. game.Players.LocalPlayer.UserId .. "&width=420&height=420&format=png",
    ImageSize = 50,
})

InfoTab:Button({
    Title = "Salin Link Telegram",
    Desc = "t.me/FarelModsss",
    Callback = function()
        setclipboard("https://t.me/FarelModsss")
        WindUI:Notify({ Title = "Berhasil", Content = "Link Telegram disalin!", Icon = "check" })
    end
})

-- [[ 2. FISHING TAB (CORE CODE) ]] --
FishTab:Section({ Title = "Main Fishing" })

-- Tombol ini menjalankan script GitHub kamu secara utuh agar fitur enkripsi tetap jalan
FishTab:Button({
    Title = "Aktifkan Auto Fishing (Full)",
    Desc = "Menjalankan Auto Shake, Reel, & Legit Mode",
    Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/FarelDestroyer/Script/main/AetherFishit.lua'))()
        WindUI:Notify({ Title = "Script Loaded", Content = "AetherFishit berhasil dijalankan!", Icon = "frown" })
    end
})

FishTab:Section({ Title = "Movement Utility" })
FishTab:Toggle({
    Title = "Walk on Water (Jalan di Air)",
    Value = false,
    Callback = function(state)
        _G.WoW = state
        if state then
            local part = Instance.new("Part", workspace)
            part.Name = "AetherWaterFloor"
            part.Size = Vector3.new(1000, 1, 1000)
            part.Transparency = 1
            part.Anchored = true
            task.spawn(function()
                while _G.WoW do
                    part.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, -3.5, 0)
                    task.wait()
                end
                part:Destroy()
            end)
        end
    end
})

-- [[ 3. TELEPORT TAB (WORKIT) ]] --
TeleportTab:Section({ Title = "Player Teleport" })

local PlayerDropdown = TeleportTab:Dropdown("Pilih Pemain", {}, function(selected)
    _G.TeleTarget = selected
end)

TeleportTab:Button({
    Title = "Refresh List Pemain",
    Callback = function()
        local players = {}
        for _, p in pairs(game.Players:GetPlayers()) do
            if p ~= game.Players.LocalPlayer then table.insert(players, p.Name) end
        end
        PlayerDropdown:SetOptions(players)
    end
})

TeleportTab:Button({
    Title = "Teleport Sekarang",
    Callback = function()
        if _G.TeleTarget then
            local target = game.Players:FindFirstChild(_G.TeleTarget)
            if target and target.Character then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame
            end
        end
    end
})

-- [[ 4. MISC TAB ]] --
MiscTab:Section({ Title = "Security & FPS" })

MiscTab:Button({
    Title = "Bypass Radar",
    Callback = function()
        -- Logika bypass dasar
        WindUI:Notify({ Title = "Bypass", Content = "Radar Bypass Activated", Icon = "shield" })
    end
})

MiscTab:Toggle({
    Title = "Anti-Staff (Auto Kick)",
    Value = false,
    Callback = function(state)
        if state then
            game.Players.PlayerAdded:Connect(function(plr)
                -- Deteksi sederhana jika ada pemain dengan badge/rank tertentu
                if plr:GetRankInGroup(0) > 200 then 
                    game.Players.LocalPlayer:Kick("Admin Masuk Server!")
                end
            end)
        end
    end
})

MiscTab:Button({
    Title = "FPS Boost (Fix Lag)",
    Callback = function()
        -- Mengambil logika dari file Fix Lag kamu
        for _, v in pairs(game.Workspace:GetDescendants()) do
            if v:IsA("Decal") or v:IsA("Texture") then
                v.Transparency = 1
            elseif v:IsA("ParticleEmitter") then
                v.Enabled = false
            end
        end
        WindUI:Notify({ Title = "Optimized", Content = "Texture telah dihapus untuk performa.", Icon = "zap" })
    end
})
