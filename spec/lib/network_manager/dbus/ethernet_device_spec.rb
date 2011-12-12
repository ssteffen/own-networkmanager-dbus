require 'spec_helper'

describe "NetworkManager::DBus::EthernetDevice" do
  before :each do
    @data = fixture('devices.yml')
    @object_paths = object_paths_from_fixture('devices.yml')
  end
    
  it "should list poperties" do
    network_manager_dbus_mock
    dev = NetworkManager::DBus::EthernetDevice.new @object_paths.first
    dev.properties.should == @data.first.last['ethernet']['properties']
  end
  
  it 'should access #hw_address' do
    network_manager_dbus_mock
    dev = NetworkManager::DBus::EthernetDevice.new @object_paths.first
    dev.hw_address.should == '08:00:27:FB:3B:10'
  end
end
