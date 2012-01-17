class NetworkManager::DBus::AccessPoint
  include DBusInterface::Object
  map_dbus :default_iface => 'org.freedesktop.NetworkManager.AccessPoint',
           :object_path => '/org/freedesktop/NetworkManager/AccessPoint'


  def strength
    return self['Strength']
  end

  def hw_address
    return self['HwAddress']
  end

  def ssid
    return self['Ssid']
  end

end
