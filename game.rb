require_relative 'Creature.rb'
require_relative 'persona.rb'
require_relative 'zombie.rb'
require_relative 'perro.rb'
require_relative 'Weapon.rb'

MAP = [20,20]

Persona.group = (1..5).map {|i| Persona.new}
Zombie.group = (1..20).map {|i| Zombie.new}
Perro.group = (1...2).map {|i| Perro.new}
Weapon.group = (1..10).map {|i| Gun.new}
# Weapon.group << (1..10).map {|i| Sword.new}

dias = 0
while Persona.total > 0 && Zombie.total > 0
  dias += 1
  puts "Día #{dias}, Personas: #{Persona.total}, Zombies: #{Zombie.total}, Perros: #{Perro.total}"

  Zombie.group.each(&:walk)

  Perro.group.each do |perro|
    perro.walk 3
    perro.killed_by? Zombie.group
  end

  Persona.group.each do |p|
    puts "  #{p}"
    p.walk 2
    Perro.group.each { |perro| p.meet? perro }
    Weapon.group.each { |weapon| p.found? weapon}
    zombie_presence, killed, p.attacking_zombies = false, false, 0
    Zombie.group.each do |zombie|
      killed = zombie.kill? p
      break if killed
      zombie_presence = true if p.danger? zombie
    end
    if (!zombie_presence && p.attacking_zombies == 0)
      puts "  : Todo está tranquilo por aquí"
    end
  end

  #input = gets
  puts ''
end

if Persona.total == 0
  puts "GAME OVER.\n  La humanidad ha sido aniquilada en #{dias} días"
else
  puts "VICTORY!\n  #{Persona.total} personas y #{Perro.total} perros han sobrevivido a #{dias} días de epidemia"
end
