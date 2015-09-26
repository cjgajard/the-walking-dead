require_relative 'Creature.rb'
require_relative 'Person.rb'
require_relative 'Zombie.rb'
require_relative 'Dog.rb'
require_relative 'Weapon.rb'

MAP = [20,20]

Person.group = (1..10).map {|i| Person.new}
Zombie.group = (1..10).map {|i| Zombie.new}
Dog.group = (1...5).map {|i| Dog.new}
Weapon.group = (1..10).map {|i| Gun.new}
# Weapon.group << (1..10).map {|i| Sword.new}

dias = 0
while Person.total > 0 && Zombie.total > 0
  dias += 1
  puts "Día #{dias}, Personas: #{Person.total}, Zombies: #{Zombie.total}, Perros: #{Dog.total}"

  Zombie.group.each(&:walk)

  Dog.group.each do |dog|
    dog.walk 3
    Zombie.group.each { |zombie| break if dog.killed_by?(zombie) }
  end

  Person.group.each do |person|
    puts "  #{person}"
    person.walk 2
    Dog.group.each { |dog| person.meet? dog }
    Weapon.group.each { |weapon| person.found? weapon}
    zombie_presence, killed, person.attacking_zombies = false, false, 0
    Zombie.group.each do |zombie|
      killed = zombie.kill? person
      break if killed
      zombie_presence = true if person.danger? zombie
    end
    if (!zombie_presence && person.attacking_zombies == 0)
      puts "  : Todo está tranquilo por aquí"
    end
  end

  #input = gets
  puts ''
end

if Person.total == 0
  puts "GAME OVER.\n  La humanidad ha sido aniquilada en #{dias} días"
else
  puts "VICTORY!\n  #{Person.total} personas y #{Dog.total} perros han sobrevivido a #{dias} días de epidemia"
end
