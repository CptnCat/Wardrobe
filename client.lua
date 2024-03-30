local actionOpened = false

function OpenWardrobe()
    ESX.UI.Menu.CloseAll()
    actionOpened = true
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'Wardrobe_Home', {
        title = TranslateCap('wardrobe'),
        algin = 'top-left',
        elements = {
            {label = TranslateCap('my_outfits'), value = 'myoutfits'},
            {label = TranslateCap('save_current_outfit'), value = 'save'},
        }
    }, function(data, menu)
        if data.current.value == 'save' then
            local input = lib.inputDialog(TranslateCap('wardrobe'), {
                {type = 'input', label = TranslateCap('name_the_outfit'), description = nil, required = true, min = 2, max = 25},
                {type = 'checkbox', label = TranslateCap('favorite_outfit')},
            }, {
                allowCancel = true,
            })

            if input ~= nil then
                TriggerEvent('skinchanger:getSkin', function(skin)
                    TriggerServerEvent('cat_wardrobe:saveOutfit', input[1], skin, input[2])
                    ESX.ShowNotification(TranslateCap('outfit_saved', input[1]))
                    ESX.UI.Menu.CloseAll()
                    actionOpened = false
                end)
            end
        elseif data.current.value == 'myoutfits' then
            ESX.TriggerServerCallback('cat_wardrobe:getPlayerOutfits', function(outfits, datacloth)
                if outfits ~= nil then
                    local elements = {}
        
                    for k, outfit in ipairs(outfits) do --
                        if not outfit.favourite then
                            table.insert(elements, {label = '#'..k..' - '.. outfit.label, datacloth = outfit})
                        else
                            table.insert(elements, {label = '⭐ - '.. outfit.label, datacloth = outfit})
                        end
                    end

                    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'Wardrobe_My_Outfits', {
                        title = TranslateCap('my_outfits'),
                        algin = 'top-left',
                        elements = elements
                    }, function(data2, menu)
                        OpenDetailedActionMenu(data2.current.datacloth)
                    end, function(data2, menu)
                        menu.close()
                    end)
                else
                    ESX.ShowNotification(TranslateCap('no_outfits_in_wardrobe'))
                end
            end)
        end
    end, function(data, menu)
        menu.close()
        actionOpened = false
    end)
end

function OpenDetailedActionMenu(datacloth)
    local elements = {}

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'Wardrobe_Detailed', {
        title = TranslateCap('outfit_interactions'),
        algin = 'top-left',
        elements = {
            {label = TranslateCap('put_outfit_on'), value = 'take'},
            {label = TranslateCap('share_outfit'), value = 'share'},
            {label = TranslateCap('rename_outfit'), value = 'rename'},
            {label = TranslateCap('favorite_outfit'), value = 'fav'},
            {label = TranslateCap('delete_outfit'), value = 'delete'}
        }
    }, function(data, menu)
            if data.current.value == 'take' then
                TriggerEvent('skinchanger:getSkin', function(skin)
                    TriggerEvent('skinchanger:loadClothes', skin, json.decode(datacloth.clothesData))
                    TriggerEvent('skinchanger:getSkin', function(skin)
                        TriggerServerEvent('esx_skin:save', skin)
                    end)
                end)
            elseif data.current.value == 'share' then
                local target, distance = ESX.Game.GetClosestPlayer()
                if target == -1 or distance > 1.2 or not IsEntityVisible(GetPlayerPed(target)) then
                    ESX.ShowNotification(TranslateCap('no_player_nearby'))
                else
                    TriggerServerEvent('cat_wardrobe:copyOutfit', datacloth, GetPlayerServerId(target))
                    ESX.ShowNotification(TranslateCap('outfit_shared', datacloth.label))
                end
            elseif data.current.value == 'rename' then
                local input = lib.inputDialog(TranslateCap('wardrobe'), {
                    {type = 'input', label = TranslateCap('name_the_outfit'), description = nil, required = true, min = 2, max = 25},
                }, {
                    allowCancel = true,
                })

                TriggerServerEvent('cat_wardrobe:renameOutfit', datacloth.id, input[1])
                Citizen.Wait(150)
                OpenWardrobe()
            elseif data.current.value == 'fav' then
                if datacloth.favourite then
                    TriggerServerEvent('cat_wardrobe:favOutfit', datacloth.id, false)
                    Citizen.Wait(150)
                    ESX.ShowNotification(TranslateCap('favorite_removed', datacloth.label))
                    OpenWardrobe()
                else
                    TriggerServerEvent('cat_wardrobe:favOutfit', datacloth.id, true)
                    Citizen.Wait(150)
                    ESX.ShowNotification(TranslateCap('favorite_added', datacloth.label))
                    OpenWardrobe()
                end
            elseif data.current.value == 'delete' then
                ESX.ShowNotification(TranslateCap('outfit_deleted', datacloth.label))
                TriggerServerEvent("cat_wardrobe:removeOutfit", datacloth.id)
                Citizen.Wait(500)
                OpenWardrobe()
            end
    end, function(data, menu)
        menu.close()
    end)
end


CreateThread(function()
	while true do
		Citizen.Wait(0)
        local isInMarker = false
        local letSleep = true
        local isNearMarker = false
        for k, info in pairs(Config.WardrobePositions) do
            local playerPed = PlayerPedId()
            local playerCoords = GetEntityCoords(playerPed)

            local distance = Vdist(playerCoords, info.x, info.y, info.z)

            if distance < Config.DrawDistance then
                isNearMarker = true
                DrawMarker(Config.MarkerType, info.x, info.y, info.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 130, false, false, 2, true, false, false, false)
                if distance < Config.MarkerSize.x then
					isInMarker = true
				end
                if isInMarker and not actionOpened then
                    ESX.ShowHelpNotification(TranslateCap('interaction'))
                    if IsControlJustReleased(0, 38) then
                        OpenWardrobe()
                    end
                end
                letSleep = false
            end
        end

        if isInMarker and not hasAlreadyEnteredMarker then
            hasAlreadyEnteredMarker = true
        end			
        if not isInMarker and hasAlreadyEnteredMarker and actionOpened then
            hasAlreadyEnteredMarker = false
            ESX.UI.Menu.CloseAll()
            actionOpened = false 
        end
        if letSleep then
            Citizen.Wait(500)
        end
    end
end)

if Config.EnableAdminCommand == true then
    RegisterNetEvent("cat_wardrobe:openMenu")
    AddEventHandler("cat_wardrobe:openMenu", function()
        OpenWardrobe()
    end)
end

