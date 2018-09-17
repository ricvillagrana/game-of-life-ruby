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
        neighbors_matrix.each_with_index do |row, x|
            row.each_with_index do |neighbors, y|
                neighbors = self.count_neighbors x, y
            end
        end
        # Second step: apply rules
        # Third step: update @world
    end
    
    def count_neighbors position_x, position_y
        total_neighbors = 0
        for x in (position_x - 1)..(position_x + 1)
            for y in (position_y - 1)..(position_y + 1)
                total_neighbors += 1 if !(x < 0 or x >= @size[:x] or y < 0 or y >= @size[:y] or (position_x == x && position_y == y)) and @world[x][y].is_alive?
            end
        end
        total_neighbors
    end
    
end