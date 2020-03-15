require_relative 'groupable.rb'

class Creature
  @@list = []
  attr_reader :name, :x, :y
  extend Groupable

  def initialize(name = nil, posx = nil, posy = nil)
    @name = name
    @x = posx || Random.rand(MAP[0])
    @y = posy || Random.rand(MAP[1])
    self.class.register self
    @@list << self
  end

  def self.list
    return @@list
  end

  def walk(step = 1)
    step = step.abs
    @x = (@x + Random.rand(-step..step)) % MAP[0]
    @y = (@y + Random.rand(-step..step)) % MAP[1]
  end

  def location
    "(#{x},#{y})"
  end

  def to_s
    name
  end

  def close_to?(thing)
    (thing.x - @x).abs.between?(2,3) && (thing.y - @y).abs.between?(2,3)
  end

  def beside?(thing)
    (thing.x - @x).abs.between?(0,1) && (thing.y - @y).abs.between?(0,1)
  end

  def over?(thing)
    (thing.x == @x) and (thing.y == @y)
  end

  def killed
    self.class.unregister(self)
    @@list.delete(self)
  end
end
