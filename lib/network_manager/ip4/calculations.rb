module NetworkManager::Ip4::Calculations
  def self.revert_octects(ipv4)
    IPAddress::IPv4.new(ipv4.octets.reverse.join('.'))
  end
  
  def self.ip4_from_u32(address_u32)
    revert_octects(IPAddress::IPv4.parse_u32(address_u32))
  end
end
