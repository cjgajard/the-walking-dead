class Persona
	attr_reader :name, :x, :y

	def initialize(name = nil, posx = nil, posy = nil)
		@name = name || "John Doe"
		@x = posx || Random.rand(10..20)
		@y = posy || Random.rand(10..20)
	end

	def walk
		@x = ( @x + Random.rand(-2..2) ) % $map_width
		@y = ( @y + Random.rand(-2..2) ) % $map_height
	end

	def to_s
		"#{name} está en la posición #{x}, #{y}"
	end

	def danger?(zombie)
		(zombie.x - @x).abs.between?(2,3) || (zombie.y - @y).abs.between?(2,3) ? true : false
	end

	def zombified_by?(zombie)
		(zombie.x - @x).abs.between?(0,1) || (zombie.x - @x).abs.between?(0,1) ? true : false
	end

	def killed_by?(zombies)
		dangerous_zombies = 0
		zombies.each do |zombie|
			if danger? zombie
				dangerous_zombies += 1
				puts " ¡Cuidado, #{@name}! ¡#{zombie.name} está cerca!"
			elsif zombified_by? zombie
				puts " #{@name} ha sido convertido en zombie por #{zombie.name}"
				return true
			end
		end
		print " #{@name}, todo está tranquilo por aquí\n" if dangerous_zombies == 0
		return false
	end
end