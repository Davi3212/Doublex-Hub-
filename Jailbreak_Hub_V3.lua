-- Doublex Hub V3 | Jailbreak | Delta Mobile
-- Recursos locais: GUI compacta, ESP, camera assistida, ajustes de personagem e painel de roubos.
-- Nao promete automacao de roubos ou invulnerabilidade.
-- V3: janela 306x208, abas compactas e limpeza de versoes anteriores.
local Players=game:GetService('Players')
local RunService=game:GetService('RunService')
local UIS=game:GetService('UserInputService')
local LP=Players.LocalPlayer
local camera=workspace.CurrentCamera
local parent=(type(gethui)=='function' and gethui()) or game:GetService('CoreGui')
for _,oldName in ipairs({'DoublexHubV1','DoublexHubV2','DoublexHubV3','JailbreakFunHubV1'}) do
 local old=parent:FindFirstChild(oldName)
 if old then old:Destroy() end
end
if _G.DoublexHubCleanup then pcall(_G.DoublexHubCleanup) end
local gui=Instance.new('ScreenGui'); gui.Name='DoublexHubV3'; gui.ResetOnSpawn=false; gui.IgnoreGuiInset=true; gui.Parent=parent
local connections={}; local drawings={}; local espOn=false; local aimOn=false; local fov=135; local teamFilter='Inimigos'; local speed=16; local jump=50
local function connect(sig,fn) local c=sig:Connect(fn); table.insert(connections,c); return c end
local function make(class,props,parentObj)
 local x=Instance.new(class)
 for k,v in pairs(props or {}) do x[k]=v end
 x.Parent=parentObj; return x
end
local colors={bg=Color3.fromRGB(17,21,33),panel=Color3.fromRGB(31,41,62),accent=Color3.fromRGB(64,132,219),white=Color3.fromRGB(239,243,252),muted=Color3.fromRGB(178,190,211)}
local main=make('Frame',{Name='Window',Size=UDim2.fromOffset(306,208),Position=UDim2.new(.5,-153,.5,-104),BackgroundColor3=colors.bg,BorderSizePixel=0,Active=true},gui)
make('UICorner',{CornerRadius=UDim.new(0,12)},main)
local scale=make('UIScale',{Scale=1},main)
local function updateScale()
 local vp=workspace.CurrentCamera.ViewportSize
 scale.Scale=math.min(1,math.max(.55,math.min((vp.X-20)/306,(vp.Y-20)/225)))
end
updateScale(); connect(workspace.CurrentCamera:GetPropertyChangedSignal('ViewportSize'),updateScale)
local header=make('Frame',{Size=UDim2.new(1,0,0,31),BackgroundColor3=colors.panel,BorderSizePixel=0},main)
make('UICorner',{CornerRadius=UDim.new(0,12)},header)
make('TextLabel',{Text='DOUBLEX HUB  |  JAILBREAK V3',Size=UDim2.new(1,-75,1,0),Position=UDim2.fromOffset(9,0),BackgroundTransparency=1,TextColor3=colors.white,TextSize=12,Font=Enum.Font.GothamBold,TextXAlignment=Enum.TextXAlignment.Left},header)
local function button(text,parentObj,size,pos,fn)
 local b=make('TextButton',{Text=text,Size=size,Position=pos,BackgroundColor3=colors.panel,TextColor3=colors.white,TextSize=11,Font=Enum.Font.Gotham,BorderSizePixel=0},parentObj)
 make('UICorner',{CornerRadius=UDim.new(0,7)},b); connect(b.MouseButton1Click,fn); return b
end
local open=true
local orb=button('DX',gui,UDim2.fromOffset(43,43),UDim2.fromOffset(12,110),function() open=not open;main.Visible=open end)
orb.BackgroundColor3=colors.accent
button('—',header,UDim2.fromOffset(28,24),UDim2.new(1,-62,0,3),function() open=false;main.Visible=false end)
local destroy
button('X',header,UDim2.fromOffset(28,24),UDim2.new(1,-31,0,3),function() destroy() end)
local dragging=false;local dragStart;local startPos
connect(header.InputBegan,function(i) if i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseButton1 then dragging=true;dragStart=i.Position;startPos=main.Position end end)
connect(header.InputEnded,function(i) if i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseButton1 then dragging=false end end)
connect(UIS.InputChanged,function(i) if dragging and (i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseMovement) then local d=i.Position-dragStart;main.Position=UDim2.new(startPos.X.Scale,startPos.X.Offset+d.X,startPos.Y.Scale,startPos.Y.Offset+d.Y) end end)
local tabs=make('Frame',{Size=UDim2.new(1,-10,0,28),Position=UDim2.fromOffset(5,36),BackgroundTransparency=1},main)
local content=make('ScrollingFrame',{Size=UDim2.new(1,-10,1,-72),Position=UDim2.fromOffset(5,68),BackgroundTransparency=1,ScrollBarThickness=3,CanvasSize=UDim2.fromOffset(0,0)},main)
local layout=make('UIListLayout',{Padding=UDim.new(0,5),SortOrder=Enum.SortOrder.LayoutOrder},content)
connect(layout:GetPropertyChangedSignal('AbsoluteContentSize'),function()content.CanvasSize=UDim2.fromOffset(0,layout.AbsoluteContentSize.Y+8)end)
local function clear()for _,x in ipairs(content:GetChildren()) do if x~=layout then x:Destroy() end end end
local function line(txt,height)
 return make('TextLabel',{Text=txt,Size=UDim2.new(1,-8,0,height or 31),BackgroundColor3=colors.panel,TextColor3=colors.white,TextSize=11,Font=Enum.Font.Gotham,TextWrapped=true,BorderSizePixel=0},content)
end
local function action(txt,fn)
 local b=button(txt,content,UDim2.new(1,-8,0,27),UDim2.new(),fn);return b
end
local function numberField(title,initial,callback)
 local row=make('Frame',{Size=UDim2.new(1,-8,0,30),BackgroundColor3=colors.panel,BorderSizePixel=0},content)
 make('TextLabel',{Text=title,Size=UDim2.new(.62,0,1,0),BackgroundTransparency=1,TextColor3=colors.white,TextSize=13,Font=Enum.Font.Gotham},row)
 local field=make('TextBox',{Text=tostring(initial),PlaceholderText='Digite...',Size=UDim2.new(.33,0,0,24),Position=UDim2.new(.65,0,0,3),BackgroundColor3=colors.bg,TextColor3=colors.white,TextSize=12,ClearTextOnFocus=false},row)
 connect(field.FocusLost,function()local n=tonumber(field.Text);if n then callback(n) else field.Text=tostring(initial) end end)
end
local function colorFor(p)
 local name=(p.Team and p.Team.Name or ''):lower()
 if name:find('police') or name:find('policia') then return Color3.fromRGB(65,153,255) end
 if name:find('criminal') or name:find('criminos') then return Color3.fromRGB(255,101,88) end
 if name:find('prison') or name:find('pres') then return Color3.fromRGB(255,191,66) end
 return Color3.fromRGB(210,210,210)
end
local function valid(p)
 if p==LP then return false end
 if teamFilter=='Todos' then return true end
 if teamFilter=='Inimigos' then return not (LP.Team and p.Team==LP.Team) end
 local t=(p.Team and p.Team.Name or ''):lower()
 if teamFilter=='Policia' then return t:find('police')~=nil or t:find('policia')~=nil end
 if teamFilter=='Criminosos' then return t:find('criminal')~=nil or t:find('criminos')~=nil end
 if teamFilter=='Prisioneiros' then return t:find('prison')~=nil or t:find('pres')~=nil end
 return false
end
local espFolder=make('Folder',{Name='ESP_Labels'},gui)
local function updateESP()
 for _,p in ipairs(Players:GetPlayers()) do
  if p~=LP then
   local tag=espFolder:FindFirstChild(tostring(p.UserId))
   if not tag then
    tag=make('BillboardGui',{Name=tostring(p.UserId),Size=UDim2.fromOffset(165,42),StudsOffset=Vector3.new(0,3,0),AlwaysOnTop=true,Enabled=false},espFolder)
    make('TextLabel',{Name='Label',Size=UDim2.fromScale(1,1),BackgroundTransparency=.45,BackgroundColor3=Color3.new(0,0,0),TextScaled=false,TextSize=12,TextColor3=colors.white,Font=Enum.Font.GothamBold},tag)
   end
   local ch=p.Character;local root=ch and ch:FindFirstChild('HumanoidRootPart');local my=LP.Character and LP.Character:FindFirstChild('HumanoidRootPart')
   tag.Adornee=root;tag.Enabled=espOn and valid(p) and root~=nil
   if tag.Enabled then tag:FindFirstChild('Label').Text=p.DisplayName..' | '..(p.Team and p.Team.Name or 'Sem equipe')..' | '..(my and math.floor((root.Position-my.Position).Magnitude)..'m' or '?');tag:FindFirstChild('Label').TextColor3=colorFor(p) end
  end
 end
end
local robberyNames={'Banco','Joalheria','Museu','Tumba','Usina','Trem de carga','Trem de passageiros','Aviao de carga','Navio de carga','Posto de gasolina','Loja de donuts','Mansao','Plataforma de petroleo','Crown Jewel'}
local tips={Banco='Entre quando estiver aberto; procure o cofre e a rota de saida.',Joalheria='Quebre vitrines, evite lasers e saia pelo telhado.',Museu='Exige dois jogadores para iniciar e coordenar as alavancas.',Tumba='Exige dois jogadores para iniciar; evite as armadilhas.',Usina='Resolva o puzzle e entregue o uranio rapidamente.'}
local tabNames={'Roubos','ESP','Mira','Player','Times'}
local tabButtons={};local selected='ESP';local render
render=function()
 clear()
 if selected=='Roubos' then
  line('Painel informativo. Auto Robbery nao implementado.',37)
  for _,name in ipairs(robberyNames) do action(name,function()clear();line(name..': '..(tips[name] or 'Verifique no mapa se o roubo esta aberto.'),65);action('Voltar a lista',function()render()end)end)end
 elseif selected=='ESP' then
  action('ESP: '..(espOn and 'LIGADO' or 'DESLIGADO'),function()espOn=not espOn;render()end)
  line('Mostra nome, equipe e distancia sobre os jogadores.',37)
  action('Filtro: '..teamFilter,function()local opts={'Inimigos','Todos','Policia','Criminosos','Prisioneiros'};local ix=table.find(opts,teamFilter) or 1;teamFilter=opts[ix%#opts+1];render()end)
 elseif selected=='Mira' then
  action('Camera assistida: '..(aimOn and 'LIGADA' or 'DESLIGADA'),function()aimOn=not aimOn;render()end)
  line('Mira com a camera no alvo valido mais proximo do centro. Nao dispara armas.',43)
  numberField('FOV em pixels',fov,function(n)fov=math.clamp(n,20,600)end)
  action('Filtro: '..teamFilter,function()local opts={'Inimigos','Todos','Policia','Criminosos','Prisioneiros'};teamFilter=opts[(table.find(opts,teamFilter) or 1)%#opts+1];render()end)
 elseif selected=='Player' then
  numberField('Velocidade',speed,function(n)speed=math.clamp(n,0,200);local h=LP.Character and LP.Character:FindFirstChildOfClass('Humanoid');if h then h.WalkSpeed=speed end end)
  numberField('Pulo',jump,function(n)jump=math.clamp(n,0,250);local h=LP.Character and LP.Character:FindFirstChildOfClass('Humanoid');if h then h.UseJumpPower=true;h.JumpPower=jump end end)
  action('Restaurar padrao',function()speed=16;jump=50;local h=LP.Character and LP.Character:FindFirstChildOfClass('Humanoid');if h then h.WalkSpeed=16;h.UseJumpPower=true;h.JumpPower=50 end;render()end)
  line('Alteracoes locais podem ser revertidas pelo servidor.',36)
 elseif selected=='Times' then
  for _,p in ipairs(Players:GetPlayers()) do action(p.DisplayName..' | '..(p.Team and p.Team.Name or 'Sem equipe'),function()end)end
 end
end
for i,name in ipairs(tabNames) do
 local b=button(name,tabs,UDim2.new(.2,-4,1,0),UDim2.new((i-1)*.2,2,0,0),function()selected=name;render();for n,v in pairs(tabButtons) do v.BackgroundColor3=(n==selected and colors.accent or colors.panel) end end)
 tabButtons[name]=b
end
render();tabButtons.ESP.BackgroundColor3=colors.accent
local elapsed=0
connect(RunService.RenderStepped,function(dt)
 elapsed=elapsed+dt
 if elapsed>.20 then elapsed=0;updateESP()end
 if aimOn then
  camera=workspace.CurrentCamera
  local best,dist=nil,fov
  local center=camera.ViewportSize/2
  for _,p in ipairs(Players:GetPlayers()) do
   if valid(p) then
    local ch=p.Character;local hum=ch and ch:FindFirstChildOfClass('Humanoid');local head=ch and ch:FindFirstChild('Head')
    if head and hum and hum.Health>0 then
     local pt,visible=camera:WorldToViewportPoint(head.Position)
     if visible then local d=(Vector2.new(pt.X,pt.Y)-center).Magnitude;if d<dist then dist=d;best=head end end
    end
   end
  end
  if best then camera.CFrame=camera.CFrame:Lerp(CFrame.lookAt(camera.CFrame.Position,best.Position),math.clamp(dt*7,0,1)) end
 end
end)
connect(Players.PlayerRemoving,function(p)local t=espFolder:FindFirstChild(tostring(p.UserId));if t then t:Destroy()end end)
destroy=function()
 aimOn=false;espOn=false
 for _,c in ipairs(connections) do pcall(function()c:Disconnect()end) end
 gui:Destroy();_G.DoublexHubCleanup=nil
end
_G.DoublexHubCleanup=destroy
