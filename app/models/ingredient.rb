class Ingredient < ApplicationRecord
	has_many :ingredient_potions
 	has_many :potions, :through => :ingredient_potion

 	def self.get_potions_for_this_ingredient(ingredient)
		ingredient_potions = IngredientPotion.where(ingredient_id: ingredient)
		potions = Array.new
		ingredient_potions.each do |ip|
			potions << Potion.find(ip.potion_id)
		end
		return potions
	end

	def self.destroy_recipes(ingredient)
		IngredientPotion.where(ingredient_id: ingredient).destroy_all
	end

	def self.update_potions_costs(ingredient)
		cost = 0
		
		#use_ingredients are IngredientPotion records who contains the ingredient
		use_ingredients = IngredientPotion.joins(:potion).where(:ingredient_id => ingredient)
		
		#if this list is empty then we have nothing to update
		unless (use_ingredients && use_ingredients.length > 0) then return end
		
		potions = []
		use_ingredients.each do |use_ingredient|
			#for each record we are searching the potion that is associated
			potion =  Potion.find(use_ingredient.potion_id)

			#ingredients contains record of IngredientPotion with the three ingredients for the potion
			ingredients = IngredientPotion.joins(:potion).where(:potion_id => potion.id)

			#we then add each ingredient cost to final cost
			cost = 0
			ingredients.each do |ingredient|
				id = ingredient.ingredient_id
				c =  Ingredient.find(id).production_cost
				cost += c
			end
			potion.production_cost = cost
			potion.save
		end

	end
	

end
