class NetworkManager::DBus::EthernetDevice
  include DBusInterface::Object
  map_dbus :default_iface => 'org.freedesktop.NetworkManager.Device.Wired'
  
  property 'HwAddress'
end
