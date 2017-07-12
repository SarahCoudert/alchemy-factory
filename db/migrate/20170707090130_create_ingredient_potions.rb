class CreateIngredientPotions < ActiveRecord::Migration[5.0]
  def change
    create_table :ingredient_potions do |t|
      t.integer :ingredient_id
      t.integer :potion_id

      t.timestamps
    end
  end
end
