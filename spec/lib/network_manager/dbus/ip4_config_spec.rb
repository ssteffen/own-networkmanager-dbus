require 'spec_helper'

describe "NetworkManager::DBus::Ip4Config" do
  before :each do
    @data = fixture('ip4_configs.yml')
    @object_paths = object_paths_from_fixture('ip4_configs.yml')
  end

  it 'should map interface "org.freedesktop.NetworkManager.IP4Config"' do
    NetworkManager::DBus::Ip4Config.default_iface.should ==
      'org.freedesktop.NetworkManager.IP4Config'
  end
  
  it 'should list properties' do
    network_manager_dbus_mock
    con = NetworkManager::DBus::Ip4Config.new @object_paths.first
    con.properties.should == @data.first.last['properties']
  end
  
  it 'should list #addresses' do
    network_manager_dbus_mock
    con = NetworkManager::DBus::Ip4Config.new @object_paths.first
    con.addresses.first.address.to_s.should == '192.168.56.101'
  end
  
  it 'should list #nameservers' do
    network_manager_dbus_mock
    con = NetworkManager::DBus::Ip4Config.new @object_paths.first
    con.nameservers.first.to_s.should == '10.0.0.1'
  end
  
  it 'should list #domains' do
    network_manager_dbus_mock
    con = NetworkManager::DBus::Ip4Config.new @object_paths.first
    con.domains.should == ['ns1.host.tld']
  end
end
