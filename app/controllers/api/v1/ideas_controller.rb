class Api::V1::IdeasController < ApplicationController

  def index
    if params[:category_name]
      category = Category.find_by!(name: params[:category_name])
    
      ideas = category.ideas.all
      group_json(ideas)
    else
      ideas = Idea.all
      group_json(ideas)
    end

    render json: ideas , status: :ok
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
end

def group_json(ideas)
  ideas = ideas.map do |idea|
    category = idea.category
    {id: category.id, category: category.name, body: idea.body}
  end
end