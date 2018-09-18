# Cell class
class Cell
  def initialize(alive = false)
    @alive = alive
  end

  def alive?
    @alive
  end

  def revive
    @alive = true
  end

  def kill
    @alive = false
  end
end
