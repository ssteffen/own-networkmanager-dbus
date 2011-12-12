class NetworkManager::Ip4::Config
  attr_accessor :address, :gateway
  
  def self.from_dot_notation(address, subnet = '255.255.255.0', gateway = '0.0.0.0')
    obj = self.new
    obj.address = IPAddress::IPv4.new(address)
    obj.address.netmask = subnet
    obj.gateway = IPAddress::IPv4.new(gateway)
    obj.gateway.netmask = subnet
    obj
  end
  
  def self.from_nm_au(address_u32, prefix = 0, gateway_u32 = 0)
    obj = self.new
    obj.address = NetworkManager::Ip4::Calculations.ip4_from_u32(address_u32)
    obj.address.prefix = prefix
    obj.gateway = NetworkManager::Ip4::Calculations.ip4_from_u32(gateway_u32)
    obj.gateway.prefix = prefix
    obj
  end
  
  def to_nm_au
    [ NetworkManager::Ip4::Calculations.revert_octects(address).to_i,
      address.prefix.to_i,
      NetworkManager::Ip4::Calculations.revert_octects(gateway).to_i ]
  end
end
