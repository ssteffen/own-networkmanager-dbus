module SettingsConnectionMock
  def GetSettings
    [ data['settings'] ]
  end
  
  def GetSecrets(name)
    # until we know what it correctly can return, here return sth broken
    raise DBus::Error.new 'm-settings-connection.c.830 - Internal error; secrets cache invalid.'
  end
  
  def Update(hash)
    if ipv4 = hash['ipv4']
      if addresses = ipv4['addresses']
        if addresses.first == 'aau'
          ipv4['addresses'] = addresses.last
        else
          raise ArgumentError.new("No signature given in #{addresses.inspect}, expected 'aau'")
        end
      end
    end
    data.merge(hash)
  end
end
