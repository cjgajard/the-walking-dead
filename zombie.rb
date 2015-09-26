class Zombie < Creature
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
      person.attacking_zombies += 1
      if (person.weapon && person.weapon.headshot?(self)) \
      || (person.perro && person.perro.attack?(self))
        puts "  : Mataste a #{@name}"
        @@group[@@group.index(self)] = nil
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
