-- [[ AETHER SCRIPT V1.0 FIXED ]] --
-- Developer: Farel Destroyer
-- Status: Full Version

local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

-- [[ 1. WINDOW SETUP ]] --
local Window = WindUI:CreateWindow({
    Title = "AetherScript",
    Author = "Developer: FarelDestroyer",
    Theme = "Dark",
    Size = UDim2.fromOffset(660, 430),
    Folder = "aetherscript_farel",
    SideBarWidth = 180,
    ScrollBarEnabled = true
})

-- Background Setup
Window:SetBackgroundImage("rbxassetid://76527064525832")
Window:SetBackgroundImageTransparency(0.6)

-- [[ 2. CLOSE BUTTON CONFIG ]] --
Window:EditCloseButton({
    Callback = function()
        WindUI:Notify({
            Title = "Konfirmasi",
            Content = "Matikan semua fitur AetherScript?",
            Icon = "circle-help",
            Duration = 5,
            Buttons = {
                {
                    Title = "Ya, Matikan",
                    Callback = function()
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

-- [[ 3. TABS ]] --
local InfoTab = Window:Tab({ Title = "Info", Icon = "info" })
local FishTab = Window:Tab({ Title = "Fishing", Icon = "fish" })
local TeleportTab = Window:Tab({ Title = "Teleport", Icon = "map-pin" })
local MiscTab = Window:Tab({ Title = "Misc", Icon = "package" })

-- [[ 4. INFO TAB (FIXED: Tidak Kosong Lagi) ]] --
InfoTab:Section({ Title = "User Statistics" })
InfoTab:Paragraph({
    Title = "Account Info",
    Desc = "Display Name: " .. game.Players.LocalPlayer.DisplayName .. "\nUsername: @" .. game.Players.LocalPlayer.Name .. "\nUser ID: " .. game.Players.LocalPlayer.UserId,
    Image = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. game.Players.LocalPlayer.UserId .. "&width=420&height=420&format=png",
    ImageSize = 50,
})

InfoTab:Section({ Title = "Script Status" })
InfoTab:Paragraph({
    Title = "Aether Version 1.0",
    Desc = "Status: Premium Member\nLast Update: 2024\nSupport: All Executors",
    Icon = "shield-check"
})

InfoTab:Button({
    Title = "Salin Link Telegram",
    Desc = "Join community FarelModsss",
    Callback = function()
        setclipboard("https://t.me/FarelModsss")
        WindUI:Notify({ Title = "Success", Content = "Link Telegram berhasil disalin!", Icon = "check" })
    end
})

-- [[ 5. FISHING TAB (CORE FITUR) ]] --
FishTab:Section({ Title = "Main Automation" })
FishTab:Button({
    Title = "Aktifkan AetherFishit (GitHub)",
    Desc = "Auto Shake, Reel, & Loot",
    Callback = function()
        WindUI:Notify({ Title = "Loading...", Content = "Mengambil data dari GitHub...", Icon = "loader" })
        loadstring(game:HttpGet('https://raw.githubusercontent.com/FarelDestroyer/Script/main/AetherFishit.lua'))()
    end
})

FishTab:Section({ Title = "Utility Movement" })
FishTab:Toggle({
    Title = "Walk on Water",
    Value = false,
    Callback = function(state)
        _G.WaterWalk = state
        if state then
            local p = Instance.new("Part", workspace)
            p.Name = "AetherWaterBase"
            p.Size = Vector3.new(5000, 1, 5000)
            p.Transparency = 1
            p.Anchored = true
            task.spawn(function()
                while _G.WaterWalk do
                    p.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, -3.5, 0)
                    task.wait()
                end
                p:Destroy()
            end)
        end
    end
})

-- [[ 6. TELEPORT TAB (FIXED LIST) ]] --
TeleportTab:Section({ Title = "Player Teleport" })

local PlayerDropdown = TeleportTab:Dropdown("Pilih Target", {}, function(selected)
    _G.TargetPlayer = selected
end)

local function UpdateList()
    local list = {}
    for _, p in pairs(game.Players:GetPlayers()) do
        if p ~= game.Players.LocalPlayer then table.insert(list, p.Name) end
    end
    PlayerDropdown:SetOptions(list)
end

TeleportTab:Button({
    Title = "Refresh List Pemain",
    Callback = function()
        UpdateList()
        WindUI:Notify({ Title = "Refreshed", Content = "Daftar pemain diperbarui", Icon = "refresh-cw" })
    end
})

TeleportTab:Button({
    Title = "Teleport Ke Pemain",
    Callback = function()
        if _G.TargetPlayer then
            local target = game.Players:FindFirstChild(_G.TargetPlayer)
            if target and target.Character then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame
            end
        else
            WindUI:Notify({ Title = "Error", Content = "Pilih pemain dulu!", Icon = "alert-triangle" })
        end
    end
})

-- [[ 7. MISC TAB (SECURITY & FPS) ]] --
MiscTab:Section({ Title = "Game Performance" })
MiscTab:Button({
    Title = "FPS Boost / Fix Lag",
    Desc = "Hapus texture & partikel berat",
    Callback = function()
        for _, v in pairs(game.Workspace:GetDescendants()) do
            if v:IsA("Decal") or v:IsA("Texture") then v.Transparency = 1
            elseif v:IsA("ParticleEmitter") then v.Enabled = false end
        end
        WindUI:Notify({ Title = "Optimized", Content = "Texture dibersihkan!", Icon = "zap" })
    end
})

MiscTab:Section({ Title = "Security" })
MiscTab:Toggle({
    Title = "Anti-Staff Detector",
    Value = false,
    Callback = function(state)
        _G.AntiStaff = state
        if state then
            game.Players.PlayerAdded:Connect(function(plr)
                if _G.AntiStaff and plr:GetRankInGroup(0) > 100 then 
                    game.Players.LocalPlayer:Kick("Admin Detect: " .. plr.Name)
                end
            end)
        end
    end
})

-- Initialize
UpdateList()
WindUI:Notify({ Title = "Aether Ready", Content = "Script berhasil dimuat sepenuhnya!", Icon = "check" })
