require 'spec_helper'


describe MessagesController do

  describe "POST create" do
    it "requires user to be logged in" do
      college = Fabricate(:college)
      kimboss = Fabricate(:user, college: college)
      joe = Fabricate(:user, college: college)
      category = Fabricate(:category)
      book = Fabricate(:book, user_id: joe.id, category_id: category.id, college_id: college.id)
      post :create, college_id: college.id, id: book.id, message: Fabricate.attributes_for(:message)
      expect(response).to redirect_to sign_in_path
    end
    it "creates message in database" do
      college = Fabricate(:college)
      kimboss = Fabricate(:user, college: college)
      joe = Fabricate(:user, college: college)
      session[:user_id] = kimboss.id
      category = Fabricate(:category)
      book = Fabricate(:book, user_id: joe.id, category_id: category.id, college_id: college.id)
      post :create, college_id: college.id, id: book.id, message: Fabricate.attributes_for(:message)
      expect(Message.all.count).to eq(1)
    end
  end




end