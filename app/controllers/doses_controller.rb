# Controller for doses. Each dose has a cocktail and an ingredient.
class DosesController < ApplicationController
  before_action :find_dose, only: [:destroy]

  # Load a form to capture info about dose
  def new
    @dose = Dose.new
    @cocktail = Cocktail.find(params[:cocktail_id])
  end

  # Add the dose to the database
  def create
    # Create a dose object
    @dose = Dose.new(set_params)
    # Associate it with a cocktail
    @dose.cocktail = Cocktail.find(params[:cocktail_id])
    # Associate it with a ingredient
    @dose.ingredient = Ingredient.find(params[:dose][:ingredient_id])
    # If it is valid then add to db
    if @dose.save
      redirect_to cocktail_path(@dose.cocktail)
    else # Refill form with data kept from last entry
      render :new
    end
  end

  def destroy
    @dose.destroy
    redirect_to cocktail_path(@dose.cocktail)
  end

  private

  def find_dose
    @dose = Dose.find(params[:id])
  end

  # Whitelist the allowed params and return them in hash
  def set_params
    params.require(:dose).permit(:description, :ingredient_id)
  end
end
