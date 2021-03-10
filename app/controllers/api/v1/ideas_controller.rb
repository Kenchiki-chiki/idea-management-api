class Api::V1::IdeasController < ApplicationController
  before_action :set_ideas, only: [:index]

  def index
    res_ideas = @ideas.map do |idea|
      category = idea.category
      {id: category.id, category: category.name, body: idea.body}
    end

    render json: res_ideas , status: :ok
  end

  def create
    idea = IdeaForm.new(idea_params)
  
    if idea.save
      render status: 201, json: { status: 201 }
    else
      render status: 422, json: { status: 422 }
    end
  end


  private
  
  def idea_params
    params.permit(:category_name, :body)
  end

  def set_ideas
    if params[:category_name]
      category = Category.find_by!(name: params[:category_name])    
      @ideas = category.ideas.all
    else
      @ideas = Idea.all
    end
  end

end