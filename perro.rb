class Perro
	attr_reader :name, :x, :y
	attr_accessor :owner

	def initialize(name = nil, posx = nil, posy = nil)
		@name = name || "Dog"
		@x = posx || Random.rand($world_width)
		@y = posy || Random.rand($world_height)
		@owner = nil
	end

	def walk
		if @owner
			@x = @owner.x
			@y = @owner.y
		else
			@x = ( @x + Random.rand(-2..2) ) % $world_width
			@y = ( @y + Random.rand(-2..2) ) % $world_height
		end
	end

	def beside?(thing)
		(thing.x - @x).abs.between?(0,1) || (thing.y - @y).abs.between?(0,1)
	end

	def killed_by?(zombies)
		zombies.each do |zombie|
			if @owner.nil? && beside?(zombie)
				puts " #{@name} ha sido asesinado por #{zombie.name}"
				return true
			end
		end
		false
	end
end