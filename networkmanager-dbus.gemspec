# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "network_manager/version"

Gem::Specification.new do |s|
  s.name        = "networkmanager-dbus"
  s.version     = NetworkManager::VERSION
  s.authors     = ["Jens Bissinger"]
  s.email       = ["whiterabbit.init@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{NetworkManager Interface written in Ruby}
  s.description = %q{Utilizing the official NetworkManager DBus API}

  s.rubyforge_project = "networkmanager-dbus"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {spec}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # dependencies
  s.add_development_dependency "rake"
  s.add_development_dependency "pry"
  s.add_development_dependency "rspec"
  s.add_development_dependency "rr"
  s.add_development_dependency "active_support"
  s.add_development_dependency "guard"
  s.add_development_dependency "guard-shell"
  s.add_development_dependency "growl-rspec"
  s.add_development_dependency "growl"
  s.add_development_dependency "json"
  s.add_development_dependency "marilyn-rpc"
  s.add_runtime_dependency 'ipaddress'
  s.add_runtime_dependency "ruby-dbus"
end
