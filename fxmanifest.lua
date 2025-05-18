fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'RoyWillems'
description 'Bikerental script voor SunnyDayz'

shared_script '@es_extended/imports.lua'

client_script {
    '@ox_lib/init.lua',
    'config.lua',
    'client.lua'
}

server_script 'server.lua'

dependencies {
    'ox_target',
    'ox_lib',
    'es_extended'
}
