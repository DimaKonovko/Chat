require 'socket'

socket = TCPSocket.new('127.0.0.1', 1111)

Thread.new do
  loop do
    puts socket.gets.chomp
  end
end

loop do
  msg = gets.chomp
  socket.puts msg
end
