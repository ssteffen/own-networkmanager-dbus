describe NetworkManager::SettingsHash do
  subject{NetworkManager::SettingsHash}

  it{should respond_to(:create_wifi_settings).with(2)}
  it{should respond_to(:create_ethernet_settings).with(0)}

  describe :create_wifi_settings do
    context "should give settings for Test AP with password pass" do
      before(:each) do
        @hash = NetworkManager::SettingsHash.create_wifi_settings("Test", "pass")
      end
      specify {@hash.should be_a Hash}
      specify {@hash['connection']['type'].should eql '802-11-wireless'}
      specify {@hash['802-11-wireless-security']['key-mgmt'].should eql 'wpa-psk'}
    end
  end

  describe :create_ethernet_settings do
    context "should give settings for ethernet" do
      before(:each) do
        @hash = NetworkManager::SettingsHash.create_ethernet_settings
      end
      specify {@hash.should be_a Hash}
      specify {@hash['connection']['type'].should eql '802-3-ethernet'}
    end
  end
end
