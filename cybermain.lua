local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Evita duplicar a interface caso execute o script mais de uma vez
if PlayerGui:FindFirstChild("CyberExecutorUI") then
    PlayerGui.CyberExecutorUI:Destroy()
end

-- [[ INSTÂNCIA PRINCIPAL ]] --
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "CyberExecutorUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = PlayerGui

-- [[ EFEITO DE BLUR (DESFOQUE) ]] --
local BlurEffect = Instance.new("BlurEffect")
BlurEffect.Size = 0
BlurEffect.Enabled = false
BlurEffect.Parent = Lighting

-- [[ DESIGN DO TOGGLE BUTTON (BOTÃO DE RAIO) ]] --
local ToggleButton = Instance.new("TextButton")
local UICornerToggle = Instance.new("UICorner")
local UIStrokeToggle = Instance.new("UIStroke")

ToggleButton.Name = "ToggleButton"
ToggleButton.Size = UDim2.new(0, 60, 0, 60)
ToggleButton.Position = UDim2.new(0, 20, 0.5, -30)
ToggleButton.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
ToggleButton.Text = "⚡️"
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.TextSize = 28
ToggleButton.Font = Enum.Font.SourceSansBold
ToggleButton.Active = true
ToggleButton.Draggable = true -- Propriedade nativa simplificada para mobile
ToggleButton.Parent = ScreenGui

UICornerToggle.CornerRadius = UDim.new(0, 15)
UICornerToggle.Parent = ToggleButton

UIStrokeToggle.Color = Color3.fromRGB(255, 215, 0) -- Borda Dourada/Raio
UIStrokeToggle.Thickness = 2
UIStrokeToggle.Parent = ToggleButton

-- [[ PAINEL PRINCIPAL (MAIN FRAME) ]] --
local MainFrame = Instance.new("Frame")
local UICornerMain = Instance.new("UICorner")
local UIStrokeMain = Instance.new("UIStroke")

MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 450, 0, 280)
MainFrame.Position = UDim2.new(0.5, -225, 0.5, -140)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
MainFrame.Visible = false
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

UICornerMain.CornerRadius = UDim.new(0, 12)
UICornerMain.Parent = MainFrame

UIStrokeMain.Color = Color3.fromRGB(45, 45, 50)
UIStrokeMain.Thickness = 1
UIStrokeMain.Parent = MainFrame

-- [[ BARRA DE TÍTULO / ABAS ]] --
local TopBar = Instance.new("Frame")
TopBar.Name = "TopBar"
TopBar.Size = UDim2.new(1, 0, 0, 40)
TopBar.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
TopBar.Parent = MainFrame

local TabTitle = Instance.new("TextLabel")
TabTitle.Size = UDim2.new(0, 120, 1, 0)
TabTitle.Position = UDim2.new(0, 15, 0, 0)
TabTitle.BackgroundTransparency = 1
TabTitle.Text = "CyberExecutor"
TabTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
TabTitle.TextSize = 18
TabTitle.Font = Enum.Font.GothamBold
TabTitle.TextXAlignment = Enum.TextXAlignment.Left
TabTitle.Parent = TopBar

-- Indicador da Aba Ativa
local TabButton = Instance.new("TextButton")
TabButton.Size = UDim2.new(0, 100, 1, 0)
TabButton.Position = UDim2.new(0, 150, 0, 0)
TabButton.BackgroundTransparency = 1
TabButton.Text = "Executor"
TabButton.TextColor3 = Color3.fromRGB(255, 215, 0)
TabButton.TextSize = 14
TabButton.Font = Enum.Font.GothamBold
TabButton.Parent = TopBar

-- [[ CONTEÚDO DA ABA EXECUTOR ]] --
local ContentFrame = Instance.new("Frame")
ContentFrame.Name = "ContentFrame"
ContentFrame.Size = UDim2.new(1, -30, 1, -60)
ContentFrame.Position = UDim2.new(0, 15, 0, 50)
ContentFrame.BackgroundTransparency = 1
ContentFrame.Parent = MainFrame

-- Campo de Texto (Editor de Código)
local TextBox = Instance.new("TextBox")
local UICornerBox = Instance.new("UICorner")
local UIStrokeBox = Instance.new("UIStroke")

TextBox.Size = UDim2.new(1, 0, 0, 160)
TextBox.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
TextBox.Text = ""
TextBox.PlaceholderText = "-- Digite seu script aqui...\n-- Exemplo: print('Hi Executor World!')"
TextBox.PlaceholderColor3 = Color3.fromRGB(100, 100, 105)
TextBox.TextColor3 = Color3.fromRGB(240, 240, 240)
TextBox.TextSize = 14
TextBox.Font = Enum.Font.Code
TextBox.TextXAlignment = Enum.TextXAlignment.Left
TextBox.TextYAlignment = Enum.TextYAlignment.Top
TextBox.ClearTextOnFocus = false
TextBox.MultiLine = true
TextBox.Parent = ContentFrame

UICornerBox.CornerRadius = UDim.new(0, 8)
UICornerBox.Parent = TextBox
UIStrokeBox.Color = Color3.fromRGB(35, 35, 40)
UIStrokeBox.Parent = TextBox

-- Botão Executar
local ExecuteButton = Instance.new("TextButton")
local UICornerExec = Instance.new("UICorner")

ExecuteButton.Size = UDim2.new(0, 120, 0, 40)
ExecuteButton.Position = UDim2.new(1, -120, 1, -40)
ExecuteButton.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
ExecuteButton.Text = "Executar"
ExecuteButton.TextColor3 = Color3.fromRGB(20, 20, 25)
ExecuteButton.TextSize = 14
ExecuteButton.Font = Enum.Font.GothamBold
ExecuteButton.Parent = ContentFrame

UICornerExec.CornerRadius = UDim.new(0, 8)
UICornerExec.Parent = ExecuteButton

-- [[ SISTEMA DE NOTIFICAÇÃO DE ERRO ]] --
local function mostrarNotificacao(mensagem, cor)
    local Notif = Instance.new("TextLabel")
    local NotifCorner = Instance.new("UICorner")
    
    Notif.Size = UDim2.new(0, 250, 0, 35)
    Notif.Position = UDim2.new(0.5, -125, 0, -50)
    Notif.BackgroundColor3 = cor or Color3.fromRGB(200, 50, 50)
    Notif.Text = mensagem
    Notif.TextColor3 = Color3.fromRGB(255, 255, 255)
    Notif.Font = Enum.Font.GothamBold
    Notif.TextSize = 12
    Notif.Parent = ScreenGui
    NotifCorner.CornerRadius = UDim.new(0, 6)
    NotifCorner.Parent = Notif
    
    -- Animação de entrada e saída da notificação
    Notif:TweenPosition(UDim2.new(0.5, -125, 0, 20), "Out", "Quad", 0.3, true)
    task.wait(2.5)
    Notif:TweenPosition(UDim2.new(0.5, -125, 0, -50), "In", "Quad", 0.3, true, function()
        Notif:Destroy()
    end)
end

-- [[ LÓGICA DEABRIR / FECHAR COM TWEENS MODERNOS ]] --
local menuAberto = false
local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

ToggleButton.MouseButton1Click:Connect(function()
    menuAberto = not menuAberto
    
    if menuAberto then
        -- Abrir Menu
        MainFrame.Visible = true
        BlurEffect.Enabled = true
        
        MainFrame.Size = UDim2.new(0, 450, 0, 0)
        MainFrame.BackgroundTransparency = 1
        TopBar.BackgroundTransparency = 1
        ContentFrame.Size = UDim2.new(1, -30, 0, 0)
        TextBox.BackgroundTransparency = 1
        ExecuteButton.BackgroundTransparency = 1
        
        TweenService:Create(MainFrame, tweenInfo, {Size = UDim2.new(0, 450, 0, 280), BackgroundTransparency = 0}):Play()
        TweenService:Create(TopBar, tweenInfo, {BackgroundTransparency = 0}):Play()
        TweenService:Create(TextBox, tweenInfo, {BackgroundTransparency = 0}):Play()
        TweenService:Create(ExecuteButton, tweenInfo, {BackgroundTransparency = 0}):Play()
        TweenService:Create(BlurEffect, tweenInfo, {Size = 15}):Play()
    else
        -- Fechar Menu
        local fecharMain = TweenService:Create(MainFrame, tweenInfo, {Size = UDim2.new(0, 450, 0, 0), BackgroundTransparency = 1})
        TweenService:Create(TopBar, tweenInfo, {BackgroundTransparency = 1}):Play()
        TweenService:Create(TextBox, tweenInfo, {BackgroundTransparency = 1}):Play()
        TweenService:Create(ExecuteButton, tweenInfo, {BackgroundTransparency = 1}):Play()
        TweenService:Create(BlurEffect, tweenInfo, {Size = 0}):Play()
        
        fecharMain.Completed:Connect(function()
            if not menuAberto then
                MainFrame.Visible = false
                BlurEffect.Enabled = false
            end
        end)
        fecharMain:Play()
    end
end)

-- [[ SISTEMA DE EXECUÇÃO (EXPLOIT / NATIVO) ]] --
ExecuteButton.MouseButton1Click:Connect(function()
    local codigoParaExecutar = TextBox.Text
    
    -- Remove espaços em branco para verificar se está realmente vazio
    if string.gsub(codigoParaExecutar, "%s+", "") == "" then
        mostrarNotificacao("Erro: O campo de código está vazio!", Color3.fromRGB(220, 50, 50))
        return
    end
    
    -- Executa usando a função nativa ou injetada pelo ambiente
    -- O 'loadstring' compila o texto e os parênteses extras () executam o bytecode gerado
    local sucesso, erro = pcall(function()
        local func = loadstring(codigoParaExecutar)
        if func then
            func()
            mostrarNotificacao("Código executado!", Color3.fromRGB(50, 180, 50))
        else
            error("Falha ao compilar o código (Syntax Error).")
        end
    end)
    
    if not sucesso then
        mostrarNotificacao("Erro de Execução: verifique o console", Color3.fromRGB(220, 50, 50))
        warn("[CyberExecutor Error]: " .. tostring(erro))
    end
end)
