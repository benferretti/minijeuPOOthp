require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'


player1 = Player.new("Josiane")
player2 = Player.new("José")

while player2.life_points > 0 && player1.life_points > 0
	puts "\nVoici l'état de chaque joueur :"
	player1.show_state
	player2.show_state
	puts "\nPassons à la phase d'attaque :"
	player1.attacks(player2)
	if player2.life_points <= 0
		puts "le joueur #{player2.name} a été tué !"
		break
	end
	player2.attacks(player1)
	if player1.life_points <= 0
		puts "le joueur #{player2.name} a été tué !"
		break
	end
end
