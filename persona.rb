class Persona < Creature
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

  attr_accessor :perro, :attacking_zombies
  def initialize(name = nil, posx = nil, posy = nil)
    super
    @name = name || "Persona #{@@group.size+1}"
    @perro = nil
    @attacking_zombies = 0
    @@group << self
  end

  def to_s
    "#{@name} está en la posición #{@x}, #{@y}"
  end

  def danger?(zombie)
    if close_to? zombie
      puts " >  ¡Cuidado! ¡#{zombie.name} está cerca!" 
      true
    else
      false
    end
  end

  def zombified_by(zombie)
    puts " >  Ha sido convertido en zombie por #{zombie.name}"
    @@group.delete(self)
  end

  def meet?(perro)
    if @perro.nil? && perro.owner.nil? && beside?(perro)
      @perro = perro
      perro.owner = self
      puts " >  Ha adoptado a #{@perro.name}"
    end
  end
end