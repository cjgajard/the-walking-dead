class Creature
  attr_reader :name, :x, :y
  def initialize(name = nil, posx = nil, posy = nil)
    @x = posx || Random.rand($world_width)
    @y = posy || Random.rand($world_height)
  end

  def walk(step = 1)
    step = step.abs
    @x = (@x + Random.rand(-step..step)) % $world_width
    @y = (@y + Random.rand(-step..step)) % $world_height
  end

  def close_to?(thing)
    (thing.x - @x).abs.between?(2,3) && (thing.y - @y).abs.between?(2,3)
  end

  def beside?(thing)
    (thing.x - @x).abs.between?(0,1) && (thing.y - @y).abs.between?(0,1)
  end
end