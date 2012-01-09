module ActiveConnectionMock

  def all_properties
    data['properties']
  end

  def devices
    self['Devices'].map do |x|
      NetworkManager::DBus::Device.new x
    end
  end

end
