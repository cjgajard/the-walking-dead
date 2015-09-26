class Zombie < Creature
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
  
  def initialize(name = nil, posx = nil, posy = nil)
    super
    @name = name || "Comecerebros #{@@group.size+1}"
    @x = posx || Random.rand(MAP[0]/4)
    @y = posy || Random.rand(MAP[0]/4)
    @@group << self
  end

  def to_s
    'Braaaaains!'
  end

  def kill?(person)
    if beside? person
      if person.perro && person.perro.attack?(self)
        @@group[@@group.index(self)] = nil
        return false
      else
        person.zombified_by self
        @@group << Zombie.new(person.name)
        return true
      end
    else
      return false
    end
  end
end
