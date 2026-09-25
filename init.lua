-- 1. Aguarda o motor do jogo carregar o mapa e as instâncias vitais para não dar crash no mobile
if not game:IsLoaded() then
    game.Loaded:Wait()
end

print("[CyberExecutor] Jogo carregado. Baixando interface do GitHub...")

-- 2. Define a URL oficial do seu repositório
local CyberURL = "https://raw.githubusercontent.com/FrigoStudios/CyberExecutorMain/refs/heads/main/cybermain.lua"

-- 3. Faz o download e executa o código da interface de forma segura
local sucesso, erro = pcall(function()
    -- game:HttpGet baixa o texto do código direto do seu GitHub em tempo real
    local codigoInterface = game:HttpGet(CyberURL)
    
    -- loadstring() compila o texto baixado, e os () no final executam o ambiente Luau
    loadstring(codigoInterface)()
end)

-- 4. Feedback no console para monitoramento na sua conta alt
if sucesso then
    print("[CyberExecutor] Interface carregada com sucesso do repositório FrigoStudios!")
else
    warn("[CyberExecutor Erro de Inicialização]: " .. tostring(erro))
end
