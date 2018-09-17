class RandomSeed
    def initialize size
        @seed = nil
        @size = size
        self.generate
    end

    def get_seed
        @seed
    end

    def generate size = @size
        r = Random.new
        @seed = Array.new(size) {Array.new(size) {r.rand 0..1}}
    end
end