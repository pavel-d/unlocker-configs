## Unlocker Proxy

Dynamic configuration for sniproxy and bind9

## Setup

Requires sniproxy and bind9 installed on remote machine. Tested on Ubuntu 14.04 only

## Deploy
Install `mina` locally, `$ gem install mina`
Make changes to the configuration and run deploy
`$ mina deploy`
It generate configs for sniproxy and bind9 from fresh dump of forbidden sites [dump](https://github.com/zapret-info/z-i/) and include additional hosts from [config/settings.yml](config/settings.yml)

Services won't be restarted if any of deploy steps fail