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
end
