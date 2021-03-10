require 'rails_helper'

RSpec.describe "Ideas", type: :request do
  describe "ideas" do

    it 'creates a category' do
      category = FactoryBot.create(:category, name:'App')

      expect {
        post api_v1_ideas_path, params: {
            category_name: "App",
            body: "TestTool"
        }
      }.to change(category.ideas, :count).by(1)

      expect(response).to have_http_status(:success)
    end

    it "get request successfully" do
      get api_v1_ideas_path   
      expect(response).to have_http_status(:ok)
    end


  end
end
