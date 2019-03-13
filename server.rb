require 'socket'

# Receiving messages from client and sending to
# other clients
def client_handler(client, all_clients)
  client.puts 'Welcome to server, stranger!'
  loop do
    msg = client.gets
    if msg.nil?
      puts 'Client disconnected'
      break
    end
    all_clients.each { |dest| send_msg(msg, dest) if dest != client }
  end
end

def send_msg(msg, dest)
  msg = '           -' + msg
  dest.puts msg
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
rescue
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

    all_clients.delete(client)

    Thread.current.kill
    threads.delete(Thread.current)
  end
end

threads.each(&:join)
