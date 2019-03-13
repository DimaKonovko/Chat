require 'socket'

begin
  socket = TCPSocket.new('127.0.0.1', 1111)
rescue
  abort 'ERROR! Connection failed'
end

Thread.new do
  loop do
    puts socket.gets.chomp
  end
end

loop do
  msg = gets.chomp
  socket.puts msg
end
