require 'spec_helper'

describe "NetworkManager::DBus::AccessPoint" do 
  before :each do 
    @data = fixture('access_points.yml')
    @object_path = object_paths_from_fixture('access_points.yml').first
  end

  it 'should map interface "org.freedesktop.NetworkManager.AccessPoint"' do
    NetworkManager::DBus::AccessPoint.default_iface.should ==
      "org.freedesktop.NetworkManager.AccessPoint"
  end
  
  it 'should list properties' do 
    network_manager_dbus_mock
    con = NetworkManager::DBus::AccessPoint.new @object_path
    con.properties.should == @data.first.last["properties"]
  end
end
