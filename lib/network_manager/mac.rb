module NetworkManager::Mac
  # @param [String] hex_str e.g. '08:00:27:FB:3B:10'
  # @return [Array<Fixnum>] array e.g. [8, 0, 39, 251, 59, 16]
  def self.hex_str_to_a(hex_str)
    hex_arr = hex_str.split(':')
    hex_arr.map{|hex| hex.to_i(16)}
  end
end
