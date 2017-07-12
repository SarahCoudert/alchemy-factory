class IngredientPotion < ApplicationRecord
	belongs_to :potion
	belongs_to :ingredient
end
