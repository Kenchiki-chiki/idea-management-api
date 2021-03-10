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

    it 'does not creates a category when there is no category_name' do
      category = FactoryBot.create(:category, name:'App')      
        post api_v1_ideas_path, params: {
            category_name: "",
            body: "TestTool"
        }
      expect(response.status).to eq(422)
    end

    it 'creates a category when there is no body' do
      category = FactoryBot.create(:category, name:'App')      
        post api_v1_ideas_path, params: {
            category_name: "App",
            body: ""
        }
      expect(response.status).to eq(422)
    end

    it "get request successfully" do
      get api_v1_ideas_path   
      expect(response).to have_http_status(:ok)
    end   

    it 'get request successfully when the category name exists' do
      category = FactoryBot.create(:category, name:'App')      
        get api_v1_ideas_path, params: {
            category_name: "App",
        }
        expect(response).to have_http_status(:success)
    end

  end
end
