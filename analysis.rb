require_relative 'game.rb'
rango = (5..10)
s = rango.inject { |sum| sum + game } / rango.count

puts "Dias promedio: #{s}"