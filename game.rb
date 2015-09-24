# 面白い例題

# Un sistema de zombies con posición x,y
# Cuando los zombies esten cerca de las personas, le advierte
# Cuando estan al lado, la persona se transforma en zombie
# 5 Perros que se comen al zombie al atacar
# clase arma, esta botada, las personas pueden tomarla; sirve para defenderse del zombie 

require_relative 'persona.rb'
require_relative 'zombie.rb'

$map_width = 24
$map_height = 24

personas = []
10.times do |i|
	personas << Persona.new("Persona #{i+1}")
end

zombies = []
5.times do |i|
	zombies << Zombie.new("Mai #{i+1}")
end

turnos = 1

until personas.count == 0
	puts "Día #{turnos}, Personas: #{personas.count}, Zombies: #{zombies.count}"
	zombies.each(&:walk)
	#personas.each(&:walk)
	personas.each do |p|
		p.walk
		if p.killed_by? zombies
			personas.delete(p).name
			zombies << Zombie.new(p.name)
		end
	end
	turnos += 1
	#input = gets
	puts "\n\n\n"
end

puts "GAME OVER"
puts " La humanidad ha sido aniquilada en #{turnos} días"