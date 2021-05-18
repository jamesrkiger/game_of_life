def ArrayDuplicator(array)
    newarray = Array.new(array.length) {Array.new(array[0].length) {"*"}}
        arraylength = array.length
        (0...arraylength).each do |x|
            (0...arraylength).each do |y|
                newarray[x][y] = array[x][y]
            end
        end
        return newarray
    end 
#Welcome system
system 'cls'
File.foreach("./LifeAscii.txt") { |line| puts line }
puts
puts "Welcome, how many iterations would you like to see?"
runtime = gets.chomp.to_i

puts "What shape would you like to see? \n
(a) Blinker
(b) r-pentimino
(c) Figure 8
(d) Surprise me"
shape = gets.chomp.downcase 

#initiate process
system 'cls'

puts

# create grid
dead = 1
live = 0
dead_display = ". "
live_display = "0 "
grid = Array.new(20) {Array.new(20){dead}}
live_count = 0
display_size = grid.length-2 

if shape == "a"
    #blinker
    grid[3][4] = live
    grid[3][5] = live
    grid[3][6] = live
elsif shape == "b"
    #r-pentimino 
    grid[8][10] = live
    grid[9][8] = live
    grid[8][9] = live
    grid[9][9] = live
    grid[10][9] = live
elsif shape == "c"
    #figure 8
    grid[8][8] = live
    grid[8][9] = live
    grid[8][10] = live
    grid[9][8] = live
    grid[9][9] = live
    grid[9][10] = live
    grid[10][8] = live
    grid[10][9] = live
    grid[10][10] = live
    grid[11][11] = live
    grid[11][12] = live
    grid[11][13] = live
    grid[12][11] = live
    grid[12][12] = live
    grid[12][13] = live
    grid[13][11] = live
    grid[13][12] = live
    grid[13][13] = live
elsif shape == "d"
    #randomizer
    (1..display_size).each do |x|
        (1..display_size).each do |y|
            grid[x][y] = live if rand(2) == 1
        end
    end
end

#set up duplicate grid for processing
working_grid = ArrayDuplicator(grid)
#Display initial positions
(1..display_size).each do |x|
    (1..display_size).each do |y|
        print live_display if grid[x][y] == live
        print dead_display if grid[x][y] == dead
    end
    puts
end
#cycle through cells, determine what to do with them

#while loop includes whole game process and display
while runtime >= 0
    system 'cls'
#for each cell, take count of how many live cells are in a 3x3 square centered on it
    (1..display_size).each do |x|
        live_count = 0
        (1..display_size).each do |y|
            live_count = 0
            (x-1..x+1).each do |x_check|
                    (y-1..y+1).each do |y_check|    
                        if (grid[x_check][y_check] == live)
                            live_count += 1
                        end
                    end
            end
            #Use count to determine what cell state should be in next iteration
            if grid[x][y] == live
                if (((live_count - 1) == 2) || ((live_count-1) == 3))
                    working_grid[x][y] = live
                else
                    working_grid[x][y] = dead
                end
            elsif (grid[x][y] == dead)
                if (live_count == 3)
                    working_grid[x][y] = live
                else
                    working_grid[x][y] = dead
                end
            end        
        end

    end
    #print new iteration
    (1..display_size).each do |x|
        (1..display_size).each do |y|
            print live_display if grid[x][y] == live
            print dead_display if grid[x][y] == dead
        end
        puts
    end
    #Switch grid state to working_grid state
    grid = ArrayDuplicator(working_grid)

    puts
    #pause for viewing
    sleep 0.25
    runtime -= 1

end
system("cls")
puts "Thank you for playing"
puts
puts "Brought to you by:
Gret
Justice
David
Yousef
James"


