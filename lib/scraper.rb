require 'open-uri'
require 'nokogiri'

class Scraper

  def self.list_recipes(ingredient)
    url = "http://www.letscookfrench.com/recipes/find-recipe.aspx?aqt=#{ingredient}"

    html_file = open(url).read
    html_doc = Nokogiri::HTML(html_file)

    links = []
    html_doc.search('.m_titre_resultat a').each do |link|
      recipe_name = link.text
      recipe_url = "http://www.letscookfrench.com" + link.attributes['href'].value
      links << [recipe_name, recipe_url]
    end

    links
  end

  def self.get_recipe(url)
    html_file = open(url).read
    html_doc = Nokogiri::HTML(html_file)

    recipe_name = html_doc.search('h1').text.strip
    recipe_description = html_doc.search('.m_content_recette_todo').text.gsub(/\n/,'').gsub(/\s{2}+/,'').strip
    prep_time = html_doc.search('.preptime').text.strip.to_i
    difficult = html_doc.search('.m_content_recette_breadcrumb').text.match(/-([\w\s]+)-/)[1].strip

    Recipe.new(name: recipe_name, description: recipe_description, prep_time: prep_time, difficult: difficult)

  end


end