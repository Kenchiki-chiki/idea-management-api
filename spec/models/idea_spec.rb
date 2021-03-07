require 'rails_helper'

RSpec.describe Idea, type: :model do
  it "is valid with category_id, body" do
    category = FactoryBot.create(:category)
    idea = category.ideas.new(
      category_id: 1,
      body: "TestTool"
    )
    expect(idea).to be_valid
  end

  it "is invalid without a category_id" do
    idea = Idea.new(category_id: nil)
    idea.valid?
    expect(idea.errors[:category_id]).to include("can't be blank")
  end

  it "is invalid without a body" do
    idea = Idea.new(body: nil)
    idea.valid?
    expect(idea.errors[:body]).to include("can't be blank")
  end
end
