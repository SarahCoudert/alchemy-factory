json.extract! ingredient, :id, :name, :production_cost, :picture, :description, :created_at, :updated_at
json.url ingredient_url(ingredient, format: :json)
