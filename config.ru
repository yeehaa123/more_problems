# config.ru
require 'sinatra/base'
require './url_helpers'
require 'sinatra/twitter-bootstrap'
require './problem'
require 'pry'

class ProblemApp < Sinatra::Base
  register Sinatra::Twitter::Bootstrap::Assets

  helpers UrlHelpers

  get "/" do
    redirect problems_path
  end

  get "/problems" do
    @problems = Problem.all
    erb :index
  end

  get "/problems/new" do
    @problem = Problem.new
    erb :form
  end

  get "/problems/:id" do
    @problem = Problem.get id(params)
    redirect edit_problem_path(@problem)
  end

  get "/problems/:id/edit" do
    @problem = Problem.get id(params)
    erb :form
  end

  post "/problems" do
    Problem.create(params[:problem])
    redirect problems_path
  end

  put "/problems/:id" do
   @problem = Problem.get id(params)
    @problem.update(params[:problem])
    redirect problems_path
  end

  delete "/problems/:id" do
    binding.pry
    @problem = Problem.get id(params)
    @problem.destroy
    redirect problems_path
  end

  def id(params) 
    if params[:id]
      params[:id].to_i
    else
      puts "NOT FOUND"
    end
  end
end

use Rack::MethodOverride
run ProblemApp
