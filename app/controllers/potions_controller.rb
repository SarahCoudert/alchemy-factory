class PotionsController < ApplicationController
  before_action :set_potion, only: [:show, :edit, :update, :destroy]

  # GET /potions
  # GET /potions.json
  def index
    @potions = Potion.all.order(:name)
  end

  # GET /potions/1
  # GET /potions/1.json
  def show
    @ingredients = Potion.get_ingredients_for_this_potion(params[:id])
    @sale_price = Potion.get_sale_cost(@potion.production_cost, 20)
  end

  # GET /potions/new
  def new
    @potion = Potion.new
    @ingredients = Ingredient.all
  end

  # GET /potions/1/edit
  def edit
    @ingredients = Ingredient.all
  end

  # POST /potions
  # POST /potions.json
  def create
    costs = Potion.compute_production_costs(params["ingredients"])
    
    potion_params["production_cost"] = costs
    
    @potion = Potion.new(name: potion_params["name"], description: potion_params["description"], production_cost: costs)
    
    respond_to do |format|
      if @potion.save
        Potion.save_ingredients(params["ingredients"], @potion.id)
        format.html { redirect_to @potion, notice: 'Potion was successfully created.' }
        format.json { render :show, status: :created, location: @potion }
      else
        format.html { render :new }
        format.json { render json: @potion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /potions/1
  # PATCH/PUT /potions/1.json
  def update
    
    respond_to do |format|
      if @potion.update(potion_params)
        if params["ingredients"] && params["ingredients"].size > 0
          
          Potion.destroy_recipes(@potion.id)
          Potion.save_ingredients(params["ingredients"], @potion.id)
          
          costs = Potion.compute_production_costs(params["ingredients"])
          @potion.production_cost = costs
          @potion.save
        end
        format.html { redirect_to @potion, notice: 'Potion was successfully updated.' }
        format.json { render :show, status: :ok, location: @potion }
      else
        format.html { render :edit }
        format.json { render json: @potion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /potions/1
  # DELETE /potions/1.json
  def destroy
    Potion.destroy_recipes(@potion.id)
    @potion.destroy
    respond_to do |format|
      format.html { redirect_to potions_url, notice: 'Potion was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def get_new_price
    pc = params["production_cost"].to_i
    ma = params["margin"].to_i
    respond_to do |format|
      format.json { render json: Potion.get_sale_cost(pc, ma) }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_potion
      @potion = Potion.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def potion_params
      params.require(:potion).permit(:name, :production_cost, :description)
    end
end
