require 'socket'

def client_handler(client, all_clients)
  loop do
    msg = client.gets
    break if msg.nil?

    all_clients.each { |i| i.puts msg if i != client }
  end
end

server = TCPServer.new('127.0.0.1', 1111)
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
puts 'Server stop'
