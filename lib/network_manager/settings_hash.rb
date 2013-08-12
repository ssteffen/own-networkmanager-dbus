class NetworkManager::SettingsHash < Hash

  # Generates a connection settings hash for a wifi connection.
  def self.create_wifi_settings(ssid, pass = nil, wpa_flags = 0)
    connection_settings = {
      'id' => ssid,
      'uuid' => SecureRandom.uuid,
      'type' => '802-11-wireless',
      'name' => 'connection'
    }
    # IMPORTANT NOTE: 
    # DBus required byte arrays to be a specific type format. Using ruby-dbus we can parse a DBus byte array object
    # by calling DBus::Type::Parser.new('ay'), where the characters 'a' refers to array, of type 'y' referring to byte.
    # See the DBus Specifications for more details: http://dbus.freedesktop.org/doc/dbus-specification.html
    security = (pass)? '802-11-wireless-security' : nil
    ssid = (ssid.kind_of?(String))? ssid.bytes.to_a : ssid
    wifi_settings = {
      'ssid' => [DBus::Type::Parser.new('ay').parse[0], ssid],
      'name' => '802-11-wireless'
    }
    if security
      wifi_settings["security"] = security
      security_settings = {
        'name' => '802-11-wireless-security'
      }
      if(wpa_flags != 0)
        security_settings.merge!({
          'key-mgmt' => 'wpa-psk',
          'psk' => pass
        })
      else
        security_settings.merge!({
          'key-mgmt' => 'none',
          'wep-key0' => pass
        })
      end
    end
    ipv4_settings = {
      'method' => 'auto',
      'name' =>  'ipv4'
    }

    general_connection = {
      'connection' => connection_settings,
      '802-11-wireless' => wifi_settings,
      'ipv4' => ipv4_settings
    }
    if(security)
      general_connection['802-11-wireless-security'] = security_settings
    end
    return general_connection
  end

  def self.create_ethernet_settings
    return {
      'connection' => {
        'id' => 'wired3',
        'uuid' => "#{Time.now.to_i}",
        'type' => '802-3-ethernet'},
      '802-3-ethernet' => {}
    }
  end
end
