
class Computer
    @@users = {}
    def initialize(username, password)
        @username = username
        @password = password
        @@users[username] = password
        @files = {}
    end
    
    def create(filename)
        time = Time.now
        @files[filename] = time
        puts "New file created! Filename: #{filename}, Username: #{@username}, Time: #{time}"
    end
    
    def Computer.get_users
        return @@users
    end
end

my_computer = Computer.new("Hotdogs", "Cranberries")
my_computer.create("Sauce")