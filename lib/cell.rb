class Cell 
    def initialize alive
        @alive = alive
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