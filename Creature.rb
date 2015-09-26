class Creature
  attr_reader :name, :x, :y
  def initialize(name = nil, posx = nil, posy = nil)
    @x = posx || Random.rand(MAP[0])
    @y = posy || Random.rand(MAP[1])
  end

  def walk(step = 1)
    step = step.abs
    @x = (@x + Random.rand(-step..step)) % MAP[0]
    @y = (@y + Random.rand(-step..step)) % MAP[1]
  end

  def close_to?(thing)
    (thing.x - @x).abs.between?(2,3) && (thing.y - @y).abs.between?(2,3)
  end

  def beside?(thing)
    (thing.x - @x).abs.between?(0,1) && (thing.y - @y).abs.between?(0,1)
  end

  def over?(thing)
    (thing.x - @x)==0 && (thing.y - @y)==1
  end
end