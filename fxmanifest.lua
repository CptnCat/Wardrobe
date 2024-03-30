fx_version 'cerulean'
game 'gta5'

author 'EpicCat'
description 'Free Wardrobe Script'
version '1.0'

lua54 'yes'

shared_scripts {
	'@ox_lib/init.lua',
	'@es_extended/imports.lua',
}

client_scripts {
    '@es_extended/locale.lua',
	'locales/*.lua',
    'config.lua',
    'client.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    '@es_extended/locale.lua',
	'locales/*.lua',
    'config.lua',
    'server.lua',
}

dependencies {
    'es_extended',
    'esx_menu_default',
    'ox_lib'
}