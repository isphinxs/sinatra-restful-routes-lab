require "./config/environment.rb"
require "sinatra/base"

class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  # code actions here!
  get "/recipes" do
    @recipes = Recipe.all
    erb :index
  end

  get "/recipes/new" do
    erb :new
  end

  get "/recipes/:id/edit" do
    @recipe = Recipe.find(params[:id])
    erb :edit
  end

  patch "/recipes/:id" do
    recipe = Recipe.find(params[:id])
    recipe.name = params[:name]
    recipe.ingredients = params[:ingredients]
    recipe.cook_time = params[:cook_time]
    recipe.save
    redirect "/recipes/#{params[:id]}"
  end

  post "/recipes" do
    recipe = Recipe.new(params)
    recipe.save
    id = recipe.id
    redirect "/recipes/#{id}"
  end

  get "/recipes/:id" do
    @recipe = Recipe.find(params[:id])
    erb :show
  end

  delete "/recipes/:id" do
    recipe = Recipe.find(params[:id])
    recipe.destroy
    redirect "/recipes"
  end
end
