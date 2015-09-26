class Person < Creature
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

  attr_accessor :dog, :attacking_zombies, :weapon
  def initialize(name = nil, posx = nil, posy = nil)
    super
    @name = name || "Persona #{@@group.size+1}"
    @dog, @weapon = nil, nil
    @attacking_zombies = 0
    @@group << self
  end

  def to_s
    "#{@name} --> (#{@x}, #{@y})"
  end

  def danger?(zombie)
    if close_to? zombie
      puts "  : ¡Cuidado! ¡#{zombie.name} está cerca!" 
      return true
    else
      return false
    end
  end

  def zombified_by(zombie)
    puts "  : Has sido convertido en zombie por #{zombie.name}"
    @@group[@@group.index(self)] = nil
  end

  def meet?(dog)
    if @dog.nil? && dog.owner.nil? && beside?(dog)
      @dog = dog
      dog.owner = self
      puts "  : Has adoptado a #{@dog.name}"
    end
  end

  def found?(weapon)
    if @weappon.nil? && over?(weapon)
      @weapon = weapon
      puts "  : Has encontrado un arma"
    end
  end
end