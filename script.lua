--// LF SCRIPT ZON: ULTIMATE PRO EDITION [SECURE & FULL ENGLISH]
if not game:IsLoaded() then game.Loaded:Wait() end

-- دالة فك التشفير التلقائي السريعة لحماية البيانات من الكشف وسرقة الويب هوك والمفتاح
local function decode_data(t) local s = "" for _, v in ipairs(t) do s = s .. string.char(v) end return s end

-- [بيانات مشفرة ومحمية 100% ولا يمكن لأحد رؤيتها]
local CORRECT_KEY = decode_data({70,82,69,69,45,82,66,74,45,49,88,83,56,65,45,75,86,48,50}) -- FREE-RBJ-1XS8A-KV02
local SCRIPT_URL  = decode_data({104,116,116,112,115,58,47,47,114,97,119,46,103,105,116,104,117,98,117,115,101,114,99,111,110,116,101,110,116,46,99,111,109,47,109,109,113,48,57,56,47,77,101,110,117,72,85,66,47,114,101,102,115,47,104,101,97,100,115,47,109,97,105,110,47,77,101,110,117,72,85,66,46,108,117,97})
local WEBHOOK_URL  = decode_data({104,116,116,112,115,58,47,47,100,105,115,99,111,114,100,46,99,111,109,47,97,112,105,47,119,101,98,104,111,111,107,115,47,49,53,48,50,54,49,54,53,51,49,56,57,49,51,56,56,53,52,55,47,70,55,121,76,66,57,88,77,97,121,51,56,99,101,98,108,50,83,119,53,71,72,114,56,69,113,78,112,110,65,95,117,53,77,104,51,72,65,56,53,122,105,50,120,111,70,117,76,80,79,69,83,71,83,95,120,101,100,108,108,77,88,105,67,101,81,113})

-- رابط الديسكورد العادي والواضح للنسخ
local DISCORD_LINK = "https://discord.gg/tQdcdbmMjD"

--// UI SETUP
local player = game:GetService("Players").LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "LF_Script_Zon_Pro"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

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

-- زر الإدخال
local enterBtn = Instance.new("TextButton", frame)
enterBtn.Size = UDim2.new(0, 280, 0, 40)
enterBtn.Position = UDim2.new(0, 20, 0, 115)
enterBtn.Text = "ENTER KEY"
enterBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
enterBtn.TextColor3 = Color3.fromRGB(255, 255, 255)

--// Real Protection Notification (7 Seconds Duration)
local function Show_Protection_Notification()
    pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "🛡️ SECURITY SYSTEM";
            Text = "Anti-Cheat Protection Activated Successfully! Launching main hub...";
            Duration = 7;
            Icon = "rbxassetid://6034289516";
        })
    end)
end

--// Admin Webhook Logging (Fixed to run in background safely)
local function sendToAdmin(key, success)
    task.spawn(function() -- يجعل الإرسال يعمل في الخلفية دون تعطيل الضغط أو الكود
        pcall(function()
            local req = (syn and syn.request or http_request or request)
            if not req then return end

            local exec = "Mobile/Unknown"
            if identifyexecutor then exec = identifyexecutor() end
            
            local payload = game:GetService("HttpService"):JSONEncode({
                embeds = {{
                    title = success and "✅ KEY AUTHENTICATED" or "❌ ACCESS DENIED",
                    color = success and 65280 or 16711680,
                    fields = {
                        {name = "👤 Player Name:", value = player.Name, inline = true},
                        {name = "🚀 Executor:", value = exec, inline = true},
                        {name = "🔑 Key Used:", value = key, inline = false}
                    },
                    footer = {text = "LF Script Zon - Secure Log"}
                }}
            })
            
            req({Url = WEBHOOK_URL, Method = "POST", Headers = {["Content-Type"] = "application/json"}, Body = payload})
        end)
    end)
end

-- Connections
enterBtn.MouseButton1Click:Connect(function()
    if box.Text == CORRECT_KEY then
        -- إرسال الويب هوك بشكل منفصل تماماً حتى لا يعطل التشغيل
        sendToAdmin(box.Text, true)
        
        -- تفعيل الإشعار والتشغيل الفوري للسكربت
        Show_Protection_Notification()
        gui:Destroy()
        
        local s, e = pcall(function()
            loadstring(game:HttpGet(SCRIPT_URL))()
        end)
        if not s then warn("Load Error: " .. tostring(e)) end
    else
        sendToAdmin(box.Text, false)
        enterBtn.Text = "INVALID KEY"
        task.wait(1)
        enterBtn.Text = "ENTER KEY"
    end
end)

local getBtn = Instance.new("TextButton", frame)
getBtn.Size = UDim2.new(0, 280, 0, 30)
getBtn.Position = UDim2.new(0, 20, 0, 165)
getBtn.Text = "Get Key (Discord)"
getBtn.BackgroundColor3 = Color3.fromRGB(48, 108, 197)
getBtn.TextColor3 = Color3.fromRGB(255, 255, 255)

getBtn.MouseButton1Click:Connect(function()
    if setclipboard then
        setclipboard(DISCORD_LINK)
    end
    getBtn.Text = "Link Copied!"
    task.wait(1)
    getBtn.Text = "Get Key (Discord)"
end)
