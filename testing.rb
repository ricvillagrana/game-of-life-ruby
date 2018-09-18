require_relative 'lib/conway'
require_relative 'lib/seeds/seeds.rb'

conway = Conway.new
rand_seed = conway.new_seed 40
world = conway.new_world generator # rand_seed.get_seed

loop do
  system 'clear' or system 'cls'
  world.show
  world.next_generation
  sleep 0.1
end
