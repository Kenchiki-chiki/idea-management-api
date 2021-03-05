class Api::V1::IdeasController < ApplicationController

  def index
    binding.pry
    if params[:category_name]
      category = Category.find_by!(name: category_name)
    
      ideas = category.ideas.all
      rescue ActiveRecord::RecordInvalid
        render status: 422, json: { status: 422 }
      end
    else
      ideas = Idea.all
    end
    render json: :ideas, status: :created
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
