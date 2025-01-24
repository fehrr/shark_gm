-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("shark_gm", cRP)
vCLIENT = Tunnel.getInterface("shark_gm")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.Prepare("shark_gm/setData", "INSERT INTO shark_gm_members(user_id,name,cargo,status,organization,login) VALUES(@user_id ,@name,@cargo,@status , @organization, @login)")
vRP.Prepare("shark_gm/checkData", "SELECT * FROM shark_gm_members WHERE user_id = @user_id ")
vRP.Prepare("shark_gm/membersData", "SELECT * FROM shark_gm_members WHERE organization = @organization")
vRP.Prepare("shark_gm/updateData", "UPDATE shark_gm_members SET cargo = @cargo WHERE user_id = @user_id")
vRP.Prepare("shark_gm/deleteData", "DELETE FROM shark_gm_members WHERE user_id = @user_id")
vRP.Prepare("shark_gm/updateStatus", "UPDATE shark_gm_members SET status = @status WHERE user_id = @user_id")
vRP.Prepare("shark_gm/HowStatus", "SELECT count(status) FROM shark_gm_members WHERE status = @status AND organization = @organization")
vRP.Prepare("shark_gm/membersQtd", "SELECT count(user_id) FROM shark_gm_members WHERE organization = @organization")
vRP.Prepare("shark_gm/orgQtd", "SELECT membros FROM shark_gm_organization WHERE organization = @organization")
vRP.Prepare("shark_gm/updateDataMembers", "UPDATE shark_gm_organization SET membros = @membros WHERE organization = @organization")
vRP.Prepare("shark_gm/groupMensage", "SELECT mensagem FROM shark_gm_organization WHERE organization = @organization")
vRP.Prepare("shark_gm/setMensage", "UPDATE shark_gm_organization SET mensagem = @mensagem WHERE organization = @organization")
vRP.Prepare("shark_gm/login", "UPDATE shark_gm_members SET login = @login WHERE user_id = @user_id")
vRP.Prepare("shark_gm/setBlackList", "INSERT INTO shark_gm_blacklist(id,blacklist) VALUES(@id,@blacklist)")
vRP.Prepare("shark_gm/getBlackList", "SELECT * FROM shark_gm_blacklist WHERE id = @id")
vRP.Prepare("shark_gm/remBlackList", "DELETE FROM shark_gm_blacklist WHERE id = @id")
vRP.Prepare("shark_gm/getOrganization", "SELECT * FROM shark_gm_organization WHERE organization = @organization")
vRP.Prepare("shark_gm/createOrganization", "INSERT INTO shark_gm_organization(organization,mensagem,membros) VALUES(@organization,@mensagem,@membros)")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand(Cfg.AttListOfOrgsInDB, function(source, Message, rawCommand)
     local source = source
     local Passport = vRP.Passport(source)
     for _, i in pairs(Cfg.UseCommandAttListOfOrgs) do
          if vRP.HasGroup(Passport, i, 2) then
               for Number, v in pairs(Cfg.ListOfOrgs) do
                    local Consult = vRP.Query("shark_gm/getOrganization", { organization = Number })
                    if not Consult[1] then
                         vRP.Execute("shark_gm/createOrganization", { organization = Number, mensagem = "Coloque seus avisos aqui", membros = v.MaxMembers })
                         print("A organização " .. Number .. " foi inserida na tabela shark_gm_organization corretamente")
                    end
               end
               return
          end
     end
     TriggerClientEvent("Notify", source, "vermelho", "Você não tem permissão para utilizar o comando " .. Cfg.AttListOfOrgsInDB, 8000)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand(Cfg.CommandForRemMember, function(source, Message, rawCommand)
     local source = source
     local Passport = vRP.Passport(source)
     for _, i in pairs(Cfg.UseCommandRemMember) do
          if vRP.HasGroup(Passport, i, 2) then
               local Consult = vRP.Query("shark_gm/checkData", { user_id = Message[1] })
               if Consult[1] and Consult[1].organization == Message[2] then
                    vRP.Execute("shark_gm/deleteData", { user_id = Message[1] })
                    TriggerClientEvent("Notify", source, "verde", "Passaporte " .. Message[1] .. " removido da organização " .. Message[2], 8000)
                    return
               end
          end
     end
     TriggerClientEvent("Notify", source, "vermelho", "Você não tem permissão para utilizar o comando " .. Cfg.CommandForRemMember, 8000)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand(Cfg.CommandForAddNewLider, function(source, Message, rawCommand)
     local source = source
     local Passport = vRP.Passport(source)
     local Identity = vRP.Identity(Message[1])
     if Passport then
          for _, i in pairs(Cfg.UseCommandAddNewLider) do
               if vRP.HasGroup(Passport, i, 2) then
                    vRP.SetPermission(Message[1], Message[2], 1)
                    vRP.Execute("shark_gm/setData", {  user_id = parseInt(Message[1]), name = Identity.name .. " " .. Identity.name2, cargo = Cfg.ListOfOrgs[Message[2]].PermLider, status = "on", organization = Message[2], login = parseInt(os.time()) })
                    TriggerClientEvent("system:Update", source, "updateData")
                    TriggerClientEvent("Notify", source, "verde", "O " .. Identity.name .. " " .. Identity.name2 .. " foi adicionado como lider do grupo " .. Message[2], 8000)
                    return
               end
          end
          TriggerClientEvent("Notify", source, "vermelho", "Você não tem permissão para utilizar o comando " .. Cfg.CommandForAddNewLider, 8000)
     end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.infos(Data)
     local source = source
     local Passport = vRP.Passport(source)
     local Identity = vRP.Identity(Passport)
     if Passport then
          local Consult = vRP.Query("shark_gm/checkData", { user_id = Passport })
          if Consult[1] then
               return { Identity.name .. " " .. Identity.name2, Identity.id, Data, Consult[1].cargo }
          end
     end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.requestMembers(Data)
     local Members = {}
     local source = source
     local Passport = vRP.Passport(source)
     local Consult = vRP.Query("shark_gm/membersData", { organization = Data })
     if vRP.Passport(source) then
          for _, i in pairs(Consult) do
               local Identity = vRP.Identity(i.user_id)
               if Cfg.ListOfOrgs[Data].PermInservice and "" ~= Cfg.ListOfOrgs[Data].PermInservice then
               end
               for Number, v in pairs(Cfg.ListOfOrgs[Data].Hierarquia) do
               end
               table.insert(Members, {
                    id = i.user_id,
                    name = Identity.name .. " " .. Identity.name2,
                    pesocargo = Number,
                    cargo = i.cargo,
                    Nuiservico = true,
                    servico = cRP.InService(i.user_id, Data),
                    status = i.status
               })
          end
          return Members
     end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.InService(Passport, Permission)
     local source = source
     if Passport and Cfg.ListOfOrgs[Permission].PermInservice then
          if vRP.HasService(Passport, Cfg.ListOfOrgs[Permission].PermInservice) then
               return true
          else
               return false
          end
     end
     return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.InServiceClient(Permission)
     local source = source
     local Passport = vRP.Passport(source)
     if Passport and Cfg.ListOfOrgs[Permission].PermInservice then
          if vRP.HasService(Passport, Cfg.ListOfOrgs[Permission].PermInservice) then
               return true
          else
               return false
          end
     end
     return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.AttData(Data)
     local source = source
     local Passport = vRP.Passport(source)
     if Passport then
          local membros = vRP.Query("shark_gm/membersQtd", { organization = Data })
          return membros
     end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.requestSetGroup(Passport, Group, Data)
     local source = source
     local Passport = vRP.Passport(source)
     local Source = vRP.Source(Passport)
     local Identity = vRP.Identity(Passport)
     local Consult = vRP.Query("shark_gm/getBlackList", { id = Passport })
     if vRP.Passport(source) then
          if cRP.getOrganizacao(Passport) then
               TriggerClientEvent("Notify", source, "vermelho", "Este usuario ja faz parte de uma organização", 8000)
               return
          end
          if Consult[1] then
               if Cfg.Blacklist.System then
                    if Consult[1].blacklist <= parseInt(os.time()) then
                         if not cRP.checkMaxGroup(Data) then
                              TriggerClientEvent("Notify", source, "amarelo", "Convite para o " .. Data .. " enviado para o " .. Identity.name .. " " .. Identity.name2 .. "", 8000)
                              if vRP.Request(Source, "Deseja ingressar no " .. Data, "Sim, ingressar", "Não") then
                                   for Number, v in pairs(Cfg.ListOfOrgs[Data].Hierarquia) do
                                        if v == Group then
                                             cRP.AttData(Data)
                                             vRP.SetPermission(Passport, Data, Number)
                                             vRP.Execute("shark_gm/setData", { user_id = parseInt(Passport), name = Identity.name .. " " .. Identity.name2, cargo = Group, status = "on", organization = Data, login = parseInt(os.time()) })
                                             TriggerClientEvent("system:Update", source, "updateData")
                                             TriggerClientEvent("Notify", Source, "verde", "Você ingressou no " .. Data, 8000)
                                        end
                                   end
                              else
                                   TriggerClientEvent("Notify", source, "vermelho", "O mesmo recusou o convite", 8000)
                              end
                         else
                              TriggerClientEvent("system:Update", source, "updateData")
                              TriggerClientEvent("Notify", source, "vermelho", "Seu grupo está cheio, não foi possivel adicionar o novo membro", 8000)
                         end
                    else
                         TriggerClientEvent("Notify", source, "vermelho", "O " .. Identity.name .. " " .. Identity.name2 .. " ainda esta na blacklist, a blacklist acaba as " .. os.date("%H:%M do dia %d/%m", Consult[1].blacklist), 8000)
                    end
               end
          elseif not cRP.checkMaxGroup(Data) then
               TriggerClientEvent("Notify", source, "amarelo", "Convite para o " .. Data .. " enviado para o " .. Identity.name .. " " .. Identity.name2 .. "", 8000)
               if vRP.Request(Source, "Deseja ingressar no " .. Data, "Sim, ingressar", "Não") then
                    for Number, v in pairs(Cfg.ListOfOrgs[Data].Hierarquia) do
                         if v == Group then
                              cRP.AttData(Data)
                              vRP.SetPermission(Passport, Data, Number)
                              vRP.Execute("shark_gm/setData", { user_id = parseInt(Passport), name = Identity.name .. " " .. Identity.name2, cargo = Group, status = "on", organization = Data, login = parseInt(os.time()) })
                              TriggerClientEvent("system:Update", source, "updateData")
                              TriggerClientEvent("Notify", Source, "verde", "Você ingressou no " .. Data, 8000)
                         end
                    end
               else
                    TriggerClientEvent("Notify", source, "vermelho", "O mesmo recusou o convite", 8000)
               end
          else
               TriggerClientEvent("system:Update", source, "updateData")
               TriggerClientEvent("Notify", source, "vermelho", "Seu grupo está cheio, não foi possivel adicionar o novo membro", 8000)
          end
     end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.updateMember(Passport, Group, Data)
     local source = source
     local Consult = vRP.Query("shark_gm/checkData", { user_id = parseInt(Passport) })
     if Data and vRP.Passport(source) then
          if "Gerente" == Group then
               if true then
                    vRP.Execute("shark_gm/updateData", { cargo = Group, user_id = parseInt(Passport) })
                    TriggerClientEvent("system:Update", source, "updateData")
                    for Number, v in pairs(Cfg.ListOfOrgs[Data].Hierarquia) do
                         if v == Group then
                              cRP.AttData(Data)
                              vRP.SetPermission(Passport, Data, Number)
                         end
                    end
               else
                    TriggerClientEvent("Notify", source, "vermelho", "Apenas lider pode setar gerente", 8000)
               end
          else
               if Consult[1] and Consult[1].cargo then
                    vRP.RemovePermission(Passport, Consult[1].cargo)
               end
               for Number, v in pairs(Cfg.ListOfOrgs[Data].Hierarquia) do
                    if v == Group then
                         cRP.AttData(Data)
                         vRP.SetPermission(Passport, Data, Number)
                    end
               end
               vRP.Execute("shark_gm/updateData", { cargo = Group, user_id = parseInt(Passport) })
               TriggerClientEvent("system:Update", source, "updateData")
          end
     end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.deleteMember(Passport, Group)
     local source = source
     local Consult = vRP.Query("shark_gm/checkData", { user_id = Passport })
     local ConsultBlack = vRP.Query("shark_gm/getBlackList", { id = Passport })
     if vRP.Passport(source) then
          if "Lider" == Consult[1].cargo then
               TriggerClientEvent("Notify", source, "vermelho", "Voc\195\170 quer remover seu lider?", 8000)
          elseif "Gerente" == Consult[1].cargo then
               if "Lider" == Consult[1].cargo then
                    vRP.RemovePermission(Passport, Group)
                    vRP.RemovePermission(Passport, Group .. "Lider")
                    vRP.RemovePermission(Passport, "PoliceLider")
                    vRP.RemovePermission(Passport, "Police")
                    vRP.RemovePermission(Passport, "waitPolicia")
                    vRP.RemovePermission(Passport, "waitParamedic")
                    vRP.RemovePermission(Passport, "Paramedic")
                    vRP.RemovePermission(Passport, "Police")
                    vRP.RemovePermission(Passport, "waitPolice")
                    vRP.RemovePermission(Passport, "Federal")
                    vRP.RemovePermission(Passport, "waitFederal")
                    vRP.RemovePermission(Passport, "Policial")
                    vRP.RemovePermission(Passport, "Mechanic")
                    vRP.RemovePermission(Passport, "Mechanic2")
                    vRP.RemovePermission(Passport, "Recruta")
                    vRP.RemovePermission(Passport, "Soldado")
                    vRP.RemovePermission(Passport, "Cabo")
                    vRP.RemovePermission(Passport, "3\194\176-Sargento")
                    vRP.RemovePermission(Passport, "2\194\176-Sargento")
                    vRP.RemovePermission(Passport, "1\194\176-Sargento")
                    vRP.RemovePermission(Passport, "Aspirante-A-Oficial")
                    vRP.RemovePermission(Passport, "SubTenente")
                    vRP.RemovePermission(Passport, "2\194\176-Tenente")
                    vRP.RemovePermission(Passport, "1\194\176-Tenente")
                    vRP.RemovePermission(Passport, "Capitão")
                    vRP.RemovePermission(Passport, "Major")
                    vRP.RemovePermission(Passport, "Tenente-Coronel")
                    vRP.RemovePermission(Passport, "Coronel")
                    vRP.RemovePermission(Passport, "Corregedoria")
                    vRP.RemovePermission(Passport, "Favela1")
                    vRP.RemovePermission(Passport, "LiderFavela1")
                    vRP.RemovePermission(Passport, "Favela2")
                    vRP.RemovePermission(Passport, "LiderFavela2")
                    vRP.RemovePermission(Passport, "Favela3")
                    vRP.RemovePermission(Passport, "LiderFavela3")
                    vRP.RemovePermission(Passport, "Favela4")
                    vRP.RemovePermission(Passport, "LiderFavela4")
                    vRP.RemovePermission(Passport, "Favela5")
                    vRP.RemovePermission(Passport, "LiderFavela5")
                    vRP.RemovePermission(Passport, "Favela6")
                    vRP.RemovePermission(Passport, "LiderFavela6")
                    vRP.RemovePermission(Passport, "Favela7")
                    vRP.RemovePermission(Passport, "LiderFavela7")
                    vRP.RemovePermission(Passport, "Favela8")
                    vRP.RemovePermission(Passport, "LiderFavela8")
                    vRP.RemovePermission(Passport, "Favela9")
                    vRP.RemovePermission(Passport, "LiderFavela9")
                    vRP.RemovePermission(Passport, "Favela10")
                    vRP.RemovePermission(Passport, "LiderFavela10")
                    vRP.RemovePermission(Passport, "Mafia1")
                    vRP.RemovePermission(Passport, "LiderMafia1")
                    vRP.RemovePermission(Passport, "Mafia2")
                    vRP.RemovePermission(Passport, "LiderMafia2")
                    vRP.RemovePermission(Passport, "Mafia4")
                    vRP.RemovePermission(Passport, "LiderMafia4")
                    vRP.RemovePermission(Passport, "Mafia3")
                    vRP.RemovePermission(Passport, "LiderMafia3")
                    vRP.RemovePermission(Passport, "Lavagem1")
                    vRP.RemovePermission(Passport, "LiderLavagem1")
                    vRP.RemovePermission(Passport, "Lavagem2")
                    vRP.RemovePermission(Passport, "LiderLavagem2")
                    vRP.RemovePermission(Passport, "Diretoria")
                    vRP.RemovePermission(Passport, "Diretoria")
                    vRP.RemovePermission(Passport, "Vice Diretor")
                    vRP.RemovePermission(Passport, "Cirurgião")
                    vRP.RemovePermission(Passport, "Socorrista Chefe")
                    vRP.RemovePermission(Passport, "Socorrista 2\194\176Classe")
                    vRP.RemovePermission(Passport, "Socorrista")
                    vRP.RemovePermission(Passport, "Interno")
                    vRP.RemovePermission(Passport, "Estagiario")
                    vRP.RemovePermission(Passport, "Paramedico")
                    vRP.RemovePermission(Passport, "Hospital")
                    vRP.RemovePermission(Passport, "Paramedic")
                    vRP.RemovePermission(Passport, "waitParamedic")
                    vRP.Execute("shark_gm/deleteData", { user_id = parseInt(Passport) })
                    TriggerClientEvent("system:Update", source, "updateData")
                    if ConsultBlack[1] then
                         if ConsultBlack[1].blacklist <= parseInt(os.time()) then
                              vRP.Query("shark_gm/remBlackList", { id = Passport })
                              vRP.Query("shark_gm/setBlackList", { id = Passport, blacklist = parseInt(os.time()) + 259200 })
                         else
                              vRP.Query("shark_gm/setBlackList", { id = Passport, blacklist = parseInt(os.time()) + 259200 })
                         end
                    end
               else
                    TriggerClientEvent("Notify", source, "vermelho", "Apenas lider pode remover gerente", 8000)
               end
          else
               vRP.RemovePermission(Passport, Group)
               vRP.RemovePermission(Passport, Group .. "Lider")
               vRP.RemovePermission(Passport, "PoliceLider")
               vRP.RemovePermission(Passport, "Police")
               vRP.RemovePermission(Passport, "waitPolicia")
               vRP.RemovePermission(Passport, "waitParamedic")
               vRP.RemovePermission(Passport, "Paramedic")
               vRP.RemovePermission(Passport, "Police")
               vRP.RemovePermission(Passport, "waitPolice")
               vRP.RemovePermission(Passport, "Federal")
               vRP.RemovePermission(Passport, "waitFederal")
               vRP.RemovePermission(Passport, "Policial")
               vRP.RemovePermission(Passport, "Mechanic")
               vRP.RemovePermission(Passport, "Mechanic2")
               vRP.RemovePermission(Passport, "Recruta")
               vRP.RemovePermission(Passport, "Soldado")
               vRP.RemovePermission(Passport, "Cabo")
               vRP.RemovePermission(Passport, "3\194\176-Sargento")
               vRP.RemovePermission(Passport, "2\194\176-Sargento")
               vRP.RemovePermission(Passport, "1\194\176-Sargento")
               vRP.RemovePermission(Passport, "Aspirante-A-Oficial")
               vRP.RemovePermission(Passport, "SubTenente")
               vRP.RemovePermission(Passport, "2\194\176-Tenente")
               vRP.RemovePermission(Passport, "1\194\176-Tenente")
               vRP.RemovePermission(Passport, "Capitão")
               vRP.RemovePermission(Passport, "Major")
               vRP.RemovePermission(Passport, "Tenente-Coronel")
               vRP.RemovePermission(Passport, "Coronel")
               vRP.RemovePermission(Passport, "Corregedoria")
               vRP.RemovePermission(Passport, "Favela1")
               vRP.RemovePermission(Passport, "LiderFavela1")
               vRP.RemovePermission(Passport, "Favela2")
               vRP.RemovePermission(Passport, "LiderFavela2")
               vRP.RemovePermission(Passport, "Favela3")
               vRP.RemovePermission(Passport, "LiderFavela3")
               vRP.RemovePermission(Passport, "Favela4")
               vRP.RemovePermission(Passport, "LiderFavela4")
               vRP.RemovePermission(Passport, "Favela5")
               vRP.RemovePermission(Passport, "LiderFavela5")
               vRP.RemovePermission(Passport, "Favela6")
               vRP.RemovePermission(Passport, "LiderFavela6")
               vRP.RemovePermission(Passport, "Favela7")
               vRP.RemovePermission(Passport, "LiderFavela7")
               vRP.RemovePermission(Passport, "Favela8")
               vRP.RemovePermission(Passport, "LiderFavela8")
               vRP.RemovePermission(Passport, "Favela9")
               vRP.RemovePermission(Passport, "LiderFavela9")
               vRP.RemovePermission(Passport, "Favela10")
               vRP.RemovePermission(Passport, "LiderFavela10")
               vRP.RemovePermission(Passport, "Mafia1")
               vRP.RemovePermission(Passport, "LiderMafia1")
               vRP.RemovePermission(Passport, "Mafia2")
               vRP.RemovePermission(Passport, "LiderMafia2")
               vRP.RemovePermission(Passport, "Mafia4")
               vRP.RemovePermission(Passport, "LiderMafia4")
               vRP.RemovePermission(Passport, "Mafia3")
               vRP.RemovePermission(Passport, "LiderMafia3")
               vRP.RemovePermission(Passport, "Lavagem1")
               vRP.RemovePermission(Passport, "LiderLavagem1")
               vRP.RemovePermission(Passport, "Lavagem2")
               vRP.RemovePermission(Passport, "LiderLavagem2")
               vRP.RemovePermission(Passport, "Diretoria")
               vRP.RemovePermission(Passport, "Diretoria")
               vRP.RemovePermission(Passport, "Vice Diretor")
               vRP.RemovePermission(Passport, "Cirurgião")
               vRP.RemovePermission(Passport, "Socorrista Chefe")
               vRP.RemovePermission(Passport, "Socorrista 2\194\176Classe")
               vRP.RemovePermission(Passport, "Socorrista")
               vRP.RemovePermission(Passport, "Interno")
               vRP.RemovePermission(Passport, "Estagiario")
               vRP.RemovePermission(Passport, "Paramedico")
               vRP.RemovePermission(Passport, "Hospital")
               vRP.RemovePermission(Passport, "Paramedic")
               vRP.RemovePermission(Passport, "waitParamedic")
               vRP.Execute("shark_gm/deleteData", { user_id = parseInt(Passport) })
               TriggerClientEvent("system:Update", source, "updateData")
               if ConsultBlack[1] then
                    if not Cfg.Blacklist.System then
                    end
                    if "days" == Cfg.Blacklist.Type or "Days" == Cfg.Blacklist.Type or "DAYS" ~= Cfg.Blacklist.Type then
                         vRP.Query("shark_gm/setBlackList", { id = Passport, blacklist = parseInt(os.time()) + Cfg.Blacklist.Time * 3600 })
                    end
                    if "hours" == Cfg.Blacklist.Time or "Hours" == Cfg.Blacklist.Time or "HOURS" ~= Cfg.Blacklist.Time then
                         vRP.Query("shark_gm/setBlackList", { id = Passport, blacklist = parseInt(os.time()) + Cfg.Blacklist.Time * 3600 })
                    end
                    if ConsultBlack[1].blacklist <= parseInt(os.time()) then
                         vRP.Query("shark_gm/remBlackList", { id = Passport })
                    else
                         vRP.Query("shark_gm/setBlackList", { id = Passport, blacklist = parseInt(os.time()) + Cfg.Blacklist.Time * 3600 })
                    end
               else
                    if ConsultBlack[1] then
                         if ConsultBlack[1].blacklist <= parseInt(os.time()) then
                              vRP.Query("shark_gm/remBlackList", { id = Passport })
                              vRP.Query("shark_gm/setBlackList", { id = Passport, blacklist = parseInt(os.time()) + 259200 })
                         else
                              vRP.Query("shark_gm/setBlackList", { id = Passport, blacklist = parseInt(os.time()) + 259200 })
                         end
                    else
                         vRP.Query("shark_gm/setBlackList", { id = Passport, blacklist = parseInt(os.time()) + 259200 })
                    end
               end
          end
     end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.requestMembersOn(Group)
     local Quantity = {}
     local source = source
     local Passport = vRP.Passport(source)
     if Passport then
          table.insert(Quantity, {
               qtdOn = vRP.Query("shark_gm/HowStatus", { status = "on", organization = Group })[1]["count(status)"]
          })
          return Quantity
     end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.requestMembersMax(Group)
     local Quantity = {}
     local source = source
     local Passport = vRP.Passport(source)
     if Passport then
          if vRP.Query("shark_gm/orgQtd", { organization = Group })[1] then
               table.insert(Quantity, {
                    qtd = vRP.Query("shark_gm/membersQtd", { organization = Group })[1]["count(user_id)"],
                    maxQtd = vRP.Query("shark_gm/orgQtd", { organization = Group })[1].membros
               })
               return Quantity
          else
               return 1
          end
     end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.requestgroupMensage(Group)
     local Message = {}
     local source = source
     local Passport = vRP.Passport(source)
     local Consult = vRP.Query("shark_gm/groupMensage", { organization = Group })
     if Passport then
          if Consult[1] then
               table.insert(Message, {
                    msg = Consult[1].mensagem
               })
               return Message
          else
               table.insert(Message, {
                    msg = "Insira sua mensagem aqui"
               })
               return Message
          end
     end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.requestSetGroupMensage(Message, Group)
     local source = source
     local Passport = vRP.Passport(source)
     if Passport then
          vRP.Execute("shark_gm/setMensage", { mensagem = Message, organization = Group })
          TriggerClientEvent("system:Update", source, "updateData")
     end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.getOrganizacao(Passport)
     local source = source
     local Consult = vRP.Query("shark_gm/checkData", { user_id = parseInt(Passport) })
     local Consult2 = vRP.Query("shark_gm/checkData", { user_id = parseInt(vRP.Passport(source)) })
     if nil ~= Passport then
          if Passport then
               ({}).user_id = parseInt(Passport)
               if Consult[1] then
                    return Consult[1].organization
               end
          end
     elseif vRP.Passport(source) then
          if Consult2[1] then
               return Consult2[1].organization
          end
     end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.checkLider()
     local source = source
     local Passport = vRP.Passport(source)
     local Consult = vRP.Query("shark_gm/checkData", { user_id = parseInt(Passport) })
     if Passport then
          if Consult[1] then
               if Consult[1].cargo == Cfg.ListOfOrgs[Consult[1].organization].PermLider then
                    return "Lider"
               end
               if Cfg.ListOfOrgs[Consult[1].organization].PermSubLider and Consult[1].cargo == Cfg.ListOfOrgs[Consult[1].organization].PermSubLider then
                    return "SubLider"
               end
               if Cfg.ListOfOrgs[Consult[1].organization].PermGerente and Consult[1].cargo == Cfg.ListOfOrgs[Consult[1].organization].PermGerente then
                    return "SubLider"
               end
          end
          return false
     end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.ReturnHierarquia(Group)
     local Hierarchy = {}
     for Number, v in pairs(Cfg.ListOfOrgs[Group].Hierarquia) do
          table.insert(Hierarchy, {
               ordem = Number,
               cargo = v
          })
     end
     return Hierarchy
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.checkMaxGroup(Group)
     local Consult = vRP.Query("shark_gm/membersQtd", { organization = Group })
     local Consult2 = vRP.Query("shark_gm/orgQtd", { organization = Group })
     if parseInt(Consult[1]["count(user_id)"]) - parseInt(Consult2[1].membros) > 0 then
          return false
     elseif 0 == parseInt(Consult[1]["count(user_id)"]) - parseInt(Consult2[1].membros) then
          return true
     end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.PermToUseStaffTablet()
     local source = source
     local Passport = vRP.Passport(source)
     if Passport then
          for Number, v in pairs(Cfg.UseStaffTablet) do
               if vRP.HasGroup(Passport, v, 2) then
                    return true
               end
          end
          return false
     end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Connect", function(Passport)
     vRP.Execute("shark_gm/updateStatus", { status = "on", user_id = parseInt(Passport) })
     vRP.Execute("shark_gm/login", { login = parseInt(os.time()), user_id = parseInt(Passport) })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("Disconnect", function(Passport)
     vRP.Execute("shark_gm/updateStatus", { status = "off", user_id = parseInt(Passport) })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("removerbl", function(source, Message)
     local source = source
     local Passport = vRP.Passport(source)
     local Consult = vRP.Query("shark_gm/remBlackList", { id = Message[1] })
     if Passport and vRP.HasGroup(Passport, "Staff", 2) then
          if Consult then
               TriggerClientEvent("Notify", source, "verde", "Envio concluído.", 10000)
          else
               TriggerClientEvent("Notify", source, "vermelho", "deu merda ai.", 10000)
          end
     end
end)
