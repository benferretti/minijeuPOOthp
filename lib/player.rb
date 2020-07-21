class Player 
	attr_accessor :name, :life_points

	def initialize (name)
		@name = name.to_s
		@life_points = 10
	end

	def show_state
		print "#{name} a #{life_points} points de vie. "
	end

	def gets_damage(damage)
		@life_points = @life_points - damage
		if @life_points <= 0
			puts "le joueur #{@name} a été tué !"
		end
	end

	def attacks(player_attacked)
		print "#{self.name} attaque le joueur #{player_attacked.name}. "
		damage = compute_damage
		player_attacked.life_points = player_attacked.life_points - damage
		puts "Il lui inflige #{damage} points de dommages !"
	end

	def compute_damage
		return rand(1..6)
	end
end

class HumanPlayer < Player
	attr_accessor :weapon_level

	def initialize (name)
		@name = name
		@life_points = 100
		@weapon_level = 1
	end

	def show_state
		print "#{name} a #{@life_points} points de vie et une arme de niveau #{@weapon_level}. "
	end	

	def compute_damage
		return rand(1..6) * @weapon_level
	end

	def search_weapon
		new_weapon_level = rand(1..6)
		print "Tu as trouvé une arme de niveau #{new_weapon_level}. "
		if new_weapon_level > weapon_level
			puts "Tu remplaces ton ancienne arme par ta nouvelle arme"
			@weapon_level = new_weapon_level
		else 
			puts "Cette nouvelle arme n'est pas plus puissante que ton arme actuelle"
		end
	end

	def search_health_pack
		health_pack = rand(1..6)
		if health_pack == 1
			puts "Tu n'as rien trouvé..."
		elsif health_pack > 1 && health_pack < 6
			puts "Tu  as trouvé un pack de +50 points de vie!"
			if @life_points + 50 < 100
				@life_points += 50
			else 
				@life_points = 100
			end
		else 
			puts "Waow, tu as trouvé un pack de +80 points de vie !"
			if @life_points + 80 < 100
				@life_points += 80
			else 
				@life_points = 100
			end
		end
		show_state
	end
end

















































