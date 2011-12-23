class NetworkManager::DBus::AccessPoint
  include DBusInterface::Object
  map_dbus :default_iface => 'org.freedesktop.NetworkManager.AccessPoint',
           :object_path => '/org/freedesktop/NetworkManager/AccessPoint'


  def strength
    return self['Strength']
  end

end
