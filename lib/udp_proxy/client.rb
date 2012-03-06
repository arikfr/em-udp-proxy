# TODO: periodically kill all dead connections
module UDPProxy
  class Client < EM::Connection
    attr_accessor :client_ip, :client_port

    def initialize(client_ip, client_port, server)
      @client_ip, @client_port = client_ip, client_port
      @server = server
    end

    def receive_data(data)
      port, ip = Socket.unpack_sockaddr_in(get_peername)
      @server.send_datagram(data, client_ip, client_port)
    end
  end

  class Clients
    def initialize(server)
      @clients = {}
      @server = server
    end

    def client(ip, port)
      @clients[key(ip, port)] || @clients[key(ip,port)] = create_client(ip, port)
    end

  private
    def key(ip, port)
      "#{ip}:#{port}"
    end

    def create_client(ip, port)
      Syslog.notice "Creating new client for #{ip}:#{port}"
      client = EM::open_datagram_socket "127.0.0.1", 0, Client, ip, port, @server
    end
  end

end