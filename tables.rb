class Tables
    attr_accessor :name
    attr_accessor :id
    attr_accessor :login
    attr_accessor :process
    attr_accessor :admin

    #constructor
    def initialize
        @name = ""
        @id = ""
        @login = ""
        @process = 0
        @admin = false
    end

    def prt
       
        puts "\n\n Name #{@name}"
        puts "\n#{@id}"
        puts "\n#{@login}"
        puts "\n#{@process}"
        puts "\n#{@admin}"
    end
end

# Main Program

# This is readying the files and looking for them
file = File.new("ps.txt","r")
file = File.new("id.txt","r")

# Listing all objects

places  = []

letter = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
letter = letter.split(//)

# Input coming from the pinky file
pinky = File.new("pinky.txt", "r")
cur_place = nil
# Looking at each line and reading it
while (line = pinky.gets)
    line.strip!            # Remove white space
    words = line.split     # Make a word array
cur_place = Tables.new
cur_place.id = words[0]
cur_place.name = words[1]
if letter.include?(words[2][0,1])
cur_place.name = cur_place.name+" "+words[2]
end
if words.last.include?(":")
cur_place.login = "localhost"
    else
cur_place.login = words.last
end
places << cur_place
end
pinky.close

#input from id text file

id = File.new("id.txt", "r")
while (line = id.gets)
    line.strip!
    words = line.split
    if words[0] == "root" || words[1] == "wheel"
        places.each do |a|
            if words[0]==a.id
                a.admin = true
            end
        end
    end
end
id.close

#ps text file

ps = File.new("ps.txt", "r")
while(line = ps.gets)
    line.strip!
    words = line.split
    places.each do |a|
        if words[0] == a.id
            a.process = a.process+1
        end
    end
end
ps.close          

#HTML 

fileHtml = File.new("table.html","w+")
fileHtml.write("<html>
    <head><title> Last Assignment </title></head>
    <body>
    <h3> Table </h3>
    <table>
        <tr>
            <th>Name</th>
            <th>Username</th>
            <th>Logged in from?</th>
            <th>Processes</th>
            <th>Admin</th>
            ") 

#HTML 
places.each do |a|
fileHtml.write("<tr>
    <td>#{a.name}</td>
    <td>#{a.id}</td>
    <td>#{a.login}</td>
    <td>#{a.process}</td>
    <td>#{a.admin}\n\n\n</td>
    </tr>")
end
fileHtml.write("</table>
    </body>
    </html>")

