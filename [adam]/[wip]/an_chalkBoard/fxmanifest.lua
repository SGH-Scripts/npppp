fx_version 'cerulean'
games { 'rdr3', 'gta5' }
author 'AN Services | https://discord.gg/f2Nbv9Ebf5' -- Join Discord for support: https://discord.gg/f2Nbv9Ebf5
description 'AN Chalk Board Sign'
version '1.0.0'
lua54 'yes'

ui_page 'html/index.html'

server_scripts {
	-- '@mysql-async/lib/MySQL.lua', -- uncomment this if you're using mysql-async
    '@oxmysql/lib/MySQL.lua', -- comment this if you're using mysql-async
	'server/main.lua',
}

client_scripts {
	'client/main.lua',
}

shared_scripts {
    'config.lua'
}

files {
    'html/banner.png',
    'html/index.html',
    'html/script.js',
    'html/styles.css',
}

escrow_ignore {
	'client/main.lua',
	'config.lua',
	'server/main.lua',
	'stream/prop_protest_sign_01.ydr',
	'item_config/ESX_run_this_on_your_database.sql',
	'item_config/QBCore_add_this_line_in_items_shared.lua',
	'item_config/ad_sign.png',
	'html/*',
}
dependency '/assetpacks'