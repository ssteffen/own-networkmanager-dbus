class NetworkManager::DBus::Settings
  include DBusInterface::Object
  map_dbus :default_iface => 'org.freedesktop.NetworkManager.Settings',
             :object_path => '/org/freedesktop/NetworkManager/Settings'
  no_properties!
  
  # TODO methods
  # GetConnectionByUuid
  
  # TODO signals
  # PropertiesChanged
  
  property 'Hostname'
  property 'CanModify', :boolean
  
  def self.connections
    instance.connections
  end
  
  # @return [Array<NetworkManager::DBus::SettingsConnection>] connections
  def connections
    call('ListConnections').map do |list|
      list.map do |object_path|
        ::NetworkManager::DBus::SettingsConnection.new(object_path)
      end
    end.flatten
  end
  
  # @param [Hash] connection hash
  def add_connection(connection_hash)
    call('AddConnection', connection_hash)
  end
  
  # @param [String] new_hostname
  def hostname=(new_name)
    call('SaveHostname', new_name)
  end
end
