class NetworkManager::DBus::SettingsConnection
  class SecretsCacheInvalidError < StandardError; end
  
  HW_TYPE_ETHERNET = '802-3-ethernet'
  HW_TYPE_WIRELESS = '802-11-wireless'
  HW_TYPE_BLUETOOTH = 'bluetooth'
  SW_TYPE_VPN = 'vpn'
  SW_TYPE_BRIDGE = 'bridge'
  
  include DBusInterface::Object
  no_properties!
  map_dbus :default_iface => 'org.freedesktop.NetworkManager.Settings.Connection'
  
  def settings
    call('GetSettings').first
  end
  
  # removes the connection
  def delete
    call('Delete')
  end
  
  def secrets(name = '')
    call('GetSecrets', name)
  rescue DBus::Error => e
    raise SecretsCacheInvalidError.new("Secrets cache invalid (#{e})")
  end
  
  # @return [String] name
  def name
    settings['connection']['id']
  end
  
  # @return [String] uuid
  def uuid
    settings['connection']['uuid']
  end
  
  # @return [String] type
  def type
    settings['connection']['type']
  end
  
  # updates the connection
  # @note this does not activate the changes on a device (re-activation is required)
  def update(hash)
    new_settings = hash.dup
    unless new_settings.has_key? 'connection'
      new_settings.merge!(settings)
    end
    # ensure method signatures
    # TODO maybe needed also for routes, ...
    if ipv4_settings = new_settings[IPV4]
      if addresses = ipv4_settings[IPV4_ADDRESSES]
        if addresses.first != 'aau'
          ipv4_settings[IPV4_ADDRESSES] = ['aau', addresses]
        end
      end
    end
    call('Update', new_settings)
  end
  
  # @param [String] a new name
  def name=(new_id)
    hash = settings
    hash['connection']['id'] = new_id
    hash.delete IPV4
    update(hash)
  end
  
  IPV4 = 'ipv4'
  IPV4_ADDRESSES = 'addresses'
  IPV4_METHOD = 'method'
  IPV4_METHOD_AUTO = 'auto'
  IPV4_METHOD_MANUAL = 'manual'
  
  # @param [Hash]
  def ip4=(ip4)
    hash = settings
    hash[IPV4] = ip4
    update(hash)
  end
  
  # makes ip4 auto (use dhcp)
  def ip4_auto!
    self.ip4 = {IPV4_METHOD => IPV4_METHOD_AUTO}
  end
  
  # manual ip4 settings (ip etc.)
  # @param [Array<NetworkManager::Ip4Config>] addresses
  def ip4_manual=(addresses)
    # ensure wrapper array
    addresses = [addresses] unless addresses.is_a? Array
    
    self.ip4 = {
      IPV4_METHOD => IPV4_METHOD_MANUAL,
      IPV4_ADDRESSES => addresses.map{|a| a.to_nm_au}
    }
  end
  
  # current ipv4
  def ip4
    if ipv4 = settings[IPV4]
      if ipv4[IPV4_METHOD] == IPV4_METHOD_MANUAL
        address = ipv4[IPV4_ADDRESSES].first
        NetworkManager::Ip4::Config.from_nm_au *address
      else
        IPV4_METHOD_AUTO
      end
    else
      nil
    end
  end
  
  # lock on given device
  def lock_on_device(device)
    hash = settings
    hex_str = begin
      if device['PermHwAddress']
        device['PermHwAddress']
      elsif device.ethernet?
        hw = device.ethernet.hw_address
        DBusInterface::Connection.clear! # this is a caching bug!! when calling #ethernet the device itself gets crrupted
        hw
      end
    end
    if hex_str
      mac_arr = NetworkManager::Mac.hex_str_to_a hex_str
      hash[HW_TYPE_ETHERNET]['mac-address'] = mac_arr
      update(hash)
    else
      raise ArgumentError.new("could not found hardware address of #{dev.inspect}")
    end
  end
  
  def to_s
    "#{self.class} #{self.settings.inspect}"
  end
end
