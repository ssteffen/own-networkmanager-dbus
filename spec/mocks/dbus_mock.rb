class DBusMock
  attr_reader :data
  attr_accessor :default_iface, :introspect, :all_properties
  def initialize(path)
    @data = merged_dbus_fixtures[path]
  end
  def default_iface=(iface)
    @default_iface = iface
    case iface
      when /NetworkManager$/
        extend RootMock
      when /NetworkManager.Connection.Active$/
        extend ActiveConnectionMock
      when /NetworkManager.Settings$/
        extend SettingsMock
      when /NetworkManager.Device.Wired$/
        extend EthernetDeviceMock
      when /NetworkManager.Device.Wireless$/
        extend WirelessDeviceMock
      when /NetworkManager.AccessPoint$/
        extend AccessPointMock
      when /NetworkManager.Settings.Connection$/
        extend SettingsConnectionMock
    end
    iface
  end
  def call(method, *args)
    if self.respond_to?(method)
      self.send(method, *args)
    else
      [ ]      
    end
  end
  def all_properties
    data['properties']
  end
end
