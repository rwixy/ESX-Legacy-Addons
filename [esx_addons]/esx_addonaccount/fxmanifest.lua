fx_version 'cerulean'
game 'gta5'
lua54 'yes'
use_fxv2_oal 'yes'

author 'ESX-Framework'
description 'Allows resources to store account data, such as society funds'
lua54 'yes'
version '1.1'
legacyversion '1.14.1'

server_scripts {
	'@es_extended/imports.lua',
	'@oxmysql/lib/MySQL.lua',
	'server/classes/addonaccount.lua',
	'server/database.lua',
	'server/main.lua'
}
