# READY Un sistema de zombies con posición x,y
# READY Cuando los zombies esten cerca de las personas, le advierte
# READY Cuando estan al lado, la persona se transforma en zombie
# 5 Perros que se comen al zombie al atacar humanos
# clase arma, esta botada, las personas pueden tomarla; sirve para defenderse del zombie 

require_relative 'persona.rb'
require_relative 'zombie.rb'
require_relative 'perro.rb'

$world_width = 32
$world_height = 32

dias = 1
personas = (1..10).map {|i| Persona.new("Persona #{i+1}")}
zombies = (1..5).map {|i| Zombie.new("Maida #{i+1}")}
perros = (1..5).map {|i| Perro.new("Perro #{i+1}")}


while personas.count > 0 && zombies.count > 0
	puts "Día #{dias}, Personas: #{personas.count}, Zombies: #{zombies.count}, Perros: #{perros.count}"

	zombies.each(&:walk)

	perros.each do |perro|
		perro.walk
		perros.delete(perro) if perro.killed_by? zombies
	end

	personas.each do |p|
		p.walk
		p.meet? perros
		if p.zombified_by? zombies
			personas.delete(p)
			zombies << Zombie.new(p.name)
		end
	end

	dias += 1
	#input = gets
	puts "\n\n\n"
end

if personas.count == 0
	puts "GAME OVER"
	puts " La humanidad ha sido aniquilada en #{dias} días"
else
	puts "VICTORY!"
	puts " #{personas.count} personas y #{perros.count} perros han sobrevivido a #{dias} días de epidemia"
end
