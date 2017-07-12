class AddHexColorToPotion < ActiveRecord::Migration[5.0]
  def change
    add_column :potions, :hexColor, :string
  end
end
