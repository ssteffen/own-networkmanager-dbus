require File.join(File.expand_path(File.dirname(__FILE__)), '../lib/network_manager')

# the first setting (hopefully a eth0 default foo)
con = NetworkManager::DBus::Settings.connections.first

# new ip4 config
# ip + netmask + gateway
ip4 = NetworkManager::Ip4::Config.from_dot_notation '192.168.10.100', '255.255.255.0', '192.168.10.1'

# change the settings obj
con.ip4_manual = ip4

# take minor important device no.2 :)
dev = NetworkManager.devices[1]

# apply the settings obj to the dev
NetworkManager::DBus::Root.activate_connection con, dev
