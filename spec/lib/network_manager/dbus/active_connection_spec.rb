require 'spec_helper'

describe "NetworkManager::DBus::ActiveConnection" do
  before :each do
    @data = fixture('active_connections.yml')
    @object_paths = object_paths_from_fixture('active_connections.yml')
  end

  it 'should map interface "org.freedesktop.NetworkManager.Connection.Active"' do
    NetworkManager::DBus::ActiveConnection.default_iface.should ==
      'org.freedesktop.NetworkManager.Connection.Active'
  end
  
  it 'shoud list properties' do
    network_manager_dbus_mock
    con = NetworkManager::DBus::ActiveConnection.new @object_paths.first
    con.properties.should == @data.first.last['properties']
  end

  it "should list devices" do
    network_manager_dbus_mock
    con = NetworkManager::DBus::ActiveConnection.new @object_paths.first
    con.devices.size.should_not eql(0)
    con.devices.first.class.should eql(NetworkManager::DBus::Device)
  end
end
