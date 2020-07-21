require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'

puts "------------------------------------------------
|Bienvenue sur 'ILS VEULENT TOUS MA POO' !      |
|Le but du jeu est d'être le dernier survivant !|
-------------------------------------------------"

puts "Quel est ton nom ?"
user = HumanPlayer.new(gets.chomp.to_s)
enemies = Array.new
player1 = Player.new("Josiane")
player2 = Player.new("José")
enemies << player1
enemies << player2

while user.life_points > 0 && (player1.life_points > 0 || player2.life_points > 0)  
	user.show_state
	puts "Quelle action veux-tu effectuer ?"
	puts "\na - chercher une meilleure arme"
	puts "s - chercher à se soigner"
	puts "\nattaquer un joueur en vue :"
	print "0 - "
	if player1.life_points <= 0
			print "#{player1.name} est dead"
		else 
			player1.show_state 
		end
	print "\n1 - "
	if player2.life_points <= 0
			puts "#{player2.name} est dead" #pour éviter d'afficher que player a -4 pts de vie
		else 
			player2.show_state 
		end
	puts""
	choice = gets.chomp.to_s
	if (choice == "a")
		user.search_weapon 
	elsif (choice == "s")
	 	user.search_health_pack
	elsif choice == "0"
		user.attacks(player1)
		player1.show_state 
	elsif choice == "1"
		user.attacks(player2)
		player2.show_state
	end
	enemies.each {|i| i.life_points > 0 ? i.attacks(user) : nil }

end

if (user.life_points > 0)
	puts "Bravo ! Tu as gagné !"
else 
	puts "Loser ! Tu as perdu"
end






















