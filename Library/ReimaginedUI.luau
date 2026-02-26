
-- Reimagined Futuristic UI for Mobile & Desktop (Roblox LuaU)
-- Light Mode (Blue) / Dark Mode (Red)

local ReimaginedUI = {}
ReimaginedUI.__index = ReimaginedUI

ReimaginedUI.Themes = {
    Light = {
        Background = Color3.fromRGB(8, 24, 64),
        Primary = Color3.fromRGB(0, 120, 255),
        Text = Color3.fromRGB(230, 240, 255),
        Accent = Color3.fromRGB(80, 160, 255),
        Panel = Color3.fromRGB(12, 36, 92)
    },
    Dark = {
        Background = Color3.fromRGB(24, 0, 0),
        Primary = Color3.fromRGB(200, 40, 40),
        Text = Color3.fromRGB(255, 220, 220),
        Accent = Color3.fromRGB(255, 90, 90),
        Panel = Color3.fromRGB(40, 0, 0)
    }
}

ReimaginedUI.CurrentTheme = "Light"

function ReimaginedUI:ToggleTheme()
    self.CurrentTheme = self.CurrentTheme == "Light" and "Dark" or "Light"
    if self._root then
        self._root.BackgroundColor3 = self.Themes[self.CurrentTheme].Background
        for _, v in ipairs(self._root:GetDescendants()) do
            if v:IsA("Frame") and v.Name == "Panel" then
                v.BackgroundColor3 = self.Themes[self.CurrentTheme].Panel
            elseif v:IsA("TextLabel") or v:IsA("TextButton") then
                v.TextColor3 = self.Themes[self.CurrentTheme].Text
            end
        end
    end
end

local function corner(parent, r)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, r or 14)
    c.Parent = parent
end

function ReimaginedUI:CreateWindow(title)
    local Players = game:GetService("Players")
    local UIS = game:GetService("UserInputService")
    local player = Players.LocalPlayer

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "ReimaginedUI"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.Parent = player:WaitForChild("PlayerGui")

    local Root = Instance.new("Frame")
    Root.Name = "Root"
    Root.Size = UIS.TouchEnabled and UDim2.fromScale(0.92, 0.8) or UDim2.fromScale(0.5, 0.6)
    Root.Position = UDim2.fromScale(0.5, 0.5)
    Root.AnchorPoint = Vector2.new(0.5, 0.5)
    Root.BackgroundColor3 = self.Themes[self.CurrentTheme].Background
    Root.Parent = ScreenGui
    corner(Root, 18)

    self._root = Root

    local Header = Instance.new("Frame")
    Header.Size = UDim2.fromScale(1, 0.14)
    Header.BackgroundTransparency = 1
    Header.Parent = Root

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.fromScale(0.7, 1)
    Title.Position = UDim2.fromScale(0.03, 0)
    Title.BackgroundTransparency = 1
    Title.TextXAlignment = Left
    Title.Text = title or "Reimagined UI"
    Title.Font = Enum.Font.GothamBold
    Title.TextScaled = true
    Title.TextColor3 = self.Themes[self.CurrentTheme].Text
    Title.Parent = Header

    local Toggle = Instance.new("TextButton")
    Toggle.Size = UDim2.fromScale(0.22, 0.7)
    Toggle.Position = UDim2.fromScale(0.75, 0.15)
    Toggle.Text = "Toggle Theme"
    Toggle.Font = Enum.Font.GothamBold
    Toggle.TextScaled = true
    Toggle.TextColor3 = self.Themes[self.CurrentTheme].Text
    Toggle.BackgroundColor3 = self.Themes[self.CurrentTheme].Primary
    Toggle.Parent = Header
    corner(Toggle, 12)

    Toggle.MouseButton1Click:Connect(function()
        self:ToggleTheme()
        Toggle.BackgroundColor3 = self.Themes[self.CurrentTheme].Primary
    end)

    local Body = Instance.new("Frame")
    Body.Size = UDim2.fromScale(1, 0.86)
    Body.Position = UDim2.fromScale(0, 0.14)
    Body.BackgroundTransparency = 1
    Body.Parent = Root

    local UIList = Instance.new("UIListLayout")
    UIList.Padding = UDim.new(0, 10)
    UIList.Parent = Body

    return {
        AddPanel = function(text)
            local Panel = Instance.new("Frame")
            Panel.Name = "Panel"
            Panel.Size = UDim2.new(1, -20, 0, 70)
            Panel.BackgroundColor3 = self.Themes[self.CurrentTheme].Panel
            Panel.Parent = Body
            corner(Panel, 14)

            local Label = Instance.new("TextLabel")
            Label.Size = UDim2.fromScale(1, 1)
            Label.BackgroundTransparency = 1
            Label.Text = text or "Panel"
            Label.Font = Enum.Font.Gotham
            Label.TextScaled = true
            Label.TextColor3 = self.Themes[self.CurrentTheme].Text
            Label.Parent = Panel

            return Panel
        end
    }
end

return ReimaginedUI
