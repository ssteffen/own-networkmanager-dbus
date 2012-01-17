module RootMock
  def GetDevices
    object_paths = object_paths_from_fixture('devices.yml')
    [ object_paths ]
  end
  
  def GetDeviceByIpIface(iface)
    devices_data = fixture('devices.yml')
    object_path, hash = devices_data.find do |object_path,hash|
      hash['properties']['Interface'] == iface
    end
    [ object_path ]
  end

  def AddAndActivateConnection(settings_hash, device, specific_object)
    settings = object_paths_from_fixture('settings.yml')
    a_connections = object_paths_from_fixture('active_connections.yml')
    [settings.last, a_connections.last]
  end

end
