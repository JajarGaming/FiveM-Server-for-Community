
fx_version 'cerulean'
games { 'rdr3', 'gta5' }

description 'Main code of the server is located here.' -- Credit goes to FAXES and some more people for the code.
version '1.0.0'

-- What to run
client_scripts {
    'client/cl_*.lua'
}

sserver_scripts {
    'server/sv_*.lua'
}