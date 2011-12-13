require File.join(File.dirname(__FILE__), 'dbus_mock')
require File.join(File.dirname(__FILE__), 'dbus/root_mock')
require File.join(File.dirname(__FILE__), 'dbus/settings_mock')
require File.join(File.dirname(__FILE__), 'dbus/settings_connection_mock')
require File.join(File.dirname(__FILE__), 'dbus/ethernet_device_mock')
require File.join(File.dirname(__FILE__), 'dbus/active_connection_mock')
require File.join(File.dirname(__FILE__), 'dbus/wireless_device_mock')
require File.join(File.dirname(__FILE__), 'dbus/access_point_mock')

require File.join(File.dirname(__FILE__), 'system_bus_mock')
require File.join(File.dirname(__FILE__), 'system_bus_service_mock')

def dbus_interface_mock  
  system_bus_mock = ::SystemBusMock.new
  stub(DBusInterface).system_bus { system_bus_mock }
end

def network_manager_dbus_mock
  DBusInterface::Connection.clear!
  dbus_interface_mock
end
