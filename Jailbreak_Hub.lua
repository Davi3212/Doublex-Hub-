-- Doublex Hub | Jailbreak | v1.0
-- Interface local e assistente de roubos. Nao altera recompensas nem remove dano do servidor.
local Players = game:GetService('Players')
local UIS = game:GetService('UserInputService')
local RunService = game:GetService('RunService')
local TweenService = game:GetService('TweenService')
local player = Players.LocalPlayer
if not player then return end
local pg = player:WaitForChild('PlayerGui', 12)
if not pg then return end
local old = pg:FindFirstChild('DoublexJailbreakHub')
if old then old:Destroy() end
local gui = Instance.new('ScreenGui')
gui.Name='DoublexJailbreakHub'; gui.ResetOnSpawn=false; gui.IgnoreGuiInset=true; gui.ZIndexBehavior=Enum.ZIndexBehavior.Sibling; gui.Parent=pg
local function new(class, props, parent)
 local o=Instance.new(class)
 for k,v in pairs(props or {}) do o[k]=v end
 o.Parent=parent
 return o
end
local function corner(p,r) new('UICorner',{CornerRadius=UDim.new(0,r or 9)},p) end
local main=new('Frame',{Size=UDim2.fromOffset(345,370),Position=UDim2.new(.5,-172,.5,-185),BackgroundColor3=Color3.fromRGB(19,23,34),BorderSizePixel=0,Active=true},gui)
corner(main,12)
new('UIStroke',{Color=Color3.fromRGB(65,90,150),Thickness=1.4},main)
local top=new('Frame',{Size=UDim2.new(1,0,0,43),BackgroundColor3=Color3.fromRGB(32,42,65),BorderSizePixel=0},main);corner(top,12)
new('TextLabel',{Text='DOUBLEX HUB  |  JAILBREAK',Size=UDim2.new(1,-88,1,0),Position=UDim2.fromOffset(12,0),TextColor3=Color3.new(1,1,1),TextSize=15,Font=Enum.Font.GothamBold,TextXAlignment=Enum.TextXAlignment.Left,BackgroundTransparency=1},top)
local function button(parent,label,pos,size,callback)
 local b=new('TextButton',{Text=label,Position=pos,Size=size,BackgroundColor3=Color3.fromRGB(43,56,82),TextColor3=Color3.new(1,1,1),Font=Enum.Font.GothamMedium,TextSize=12,BorderSizePixel=0,AutoButtonColor=true},parent)
 corner(b,7); b.MouseButton1Click:Connect(callback);return b
end
local minimized=false
local body=new('Frame',{Position=UDim2.fromOffset(0,43),Size=UDim2.new(1,0,1,-43),BackgroundTransparency=1},main)
button(top,'_',UDim2.new(1,-77,0,7),UDim2.fromOffset(31,29),function() minimized=not minimized;body.Visible=not minimized;main.Size=minimized and UDim2.fromOffset(345,43) or UDim2.fromOffset(345,370) end)
button(top,'X',UDim2.new(1,-40,0,7),UDim2.fromOffset(31,29),function() gui:Destroy() end)
local dragging,startMouse,startPos=false,nil,nil
top.InputBegan:Connect(function(i)
 if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then dragging=true;startMouse=i.Position;startPos=main.Position
 i.Changed:Connect(function() if i.UserInputState==Enum.UserInputState.End then dragging=false end end) end
end)
UIS.InputChanged:Connect(function(i)
 if dragging and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then
 local d=i.Position-startMouse;main.Position=UDim2.new(startPos.X.Scale,startPos.X.Offset+d.X,startPos.Y.Scale,startPos.Y.Offset+d.Y)
 end
end)
local tabs=new('Frame',{Position=UDim2.fromOffset(8,8),Size=UDim2.new(1,-16,0,33),BackgroundTransparency=1},body)
new('UIListLayout',{FillDirection=Enum.FillDirection.Horizontal,Padding=UDim.new(0,4)},tabs)
local pages={};local tabButtons={}
local names={'Roubos','Personagem','Jogadores','Sobre'}
for _,name in ipairs(names) do
 local page=new('ScrollingFrame',{Position=UDim2.fromOffset(9,49),Size=UDim2.new(1,-18,1,-87),BackgroundTransparency=1,ScrollBarThickness=3,CanvasSize=UDim2.fromOffset(0,0),AutomaticCanvasSize=Enum.AutomaticSize.Y,Visible=false},body)
 new('UIListLayout',{Padding=UDim.new(0,7),SortOrder=Enum.SortOrder.LayoutOrder},page)
 new('UIPadding',{PaddingBottom=UDim.new(0,8),PaddingRight=UDim.new(0,5)},page)
 pages[name]=page
 local b=button(tabs,name,UDim2.new(),UDim2.new(.25,-3,1,0),function()
  for n,p in pairs(pages) do p.Visible=n==name end
  for n,bt in pairs(tabButtons) do bt.BackgroundColor3=n==name and Color3.fromRGB(52,96,158) or Color3.fromRGB(43,56,82) end
 end)
 tabButtons[name]=b
end
local status=new('TextLabel',{Text='Pronto. Modo manual assistido.',Position=UDim2.new(0,9,1,-33),Size=UDim2.new(1,-18,0,27),BackgroundColor3=Color3.fromRGB(26,35,52),TextColor3=Color3.fromRGB(194,219,255),TextSize=11,Font=Enum.Font.Gotham,TextWrapped=true},body);corner(status,6)
local function say(s) if status.Parent then status.Text=s end end
local function line(parent,text)
 return new('TextLabel',{Text=text,Size=UDim2.new(1,-4,0,34),BackgroundTransparency=1,TextColor3=Color3.fromRGB(224,232,245),TextSize=12,Font=Enum.Font.Gotham,TextWrapped=true,TextXAlignment=Enum.TextXAlignment.Left},parent)
end
local function wide(parent,text,fn)
 return button(parent,text,UDim2.new(),UDim2.new(1,-5,0,34),fn)
end
local robberies={
 {'Banco','Bank','Precisa de acesso adequado; siga o cofre e a saida.'},
 {'Joalheria','Jewelry','Colete joias, evite lasers e entregue na base criminosa.'},
 {'Museu','Museum','Exige dois jogadores. Resolva puzzles e entregue no Volcano.'},
 {'Tumba','Tomb','Exige dois jogadores na entrada. Evite armadilhas.'},
 {'Usina','Power Plant','Resolva o puzzle e entregue no Volcano rapidamente.'},
 {'Crown Jewel','Crown Jewel','Complete as etapas e siga a entrega indicada.'},
 {'Trem de carga','Cargo Train','Entre no trem e recolha os itens disponiveis.'},
 {'Trem de passageiros','Passenger Train','Recolha itens e conclua a entrega.'},
 {'Aviao de carga','Cargo Plane','Acompanhe a rota e siga o objetivo de entrega.'},
 {'Navio de carga','Cargo Ship','Roubo com veiculo aereo e carga.'},
 {'Plataforma petrolifera','Oil Rig','Enfrente as etapas e siga o objetivo.'},
 {'Mansao','Mansion','Exige condicoes especiais para iniciar.'},
 {'Loja de donuts','Donut','Roubo pequeno; pode estar indisponivel.'},
 {'Posto de gasolina','Gas Station','Roubo pequeno; pode estar indisponivel.'},
 {'Mercado','Grocery','Roubo pequeno; pode estar indisponivel.'}
}
local chosen=robberies[1]
line(pages.Roubos,'Selecione um roubo para ver o guia. Nao ha auto farm funcional nesta versao.')
local selected=line(pages.Roubos,'Selecionado: Banco')
local tip=line(pages.Roubos,chosen[3]);tip.Size=UDim2.new(1,-4,0,49)
local list=new('ScrollingFrame',{Size=UDim2.new(1,-5,0,130),BackgroundColor3=Color3.fromRGB(25,32,48),BorderSizePixel=0,ScrollBarThickness=4,CanvasSize=UDim2.fromOffset(0,#robberies*32)},pages.Roubos);corner(list,7)
for i,r in ipairs(robberies) do
 button(list,r[1],UDim2.fromOffset(5,(i-1)*32),UDim2.new(1,-13,0,29),function() chosen=r;selected.Text='Selecionado: '..r[1];tip.Text=r[3];say('Guia de '..r[1]..' selecionado.') end)
end
wide(pages.Roubos,'Procurar local no mapa (Workspace)',function()
 local target
 local key=chosen[2]:lower()
 for _,o in ipairs(workspace:GetDescendants()) do
  if (o:IsA('BasePart') or o:IsA('Model')) and o.Name:lower():find(key,1,true) then
   local part=o:IsA('BasePart') and o or o.PrimaryPart or o:FindFirstChildWhichIsA('BasePart',true)
   if part then target=part;break end
  end
 end
 if not target then say('Local nao identificado no Workspace; use o mapa do Jailbreak.') return end
 local char=player.Character;local root=char and char:FindFirstChild('HumanoidRootPart')
 if not root then say('Personagem indisponivel.') return end
 say(string.format('%s: aproximadamente %d studs (distancia em linha reta).',chosen[1],math.floor((root.Position-target.Position).Magnitude)))
end)
wide(pages.Roubos,'Modo automatico - informacoes',function() say('Auto Robbery e bypass de danos nao implementados. Sem promessa falsa de funcionamento.') end)
local function humanoid() local c=player.Character;return c and c:FindFirstChildOfClass('Humanoid') end
line(pages.Personagem,'Ajustes locais; o servidor pode restaurar os valores.')
local function numericSetting(label,default,min,max,property)
 line(pages.Personagem,label..' ('..min..' a '..max..')')
 local field=new('TextBox',{Text=tostring(default),PlaceholderText=tostring(default),ClearTextOnFocus=false,Size=UDim2.new(1,-5,0,35),BackgroundColor3=Color3.fromRGB(39,49,70),TextColor3=Color3.new(1,1,1),Font=Enum.Font.Gotham,TextSize=14},pages.Personagem);corner(field,7)
 wide(pages.Personagem,'Aplicar '..label,function()
  local n=tonumber(field.Text)
  if not n or n<min or n>max then say('Digite um numero entre '..min..' e '..max);return end
  local h=humanoid();if not h then say('Humanoid nao encontrado.');return end
  if property=='JumpPower' then h.UseJumpPower=true end
  h[property]=n;say(label..' definido localmente para '..n)
 end)
end
numericSetting('Velocidade',16,0,150,'WalkSpeed')
numericSetting('Pulo',50,0,200,'JumpPower')
wide(pages.Personagem,'Restaurar movimento',function() local h=humanoid();if h then h.WalkSpeed=16;h.UseJumpPower=true;h.JumpPower=50;say('Movimento local restaurado.') end end)
line(pages.Jogadores,'Lista por equipes. Atualize para ver jogadores atuais.')
local playersLabel=line(pages.Jogadores,'Toque em Atualizar.');playersLabel.Size=UDim2.new(1,-4,0,175);playersLabel.TextYAlignment=Enum.TextYAlignment.Top
wide(pages.Jogadores,'Atualizar jogadores / equipes',function()
 local grouped={}
 for _,p in ipairs(Players:GetPlayers()) do local t=p.Team and p.Team.Name or 'Sem equipe';grouped[t]=grouped[t] or {};table.insert(grouped[t],p.DisplayName..' (@'..p.Name..')') end
 local out={};for t,arr in pairs(grouped) do table.insert(out,t..' ['..#arr..']\n'..table.concat(arr,', ')) end
 table.sort(out);playersLabel.Text=table.concat(out,'\n\n');playersLabel.Size=UDim2.new(1,-4,0,math.max(175,#out*75));say('Equipes atualizadas.')
end)
line(pages.Sobre,'Doublex Hub v1.0 | Jailbreak\nInterface para Delta Mobile. Guias de roubos, busca de locais, equipes e ajustes locais.\nNao inclui invulnerabilidade, auto puzzle ou auto robbery. Nao executa codigo remoto adicional.')
wide(pages.Sobre,'Parar e fechar Doublex Hub',function() gui:Destroy() end)
pages.Roubos.Visible=true;tabButtons.Roubos.BackgroundColor3=Color3.fromRGB(52,96,158)
