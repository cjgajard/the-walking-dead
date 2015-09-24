class Zombie
	attr_reader :name, :x, :y

	def initialize(name = nil, posx = nil, posy = nil)
		@name = name || "Comecerebros"
		@x = posx || Random.rand($world_width/2)
		@y = posy || Random.rand($world_height/2)
	end

	def walk
		@x = ( @x + Random.rand(-1..1) ) % $world_width
		@y = ( @y + Random.rand(-1..1) ) % $world_height
	end

	#def to_s
	#	'Braaaaains!'
	#end
end
