require 'spec_helper'

describe "NetworkManager::DBus::Device" do
  before :each do
    @devices = fixture('devices.yml')
    @object_paths = object_paths_from_fixture('devices.yml')
  end
  
  describe "NM_DEVICE_TYPE" do
    before :each do
      network_manager_dbus_mock
      @nm_device_type = NetworkManager::DBus::Device::NM_DEVICE_TYPE__PROPERTY
      @device = NetworkManager::DBus::Device.new @object_paths.first
    end
    
    describe "NM_DEVICE_TYPE_ETHERNET" do
      it "should detect ethernet devices with NM_DEVICE_TYPE_ETHERNET" do
        @device.properties[@nm_device_type] =
          NetworkManager::DBus::Device::NM_DEVICE_TYPE_ETHERNET
        @device.ethernet?.should == true
      end
      
      it "should not detect ethernet devices withour NM_DEVICE_TYPE_ETHERNET" do
        @device.properties[@nm_device_type] = 1234567
        @device.ethernet?.should == false
      end
      
      it "should instantiate ethernet devices" do
        @device.properties[@nm_device_type] =
          NetworkManager::DBus::Device::NM_DEVICE_TYPE_ETHERNET
        @device.ethernet.class.should == NetworkManager::DBus::EthernetDevice
      end
      
      it "should not instantiate unknown device types" do
        @device.properties[@nm_device_type] = 12345123
        @device.ethernet.should == nil
      end
    end
  end
  
  it "should provide ip4_address" do
    network_manager_dbus_mock
    device = NetworkManager::DBus::Device.new @object_paths.first
    device.ip4_address.to_s.should == '192.168.56.101'
  end
  
  it 'should provide ip4_config' do
    network_manager_dbus_mock
    device = NetworkManager::DBus::Device.new @object_paths.first
    device.ip4_config.class.should == NetworkManager::DBus::Ip4Config
  end

# NetworkManager 0.7 doesnt support this test case. Created similar test in root  
#  it 'should provide active_connection' do
#    network_manager_dbus_mock
#    device = NetworkManager::DBus::Device.new @object_paths.first
#    device.active_connection.class.should == NetworkManager::DBus::ActiveConnection
#  end
end
