-- Simple 911 Command (With Location & Blip) -- 
		-- Made By Chezza --

displayTime = 300 -- Refreshes Blips every 5 Minutes by Default --  
ondutycommand = 'onduty' -- Change this if you already have a 'onduty' command already set --
passwordmode = true -- By Changing this to 'false' it will make it so you need a password to go on-duty --  { For the 'passwordmode' and 'password' to work you need to have 'ondutymode' set to 'true' } --
password = '123' -- Please change this to your desired password -- { For the 'passwordmode' and 'password' to work you need to have 'ondutymode' set to 'true' } --

-- Code --

blip = nil
blips = {}

local onduty = false

RegisterCommand(ondutycommand, function(source, args)
    if passwordmode then 
        if args[1] == password then
            if not onduty then 
                onduty = true
                TriggerEvent('chatMessage', '', {255,255,255}, '^2You are now ^*On-Duty^r^2 and you are able to recieve 911 calls.')
            else
                onduty = false
                TriggerEvent('chatMessage',  '', {255,255,255}, '^1You are now ^*Off-Duty^r^1 and you will no longer be able to recieve 911 calls.')
            end
        else
            TriggerEvent('chatMessage', '', {255,255,255}, '^1Incorrect Password')
        end
    else
        if not onduty then 
            onduty = true
            TriggerEvent('chatMessage', '', {255,255,255}, '^2You are now ^*On-Duty^r^2 and you are able to recieve 911 calls.')
        else
            onduty = false
            TriggerEvent('chatMessage', '', {255,255,255}, '^1You are now ^*Off-Duty^r^1 and you will no longer be able to recieve 911 calls.')
        end
    end 
end)


Citizen.CreateThread(function()
    TriggerEvent('chat:addSuggestion', '/911', 'Submits a 911 call to the Emergency Services!', {
    { name="Report", help="Enter the incident/report here!" }
})
end)

RegisterNetEvent('911:setBlip')
AddEventHandler('911:setBlip', function(name, x, y, z)
    blip = AddBlipForCoord(x, y, z)
    SetBlipSprite(blip, 66)
    SetBlipScale(blip, 1.0)
    SetBlipColour(blip, 3)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString('911 Call - ' .. name)
    EndTextCommandSetBlipName(blip)
    table.insert(blips, blip)
    Wait(displayTime * 1000)
    for i, blip in pairs(blips) do 
        RemoveBlip(blip)
    end
end)

RegisterNetEvent('911:sendtoteam')
AddEventHandler('911:sendtoteam', function(name, location, msg, x, y, z)
    if onduty then 
        TriggerServerEvent('911:sendmsg', name, location, msg, x, y, z)
    end
end)

-- Command -- 

RegisterCommand('911', function(source, args)
    local name = GetPlayerName(PlayerId())
    local ped = GetPlayerPed(PlayerId())
    local x, y, z = table.unpack(GetEntityCoords(ped, true))
    local street = GetStreetNameAtCoord(x, y, z)
    local location = GetStreetNameFromHashKey(street)
    local msg = table.concat(args, ' ')
    if args[1] == nil then
        TriggerEvent('chatMessage', '^5911', {255,255,255}, ' ^7Please enter your ^1report/issue.')
    else
        TriggerServerEvent('911', location, msg, x, y, z, name)
    end
end)

