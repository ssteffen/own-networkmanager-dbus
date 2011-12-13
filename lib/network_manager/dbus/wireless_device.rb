class NetworkManager::DBus::WirelessDevice
  include DBusInterface::Object
  map_dbus :default_iface => 'org.freedesktop.NetworkManager.Device.Wireless'

  property "HwAddress"

  def access_points
    call('GetAccessPoints').flatten.map do |object_path|
        new_access_point(object_path)
    end
  end

private 
  def new_access_point(object_path)
    NetworkManager::DBus::AccessPoint.new object_path
  end
end
