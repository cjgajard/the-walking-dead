class Weapon
	@@group = []
  def self.group
    @@group.compact
  end
  def self.group=(new_group)
    @@group = new_group
  end

  def self.total
    @@group.compact.size
  end
  
	attr_reader :x, :y
	def initialize(posx=nil, posy=nil)
		@x = posx || Random.rand(MAP[0])
    @y = posy || Random.rand(MAP[1])
  end
end

class Gun < Weapon
	def headshot?(zombie)
		puts "  : Intestas defenderte de #{zombie.name}"
		3.times do |i|
			print "  : Disparo #{i+1}: "
			case Random.rand(3)
			when 0
			  puts "HEEEADSHOOOT !!"
			  return true
			when 1
			  puts "Le diste en una de sus piernas pero siguó arrastrandose hacia tí"
			when 2
			  puts "La bala no le llegó."
			end
		end
		return false
	end
end