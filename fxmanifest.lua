--[[ ===================================================== ]] --
--[[            MH Blackmarket Script by MaDHouSe          ]] --
--[[ ===================================================== ]] --
fx_version 'cerulean'
game 'gta5'

author 'MaDHouSe'
description 'mh-blackmarket'
version '1.0'

shared_scripts {'@qb-core/shared/locale.lua', 'locales/en.lua'}
client_scripts {'configs/cl_config.lua', 'client/main.lua'}
server_scripts {'configs/sv_config.lua', 'server/main.lua', 'server/update.lua'}

lua54 'yes'
