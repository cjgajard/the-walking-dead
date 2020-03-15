require_relative 'creature.rb'

class Person < Creature
  # attr_accessor :dog, :attacking_zombies
  attr_accessor :weapon

  def initialize(name = "Persona #{self.class.index}", posx = nil, posy = nil)
    super(name, posx, posy)
    # @dog = nil
    @weapon = nil
    # @attacking_zombies = 0
  end

  def check
    if (w = found_weapon?)
      puts "\t\t* Ha encontrado #{w}"
      @weapon = w
    end
    if (z = danger?)
      puts "\t\t> ¡Mierda! ¡#{z} está cerca!"
    else
      puts "\t\t> Todo está tranquilo por aquí"
    end
  end

  def walk(step = 2)
    super(step)
  end

  def attack(creature)
    return unless creature.is_a?(Zombie)
    return unless beside?(creature)
    return unless @weapon
    puts "\t\t* Ha matado a #{creature}"
    creature.killed
  end

  private

  def found_weapon?
    Weapon.group.each { |w| return w if over?(w) }
    return nil
  end

  def danger?
    Zombie.group.each { |z| return z if close_to?(z) }
    return nil
  end
end
