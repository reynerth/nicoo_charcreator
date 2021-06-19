fx_version 'cerulean'
games { 'gta5' }

author 'NicooPasPis'
-- Edited by X00LA
description 'Nicoo Char Creator'
version '1.3.0'

client_scripts {
    'RageUI/src/RMenu.lua',
    'RageUI/src/menu/RageUI.lua',
    'RageUI/src/menu/Menu.lua',
    'RageUI/src/menu/MenuController.lua',

    'RageUI/src/components/*.lua',

    'RageUI/src/menu/elements/*.lua',

    'RageUI/src/menu/items/*.lua',

    'RageUI/src/menu/panels/*.lua',

    'RageUI/src/menu/panels/*.lua',
    'RageUI/src/menu/windows/*.lua',
    
    
    'config.lua',
    'messages.lua',
    'client/*.lua'
}

server_scripts {
    'server/*.lua',
}