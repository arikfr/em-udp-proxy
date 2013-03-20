require 'em-udp-proxy/client'

module EMUDPProxy
  class Server < EM::Connection
    include Callbacks
    attr_reader :relay_ip, :relay_port

    def initialize(address, relay_ip, relay_port)
      @relay_ip, @relay_port = relay_ip, relay_port
      @clients = Clients.new(self, address)
      #Proxy new client events
      @clients.on(:new_client){|*a| run_callbacks(:new_client, *a) }
    end

    def receive_data(data)
      port, ip = Socket.unpack_sockaddr_in(get_peername)
      client = @clients.client(ip, port)
      run_callbacks(:receive_data, data, client)
      client.send_datagram(data, relay_ip, relay_port)
    end


    def self.start(ip, port, remote_ip, remote_port)
      @server = EM.open_datagram_socket(ip, port, self, ip, remote_ip, remote_port)
    end

    def self.stop
      #?
    end

  end
end
