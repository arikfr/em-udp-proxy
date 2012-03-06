module UDPProxy
  class Server < EM::Connection
    def initialize(relay_ip, relay_port)
      @relay_ip, @relay_port = relay_ip, relay_port
      @clients = Clients.new(self)
    end

    def receive_data(data)
      port, ip = Socket.unpack_sockaddr_in(get_peername)
      client = @clients.client(ip, port)
      client.send_datagram(data, @relay_ip, @relay_port)
    end
  end
end