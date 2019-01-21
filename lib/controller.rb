require_relative 'view'
require_relative 'scraper'

class Controller

  def initialize(cookbook)
    @cookbook = cookbook
    @view = View.new
  end

  def list
    display_recipes
  end

  def create
    # Ask recipe name
    name = @view.ask_recipe_name
    # Ask recipe description
    description = @view.ask_recipe_description
    prep_time = @view.ask_recipe_prep_time
    difficult = @view.ask_recipe_difficult

    # Create a new recipe
    new_recipe = Recipe.new(description: description, name: name, prep_time: prep_time, difficult: difficult)
    # Add recipe in cookbook
    @cookbook.add_recipe(new_recipe)
  end

  def destroy
    # Display all recipes
    display_recipes
    # ask recipe index to remove
    index = @view.ask_index
    # Call cookbook to remove by index
    @cookbook.remove_recipe(index)
  end

  def mark_as_done
    # List all recipes
    display_recipes
    # Ask recipe index
    index = @view.ask_index
    # Find the recipe in cookbook by index
    recipe = @cookbook.find(index)
    # Mark recipe as done
    recipe.mark_as_done!
    # save the csv
    @cookbook.save
  end

  def import
    #Ask the ingredient
    ingredient = @view.ask_ingredient
    # Get the array of names and url
    links = Scraper.list_recipes(ingredient)
    # Get the index of recipe to import
    index = @view.ask_recipe_to_import(links.map {|row| row[0] })

    # Get the URL to import
    url = links[index][1]

    # Create a new recipe
    new_recipe = Scraper.get_recipe(url)

    # Add recipe to cookbook
    @cookbook.add_recipe(new_recipe)
  end


  private

  def display_recipes
    # Get all recipes from cookbook
    recipes = @cookbook.all
    # Call view with all recipes
    @view.display(recipes)
  end
end


