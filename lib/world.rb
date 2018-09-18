require_relative 'cell'
require 'pry'

# Class World
class World
  def initialize(seed)
    @size = {
      x: seed.first.size,
      y: seed.size
    }
    @world = convert_seed_into_world seed
    @neighbors_matrix = Array.new(@size[:x]) { Array.new(@size[:y]) { 0 } }
  end

  def show
    horizontal_line = '══' * @size[:x]
    print "╔#{horizontal_line}╗\n"
    @world.map do |row|
      print '║' # Left edge
      row.map { |cell| print cell.alive? ? '██' : '  ' }
      print "║\n" # Right edge
    end
    print "╚#{horizontal_line}╝\n"
  end

  def convert_seed_into_world(seed)
    seed.map do |row|
      row.map do |cell|
        Cell.new cell == 1
      end
    end
  end
  
  def next_generation
    # First step: count neighbors
    @world.each_with_index do |row, x|
      row.each_with_index do |_, y|
        @neighbors_matrix[x][y] = count_neighbors x, y
      end
    end
    # Second step: apply rules
    # We have to consider this is going to take
    # @world and @neighbors_matrix to evaluate
    apply_rules
    # Third step: update @world
    # Done within method apply_rules
  end

  def count_neighbors(position_x, position_y)
    total_neighbors = 0
    rows = ((position_x - 1)..(position_x + 1)).to_a
    rows.delete_if { |x| x < 0 || x >= @size[:x] }

    cols = ((position_y - 1)..(position_y + 1)).to_a
    cols.delete_if { |y| y < 0 || y >= @size[:y] }

    rows.each do |x|
      cols.each do |y|
        # Check if is not out of bounds
        if (position_x != x || position_y != y) && @world[x][y].alive?
          total_neighbors += 1
        end
      end
    end
    total_neighbors
  end

  def apply_rules
    @neighbors_matrix.each_with_index do |row, x|
      row.each_with_index do |neighbors, y|
        cell = @world[x][y]
        check_rule(neighbors, x, y) ? cell.revive : cell.kill
      end
    end
  end

  def check_rule(neighbors, pos_x, pos_y)
    alive = false
    if @world[pos_x][pos_y].alive? # Any live cell ...
      # ... with fewer than two live neighbors dies, as if by under population.
      # ... with two or three live neighbors lives on to the next generation.
      # ... with more than three live neighbors dies, as if by overpopulation.
      alive = [2, 3].include? neighbors
    else
      # Any dead cell with exactly three live neighbors becomes a live cell,
      # as if by reproduction.
      alive = neighbors == 3
    end
    # then...
    alive
  end
end
