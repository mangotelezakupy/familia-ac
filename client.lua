local ilosc_propow = 0

if Config.Components.Anticheat then
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        SetPedInfiniteAmmoClip(PlayerPedId(), false)
        SetEntityInvincible(PlayerPedId(), false)
        SetEntityCanBeDamaged(PlayerPedId(), true)
        ResetEntityAlpha(PlayerPedId())
        local fallin = IsPedFalling(PlayerPedId())
        local ragg = IsPedRagdoll(PlayerPedId())
        local parac = GetPedParachuteState(PlayerPedId())
        if parac >= 0 or ragg or fallin then
            SetEntityMaxSpeed(PlayerPedId(), 80.0)
        else
            SetEntityMaxSpeed(PlayerPedId(), 7.1)
        end
    end
end)


teleported = false;
Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(1000);
        if (IsControlJustPressed(0, 18)) then 
            teleported = true;
            Wait(1000);
            teleported = false;
        end
    end 
end)

Citizen.CreateThread(function()
    Citizen.Wait(30000)
    while true do
        Citizen.Wait(0)
        local ped = PlayerPedId()
        local posx,posy,posz = table.unpack(GetEntityCoords(ped,true))
        local still = IsPedStill(ped)
        local vel = GetEntitySpeed(ped)
        local ped = PlayerPedId()
        local veh = IsPedInAnyVehicle(ped, true)
        local speed = GetEntitySpeed(ped)
        local para = GetPedParachuteState(ped)
        local flyveh = IsPedInFlyingVehicle(ped)
        local rag = IsPedRagdoll(ped)
        local fall = IsPedFalling(ped)
        local parafall = IsPedInParachuteFreeFall(ped)
        Wait(3000) 

        local more = speed - 9.0 

        local rounds = tonumber(string.format("%.2f", speed))
        local roundm = tonumber(string.format("%.2f", more))


        if not IsEntityVisible(PlayerPedId()) then
            SetEntityHealth(PlayerPedId(), -100) 
        end

        newx,newy,newz = table.unpack(GetEntityCoords(ped,true))
        newPed = PlayerPedId() 
        if not teleported and GetDistanceBetweenCoords(posx,posy,posz, newx,newy,newz) > 200 and still == IsPedStill(ped) and vel == GetEntitySpeed(ped) and ped == newPed then
            TriggerServerEvent("Anticheat:NoClip", GetDistanceBetweenCoords(posx,posy,posz, newx,newy,newz))
        end
    end
end)



Citizen.CreateThread(function()
    while true do
        Wait(1000)
        local ped = NetworkIsInSpectatorMode()
        if ped == 1 then
            TriggerServerEvent("Anticheat:SpectateTrigger", "[Familia-AC]: Onion.exe ");
        end
    end
end)
end

-- CLEAR OBJECT,AUTA ETC
RegisterNetEvent("ac:clearvehicles")
AddEventHandler("ac:clearvehicles", function()
    for sR4HoXp6l3D4 in EnumerateVehicles() do
        if not IsPedInVehicle(Citizen.InvokeNative(0x43A66C31C68491C0, -1), sR4HoXp6l3D4, true) then
            SetEntityAsMissionEntity(GetVehiclePedIsIn(sR4HoXp6l3D4, true), 1, 1)
            DeleteEntity(GetVehiclePedIsIn(sR4HoXp6l3D4, true))
            SetEntityAsMissionEntity(sR4HoXp6l3D4, 1, 1)
            DeleteEntity(sR4HoXp6l3D4)
        end
    end
end)

weaponblacklist = {
	"WEAPON_MINIGUN",
    "WEAPON_APPISTOL",
    "WEAPON_DOUBLEACTION",
    "WEAPON_RAYPISTOL",
    "WEAPON_NAVYREVOLVER",
    "WEAPON_RAYCARBINE",
    "WEAPON_DBSHOTGUN",
    "WEAPON_AUTOSHOTGUN",
    "WEAPON_ASSAULTRIFLE",
    "WEAPON_MG",
    "WEAPON_HEAVYSNIPER",
    "WEAPON_FIREWORK",
    "WEAPON_HOMINGLAUNCHER",
    "WEAPON_COMPACTLAUNCHER",
    "WEAPON_RAYMINIGUN",
    "WEAPON_BZGAS",
    "WEAPON_MOLOTOV",
    "WEAPON_STICKYBOMB",
    "WEAPON_PROXMINE",
    "WEAPON_ADVANCEDRIFLE",
    "WEAPON_COMBATMG",
    "weapon_carbinerifle",
    "WEAPON_CARBINERIFLE_MK2",
    "WEAPON_ASSAULTSHOTGUN",
    "WEAPON_BULLPUPSHOTGUN",
    "WEAPON_GRENADELAUNCHER",
    "WEAPON_GRENADELAUNCHER_SMOKE",
    "WEAPON_RPG",
    "WEAPON_STINGER",
    "WEAPON_MINIGUN",
    "WEAPON_GRENADE",
    "WEAPON_GUSENBERG",
    "WEAPON_BULLPUPRIFLE",
    "WEAPON_DAGGER",
    "WEAPON_MUSKET",
    "WEAPON_HEAVYSHOTGUN",
    "WEAPON_MARKSMANRIFLE",
    "WEAPON_FLAREGUN",
    "WEAPON_GARBAGEBAG",
    "WEAPON_MARKSMANPISTOL",
    "WEAPON_HATCHET",
    "WEAPON_RAILGUN",
    "WEAPON_MACHINEPISTOL",
    "WEAPON_REVOLVER",
    "weapon_pistol50",
    "weapon_specialcarbine",
    "weapon_sniperrifle",
    "weapon_grenade",
    "WEAPON_RAILGUN"
}

--Blacklista broni 
Citizen.CreateThread(function()
    local nick = GetPlayerName(PlayerId())
    local id = GetPlayerServerId(PlayerId())
	while true do
		Wait(10000)

		playerPed = GetPlayerPed(-1)
		if playerPed then
			nothing, weapon = GetCurrentPedWeapon(playerPed, true)

			if isWeaponBlacklisted(weapon) then
				RemoveWeaponFromPed(playerPed, weapon)
				TriggerServerEvent('powiadomienie:bronie', nick, weapon, id)
			end
		end
	end
end)


Citizen.CreateThread(function()
    while true do

        Citizen.Wait(5)
    local nick = GetPlayerName(PlayerId())
    local id = GetPlayerServerId(PlayerId())
    local awsd = Citizen.InvokeNative(0x9483AF821605B1D8, Citizen.InvokeNative(0x43A66C31C68491C0, -1))
        if awsd then
          if awsd > 98 then
				TriggerServerEvent('powiadomienie:armor', nick, awsd, id)
                Citizen.Wait(1000) 
            end
        end
    end
end)
function isWeaponBlacklisted(model)
	for _, blacklistedWeapon in pairs(weaponblacklist) do
		if model == GetHashKey(blacklistedWeapon) then
			return true
		end
	end

	return false
end

Citizen.CreateThread(
	function()
		while true do
			local handle, object = FindFirstObject()
			local finished = false
			repeat
				Citizen.Wait(1)
				if Config.Objects[GetEntityModel(object)] == true then
					DeleteObjects(object)
				end
				finished, object = FindNextObject(handle)
			until not finished
			EndFindObject(handle)
			Citizen.Wait(10000)
		end
	end
)

function DeleteObjects(object)
	if DoesEntityExist(object) then
		NetworkRequestControlOfEntity(object)
		while not NetworkHasControlOfEntity(object) do
			Citizen.Wait(1)
		end
		DetachEntity(object, 0, false)
		SetEntityCollision(object, false, false)
		SetEntityAlpha(object, 0.0, true)
		SetEntityAsMissionEntity(object, true, true)
		SetEntityAsNoLongerNeeded(object)
		DeleteEntity(object)
        TriggerServerEvent('licznik:prop')
	end
end


RegisterNetEvent("ac:clearpeds")
AddEventHandler("ac:clearpeds", function()
    for Kkjy25CzbmFuahd in EnumeratePeds() do
        if not (IsPedAPlayer(Kkjy25CzbmFuahd)) then
            Citizen.InvokeNative(0xF25DF915FA38C5F3, Kkjy25CzbmFuahd, true)
            DeleteEntity(Kkjy25CzbmFuahd)
        end
    end
end)

RegisterNetEvent("ac:clearentity")
AddEventHandler("ac:clearentity", function()
    for WEgd4 in EnumerateObjects() do
        DeleteEntity(WEgd4)
    end
end)


function EnumerateEntities(m4jhD5Kf, wkoW6Q, sB6h0J)
    return coroutine.wrap(function()
        local VXq9qZcQX, SRn3A = m4jhD5Kf()
            if not SRn3A or SRn3A == 0 then
            sB6h0J(VXq9qZcQX)
            return
            end;
        local mjC3gP = {
        handle = VXq9qZcQX,
        destructor = sB6h0J
        }
        setmetatable(mjC3gP, p6E)
        local hXa2EFUJmIz8cIZ59 = true
        repeat
            coroutine.yield(SRn3A)
            hXa2EFUJmIz8cIZ59, SRn3A = wkoW6Q(VXq9qZcQX)
        until not hXa2EFUJmIz8cIZ59;
            mjC3gP.destructor, mjC3gP.handle = nil, nil
            sB6h0J(VXq9qZcQX)
    end)
end;
function EnumeratePeds()
    return EnumerateEntities(FindFirstPed, FindNextPed, EndFindPed)
end;
function EnumerateVehicles()
    return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
end
function EnumerateObjects()
    return EnumerateEntities(FindFirstObject, FindNextObject, EndFindObject)
end;
function _DeleteEntity(entity)
    Citizen.InvokeNative(0xAE3CBE5BF394C9C9, Citizen.PointerValueIntInitialized(entity))
end

CreateThread(function()
    while true do
        ClearAllBrokenGlass()
        ClearAllHelpMessages()
        LeaderboardsReadClearAll()
        ClearBrief()
        ClearGpsFlags()
        ClearPrints()
        ClearSmallPrints()
        ClearReplayStats()
        LeaderboardsClearCacheData()
        ClearFocus()
        ClearHdArea()
        Wait(1*60000)
    end
end)


-- CLEAR OBJECT,AUTA ETC
RegisterNetEvent("ac1:clearvehicles")
AddEventHandler("ac1:clearvehicles", function()
    for sR4HoXp6l3D4 in EnumerateVehicles() do
        if not IsPedInVehicle(Citizen.InvokeNative(0x43A66C31C68491C0, -1), sR4HoXp6l3D4, true) then
            SetEntityAsMissionEntity(GetVehiclePedIsIn(sR4HoXp6l3D4, true), 1, 1)
            DeleteEntity(GetVehiclePedIsIn(sR4HoXp6l3D4, true))
            SetEntityAsMissionEntity(sR4HoXp6l3D4, 1, 1)
            DeleteEntity(sR4HoXp6l3D4)
        end
    end
end)

RegisterNetEvent("ac1:clearpeds")
AddEventHandler("ac1:clearpeds", function()
    for Kkjy25CzbmFuahd in EnumeratePeds() do
        if not (IsPedAPlayer(Kkjy25CzbmFuahd)) then
            Citizen.InvokeNative(0xF25DF915FA38C5F3, Kkjy25CzbmFuahd, true)
            DeleteEntity(Kkjy25CzbmFuahd)
        end
    end
end)

RegisterNetEvent("ac1:clearentity")
AddEventHandler("ac1:clearentity", function()
    for WEgd4 in EnumerateObjects() do
        DeleteEntity(WEgd4)
    end
end)
