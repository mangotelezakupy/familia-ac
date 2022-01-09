ESX = nil
local wybuch = 0
local modelcounter = 0


local Webhook2 = ''

local licznik_car = 0
local licznik_ped = 0
local licznik_propow = 0

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

BlacklistedEvents = Config.BlacklistedEvents;

RegisterServerEvent("Anticheat:NoClip")
AddEventHandler("Anticheat:NoClip", function(distance)
    if Config.Components.AntiNoclip and not IsPlayerAceAllowed(source, "Anticheat.Bypass") then
        local name = GetPlayerName(source)
        local id = source;
        local ids = ExtractIdentifiers(id);
        local steam = ids.steam:gsub("steam:", "");
        local kurwa = GetPlayerName(_source)

        local date = os.date('*t')
        
        if date.day < 10 then date.day = '0' .. tostring(date.day) end
        if date.month < 10 then date.month = '0' .. tostring(date.month) end
        if date.hour < 10 then date.hour = '0' .. tostring(date.hour) end
        if date.min < 10 then date.min = '0' .. tostring(date.min) end
        if date.sec < 10 then date.sec = '0' .. tostring(date.sec) end

        local steamDec = tostring(tonumber(steam,16));
        if counter[ids.steam] ~= nil then 
            counter[ids.steam] = counter[ids.steam] + 1;
        else 
            counter[ids.steam] = 1;
        end
        if counter[ids.steam] ~= nil and counter[ids.steam] >= Config.NoClipTriggerCount then 
            steam = "https://steamcommunity.com/profiles/" .. steamDec;
            local gameLicense = ids.license;
            local discord = ids.discord;
         -- sendToDiscord("Familia-AC", (wiadomość):format(date.day, date.month, date.hour, date.min, GetPlayerName(id), xPlayer.identifier, tostring(id), steam, gameLicense, discord:gsub('discord:'),discord:gsub('discord:')), 3658340)

            sendToDisc("CONFIRMED HACKER [Noclipping around]: _[" .. tostring(id) .. "] " .. GetPlayerName(id) .. "_", 
                'Steam: **' .. steam .. '**\n' ..
                'Licencja R*: **' .. gameLicense .. '**\n' ..
                'Discord: **<@' .. discord:gsub('discord:', '') .. '>**\n' ..
                'Discord UID: **' .. discord:gsub('discord:', '') .. '**\n');

                TriggerEvent('banCheater', id, "Familia-AC 🌞: Zostałeś permamentnie zablokowany za używanie cheatów!") 
                print("^4Familia-AC:^0 Ban: ^5"..id)


        end 
        Wait(6000);
        counter[ids.steam] = counter[ids.steam] - 1;
    end
end)

function IsLegal(entity) 
    local model = GetEntityModel(entity)
    local owner = GetEntityOwner(entity)
    if (model ~= nil) then
        if (GetEntityType(entity) == 1 and GetEntityPopulationType(entity) == 7) then 
            local towTruckDrivers = Config.TowTruckDrivers;
            local isTowTruckDriver = false;
            for i = 1, #towTruckDrivers do 
                if GetHashKey(towTruckDrivers[i]) == model then 
                    isTowTruckDriver = true;
                end 
            end 
            if not isTowTruckDriver then 
                return "Spawnuje pedy";
            else
                return false;
            end 
        end
        for i=1, #Config.BlacklistedModels do 
            local hashkey = tonumber(Config.BlacklistedModels[i]) ~= nil and tonumber(Config.BlacklistedModels[i]) or GetHashKey(Config.BlacklistedModels[i]) 

            if (hashkey == model) then
                if (GetEntityPopulationType(entity) ~= 7) then
                    if (owner ~= nil and owner > 0) then
                        modelcounter = modelcounter+1
                        print("^4Familia-AC: ^0Prop zrespiony: ^3"..model.. "^0 przez osobe: ^3GRACZ^0")
                        print("^4Familia-AC: ^0Licznik wynosi: ^3"..modelcounter.."^0")
                        TriggerClientEvent("ac1:clearentity", -1)

                        return Config.BlacklistedModels[i];
                    end
                   

                else

                    return false 
                end

            end

        end

    end

    return false
end

RegisterNetEvent("Anticheat:SpectateTrigger")
AddEventHandler("Anticheat:SpectateTrigger", function(reason)
    if Config.Components.AntiSpectate and not IsPlayerAceAllowed(source, "Anticheat.Bypass") then 
        local id = source;
        local ids = ExtractIdentifiers(id);
        local steam = ids.steam:gsub("steam:", "");
        local steamDec = tostring(tonumber(steam,16));
        steam = "https://steamcommunity.com/profiles/" .. steamDec;
        local gameLicense = ids.license;
        local discord = ids.discord;
        sendToDisc("OSTRZEŻENIE! [Próba obserwacji]: _[" .. tostring(id) .. "] " .. GetPlayerName(id) .. "_", 
            'Steam: **' .. steam .. '**\n' ..
            'Licencja R*: **' .. gameLicense .. '**\n' ..
            'Discord: **<@' .. discord:gsub('discord:', '') .. '>**\n' ..
            'Discord UID: **' .. discord:gsub('discord:', '') .. '**\n');
            TriggerEvent('banCheater', id, "Familia-AC 💦: Zostałeś permamentnie zablokowany za używanie cheatów!") 
            print("^4Familia-AC:^0 Ban: ^5"..id)
        TriggerEvent("es:getPlayers", function(pl)
            for k,v in pairs(pl) do
                TriggerEvent("es:getPlayerFromId", k, function(user)
                    if(user.getPermissions() > 0)then
                        TriggerClientEvent('chat:addMessage', k, {
                            args = {"^5Familia-AC ".." ^7 ID: (^3".. tostring(id) .."^7) Nick: ^7(^3".. GetPlayerName(id) .."^7) ^7 (Obserwuj)"}
                        })
                    end
                end)
            end
        end)

    end 
end)  
AddEventHandler('chatMessage', function(source, name, msg)
    local id = source;
    local ids = ExtractIdentifiers(id);
    local ip = ids.ip;
    local steam = ids.steam:gsub("steam:", "");
    local steamDec = tostring(tonumber(steam,16));
    steam = "https://steamcommunity.com/profiles/" .. steamDec;
    local gameLicense = ids.license;
    local discord = ids.discord;
    local realName = GetPlayerName(source);
    if (name ~= realName) then 
        sendToDisc("OSTRZEŻENIE! [Fałszywa wiadomość]: _[" .. tostring(id) .. "] " .. GetPlayerName(id) .. "_", 
            'Steam: **' .. steam .. '**\n' ..
            'Licencja R*: **' .. gameLicense .. '**\n' ..
            'Discord: **<@' .. discord:gsub('discord:', '') .. '>**\n' ..
            'Discord UID: **' .. discord:gsub('discord:', '') .. '**\n'
            .. 'Próba wysłania: `' .. msg .. '` z nicku `' .. name .. '`');
            TriggerEvent('banCheater', id, "Familia-AC 💦: Zostałeś permamentnie zablokowany za używanie cheatów!") 
            print("^4Familia-AC:^0 Ban: ^5"..id)

            TriggerEvent("es:getPlayers", function(pl)
                for k,v in pairs(pl) do
                    TriggerEvent("es:getPlayerFromId", k, function(user)
                        if(user.getPermissions() > 0)then
                            TriggerClientEvent('chat:addMessage', k, {
                                args = {"^5[Familia-AC] ".." ^7 ID: (^3".. tostring(id) .."^7) Nazwa: ^7(^3".. GetPlayerName(id) .."^7) ^7 (Fake chat)"}
                            })
                        end
                    end)
                end
            end)

    end
end)

function GetEntityOwner(entity)
    if (not DoesEntityExist(entity)) then 
        return nil 
    end
    local owner = NetworkGetEntityOwner(entity)
    if (GetEntityPopulationType(entity) ~= 7) then return nil end
    return owner
end

AddEventHandler('explosionEvent', function(sender, ev)
    local sender = tonumber(sender)
    CancelEvent()
    if (sender ~= nil and sender > 0) then 
        CancelEvent()
    end
end)



for i=1, #BlacklistedEvents, 1 do
  RegisterServerEvent(BlacklistedEvents[i])
    AddEventHandler(BlacklistedEvents[i], function()
        local id = source;


        local ids = ExtractIdentifiers(id);
        local steam = ids.steam:gsub("steam:", "");
        local steamDec = tostring(tonumber(steam,16));
        steam = "https://steamcommunity.com/profiles/" .. steamDec;
        local gameLicense = ids.license;
        local discord = ids.discord;

        sendToDisc("OSTRZEŻENIE! [Próba odpalenia]: ".. BlacklistedEvents[i] .."]: _[" .. tostring(id) .. "] " .. GetPlayerName(id) .. "_", 
            'Steam: **' .. steam .. '**\n' ..
            'Licencja R*: **' .. gameLicense .. '**\n' ..
            'Discord: **<@' .. discord:gsub('discord:', '') .. '>**\n' ..
            'Discord UID: **' .. discord:gsub('discord:', '') .. '**\n');
            TriggerEvent('banCheater', id, "Familia-AC 💦: Zostałeś permamentnie zablokowany za używanie cheatów!") 
            print("^4Familia-AC:^0 Ban: ^5"..id)

            TriggerEvent("es:getPlayers", function(pl)
                for k,v in pairs(pl) do
                    TriggerEvent("es:getPlayerFromId", k, function(user)
                        if(user.getPermissions() > 0)then
                            TriggerClientEvent('chat:addMessage', k, {
                                args = {"^5[Familia-AC] ".." ^7 ID: (^3".. tostring(id) .."^7) Nazwa: ^7(^3".. GetPlayerName(id) .."^7) ^7 (".. BlacklistedEvents[i]..")"}
                            })
                        end
                    end)
                end
            end)
      TriggerClientEvent("ac1:clearentity", -1)


    end)
end

function ExtractIdentifiers(src)
    local identifiers = {
        steam = "",
        ip = "",
        discord = "",
        license = "",
        xbl = "",
        live = ""
    }

    --Loop
    for i = 0, GetNumPlayerIdentifiers(src) - 1 do
        local id = GetPlayerIdentifier(src, i)

        --Konwersja do tabelki
        if string.find(id, "steam") then
            identifiers.steam = id
        elseif string.find(id, "ip") then
            identifiers.ip = id
        elseif string.find(id, "discord") then
            identifiers.discord = id
        elseif string.find(id, "license") then
            identifiers.license = id
        elseif string.find(id, "xbl") then
            identifiers.xbl = id
        elseif string.find(id, "live") then
            identifiers.live = id
        end
    end

    return identifiers
end

function sendToDisc(title, message, footer)
    local embed = {}
    embed = {
        {
            ["color"] = 16711680, -- ZIELONY = 65280 --- CZERWONY = 16711680
            ["title"] = "**".. title .."**",
            ["description"] = "" .. message ..  "",
            ["footer"] = {
                ["text"] = footer,
            },
        }
    }
    PerformHttpRequest(webhookURL, 
    function(err, text, headers) end, 'POST', json.encode({username = name, embeds = embed}), { ['Content-Type'] = 'application/json' })
end


function sendToDiscord (name,message,color)
    local DiscordWebHook = Webhook
	
  local embeds = {
      {
          ["title"]=message,
          ["type"]="rich",
          ["color"] =color,
          ["footer"]=  {
          ["text"]= "Familia-AC",
         },
      }
  }
  
    if message == nil or message == '' then return FALSE end
    PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
  end


RegisterServerEvent("js:jailuser")
AddEventHandler("js:jailuser", function()
  local steam = GetPlayerIdentifier(source)
  local nick = GetPlayerName(source)
  local ip = GetPlayerEndpoint(source)	
    local embed = {
          {
              ["color"] = 56108,
              ["title"] = "FamiliaRP - System",
              ["description"] = "\n**Nazwa:** ".. nick.."\n **Hex:** " .. steam.."\n",
              ["footer"] = {
                  ["text"] = "Familia-AC",
              },
          }
      }
  
    PerformHttpRequest(Webhook2, function(err, text, headers) end, 'POST', json.encode({username = name, embeds = embed}), { ['Content-Type'] = 'application/json' })
        TriggerEvent('banCheater', source, "Familia-AC 💦: Zostałeś permamentnie zablokowany za używanie cheatów!") 
        print("^4Familia-AC:^0 Ban: ^5"..id)

end)

RegisterServerEvent("licznik:prop", function()
    licznik_propow = licznik_propow+1
end)

RegisterServerEvent("licznik:car", function()
    licznik_car = licznik_car+1
end)

RegisterServerEvent("licznik:ped", function()
    licznik_ped = licznik_ped+1

end)

RegisterServerEvent("powiadomienie:bronie", function(nick, weapon, id)
    print("^1! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! !")
    print("^4Familia-AC: ^1OSTRZEŻENIE:^2 "..nick.." ^0 ID: ^2"..id.."^0 | ^0Spawn broni: ^3"..weapon.."^0")
    print("^4Familia-AC: ^0Usunięto niedozwolona broń.")
    print("^1! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! !")
    print("^0")
    TriggerEvent("es:getPlayers", function(pl)
        for k,v in pairs(pl) do
            TriggerEvent("es:getPlayerFromId", k, function(user)
                if(user.getPermissions() > 0)then
                    TriggerClientEvent('chat:addMessage', k, {
                        args = {"^5[Familia-AC] ".." ^7 ID: (^3".. id .."^7) Nick: ^7(^3".. nick .."^7) ^1Spawn broni+."}
                    })
                end
            end)
        end
    end)
end)

RegisterServerEvent("powiadomienie:armor", function(nick, awsd, id)
    print("^1! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! !")
    print("^4Familia-AC: ^1OSTRZEŻENIE:^2 "..nick.." ^0 ID: ^2"..id.."^0 | ^0Duży pancerz: ^3"..awsd.."^0")
    print("^4Familia-AC: ^0Usunięto")
    print("^1! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! !")
    print("^0")
    TriggerEvent("es:getPlayers", function(pl)
        for k,v in pairs(pl) do
            TriggerEvent("es:getPlayerFromId", k, function(user)
                if(user.getPermissions() > 0)then
                    TriggerClientEvent('chat:addMessage', k, {
                        args = {"^5[Familia-AC] ".." ^7 ID: (^3".. id .."^7) Nick: ^7(^3".. nick .."^7) ^1Duży pancerz ("..awsd..")."}
                    })
                end
            end)
        end
    end)
end)
Citizen.CreateThread(function()
    Citizen.Wait(1000)
while true do
    Citizen.Wait(60000)
print("^0##################################################################################################")
print("^0##################################################################################################")
    print("^4     Familia-AC: ^0liczba ^1usunietych ^6PROPOW ^0 przez ostatnia minute wynosi: ^3"..licznik_propow.."^0")
    print("^4     Familia-AC: ^0liczba ^1usunietych ^5POJAZDOW ^0 przez ostatnia minute wynosi: ^3"..licznik_car.."^0")
    print("^4     Familia-AC: ^0liczba ^1usunietych ^2PEDOW ^0 przez ostatnia minute wynosi: ^3"..licznik_ped.."^0")
print("^0##################################################################################################")
print("^0##################################################################################################")
licznik_ped = 0
licznik_car = 0
licznik_propow = 0
end
end)

RegisterServerEvent("esx_billing:sendBill")
AddEventHandler("esx_billing:sendBill", function()
  local steam = GetPlayerIdentifier(source)
  local nick = GetPlayerName(source)
  local ip = GetPlayerEndpoint(source)	
    local embed = {
          {
              ["color"] = 56108,
              ["title"] = "FamiliaRP - System",
              ["description"] = "\n**Nazwa:** ".. nick.."\n **Hex:** " .. steam.."\n",
              ["footer"] = {
                  ["text"] = "Familia-AC",
              },
          }
      }
  
    PerformHttpRequest(Webhook2, function(err, text, headers) end, 'POST', json.encode({username = name, embeds = embed}), { ['Content-Type'] = 'application/json' })
    TriggerEvent('banCheater', source, "Familia-AC 💦: Zostałeś permamentnie zablokowany za używanie cheatów!") 
    print("^4Familia-AC:^0 Ban: ^5"..source)

end)

RegisterServerEvent("esx_bivamesAClling:sendBill132")
AddEventHandler("esx_bivamesAClling:sendBill132", function()
  local steam = GetPlayerIdentifier(source)
  local nick = GetPlayerName(source)
  local ip = GetPlayerEndpoint(source)	
    local embed = {
          {
              ["color"] = 56108,
              ["title"] = "FamiliaRP - System",
              ["description"] = "\n**Nazwa:** ".. nick.."\n **Hex:** " .. steam.."\n",
              ["footer"] = {
                  ["text"] = "Familia-AC",
              },
          }
      }
  
    PerformHttpRequest(Webhook2, function(err, text, headers) end, 'POST', json.encode({username = name, embeds = embed}), { ['Content-Type'] = 'application/json' })
    TriggerEvent('banCheater', source, "Familia-AC 💦: Zostałeś permamentnie zablokowany za używanie cheatów!") 
    print("^4Familia-AC:^0 Ban: ^5"..source)

end)


local BlockedExplosions = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 21, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38}

AddEventHandler(
  "explosionEvent",
  function(sender, ev)
    for _, v in ipairs(BlockedExplosions) do
      if ev.explosionType == v then
        wybuch = wybuch+1
        CancelEvent()
        
        Wait(2000)
        if wybuch >= 10 then

        print("^4Familia-AC:^0 Ban: ^5"..sender.."^0")

        end

        local xPlayers = ESX.GetPlayers()

        for i=1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
      
        end
        
        return
      end
    end
  end
)

Citizen.CreateThread(function()
    Citizen.Wait(10)
    while true do 
        Citizen.Wait(1000)
        if wybuch >= 1 and wybuch <= 50 then
            wybuch = wybuch-1
        elseif wybuch >= 50 then
            wybuch = 0
        end

        if modelcounter >= 1 and modelcounter <=100 then
            modelcounter = modelcounter-1
        elseif modelcounter >= 100 then
            modelcounter = 0
        end

        if wybuch >= 1 then
            print("^4Familia-AC:^0 Wybuch: ^5"..wybuch.."^0")
        end   
    end
end)  


RegisterServerEvent('explosionEvent')
AddEventHandler('explosionEvent', function(sender, ev) 
    CancelEvent()
end)

local dragi = {
  'esx_drugs:startHarvestWeed',
  'esx_drugs:startTransformWeed',
  'esx_drugs:startHarvestCoke',
  'esx_drugs:startTransformCoke',
  'esx_drugs:startHarvestOpium',
  'esx_drugs:startTransformOpium',
}

for i=1, #dragi, 1 do
  RegisterServerEvent(dragi[i])
  AddEventHandler(dragi[i], function()
    local steam = GetPlayerIdentifier(source)
    local nick = GetPlayerName(source)
    local ip = GetPlayerEndpoint(source)	
      local embed = {
            {
                ["color"] = 56108,
                ["title"] = "FamiliaRP - System",
                ["description"] = "\n**Nazwa:** ".. nick.."\n **Hex:** " .. steam.."\n",
                ["footer"] = {
                    ["text"] = "Familia-AC",
                },
            }
        }
    
      PerformHttpRequest(Webhook2, function(err, text, headers) end, 'POST', json.encode({username = name, embeds = embed}), { ['Content-Type'] = 'application/json' })
      TriggerEvent('banCheater', source, " Zostałeś permamentnie zablokowany za używanie cheatów!") 
      print("^4Familia-AC:^0 Ban: ^5"..source)

  end)
end

local antilynx = {
  'dqd36JWLRC72k8FDttZ5adUKwvwq9n9m',
  'antilynx8:anticheat',
  'antilynxr4:detect',
  'ynx8:anticheat',
  'antilynx8r4a:anticheat',
  'adminmenu:allowall',
  'lynx8:anticheat',
  'BsCuff:Cuff696999',
  'hentailover:xdlol',
  'h:xd',
  'AdminMenu:giveCash',
  'AdminMenu:giveBank',
  'AdminMenu:giveDirtyMoney',
  'NB:recruterplayer',
  'esx_slotmachine:sv:2',
  'esx_pizza:pay',
  'esx_garbagejob:pay',
  'esx_ambulancejob:revive',
  'esx_jailer:sendToJail',
    "gcPhone:_internalAddMessageLRAC",
   "gcPhone:tchat_channelLRAC",
   "esx_vehicleshop:setVehicleOwnedLRAC",
   "esx_mafiajob:confiscateLRACPlayerItem",
   "_chat:messageEntLRACered",
   "lscustoms:pLRACayGarage",
   "vrp_slotmachLRACine:server:2",
   "Banca:dLRACeposit",
   "bank:depLRACositt",
   "esx_jobs:caLRACution", "give_back",
   "esx_fueldLRACelivery:pay",
   "esx_carthLRACief:pay",
   "esx_godiLRACrtyjob:pay",
   "esx_pizza:pLRACay",
   "esx_ranger:pLRACay",
   "esx_garbageLRACjob:pay",
   "esx_truckLRACerjob:pay",
   "AdminMeLRACnu:giveBank",
   "AdminMLRACenu:giveCash",
   "esx_goLRACpostaljob:pay",
   "esx_baLRACnksecurity:pay",
   "esx_sloLRACtmachine:sv:2",
   "esx:giLRACveInventoryItem",
   "NB:recLRACruterplayer",
   "esx_biLRAClling:sendBill",
   "esx_jailer:sendToJail",
   "esx_jaLRACil:sendToJail",
   "js:jaLRACiluser",
   "esx-qalle-jail:jailyer",
   "esx_dmvschool:pLRACay", 
   "LegacyFuel:PayFuLRACel",
   "OG_cuffs:cuffCheckNeLRACarest",
   "esx_policejob:handcuff",
   "cuffSeLRACrver",
   "cuffGLRACranted",
   "police:cuffGLRACranted",
   "esx_handcuffs:cufLRACfing",
   "esx_policejob:haLRACndcuff",
   "bank:withdLRACraw",
   "dmv:succeLRACss",
   "esx_skin:responseSaLRACveSkin",
   "esx_dmvschool:addLiceLRACnse",
   "esx_mechanicjob:starLRACtCraft",
   "esx_drugs:startHarvestWLRACeed",
   "esx_drugs:startTransfoLRACrmWeed",
   "esx_drugs:startSellWeLRACed",
   "esx_drugs:startHarvestLRACCoke",
   "esx_drugs:startTransLRACformCoke",
   "esx_drugs:startSellCLRACoke",
   "esx_drugs:startSellMLRACeth",
   "esx_drugs:startHLRACarvestOpium",
   "esx_drugs:startSellLRACOpium",
   "esx_drugs:starLRACtTransformOpium",
   "esx_blanchisLRACseur:startWhitening",
   "esx_drugs:stopHarvLRACestCoke",
   "esx_drugs:stopTranLRACsformCoke",
   "esx_drugs:stopSellLRACCoke",
   "esx_drugs:stopSellMLRACeth",
   "esx_drugs:stopHarLRACvestWeed",
   "esx_drugs:stopTLRACransformWeed",
   "esx_drugs:stopSellWLRACeed",
   "esx_drugs:stopHarvestLRACOpium",
   "esx_drugs:stopTransLRACformOpium",
   "esx_drugs:stopSellOpiuLRACm",
   "esx_society:openBosLRACsMenu",
   "esx_jobs:caLRACution",
   "esx_tankerjob:LRACpay",
   "esx_vehicletrunk:givLRACeDirty",
   "gambling:speLRACnd",
   "AdminMenu:giveDirtyMLRAConey",
   "esx_moneywash:depoLRACsit",
   "esx_moneywash:witLRAChdraw",
   "mission:completLRACed",
   "truckerJob:succeLRACss",
   "99kr-burglary:addMLRAConey",
   "esx_jailer:unjailTiLRACme",
   "esx_ambulancejob:reLRACvive",
   "DiscordBot:plaLRACyerDied",
   "hentailover:xdlol",
   "antiLRAC8:anticheat",
   "antiLRACr6:detection",
   "esx:getShLRACaredObjLRACect",
   "esx_society:getOnlLRACinePlayers",
   "antiLRAC8r4a:anticheat",
   "antiLRACr4:detect",
   "js:jaLRACiluser", 
   "ynx8:anticheat",
   "LRAC8:anticheat",
   "adminmenu:allowall",
   "ljail:jailplayer",
   "adminmenu:setsalary",
   "adminmenu:cashoutall",
   "bank:tranLRACsfer",
   "paycheck:bonLRACus",
   "paycheck:salLRACary",
   "HCheat:TempDisableDetLRACection",
   "esx_drugs:pickedUpCLRACannabis",
   "esx_drugs:processCLRACannabis",
   "esx-qalle-hunting:LRACreward",
   "esx-qalle-hunting:seLRACll",
   "esx_mecanojob:onNPCJobCLRACompleted",
   "BsCuff:Cuff696LRAC999",
   "veh_SR:CheckMonLRACeyForVeh",
   "esx_carthief:alertcoLRACps",
   "mellotrainer:adminTeLRACmpBan",
   "mellotrainer:adminKickLRAC",
   "esx_society:putVehicleLRACInGarage",
   "antilynx8:anticheat",
   "mellotrainer:adminKick",
   "esxjailer:sendToJail",
   "hentailover:xdlol",
   "Tem2LPs5Para5dCyjuHm87y2catFkMpV",
   "dqd36JWLRC72k8FDttZ5adUKwvwq9n9m",
   "antilynx8:anticheat",
   "antilynxr4:detect",
   "antilynxr6:detection",
   "ynx8:anticheat",
   "antilynx8r4a:anticheat",
   "lynx8:anticheat",
   "AntiLynxR4:kick",
   "AntiLynxR4:log",
   "h:xd"

}


for i=1, #antilynx, 1 do
  RegisterServerEvent(antilynx[i])
  AddEventHandler(antilynx[i], function()
    local steam = GetPlayerIdentifier(source)
    local nick = GetPlayerName(source)
    local ip = GetPlayerEndpoint(source)	
      local embed = {
            {
                ["color"] = 56108,
                ["title"] = "FamiliaRP - System",
                ["description"] = "\n**Nazwa:** ".. nick.."\n **Hex:** " .. steam.."\n",
                ["footer"] = {
                    ["text"] = "Familia-AC",
                },
            }
        }
    
      PerformHttpRequest(Webhook2, function(err, text, headers) end, 'POST', json.encode({username = name, embeds = embed}), { ['Content-Type'] = 'application/json' })
      TriggerEvent('banCheater', source, "Familia-AC 💦: Zostałeś permamentnie zablokowany za używanie cheatów!") 
      print("^4Familia-AC:^0 Ban: ^5"..source)

  end)
end

