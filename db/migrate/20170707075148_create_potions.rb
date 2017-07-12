class CreatePotions < ActiveRecord::Migration[5.0]
  def change
    create_table :potions do |t|
      t.string :name
      t.integer :production_cost
      t.string :picture
      t.text :description
      t.references :ingredient, foreign_key: true

      t.timestamps
    end
  end
end
