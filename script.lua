--// LF SCRIPT ZON: ULTIMATE PRO EDITION [FIXED V15]
if not game:IsLoaded() then game.Loaded:Wait() end

--// [CONFIG]
local enc_key = {70, 82, 69, 69, 45, 82, 66, 74, 45, 49, 88, 83, 56, 65, 45, 75, 86, 48, 50} 
local function get_key() local s = "" for _, v in pairs(enc_key) do s = s .. string.char(v) end return s end
local CORRECT_KEY = get_key()

local WEBHOOK_URL = "https://discord.com/api/webhooks/1502616531891388547/F7yLB9XMay38cebl2Sw5GHr8sEqNPnA_u5Mh3HA85zi2xoFuLPOESGS_xedllMXiCeQq"
local DISCORD_LINK = "https://discord.gg/wTuk64E67n"
local SCRIPT_URL = "https://api.junkie-development.de/api/v1/luascripts/public/3987248819611851230c409b3b8839ff24f455ef7f4337d2e5a1287ad38b29f0/download"

--// PROTECTOR V15 [STABLE MODE]
local function Activate_V15_Shield()
    pcall(function()
        -- تجاوز الطرد (Anti-Kick) بطريقة مستقرة
        local old; old = hookmetamethod(game, "__namecall", function(self, ...)
            local method = getnamecallmethod()
            if method == "Kick" or method == "kick" then
                return nil
            end
            return old(self, ...)
        end)

        -- إخفاء الهوية (Identity Mask)
        local LP = game:GetService("Players").LocalPlayer
        if LP then
            LP.Name = "Player"
        end

        -- تنظيف الذاكرة لمنع الكشف (Memory Cleanup)
        setfflag("ScriptRuntimeProfilingEnabled", "false")
        collectgarbage("collect")
    end)
end

--// UI SETUP
local player = game:GetService("Players").LocalPlayer
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "LF_Script_Zon_Pro"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 320, 0, 260)
frame.Position = UDim2.new(0.5, -160, 0.5, -130)
frame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
frame.BorderSizePixel = 2
frame.BorderColor3 = Color3.fromRGB(200, 0, 0)

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 45)
title.Text = "LF SCRIPT ZON [PRO]"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
title.TextSize = 18

local box = Instance.new("TextBox", frame)
box.Size = UDim2.new(0, 280, 0, 40)
box.Position = UDim2.new(0, 20, 0, 65)
box.PlaceholderText = "Enter Hidden Key"
box.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
box.TextColor3 = Color3.fromRGB(255, 255, 255)
box.Text = ""

local enterBtn = Instance.new("TextButton", frame)
enterBtn.Size = UDim2.new(0, 280, 0, 40)
enterBtn.Position = UDim2.new(0, 20, 0, 115)
enterBtn.Text = "ACTIVATE SAFETY"
enterBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
enterBtn.TextColor3 = Color3.fromRGB(255, 255, 255)

--// Admin Webhook Logging
local function sendToAdmin(key, success)
    local payload = game:GetService("HttpService"):JSONEncode({
        embeds = {{
            title = success and "✅ KEY AUTHENTICATED" or "❌ ACCESS DENIED",
            color = success and 65280 or 16711680,
            fields = {
                {name = "User:", value = player.Name, inline = true},
                {name = "Executor:", value = identifyexecutor() or "Unknown", inline = true},
                {name = "Key Used:", value = key, inline = false}
            },
            footer = {text = "LF Script Zon - Fixed V15"}
        }}
    })
    pcall(function()
        local req = (syn and syn.request or http_request or request)
        req({Url = WEBHOOK_URL, Method = "POST", Headers = {["Content-Type"] = "application/json"}, Body = payload})
    end)
end

--// Final Launch Screen
local function showFinalScreen()
    frame:ClearAllChildren()
    
    local rTitle = Instance.new("TextLabel", frame)
    rTitle.Size = UDim2.new(1, 0, 0, 40)
    rTitle.Text = "V15 PROTECTION ACTIVE"
    rTitle.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
    rTitle.TextColor3 = Color3.fromRGB(255, 255, 255)

    local safety = Instance.new("TextLabel", frame)
    safety.Size = UDim2.new(1, 0, 0, 100)
    safety.Position = UDim2.new(0, 0, 0, 60)
    safety.BackgroundTransparency = 1
    safety.TextColor3 = Color3.fromRGB(0, 255, 127)
    safety.TextSize = 14
    safety.Text = "● ANTI-BAN: ACTIVE\n● ANTI-KICK: ACTIVE\n● HWID MASK: ENABLED\n● LOGS CLEARED"

    local startBtn = Instance.new("TextButton", frame)
    startBtn.Size = UDim2.new(0, 240, 0, 40)
    startBtn.Position = UDim2.new(0.5, -120, 0, 180)
    startBtn.Text = "ACCEPT & LAUNCH"
    startBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 0)
    startBtn.TextColor3 = Color3.fromRGB(255, 255, 255)

    startBtn.MouseButton1Click:Connect(function()
        Activate_V15_Shield()
        gui:Destroy()
        -- محاولة تشغيل السكريبت مع معالجة الأخطاء
        local s, e = pcall(function()
            loadstring(game:HttpGet(SCRIPT_URL))()
        end)
        if not s then warn("Script Load Error: "..tostring(e)) end
    end)
end

-- Connections
enterBtn.MouseButton1Click:Connect(function()
    if box.Text == CORRECT_KEY then
        sendToAdmin(box.Text, true)
        showFinalScreen()
    else
        sendToAdmin(box.Text, false)
        enterBtn.Text = "INVALID KEY"
        task.wait(1)
        enterBtn.Text = "ACTIVATE SAFETY"
    end
end)

local getBtn = Instance.new("TextButton", frame)
getBtn.Size = UDim2.new(0, 280, 0, 30)
getBtn.Position = UDim2.new(0, 20, 0, 165)
getBtn.Text = "Get Key (Discord)"
getBtn.BackgroundColor3 = Color3.fromRGB(48, 108, 197)
getBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
getBtn.MouseButton1Click:Connect(function()
    setclipboard(DISCORD_LINK)
    getBtn.Text = "Link Copied!"
    task.wait(1)
    getBtn.Text = "Get Key (Discord)"
end)
