class Potion < ApplicationRecord
	require "digest/md5"
	has_many :ingredient_potions
	has_many :ingredients, :through => :ingredient_potion

	before_save :set_hexa_color


	def self.save_ingredients(ingredients, potion)
		ingredients.each do |ingredient|
			id = ingredient.to_i
			ip = IngredientPotion.new
			ip.ingredient_id = id
			ip.potion_id = potion
			ip.save
		end
	end

	def self.destroy_recipes(potion)
		IngredientPotion.where(potion_id: potion).destroy_all
	end

	def self.get_ingredients_for_this_potion(potion)
		ingredient_potions = IngredientPotion.where(potion_id: potion)
		ingredients = Array.new
		ingredient_potions.each do |ip|
			ingredients << Ingredient.find(ip.ingredient_id)
		end
		return ingredients
	end

	def self.compute_production_costs(ingredients)
		cost = 0
		if !ingredients || ingredients.count <= 0 then return 0 end
		ingredients.each do |ingredient|
			id = ingredient.to_i
			c =  Ingredient.find(id).production_cost
			cost += c
		end
		return cost
	end

	def self.get_sale_cost(production_cost, margin)
		sale_price = 0

		production_cost = production_cost.to_f
		
		if (margin >= 100)
			return production_cost
		else
			margin = margin.to_f / 100.0
		end

		if (production_cost > 0)
			#super formule trouvée grâce à Raph
	      sale_price = ((margin * production_cost) / (1 - margin)) + production_cost
	      sale_price =  Integer(sale_price * 100) / Float(100)
	  end
	  return sale_price
	end

	private
    
    def set_hexa_color
      self.hexColor = Digest::MD5.hexdigest(self.name)[0, 6]
    end

end
