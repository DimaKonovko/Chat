require 'socket'

# Trying to connect to server
print 'Enter IP: '
ip = gets.chomp
print 'Enter port: '
port = gets.chomp

begin
  socket = TCPSocket.new(ip, port)
rescue
  abort 'ERROR! Connection failed'
end

# Main client logic
Thread.new do
  loop do
    puts socket.gets.chomp
  end
end

loop do
  msg = gets.chomp
  socket.puts msg
end
