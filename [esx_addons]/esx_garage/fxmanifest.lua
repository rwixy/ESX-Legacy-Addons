fx_version 'cerulean'
game 'gta5'

author 'ESX-Framework'
description 'Modern Garage System with React UI'
use_experimental_fxv2_oal 'true'

version '2.0.0'
<<<<<<< HEAD
legacyversion '1.14.1'
=======
legacyversion '1.14.2'
>>>>>>> upstream-1142/1.14.2

lua54 'yes'
ui_page 'nui/index.html'
files { 'nui/index.html', 'nui/**/*' }

ui_page 'web/dist/index.html'

files {
    'web/dist/index.html',
    'web/dist/**/*',
    'locales/*.lua',
}

<<<<<<< HEAD
<<<<<<< HEAD
client_scripts { '@es_extended/locale.lua', 'locales/*.lua', 'config.lua', 'client/main.lua' }
=======
shared_scripts {
    '@es_extended/imports.lua',
    '@es_extended/locale.lua',
    'locales/*.lua',
=======
shared_scripts {
    '@esx_lib/imports.lua',
    '@es_extended/imports.lua',
    '@es_extended/locale.lua',
>>>>>>> upstream-1142/1.14.2
    'config.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/modules/*.lua'
}

client_scripts {
<<<<<<< HEAD
    '@es_extended/locale.lua',
=======
>>>>>>> upstream-1142/1.14.2
    'client/modules/**/*',
    'client/init.lua'
}

dependencies {
    'es_extended',
    'oxmysql'
<<<<<<< HEAD
}
>>>>>>> 582fbc7 (merge esx_garage to 1.14.1 branch)
=======
}
>>>>>>> upstream-1142/1.14.2
