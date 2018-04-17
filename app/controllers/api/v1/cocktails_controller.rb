module Api
  module V1
    class CocktailsController < ApplicationController
      def index
        render json: Cocktail.all
      end

      def show
        cocktail = Cocktail.find(params[:id])

        cocktail_json = {
          id: cocktail.id,
          name: cocktail.name,
          description: cocktail.description,
          instructions: cocktail.instructions,
          source: cocktail.source,
          proportions: cocktail.proportions.map do |prop|
            {
              id: prop.id,
              ingredient_name: prop.ingredient.name,
              amount: prop.amount
            }
          end
        }

        render json: cocktail_json
      end

      def create
      @newCocktail = Cocktail.create(cocktail_params)
      params[:proportions].each do |proportion|
        ingredient = Ingredient.find_or_create_by(name: proportion[:ingredient_name])
        proportion = Proportion.create(amount: proportion[:amount], cocktail_id: @newCocktail.id, ingredient_id: ingredient.id)
      end
      render json: Cocktail.all
      end

      def edit

      end

      def update

      end

      def destroy

      end

      private

      def cocktail_params
        params.permit(:name, :description, :instructions, :proportions)
      end
    end
  end
end
