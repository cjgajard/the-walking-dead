class Persona < Creature
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

  attr_accessor :perro, :attacking_zombies, :weapon
  def initialize(name = nil, posx = nil, posy = nil)
    super
    @name = name || "Persona #{@@group.size+1}"
    @perro, @weapon = nil, nil
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

  def meet?(perro)
    if @perro.nil? && perro.owner.nil? && beside?(perro)
      @perro = perro
      perro.owner = self
      puts "  : Has adoptado a #{@perro.name}"
    end
  end

  def found?(weapon)
    if @weappon.nil? && over?(weapon)
      @weapon = weapon
      puts "  : Has encontrado un arma"
    end
  end
end