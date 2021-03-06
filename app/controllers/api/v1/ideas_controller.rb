class Api::V1::IdeasController < ApplicationController

  def index
    # binding.pry
    if params[:category_name]
      # Categoryのテーブルから一致するnameを取得
      category = Category.find_by!(name: params[:category_name])
    
      # 該当のcategoryと紐づくアイデアを取得
      ideas = category.ideas.all
      # rescue ActiveRecord::RecordInvalid
      #   render status: 404, json: { status: 404 }
      # end
    else
      # アイデアすべてを取得
      ideas = Idea.all
    end
    # binding.pry
    # render json: ideas, status: :created
    render json: {id: category.id, category: category.name, body: ideas.first.body} , status: :created
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
