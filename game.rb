# READY Un sistema de zombies con posición x,y
# READY Cuando los zombies esten cerca de las personas, le advierte
# READY Cuando estan al lado, la persona se transforma en zombie
# 5 Perros que se comen al zombie al atacar humanos
# clase arma, esta botada, las personas pueden tomarla; sirve para defenderse del zombie 

require_relative 'persona.rb'
require_relative 'zombie.rb'
require_relative 'perro.rb'

$world_width = 64
$world_height = 64

dias = 0
personas = (1..10).map {|i| Persona.new("Persona #{i+1}")}
zombies = (1..10).map {|i| Zombie.new("Maida #{i+1}")}
perros = (1..3).map {|i| Perro.new("Perro #{i+1}")}


while personas.count > 0 && zombies.count > 0
	dias += 1
	puts "Día #{dias}, Personas: #{personas.count}, Zombies: #{zombies.count}, Perros: #{perros.count}"

	zombies.each(&:walk)

	perros.each do |perro|
		perro.walk
		perros.delete(perro) if perro.killed_by? zombies
	end

	personas.each do |p|
		p.walk
		p.meet? perros

		dangerous_zombies = 0
		zombies.each do |zombie|
			if p.beside? zombie
				dangerous_zombies += 10
				if p.perro && dangerous_zombies < 30
					puts " #{p.name}, #{p.perro.name} te ha defendido matando a #{zombie.name}"
					zombies.delete(zombie)
				else
					if p.perro && dangerous_zombies >= 30
						puts " #{p.name}, #{p.perro.name} te ha intentado defender de #{zombie.name}, pero ha sido asesinado"
						perros.delete(p.perro)
						p.perro = nil
					end
					puts " #{p.name} ha sido convertido en zombie por #{zombie.name}"
					personas.delete(p)
					zombies << Zombie.new(p.name)
					break
				end
			elsif p.close_to? zombie
				dangerous_zombies += 1
				puts " ¡Cuidado, #{p.name}! ¡#{zombie.name} está cerca!"
			end
		end
		print " #{p.name}, todo está tranquilo por aquí\n" if dangerous_zombies == 0
	end
	
	#input = gets
	puts ""
end

if personas.count == 0
	puts "GAME OVER\n La humanidad ha sido aniquilada en #{dias} días"
else
	puts "VICTORY!\n #{personas.count} personas y #{perros.count} perros han sobrevivido a #{dias} días de epidemia"
end
