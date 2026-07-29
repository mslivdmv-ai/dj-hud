fx_version 'cerulean'
game 'gta5'

lua54 'yes'

author 'DG Development'
description 'DG-HUD - Modern ESX HUD'
version '1.0.0'

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua'
}

client_scripts {
    'client/*.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/*.lua'
}

ui_page 'web/index.html'

files {
    'web/index.html',
    'web/style.css',
    'web/script.js',
    'web/assets/*.*',
    'locales/*.json'
}

dependencies {
    'es_extended',
    'ox_lib',
    'ox_inventory',
    'ox_target',
    'pma-voice',
    'ox_fuel'
}

escrow_ignore {
    'config.lua'
}
