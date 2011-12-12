module NetworkManager::Ip4
  # require all .rb files from lib/network_manager/ip4
  Dir.glob(File.join(File.dirname(__FILE__), "ip4/*.rb")).each do |p|
    require p
  end
end
