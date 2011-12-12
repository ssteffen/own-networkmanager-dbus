require 'spec_helper'

describe "NetworkManager::Ip4::Config" do
  it 'should #from_dot_notation' do
    network_manager_dbus_mock
    c = NetworkManager::Ip4::Config.from_dot_notation '192.168.10.7', '255.255.255.0', '192.168.10.1'
    c.address.to_s == '192.168.10.7'
    c.address.netmask == '255.255.255.0'
    c.gateway.to_s == '192.168.10.1'
    c.gateway.netmask == '255.255.255.0'
  end
  
  it 'should #to_nm_au' do
    network_manager_dbus_mock
    c = NetworkManager::Ip4::Config.from_dot_notation '192.168.10.7', '255.255.255.0', '192.168.10.1'
    c.to_nm_au.should == [118139072, 24, 17475776]
  end
  
  it 'should #from_nm_au' do
    network_manager_dbus_mock
    c = NetworkManager::Ip4::Config.from_nm_au *[118139072, 24, 17475776]
    c.address.to_s == '192.168.10.7'
    c.address.netmask == '255.255.255.0'
    c.gateway.to_s == '192.168.10.1'
    c.gateway.netmask == '255.255.255.0'
  end
end
