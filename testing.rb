require_relative 'lib/world'
require_relative 'lib/seeds/random_seed'

rand_seed = RandomSeed.new 20
world = World.new rand_seed.get_seed

world.show

puts world.count_neighbors 5,5