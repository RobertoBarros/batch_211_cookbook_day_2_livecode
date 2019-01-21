class View

  def display(recipes)
    recipes.each_with_index do |recipe, index|
      puts '-' * 80
      done = recipe.done? ? '[X]' : '[ ]'
      puts "#{index + 1} #{done} - #{recipe.name} - (#{recipe.prep_time} minutes) Difficult: #{recipe.difficult}"
      puts recipe.description
      puts '-' * 80
    end
  end

  def ask_recipe_name
    puts "What is the recipe name?"
    gets.chomp
  end

  def ask_recipe_description
    puts "Enter the recipe description:"
    gets.chomp
  end

  def ask_recipe_prep_time
    puts "Enter recipe preparation time (in minutes):"
    gets.chomp.to_i
  end

  def ask_recipe_difficult
    puts "Enter the difficult:"
    difficults = ['very easy', 'easy', 'moderate', 'hard', 'very hard']
    difficults.each_with_index { |option, index| puts "#{index + 1} - #{option}" }
    index = gets.chomp.to_i - 1
    difficults[index]
  end

  def ask_index
    puts "Enter index:"
    gets.chomp.to_i - 1
  end

  def ask_ingredient
    puts "Enter the recipe main ingredient:"
    gets.chomp
  end

  def ask_recipe_to_import(recipes)
    recipes.first(5).each_with_index do |recipe, index|
      puts "#{index + 1} - #{recipe}"
    end
    puts "Enter the index of recipe to import:"

    gets.chomp.to_i - 1

  end


end