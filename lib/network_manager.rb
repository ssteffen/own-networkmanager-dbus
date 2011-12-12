# This Library provides an API based on the specs for network manager dbus api
# found here: http://projects.gnome.org/NetworkManager/developers/api/09/spec.html
require 'ipaddress'
module NetworkManager  
  # generic dbus api
  require File.join(File.dirname(__FILE__), 'dbus_interface')
  
  # version
  require File.join(File.dirname(__FILE__), 'network_manager/version')
  
  # helper
  require File.join(File.dirname(__FILE__), 'network_manager/ip4')
  require File.join(File.dirname(__FILE__), 'network_manager/mac')
  
  # network manager dbus api
  require File.join(File.dirname(__FILE__), 'network_manager/dbus')
  
  def self.settings
    NetworkManager::DBus::Settings.instance
  end

  require 'network_manager/settings_hash'
  
  # delegate to dbus root object
  def self.method_missing(*args)
    NetworkManager::DBus::Root.send(*args)
  end
  
  DBusInterface.configure do |config|
    config.interface = 'org.freedesktop.NetworkManager'
  end
end
