require 'spec_helper'

describe "NetworkManager::Mac" do
  it 'should convert #hex_str_to_a' do
    network_manager_dbus_mock
    NetworkManager::Mac.hex_str_to_a('08:00:27:FB:3B:10').should == [8, 0, 39, 251, 59, 16]
  end
end