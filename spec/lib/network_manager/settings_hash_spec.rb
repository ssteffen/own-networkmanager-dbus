describe NetworkManager::SettingsHash do
  subject{NetworkManager::SettingsHash}

  it{should respond_to(:create_wifi_settings).with(1)}
  it{should respond_to(:create_wifi_settings).with(2)}
  it{should respond_to(:create_ethernet_settings).with(0)}

  describe :create_wifi_settings do
    context "should give settings for Test AP with password pass with string ssid" do
      before(:each) do
        @hash = NetworkManager::SettingsHash.create_wifi_settings("Test", "pass", 325)
      end
      specify {@hash.should be_a Hash}
      specify {@hash['connection']['type'].should eql '802-11-wireless'}
      specify {@hash['802-11-wireless']['ssid'][1].should eql([84, 101, 115, 116])}
      specify {@hash['802-11-wireless-security']['key-mgmt'].should eql 'wpa-psk'}
    end

    context "should give settings for Test AP with password pass with byte array ssid" do
      before(:each) do
        @hash = NetworkManager::SettingsHash.create_wifi_settings("Test", "pass", 1)
      end
      specify {@hash.should be_a Hash}
      specify {@hash['connection']['type'].should eql '802-11-wireless'}
      specify {@hash['802-11-wireless']['ssid'][1].should eql([84, 101, 115, 116])}
      specify {@hash['802-11-wireless-security']['key-mgmt'].should eql 'wpa-psk'}
    end

    context "should give settings for Test AP without a password" do
      before(:each) do
        @hash = NetworkManager::SettingsHash.create_wifi_settings("Test")
      end
      specify {@hash.should be_a Hash}
      specify {@hash['connection']['type'].should eql '802-11-wireless'}
      specify {@hash['802-11-wireless-security'].should eql nil}
    end

    context "should give settings for Test AP a WEP connection with password" do
      before(:each) do
        @hash = NetworkManager::SettingsHash.create_wifi_settings("Test", "pass", 0)
      end
      specify{@hash.should be_a Hash}
      specify {@hash['connection']['type'].should eql '802-11-wireless'}
      specify {@hash['802-11-wireless']['ssid'][1].should eql([84, 101, 115, 116])}
      specify {@hash['802-11-wireless-security']['key-mgmt'].should eql 'none'}
      specify {@hash['802-11-wireless-security']['wep-key0'].should eql("pass")}
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
