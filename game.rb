require_relative 'Creature.rb'
require_relative 'persona.rb'
require_relative 'zombie.rb'
require_relative 'perro.rb'

$world_width = 20
$world_height = 20

pers = 5
Persona.group = (1..pers).map {|i| Persona.new}
Zombie.group = (1..10).map {|i| Zombie.new}
Perro.group = (1..3).map {|i| Perro.new}

dias = 0
while Persona.total > 0 && Zombie.total > 0
  dias += 1
  puts "Día #{dias}, Personas: #{Persona.total}, Zombies: #{Zombie.total}, Perros: #{Perro.total}"

  Zombie.group.each(&:walk)

  Perro.group.each do |perro|
    perro.walk
    perro.killed_by? Zombie.group
  end

  Persona.group.each do |p|
    puts " :#{p}"
    p.walk
    Perro.group.each { |perro| p.meet? perro }
    zombie_presence, killed, p.attacking_zombies = false, false, 0
    Zombie.group.each do |zombie|
      killed = zombie.kill? p
      break if killed
      zombie_presence = true if p.danger? zombie
    end
    if (!zombie_presence && p.attacking_zombies == 0)
      puts " >  Todo está tranquilo por aquí\n"
    end
  end
  #input = gets
  puts ""
end

if Persona.total == 0
  puts "GAME OVER. La humanidad ha sido aniquilada en #{dias} días"
else
  puts "VICTORY!\n #{Persona.total} personas y #{Perro.total} perros han sobrevivido a #{dias} días de epidemia"
end
