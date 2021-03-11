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

    it 'does not creates a category when there is no body' do
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

    it 'get request 404 when the category name no exists' do
      category = FactoryBot.create(:category, name:'Soft')
      expect {
          get api_v1_ideas_path, params: {
            category_name: "App",
        }
      }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it 'get request when category_name is not specified' do
      category = FactoryBot.create(:category, name:'App', id: 1)
      category2 = FactoryBot.create(:category, name:'Soft', id: 2)
      idea = Idea.new(body:'TestTool', category: category)
      idea2 = Idea.new(body:'TestSoft', category: category2)
      idea.save!     
      idea2.save!
      get api_v1_ideas_path
      expect(JSON.parse(response.body)).to eq(
        [
          { 
            'id' => 1,
            'category' => 'App',
            'body' => 'TestTool'
           },
           { 
            'id' => 2,
            'category' => 'Soft',
            'body' => 'TestSoft'
           }
        ]
      )
    end

    it 'get request when category_name is specified' do
      category = FactoryBot.create(:category, name:'App', id: 3)
      category2 = FactoryBot.create(:category, name:'Soft', id: 4)
      idea = Idea.new(body:'TestTool', category: category)
      idea2 = Idea.new(body:'TestSoft', category: category2)
      idea.save!     
      idea2.save!
      get api_v1_ideas_path , params: {
         category_name: 'App' 
        }
      expect(JSON.parse(response.body)).to eq(
        [
          { 
            'id' => 3,
            'category' => 'App',
            'body' => 'TestTool'
            }
        ]
      )
    end
  end
end
