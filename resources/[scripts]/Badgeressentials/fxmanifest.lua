-- Resource Metadata
fx_version 'cerulean'
game 'gta5'

name 'BadgerEssentials'
author 'Badger'
description 'Badger Scripts'
version '2.0'
url 'https://github.com/ChonkyBadger/BadgerEssentialsv2'

-- Files
client_script 'Badger.Client.net.dll'
ui_page 'html/ui.html'

server_script 'HttpRequests.lua'
server_script 'Badger.Server.net.dll'


files {
    'Newtonsoft.Json.dll',
    'config/config.json',
    'config/postals.json',
    'config/displays.json',
}
