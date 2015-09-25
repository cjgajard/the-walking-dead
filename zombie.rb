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
    @x = posx || Random.rand($world_width/2)
    @y = posy || Random.rand($world_height/2)
    @@group << self
  end

  def to_s
    'Braaaaains!'
  end

  def kill?(person)
    if beside? person
      person.attacking_zombies += 1
      if person.perro && person.attacking_zombies <= 3
        puts " >  #{person.perro.name} te ha defendido matando a #{@name}"
        @@group.delete(self)
        return false
      else
        if person.perro && person.attacking_zombies > 3
          puts " >  #{person.name}, #{person.perro.name} no te ha podido defender de tantos zombies"
          person.perro.owner = nil
        end
        person.zombified_by self
        @@group << Zombie.new(person.name)
        return true
      end
    else
      return false
    end
  end
end
