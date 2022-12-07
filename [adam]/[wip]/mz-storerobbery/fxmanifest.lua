fx_version 'cerulean'
game 'gta5'

description 'mz-storerobbery - Mr_Zain#4139 changes to qb-storerobbery (with or without mz-skills integration)'

version '1.1.0'

ui_page 'html/index.html'

shared_script 'config.lua'
client_script 'client/main.lua'
server_script 'server/main.lua'

files {
    'html/index.html',
    'html/script.js',
    'html/style.css',
    'html/reset.css'
}

lua54 'yes'