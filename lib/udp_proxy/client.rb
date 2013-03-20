require 'eventmachine'
require File.expand_path('callbacks', File.dirname(__FILE__))

# TODO: periodically kill all dead connections
module UDPProxy

  class Client < EM::Connection
    include Callbacks
    attr_accessor :ip, :port

    def initialize(ip, port, server)
      @ip, @port = ip, port
      @server = server
    end

    def receive_data(data)
      port, ip = Socket.unpack_sockaddr_in(get_peername)
      run_callbacks(:receive_data, data, ip, port)
      @server.send_datagram(data, self.ip, self.port)
    end
  end

  class Clients
    include Callbacks

    def initialize(server, address)
      @address = address
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
      client = EM::open_datagram_socket @address, 0, Client, ip, port, @server
      run_callbacks(:new_client, client)
      client
    end
  end

end
