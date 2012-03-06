require 'eventmachine'
require 'syslog'
require 'socket'
require File.expand_path('./udp_proxy/server.rb', File.dirname(__FILE__))
require File.expand_path('./udp_proxy/client.rb', File.dirname(__FILE__))

module UDPProxy
  def self.start(ip, port, relay_ip, relay_port)
  	start_logger

    EM::run do
      Syslog.notice "Starting proxy on: #{ip}:#{port}"
      EM::open_datagram_socket ip, port, UDPProxy::Server, ip, relay_ip, relay_port
      trap("TERM") { stop }
      trap("INT") { stop }
    end
  end

  def self.stop
    Syslog.warning "Stopping proxy..."
    EventMachine.stop
  end

  private
  def self.start_logger
  	Syslog.open('UDP-Proxy')
  end
end

# UDPProxy.start "127.0.0.1", 50001, "127.0.0.1", 50000
