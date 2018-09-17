require_relative 'cell'
require_relative 'world'
require_relative 'seeds/random_seed'

class Conway
    def initialize
        @rand_seed = RandomSeed.new 20
    end

    def new_world seed = @rand_seed.get_seed
        World.new seed
    end

    def new_seed n = 20
        RandomSeed.new n
    end
end