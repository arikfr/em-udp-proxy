require 'em-udp-proxy/server'
require 'forwardable'

module UDPProxy

  class << self
    extend Forwardable
    def_delegators Server, :start, :stop
  end

end
