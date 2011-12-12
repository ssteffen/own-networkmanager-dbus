# add a new ethernet connection
NetworkManager::DBus::Settings.instance.add_connection(
  'connection' => {
    'id' => 'wired3',
    'uuid' => "#{Time.now.to_i}",
    'type' => '802-3-ethernet'},
  '802-3-ethernet' => {})
