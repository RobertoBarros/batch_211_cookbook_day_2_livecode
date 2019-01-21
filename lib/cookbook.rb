require 'csv'

class Cookbook

  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @recipes = []
    load
  end

  def add_recipe(recipe)
    @recipes << recipe
    save
  end

  def all
    @recipes
  end

  def remove_recipe(index)
    @recipes.delete_at(index)
    save
  end

  def find(index)
    @recipes[index]
  end


  def save
    CSV.open(@csv_file_path, 'wb') do |csv|
      @recipes.each do |recipe|
        csv << [recipe.name, recipe.description, recipe.prep_time, recipe.difficult, recipe.done?]
      end
    end
  end


  private

  def load
    CSV.foreach(@csv_file_path) do |row|
      name = row[0]
      description = row[1]
      prep_time = row[2]
      difficult = row[3]
      done = row[4]
      new_recipe = Recipe.new(name: name, description: description, prep_time: prep_time.to_i, difficult: difficult, done: done == 'true')
      @recipes << new_recipe
    end
  end

end