-- [[ AETHER SCRIPT V1.0 FIXED FULL ]] --
-- Developer: Farel Destroyer

local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

-- [[ 1. WINDOW SETUP ]] --
local Window = WindUI:CreateWindow({
    Title = "AetherScript",
    Author = "Dev: Farel Destroyer",
    Theme = "Dark",
    Size = UDim2.fromOffset(660, 430),
    Folder = "aetherscript_farel",
    SideBarWidth = 180,
    ScrollBarEnabled = true
})

-- [[ NOTIFIKASI AWAL (SUKSES) ]] --
WindUI:Notify({
    Title = "AetherScript Loaded!",
    Content = "Made by FarelDestroyer. Enjoy!",
    Icon = "check",
    Duration = 5
})

-- [[ 2. TABS ]] --
local InfoTab = Window:Tab({ Title = "Info", Icon = "info" })
local FishTab = Window:Tab({ Title = "Fishing", Icon = "fish" })
local TeleportTab = Window:Tab({ Title = "Teleport", Icon = "map-pin" })
local MiscTab = Window:Tab({ Title = "Misc", Icon = "package" })

-- [[ 3. INFO TAB ]] --
InfoTab:Section({ Title = "User Info" })
InfoTab:Paragraph({
    Title = "Welcome, " .. game.Players.LocalPlayer.DisplayName,
    Desc = "Username: @" .. game.Players.LocalPlayer.Name .. "\nStatus: Active (Full Version)",
    Image = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. game.Players.LocalPlayer.UserId .. "&width=420&height=420&format=png",
    ImageSize = 48
})

InfoTab:Section({ Title = "Developer Support" })
InfoTab:Button({
    Title = "Copy Telegram Link",
    Desc = "Join community FarelModsss",
    Callback = function()
        setclipboard("https://t.me/FarelModsss")
        WindUI:Notify({ Title = "Success", Content = "Link copied to clipboard!", Icon = "copy" })
    end
})

-- [[ 4. FISHING TAB ]] --
FishTab:Section({ Title = "Main Fishing" })
FishTab:Button({
    Title = "Execute AetherFishit",
    Desc = "Auto Shake, Reel & Loot",
    Callback = function()
        -- Memanggil logic dari file AetherFishit yang kamu punya
        loadstring(game:HttpGet('https://raw.githubusercontent.com/FarelDestroyer/Script/main/AetherFishit.lua'))()
    end
})

FishTab:Section({ Title = "Water Utility" })
FishTab:Toggle({
    Title = "Walk on Water",
    Value = false,
    Callback = function(state)
        _G.WaterWalk = state
        if state then
            local part = Instance.new("Part", workspace)
            part.Name = "AetherPlatform"
            part.Size = Vector3.new(500, 1, 500)
            part.Anchored = true
            part.Transparency = 1
            task.spawn(function()
                while _G.WaterWalk do
                    part.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, -3.5, 0)
                    task.wait()
                end
                part:Destroy()
            end)
        end
    end
})

-- [[ 5. TELEPORT TAB ]] --
TeleportTab:Section({ Title = "Quick Teleport" })
local PlayerDropdown = TeleportTab:Dropdown("Select Player", {}, function(selected)
    _G.TargetTeleport = selected
end)

local function UpdateList()
    local players = {}
    for _, p in pairs(game.Players:GetPlayers()) do
        if p ~= game.Players.LocalPlayer then table.insert(players, p.Name) end
    end
    PlayerDropdown:SetOptions(players)
end

TeleportTab:Button({
    Title = "Refresh Player List",
    Callback = UpdateList
})

TeleportTab:Button({
    Title = "Teleport Now",
    Callback = function()
        if _G.TargetTeleport then
            local target = game.Players:FindFirstChild(_G.TargetTeleport)
            if target and target.Character then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame
            end
        end
    end
})

-- [[ 6. MISC TAB ]] --
MiscTab:Section({ Title = "System" })
MiscTab:Button({
    Title = "FPS Boost",
    Desc = "Remove textures to reduce lag",
    Callback = function()
        for _, v in pairs(game.Workspace:GetDescendants()) do
            if v:IsA("Decal") or v:IsA("Texture") then v.Transparency = 1 end
        end
        WindUI:Notify({ Title = "Performance", Content = "FPS Boost Active!", Icon = "zap" })
    end
})

MiscTab:Section({ Title = "Protection" })
MiscTab:Toggle({
    Title = "Anti-Staff",
    Value = false,
    Callback = function(state)
        _G.AntiStaff = state
        game.Players.PlayerAdded:Connect(function(plr)
            if _G.AntiStaff and plr:GetRankInGroup(0) > 100 then
                game.Players.LocalPlayer:Kick("Staff Detected: " .. plr.Name)
            end
        end)
    end
})

-- Init list pemain di dropdown
UpdateList()
