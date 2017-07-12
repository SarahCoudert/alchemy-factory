class CreateIngredients < ActiveRecord::Migration[5.0]
  def change
    create_table :ingredients do |t|
      t.string :name
      t.integer :production_cost
      t.string :picture
      t.text :description
      t.references :potion, foreign_key: true

      t.timestamps
    end
  end
end
