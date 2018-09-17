require_relative 'cell'
class World
    def initialize seed
        @size = {
            :x => seed.first.size,
            :y => seed.size
        }
        @world = self.convert_seed_into_world seed
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

end