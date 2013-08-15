THIS IS ALPHA STUFF :)

see [TODOs](TODO.md)

[![Travis-CI Build Status](https://secure.travis-ci.org/dpree/networkmanager-dbus.png)](https://secure.travis-ci.org/dpree/networkmanager-dbus)

# NetworkManager-Ruby

This library provides a Ruby API to NetworkManager using its DBus Interface.

Written using the NetworkManager DBus API Documentation v0.9

  * [Overview](http://projects.gnome.org/NetworkManager/developers/api/09/index.html)
  * [DBus API Spec](http://projects.gnome.org/NetworkManager/developers/api/09/spec.html)
  * [Settings Details](http://projects.gnome.org/NetworkManager/developers/api/09/ref-settings.html)

## Documentation

Please have a look at [Documentation](http://rubydoc.info/github/dpree/networkmanager-dbus)

Or build it your on your own using `yard` gem, running the command from projet dir:

    yardoc

## Installation

Please make sure that you have `dbus` and `networkmanager` installed on the machine
were you want to use this library. Remote DBus wasn't tested.

    gem install networkmanager-dbus

## Examples

At the moment this is incomplete. So for now,
please have a look at the `examples` folder and the `specs`.

    require 'networkmanager-dbus'
    NetworkManager.devices.first['Interface'] # => 'eth0' or something similar
    NetworkManager.settings.hostname          # => 'your.host.name'


Get Wireless Access Points.

    require 'networkmanager-dbus'
    dev = NetworkManager.devices.find{ |device| device["Interface"] == "wlan0"}  # => NetworkManager::DBus::Device
    wireless = dev.wireless                                                      # => NetworkManager::DBus::WirelessDevice
    wireless.access_points                                                       # => [NetworkManager::DBus::AccessPoint


Create a new wpa wifi connection

    require 'networkmanager-dbus'
    dev = NetworkManager.devices.find{ |device| device["Interface"] == "wlan0"}                   # => NetworkManager::DBus::Device
    wireless = dev.wireless                                                                       # => NetworkManager::DBus::WirelessDevice
    ap = wireless.access_points.first                                                             # => NetworkManager::DBus::AccessPoint
    settings_hash = NetworkManager::SettingsHash.create_wifi_settings("<ssid_name>", "<wpa_psk>") # => {Settings Hash to be passed to connection}
    NetworkManager.settings.add_connection(settings_hash)                                         # => creates connection object In NM 0.9, returns connection. In 0.7, returns nothing
    con = NetworkManager.settings.connections.first                                               # => Returns last created connection, only needed in v <= 0.9
    NetworkManager.activate_connection(con, dev, ap)                                              # => connects to the WAP

## Development

Development currently happens from my OSX machine where no dbus/networkmanager
is running. Therefore, i hacked some scripts together to be able to run rspec
over the wire.

On the remote-machine (linux, dbus, networkmanager)

    `script/spec_server`
    
On the local-machine (osx)

    `guard`

# Thanks

to the guys from IRC channel #nm at irc.freenode.net

   * dbcw
   * jklimes

# License

Copyright 2011 Jens Bissinger. All rights reserved. [MIT-LICENSE](MIT-LICENSE)
