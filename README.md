em-udp-proxy
===

EventMachine based UDP proxy.

Example usage:

    > em-udp-proxy -a 127.0.0.1 -p 5001 -A 192.168.1.1 -P 5001

Starts the proxy bound to 127.0.0.1 with port 5001 and forwards traffic to/from 192.168.1.1 on port 5001.


    server = EMUDPProxy.new('127.0.0.1', '5001', '192.168.1.1', '5001')
    server.on :new_client do |client|
      puts "New client: #{client.ip}:#{client.port}"
      client.on :receive_data |data, ip, port|
        puts "Client #{client.ip}:#{client.port} received: #{data}"
      end
    end
    server.on :receive_data do |data, client|
      puts "Client #{client.ip}:#{client.port} sent: #{data}"
    end


TODO:

1. More documentation :-)
2. Remove Client objects for inactive clients (after certain threshold).
3. Add some way to get stats from it. 
