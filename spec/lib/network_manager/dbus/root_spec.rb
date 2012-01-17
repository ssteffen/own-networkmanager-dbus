require 'spec_helper'
require 'active_support'

describe "NetworkManager::DBus::Root" do
  before :each do
    @devices = fixture('devices.yml')
  end

  it "should list devices" do
    network_manager_dbus_mock
    list = NetworkManager::DBus::Root.devices
    list.size.should > 0
    list.first.class.should == NetworkManager::DBus::Device
  end

  it "should return device_by_interface" do
    network_manager_dbus_mock
    dev = NetworkManager::DBus::Root.device_by_interface 'eth0'
    dev.properties.should == @devices.first.last['properties']
  end

  describe "internet_connection?" do
    it 'should recognize internet_connection? if NM_STATE_CONNECTED_GLOBAL' do
      network_manager_dbus_mock
      stub(NetworkManager::DBus::Root.instance).call('state') {
        [NetworkManager::DBus::Root::NM_STATE_CONNECTED_GLOBAL]
      }
      NetworkManager::DBus::Root.internet_connection?.should be_true
    end

    it 'should not recognize internet_connection? if not NM_STATE_CONNECTED_GLOBAL' do
      network_manager_dbus_mock
      stub(NetworkManager::DBus::Root.instance).call('state') {
        [Time.now.to_i]
      }
      NetworkManager::DBus::Root.internet_connection?.should be_false
    end
  end

  describe 'active_connections' do
    it 'should provide active_connections' do
      network_manager_dbus_mock
      stub(NetworkManager::DBus::Root.instance)
      NetworkManager::DBus::Root.active_connections.class.should == Array
      NetworkManager::DBus::Root.active_connections.first.class.should == NetworkManager::DBus::ActiveConnection
    end
  end


  # Expecting array of settings object and active connection object
  describe :add_and_activate_connection do
    before(:each) do
      network_manager_dbus_mock
      stub(NetworkManager::DBus::Root.instance)
    end

    subject {NetworkManager::DBus::Root}
    it{should respond_to(:add_and_activate_connection).with(3)}

    context "when a connection is valid" do
      before(:each) do
      end

    end

  end

end
