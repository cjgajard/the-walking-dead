class Perro < Creature
  @@group = []
  def self.group
    @@group
  end
  def self.group=(new_group)
    @@group = new_group
  end

  def self.total
    @@group.size
  end

  attr_accessor :owner
  def initialize(name = nil, posx = nil, posy = nil)
    super
    @name = name || "Dog #{@@group.size+1}"
    @owner = nil
    @@group << self
  end

  def walk(step=1)
    if @owner
      @x = @owner.x
      @y = @owner.y
    else
      super
    end
  end

  def killed_by?(zombies)
    zombies.each do |zombie|
      if @owner.nil? && beside?(zombie)
        puts " :#{@name} ha sido asesinado por #{zombie.name}"
        @@group.delete(self)
        break
      end
    end
  end

  def to_s
    "¡Guau guau!"
  end
end
