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
      if (person.weapon && person.weapon.kill?(self)) \
      || (person.dog && person.dog.attack?(self))
        puts "  : Mataste a #{@name}"
        @@group[@@group.index(self)] = nil
        return false
      else
        person.zombified_by self
        Zombie.new(person.name) # Zombie.new() automatically add new zombie to Zombie.group!!
        return true
      end
    end
  end
end
