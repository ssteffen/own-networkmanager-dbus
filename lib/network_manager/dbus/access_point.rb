class NetworkManager::DBus::AccessPoint
  include DBusInterface::Object
  map_dbus :default_iface => 'org.freedesktop.NetworkManager.AccessPoint',
           :object_path => '/org/freedesktop/NetworkManager/AccessPoint'

  # Shortcut to convert the ssid array into a human readible string.
  # Assumes utf-8 encoding unless otherwise set
  def get_ssid_string(encoding = 'utf-8')
    self["Ssid"].pack('C*').force_encoding(encoding)
  end
  
end
