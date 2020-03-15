require_relative 'creature.rb'

class Dog < Creature
  def initialize(name = nil, posx = nil, posy = nil)
    name ||= "Perro #{self.class.index}"
    super(name, posx, posy)
  end

  def walk(step = 3)
    super(step)
  end

  def attack(creature)
    return unless creature.is_a?(Zombie)
    return unless beside?(creature)
    Person.group.each do |person|
      next unless beside?(person)
      puts "\t\t* Defendió a #{person} matando a #{creature}"
      creature.killed
    end
  end

  def check
    puts "\t\t> ¡Guau guau!"
  end
end
