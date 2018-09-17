require_relative 'cell'
class World
    def initialize seed
        @size = {
            :x => seed.first.size,
            :y => seed.size
        }
        @world = self.convert_seed_into_world seed
        @neighbors_matrix = Array.new(@size[:x]) {Array.new(@size[:y]) {0}}
    end
    
    def show
        output = "╔#{'══' * @size[:x]}╗\n"
        @world.map do |row|
            output += "║"; # Left edge
            row.map do |cell|
                output += cell.is_alive? ? "██" : "  " # Show ██ if cell is alive, nothing if dead
            end
            output += "║\n"; # Right edge
        end
        
        output += "╚#{'══' * @size[:x]}╝\n"
        puts output
    end
    
    def convert_seed_into_world seed
        seed.map do |row|
            row.map do |cell|
                Cell.new cell == 1 ?  true : false
            end
        end
    end
    
    def next_generation
        # First step: count neighbors
        @world.each_with_index do |row, x|
            row.each_with_index do |neighbors, y|
                @neighbors_matrix[x][y] = self.count_neighbors x, y
            end
        end
        # Second step: apply rules
        self.apply_rules # We have to consider this is going to take @world and @neighbors_matrix to avaluate
        # Third step: update @world
        # Done within method apply_rules
    end
    
    def count_neighbors position_x, position_y
        total_neighbors = 0
        for x in (position_x - 1)..(position_x + 1)
            for y in (position_y - 1)..(position_y + 1)
                # Check if is not out of bounds
                total_neighbors += 1 if !(x < 0 or x >= @size[:x] or y < 0 or y >= @size[:y] or (position_x == x && position_y == y)) and @world[x][y].is_alive?
            end
        end
        total_neighbors
    end

    def apply_rules
        @neighbors_matrix.each_with_index do |row, x|
            row.each_with_index do |neighbors, y|
                self.check_rule_for(neighbors, x, y) ? @world[x][y].revive : @world[x][y].kill
            end
        end
    end

    def check_rule_for neighbors, x, y
        alive = false
        if @world[x][y].is_alive? # Any live cell ...
            # ... with fewer than two live neighbors dies, as if by under population.
            alive = false if neighbors < 2
            # ... with two or three live neighbors lives on to the next generation.
            alive = true if neighbors == 2 or neighbors == 3
            # ... with more than three live neighbors dies, as if by overpopulation.    
            alive = false if neighbors > 3
        else
            # Any dead cell with exactly three live neighbors becomes a live cell, as if by reproduction.
            alive = true if neighbors == 3
        end
        # then...
        alive
    end
    
end