require 'socket'

# Receiving messages from client and sending to
# other clients
def client_handler(client, all_clients)
  loop do
    msg = client.gets
    break if msg.nil?

    all_clients.each { |i| i.puts msg if i != client }
  end
end

# Trying to start server
print 'Enter IP: '
ip = gets.chomp
print 'Enter port: '
port = gets.chomp
begin
  server = TCPServer.new(ip, port)
rescue Errno::EADDRINUSE
  abort 'ERROR! Port is already used'
resque
  abort 'ERROR! Could not start server'
end
puts 'Server has been successfully started'

# Main server logic
all_clients = []
threads = []
loop do
  all_clients << server.accept
  puts 'Client connected'
  threads << Thread.start(all_clients.last) do |client|
    client_handler(client, all_clients)
    Thread.current.kill
    threads.delete(Thread.current)
  end
end

threads.each(&:join)
