class Perro < Creature
  @@group = []
  def self.group
    @@group.compact
  end
  def self.group=(new_group)
    @@group = new_group
  end

  def self.total
    @@group.compact.size
  end

  attr_accessor :owner
  def initialize(name = nil, posx = nil, posy = nil)
    super
    @name = name || "Dog #{@@group.size+1}"
    @owner = nil
    @@group << self
  end

  def walk(step=3)
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
        puts "  #{@name} ha sido asesinado por #{zombie.name}"
        @@group[@@group.index(self)] = nil
        break
      end
    end
  end

  def attack?(zombie)
    if @owner
      puts "  : #{@name} te ha defendido matando a #{zombie.name}"
      puts "  : Has dejado de ser dueño de #{@name}"
      @owner = nil
      return true
    else
      return false
    end
  end

  def to_s
    "¡Guau guau!"
  end
end
