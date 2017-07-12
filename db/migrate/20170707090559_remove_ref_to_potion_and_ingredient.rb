class RemoveRefToPotionAndIngredient < ActiveRecord::Migration[5.0]
  def change
 	 remove_reference :potions, :ingredient, index:true, foreign_key: true
 	 remove_reference :ingredients, :potion, index:true, foreign_key: true
	end
end
