# class Api::V1::CategoriesController < ApplicationController

#   def index
#     categories = Category.all

#     render json: categories
#   end

#   def create
#     Category.transaction do
#       category = Category.find_or_create_by!(name: category_params)
  
#       idea = Idea.new(body: body, category: category)
#         idea.save!
#       end
#     rescue ActiveRecord::RecordInvalid
#       false
#     end

#   end

  



  # private
  
  # def category_params
  #   params.require(:category).permit(:name)
  # end

# end
