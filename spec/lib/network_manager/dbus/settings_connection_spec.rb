require 'spec_helper'

describe "NetworkManager::DBus::SettingsConnection" do
  before :each do
    @data = fixture('settings_connections.yml')
    @object_paths = object_paths_from_fixture('settings_connections.yml')
  end
  
  it "should have no properties" do
    network_manager_dbus_mock
    con = NetworkManager::DBus::SettingsConnection.new @object_paths.first
    con.properties.should == nil
  end
  
  it "should get settings" do
    network_manager_dbus_mock
    con = NetworkManager::DBus::SettingsConnection.new @object_paths.first
    con.settings.should == @data.first.last['settings']
  end
  
  it 'should get secrets' do
    network_manager_dbus_mock
    con = NetworkManager::DBus::SettingsConnection.new @object_paths.first
    lambda do
      con.secrets
    end.should raise_error(NetworkManager::DBus::SettingsConnection::SecretsCacheInvalidError)
  end
  
  describe 'update' do
    it 'should do update' do
      network_manager_dbus_mock
      con = NetworkManager::DBus::SettingsConnection.new @object_paths.first
      hash = con.settings.dup
      hash['connection']['id'] = 'bar'
      con.update hash
      con.settings['connection']['id'].should == 'bar'
    end
  
    it 'should get #name' do
      network_manager_dbus_mock
      con = NetworkManager::DBus::SettingsConnection.new @object_paths.first
      con.name.should == 'Wired connection 1'
    end
  
    it 'should set #name=' do
      network_manager_dbus_mock
      con = NetworkManager::DBus::SettingsConnection.new @object_paths.first
      con.name = 'foo'
      con.name.should == 'foo'
    end
    
    it 'should set ip4 auto' do
      network_manager_dbus_mock
      con = NetworkManager::DBus::SettingsConnection.new @object_paths.first
      con.ip4_auto!
      con.ip4.should == 'auto'
    end
    
    it 'should set ip4 manual' do
      network_manager_dbus_mock
      con = NetworkManager::DBus::SettingsConnection.new @object_paths.first
      con.ip4_manual = NetworkManager::Ip4::Config.from_dot_notation '192.168.10.66', '255.255.0.0', '192.168.10.1'
      con.ip4.address.to_s.should == '192.168.10.66'
      con.ip4.address.netmask.should == '255.255.0.0'
      con.ip4.gateway.to_s.should == '192.168.10.1'
      con.ip4.gateway.netmask.should == '255.255.0.0'
    end
    
    it 'should respond to #lock_on_device' do
      network_manager_dbus_mock
      con = NetworkManager::DBus::SettingsConnection.new @object_paths.first
      con.lock_on_device NetworkManager::DBus::Device.new object_paths_from_fixture('devices.yml').first
      con.settings['802-3-ethernet']['mac-address'].should == [8, 0, 39, 251, 59, 16]
    end
  end
end
