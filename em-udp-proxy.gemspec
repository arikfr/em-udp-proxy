$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "em-udp-proxy"
  s.version     = "0.1.0"
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Arik Fraimovich"]
  s.email       = ["arik@arikfr.com"]
  s.homepage    = "http://github.com/arikfr/em-udp-proxy"
  s.summary     = %q{EventMachine UDP Proxy}
  s.description = s.summary

  s.add_dependency "eventmachine"

  s.files         = `git ls-files`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
