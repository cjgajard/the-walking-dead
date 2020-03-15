require_relative 'creature.rb'

class Zombie < Creature
  def initialize(
    name = self.class.new_name,
    posx = Random.rand(MAP[0]/4),
    posy = Random.rand(MAP[1]/4)
  )
    super(name, posx, posy)
  end

  def self.new_name
    "Comecerebros #{index}"
  end

  def check
    puts "\t\t> Braaaaains!"
  end

  def attack(creature)
    return unless beside?(creature)
    case creature
    when Person
      puts "\t\t> Ha convertido en zombie a #{creature}"
      creature.killed
    when Dog
      puts "\t\t> Ha asesinado a #{creature}"
      creature.killed
    end
  end
end
