ESX.RegisterServerCallback('cat_wardrobe:getPlayerOutfits', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
	local identifier = xPlayer.getIdentifier()
    MySQL.Async.fetchAll('SELECT * FROM user_outfits WHERE identifier = @identifier', {
        ['@identifier'] = identifier
    }, function(outfits)
        if outfits[1] ~= nil then
            cb(outfits)
        else
            cb(nil)
        end
    end)
end)

RegisterServerEvent('cat_wardrobe:saveOutfit')
AddEventHandler('cat_wardrobe:saveOutfit', function(label, skin, favourite)
	local xPlayer = ESX.GetPlayerFromId(source)

	if favourite then
		favourite = 1
	else
		favourite = 0
	end

	if xPlayer ~= nil then
		local identifier = xPlayer.getIdentifier()
		if label and skin ~= nil then
			MySQL.Async.execute(
				'INSERT INTO user_outfits (identifier, label, clothesData, favourite) VALUES (@identifier, @label, @clothesData, @favourite)', {
				  ['@identifier'] = identifier,
				  ['@label'] = label,
				  ['@clothesData'] = json.encode(skin),
				  ['@favourite'] = favourite
			  }
			)
		end
    end
end)

RegisterServerEvent('cat_wardrobe:removeOutfit')
AddEventHandler('cat_wardrobe:removeOutfit', function(id)
    local xPlayer = ESX.GetPlayerFromId(source)
	local identifier = xPlayer.getIdentifier()
    MySQL.Async.execute(
        'DELETE FROM user_outfits WHERE id = @id and identifier = @identifier', {
          ['@identifier'] = identifier,
          ['@id'] = id,
      }
    )
end)

RegisterServerEvent('cat_wardrobe:renameOutfit')
AddEventHandler('cat_wardrobe:renameOutfit', function(id, newname)
    local xPlayer = ESX.GetPlayerFromId(source)
	local identifier = xPlayer.getIdentifier()
    MySQL.Sync.execute("UPDATE `user_outfits` SET `label`=@label WHERE id = @id AND identifier = @identifier", { 
        ['@identifier'] = identifier,
        ['@label'] = newname,
        ['@id'] = id
    })
end)

RegisterServerEvent('cat_wardrobe:favOutfit')
AddEventHandler('cat_wardrobe:favOutfit', function(id, fav)
    local xPlayer = ESX.GetPlayerFromId(source)
	local identifier = xPlayer.getIdentifier()

    MySQL.Sync.execute("UPDATE `user_outfits` SET `favourite`=@favourite WHERE id = @id AND identifier = @identifier", { 
        ['@identifier'] = identifier,
        ['@id'] = id,
        ['@favourite'] = fav
    })
end)

RegisterServerEvent('cat_wardrobe:copyOutfit')
AddEventHandler('cat_wardrobe:copyOutfit', function(datacloth, target)
    local xPlayer = ESX.GetPlayerFromId(source)
    local reciever = ESX.GetPlayerFromId(target)
    local reciever_identifier = reciever.getIdentifier()

    MySQL.Sync.execute("INSERT INTO `user_outfits`(`identifier`, `label`, `clothesData`, `favourite`) VALUES (@identifier,@label,@clothesData,@favourite)", { 
        ['@identifier'] = reciever.identifier,
        ['@label'] = datacloth.label,
        ['@clothesData'] = datacloth.clothesData,
        ['@favourite'] = false
    })

    reciever.showNotification('Du hast ein Outfit von jemanden erhalten.')
end)

if Config.EnableAdminCommand == true then
    ESX.RegisterCommand(Config.AdminCommand, Config.AdminGroups, function(xPlayer, args, showError)
        TriggerClientEvent('cat_wardrobe:openMenu', args.playerId)
    end, true, {
        help = 'Kehre zurück ins Charaktermenü', validate = true,
        arguments = {
            {name = 'playerId', help = 'Gebe eine Spieler-ID an', type = 'playerId'}
        }
    })
end
