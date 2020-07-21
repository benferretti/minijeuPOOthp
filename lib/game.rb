
#OK bon là on attaque un gros morceaux, courage !

class Game 
	attr_accessor :human_player, :enemies_in_sight, :players_left
	def initialize (name)
		@name = name
		@enemies_in_sight = Array.new
		@players_left = 10 #je fixe mon nombre total d'ennemis à 10 et je commence avec 0 ennemi au premier tour
		@user = HumanPlayer.new("Wolverine")
	end

	def new_players_in_sight
		if @players_left == 0 #j'ai préféré utilisé players_left en tant que nombre de players total en renfort
			puts("\nTous les joueurs sont déjà en vue\n")
		else
			randnumb = rand(1..6)
			if randnumb == 1
				print "Aucun nouveau joueur adverse n'arrive. "
			elsif randnumb > 1 && randnumb < 5
				name = "player" + rand(5..99).to_s #ma méthode pour généré des players avec des noms aléatoires (ex player25)
				print "Le joueur #{name} arrive. " 
				name = Player.new(name)
				@enemies_in_sight << name
				@players_left -= 1 #lorsqu'une nouvel ennemis arrive en vue, il y en a -1 en retrait
			elsif @players_left - 2 >= 0 #pour éviter d'envoyer 2 ennemis lorsqu'il y en a qu'un en renfort
				2.times do
					name = "player" + rand(5..99).to_s
					print "Le joueur #{name} arrive. "
					name = Player.new(name)
					@enemies_in_sight << name
					@players_left -= 1
			else #ça c'est la méthode pour en envoyer 2 si il y a plus bien de 1 ennemi en renfort restant
				name = "player" + rand(5..99).to_s
				print "Le joueur #{name} arrive. "
				name = Player.new(name)
				@enemies_in_sight << name
				@players_left -= 1
				end
			end
			puts ""
		end
	end


	def kill_player(player)
		@enemies_in_sight.delete(player)
	end

	def is_still_ongoing?
		if @user.life_points <= 0 || (@players_left == 0 && @enemies_in_sight.length == 0) #la partie s'arrête si le user meurt ou s'il y a plus d'ennemis en vue et en renfort
			false
		else 
			true
		end
	end

	def show_players
		@user.show_state
		print "Il y a #{@enemies_in_sight.length} ennemis en vue. "
		puts "Il en reste au total #{@players_left + @enemies_in_sight.length}.\n"
	end

	def menu
		puts "Quelle action veux-tu effectuer ?"
		puts "\na - chercher une meilleure arme"
		puts "s - chercher à se soigner"
		puts "\nattaquer un joueur en vue :"
		c = 0
		@enemies_in_sight.each do |i|
			print "\n#{c} - "
			if i.life_points > 0
					i.show_state 
			end
			c += 1
		end
		puts""
		@choice = gets.chomp.to_s
		puts""
	return @choice
	end

	def menu_choice (choice) #le menu évolue en fonction des ennemis en vue

		@choice = choice
		if (@choice == "a")
			@user.search_weapon 
		elsif (@choice == "s")
		 	@user.search_health_pack

		elsif @choice.to_i >= 0 && @choice.to_i < @enemies_in_sight.length
			@choice = choice.to_i
			@user.attacks(@enemies_in_sight[@choice])
			@enemies_in_sight[@choice].show_state 
			if @enemies_in_sight[@choice].life_points <= 0
				kill_player(@enemies_in_sight[@choice])
			end
		else
			puts "Mauvais choix ! Tant pis pour toi"
		end
	end

	def enemies_attack
		@enemies_in_sight.each {|i| i.life_points > 0 ? i.attacks(@user) : nil }
	end

	def end
		if (@user.life_points > 0)
			puts "\nBravo ! Tu as gagné !"
		else 
			puts "\nLoser ! Tu as perdu"
		end
	end

end





















