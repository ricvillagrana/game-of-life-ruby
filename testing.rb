require_relative 'lib/universe.rb'
require_relative 'lib/seeds/random_seed'

rand_seed = RandomSeed.new 20
world = Universe.new rand_seed.get_seed

world.show