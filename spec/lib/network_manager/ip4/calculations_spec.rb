require 'spec_helper'

describe "NetworkManager::Ip4::Calculations" do
  it 'should #ip4_from_u32' do
    network_manager_dbus_mock
    ip4 = NetworkManager::Ip4::Calculations.ip4_from_u32 118139072
    ip4.to_s.should == '192.168.10.7'
  end
  
  it 'should #revert_octects' do
    network_manager_dbus_mock
    ip4 = NetworkManager::Ip4::Calculations.revert_octects IPAddress::IPv4.new('192.168.10.7')
    ip4.to_s.should == '7.10.168.192'
  end
end
