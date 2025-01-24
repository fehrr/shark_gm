

fx_version "bodacious"
game "gta5"
lua54 "yes"

shared_scripts {
    '@vrp/lib/utils.lua',
	'config.lua'
}

client_scripts {
	"@vrp/lib/utils.lua",
    "client.lua"
}

server_scripts {
    "@vrp/lib/utils.lua",
    "server.lua"
}

ui_page "nui/index.html"

files{
    "nui/**",
    "nui/**/*",
}                
