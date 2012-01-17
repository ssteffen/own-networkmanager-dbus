class NetworkManager::DBus::Root
  include DBusInterface::Object
  map_dbus :default_iface => 'org.freedesktop.NetworkManager',
           :object_path => '/org/freedesktop/NetworkManager'
  
  # Networking state is unknown.
  NM_STATE_UNKNOWN          = 0
  # Networking is inactive and all devices are disabled.
  NM_STATE_ASLEEP           = 10
  # There is no active network connection.
  NM_STATE_DISCONNECTED     = 20
  # Network connections are being cleaned up.
  NM_STATE_DISCONNECTING    = 30
  # A network device is connecting to a network and there is no other available network connection.
  NM_STATE_CONNECTING       = 40
  # A network device is connected, but there is only link-local connectivity.
  NM_STATE_CONNECTED_LOCAL  = 50
  # A network device is connected, but there is only site-local connectivity.
  NM_STATE_CONNECTED_SITE   = 60
  # A network device is connected, with global network connectivity.
  NM_STATE_CONNECTED_GLOBAL = 70
  
  # States for old 0.7 NM
  NM_OLD_STATE_SLEEP = 1
  NM_OLD_STATE_CONNECTING = 2
  NM_OLD_STATE_CONNECTED = 3
  NM_OLD_STATE_DISCONNECTED = 4

  # TODO add missing methods
  # AddAndActivateConnection
  # DeactivateConnection
  # Sleep
  # Enable
  # GetPermissions
  # SetLogging
  
  # @return [Array<NetworkManager::DBus::Device>]] devices
  def devices
    self.call('GetDevices').flatten.map do |object_path|
      new_device(object_path)
    end
  end

  def self.devices
    instance.devices
  end

  # @return [NetworkManager::DBus::ActiveConnection] con
  def active_connections
    self['ActiveConnections'].flatten.map do |object_path|
      NetworkManager::DBus::ActiveConnection.new object_path
    end
  end

 def self.active_connections
    instance.active_connections
 end
  
  def self.activate_connection(con, dev, optional = NetworkManager::DBus::NULL_OBJECT)
    instance.call('ActivateConnection', 'org.freedesktop.NetworkManagerSystemSettings',  con.object_path, dev.object_path, optional.object_path)
  end
  
  def self.device_by_interface(interface)
    paths = instance.call('GetDeviceByIpIface', interface)
    paths.empty? ? nil : new_device(paths.first)
  end

  def self.deactivate_connection(active_connection)
    instance.call("DeactivateConnection", active_connection.object_path)
  end
 
  def self.internet_connection?
    state = instance.call('state').first
    state == NM_STATE_CONNECTED_GLOBAL || state == NM_OLD_STATE_CONNECTED
  end

  def self.add_and_activate_connection(connection_hash, device, specific_object = nil)
    instance.add_and_activate_connection(connection_hash, device, specific_object)
  end

  def add_and_activate_connection(connection_hash, device, specific_object=nil)
    #For private networks we don't need a specific object. In this case just pass nil
    obj = (specific_object.nil?)? '/' : specific_object.object_path
    self.call('AddAndActivateConnection', connection_hash, device.object_path, obj)
  end

  def state
    self.call('state')
  end

  def self.state
    NetworkManager.new.state
  end

  def version
    version = self['Version']
    if version.nil?
      return "0.7"
    end
    return version
  end

  def self.version
    NetworkManager.new.version
  end

private

  def self.new_device(object_path)
    NetworkManager::DBus::Device.new object_path
  end

  def new_device(object_path)
    NetworkManager::DBus::Device.new object_path
  end

end
