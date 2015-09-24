class Zombie
	attr_reader :name, :x, :y

	def initialize(name = nil, posx = nil, posy = nil)
		@name = name || "Comecerebros"
		@x = posx || Random.rand(5)
		@y = posy || Random.rand(5)
	end

	def walk
		@x = ( @x + Random.rand(-1..1) ) % $map_width
		@y = ( @y + Random.rand(-1..1) ) % $map_height
	end

	#def to_s
	#	'Braaaaains!'
	#end
end
