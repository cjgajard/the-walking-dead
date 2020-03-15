require_relative 'person.rb'
require_relative 'zombie.rb'
require_relative 'dog.rb'
require_relative 'weapon.rb'

MAP = [20,20]

5.times do |i|
  Dog.new if i < 2
  Person.new
  Zombie.new
  Gun.new
  # Weapon.group << (1..10).map {|i| Sword.new}
end

dias = 0
while Person.total > 0 && Zombie.total > 0
  dias += 1
  puts "Día #{dias}, Personas: #{Person.total}, Zombies: #{Zombie.total}, Perros: #{Dog.total}"

  Creature.list.each do |c|
    puts "\t#{c}"
    print "\t\t* Moved from #{c.location}"
    c.walk
    puts " to #{c.location}"
    c.check
    Creature.list.each { |c2| c.attack c2 }
  end

  # input = gets
  # break if input =~ /exit/i
end

if Person.total == 0 && Zombie.total > 0
  puts "GAME OVER.\n  La humanidad ha sido aniquilada en #{dias} días"
elsif Person.total > 0 && Zombie.total == 0
  puts "VICTORY!\n  #{Person.total} personas y #{Dog.total} perros han sobrevivido a #{dias} días de epidemia"
end
