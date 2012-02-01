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

  def flags
    return self['Flags']
  end

  def wpa_flags
    return self['WpaFlags']
  end

  def rsn_flags
    return self['RsnFlags']
  end

  def mode
    return self['Mode']
  end

  def frequency
    return self['Frequency']
  end

  def max_bitrate
    return self['MaxBitrate']
  end
end
