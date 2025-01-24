-----------------------------------------------------------------------------------------------------------------------------------------
-- Shark Group Manager
-----------------------------------------------------------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("shark_gm",cRP)
vSERVER = Tunnel.getInterface("shark_gm")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local groupContext = nil
local gerente = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADFOCUS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	SetNuiFocus(false,false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- COMMAND FOR OPEN NUI
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand(Cfg.CommandOpenNUI,function(source,args)
    local ped = PlayerPedId()
    -- if not IsPauseMenuActive() and not exports["inventory"]:blockInvents() and not exports["player"]:blockCommands() and not exports["player"]:handCuff() and GetEntityHealth(ped) > 101 and not IsEntityInWater(ped) then
        if vSERVER.getOrganizacao() then
            if args[1] then
                if vSERVER.PermToUseStaffTablet() then
                    if vSERVER.requestMembersMax(args[1]) then
                        groupContext = args[1]
                        gerente = true
                    else
                        TriggerEvent("Notify","vermelho","Esta organização não existe.",8000)
                        return
                    end
                else
                    TriggerEvent("Notify","vermelho","Você não tem permissão para acessar o painel de staff.",8000)
                    return
                end
            else
                
                groupContext = vSERVER.getOrganizacao()
                gerente = vSERVER.checkLider()
                if Cfg.ListOfOrgs[groupContext]["PermInservice"] then
                    if not vSERVER.InServiceClient(groupContext) then
                        TriggerEvent("Notify","vermelho","Você não esta em serviço.",8000)
                        return
                    end
                end
                if gerente ~= false then
                    gerente = true
                end
            end
            SetNuiFocus(true,true)
            SetCursorLocation(0.5,0.5)
            SendNUIMessage({ action = "openSystem", group = groupContext, gerente = gerente })
            TransitionToBlurred(1000)
            if not IsPedInAnyVehicle(PlayerPedId()) then
                vRP.removeObjects()
                vRP.createObjects("amb@code_human_in_bus_passenger_idles@female@tablet@base","base","prop_cs_tablet",50,28422)
            end
        end
    -- end
end) 
if Cfg.OpenNUIWithKey then
    RegisterKeyMapping(Cfg.CommandOpenNUI,"Abrir menu de grupos.","keyboard",Cfg.KeyOpenNUI)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSESYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("closeSystem",function(data)
	vRP.removeObjects()
	SetNuiFocus(false,false)
	SetCursorLocation(0.5,0.5)
	SendNUIMessage({ action = "closeSystem" })
    TransitionFromBlurred(1000)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestcargos",function(data,cb)
	cb({ result = vSERVER.ReturnHierarquia(data["group"])})
end)
RegisterNUICallback("requestinfos",function(data,cb)
	cb(vSERVER.infos(data["group"]))
end)
RegisterNUICallback("requestMembers",function(data,cb)
	cb({ result = vSERVER.requestMembers(data["group"])})
end)

RegisterNUICallback("requestupdateMembers",function(data,cb)
	cb({ result = vSERVER.updateMember(data["id"],data["set"], data["cargo"])})
end)

RegisterNUICallback("requestdeleteMembers",function(data,cb)
	cb({ result = vSERVER.deleteMember(data["id"],data["group"])})
end)

RegisterNUICallback("requestMembersOn",function(data,cb)
    cb({ result = vSERVER.requestMembersOn(data["group"])})
end)

RegisterNUICallback("requestMembersMax",function(data,cb)
    cb({ result = vSERVER.requestMembersMax(data["group"])})
end)

RegisterNUICallback("requestgroupMensage",function(data,cb)
    cb({ result = vSERVER.requestgroupMensage(data["group"])})
end)

RegisterNUICallback("requestSetGroupMensage",function(data,cb)
    vSERVER.requestSetGroupMensage(data["mensage"],data["group"])
end)

RegisterNUICallback("requestSetGroup",function(data,cb)
	vSERVER.requestSetGroup(data["id"],data["set"],data["group"])
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- system:UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("system:Update")
AddEventHandler("system:Update",function(action)
	SendNUIMessage({ action = action })
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- Shark Group Manager
-----------------------------------------------------------------------------------------------------------------------------------------