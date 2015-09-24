class Persona
	attr_reader :name, :x, :y
	attr_accessor :perro

	def initialize(name = nil, posx = nil, posy = nil)
		@name = name || "John Doe"
		@x = posx || Random.rand($world_width)
		@y = posy || Random.rand($world_height)
		@perro = nil
	end

	def walk
		@x = ( @x + Random.rand(-2..2) ) % $world_width
		@y = ( @y + Random.rand(-2..2) ) % $world_height
	end

	def to_s
		"#{name} está en la posición #{x}, #{y}"
	end

	def close_to?(thing)
		(thing.x - @x).abs.between?(2,3) || (thing.y - @y).abs.between?(2,3)
	end

	def beside?(thing)
		(thing.x - @x).abs.between?(0,1) || (thing.y - @y).abs.between?(0,1)
	end

	def zombified_by?(zombies)
		dangerous_zombies = 0
		zombies.each do |zombie|
			if close_to? zombie
				dangerous_zombies += 1
				puts " ¡Cuidado, #{@name}! ¡#{zombie.name} está cerca!"
			elsif beside? zombie
				dangerous_zombies += 10
				if @perro && dangerous_zombies < 30
					puts " #{@name}, #{@perro.name} te ha defendido matando a #{zombie.name}"
				else
					if dangerous_zombies >= 30
						puts " #{@name}, #{@perro.name} te ha intentado defender de #{zombie.name}, pero ha sido asesinado"
					end
					puts " #{@name} ha sido convertido en zombie por #{zombie.name}"
					return true
				end
			end
		end
		print " #{@name}, todo está tranquilo por aquí\n" if dangerous_zombies == 0
		return false
	end

	def meet?(perros)
		perros.each do |perro|
			if @perro.nil? && perro.owner.nil? && beside?(perro)
				@perro = perro
				perro.owner = self
				puts " #{@name}, has adoptado a #{@perro.name}"
			end
		end
	end
end