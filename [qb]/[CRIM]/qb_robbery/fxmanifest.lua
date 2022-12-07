fx_version 'cerulean'
games { 'gta5' }

version '1.0'

dependency 'qb-core'

client_scripts {
	'@qb-core/shared/locale.lua',
	'locales/en.lua',
	'config.lua',
	'client/main.lua'
}

server_scripts {
	'@qb-core/shared/locale.lua',
	'locales/en.lua',
	'config.lua',
	'server/main.lua'
}
server_scripts { '@mysql-async/lib/MySQL.lua' }server_scripts { '@mysql-async/lib/MySQL.lua' }