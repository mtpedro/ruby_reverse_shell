require 'socket' #socket from std

PORT = "3000";

class Client 
	def initialize(client)
		@client = client	
	end

	def handle() #handles client connections
		print("new client!\n");

		loop do
			print("$> ")
			command = gets.to_s
			@client.write(command)
			out = @client.gets.chomp;
			puts(out.to_s)
		end
		
		@client.close()
	end
end

def start()
	sock = TCPServer.new(PORT) # bind to PORT
	puts("listening on port #{PORT.to_s}")
	
	loop do
		client = Client.new(sock.accept) # creates client obj
		client.handle()
	end
end

start();
