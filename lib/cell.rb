class Cell 
    def initialize position, alive
        @alive = alive
        @position = position # Position must be a hash {:x => 0, :y => 0}
    end

    def is_alive?
        @alive
    end

    def revive
        @alive  = true
    end

    def kill
        @alive = false
    end

end