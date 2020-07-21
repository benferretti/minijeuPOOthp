require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'



puts "Quel est ton nom ?"
my_game = Game.new(gets.chomp.to_s)

while my_game.is_still_ongoing?
	my_game.new_players_in_sight #comme je commence avec 0 ennemi en vue je commence par lancer le dé
	my_game.show_players
	my_game.menu_choice(my_game.menu)
	my_game.enemies_attack
end
my_game.end

