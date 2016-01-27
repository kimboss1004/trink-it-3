require 'spec_helper'


describe SessionsController do 

  describe 'POST create' do 

    context 'with valid user' do
      it "redirects user to home page" do
        kimboss = Fabricate(:user)
        post :create, email_address: kimboss.email_address, password: kimboss.password
        expect(response).to redirect_to join_college_user_path(kimboss.id)
      end
      it "signs user in" do
        kimboss = Fabricate(:user)
        post :create, email_address: kimboss.email_address, password: kimboss.password
        expect(session[:user_id]).to eq(kimboss.id) 
      end
    end

    context 'with invalid user' do
      it "redirects to sign-in page" do
        post :create, email_address: "joe@gmail.com", password: "bla"
        expect(response).to redirect_to sign_in_path
      end
      it "does not sign-in user if email_address does not exist" do
        post :create, email_address: "joe@gmail.com", password: "bla"
        expect(session[:user_id]).to be_nil
      end
      it "does not sign-in valid user if password is wrong" do
        kimboss = Fabricate(:user)
        post :create, email_address: kimboss.email_address, password: (kimboss.password + "bla")
        expect(session[:user_id]).to be_nil
      end
      it "makes flash error message" do
        post :create, email_address: "joe@gmail.com", password: "bla"
        expect(flash.any?).to eq(true)
      end
    end

  end

  describe 'DELETE destroy' do
    it "redirects to home page" do
      kimboss = Fabricate(:user)
      session[:user_id] = kimboss.id
      delete :destroy, id: session[:id]
      expect(response).to redirect_to root_path
    end
    it "signs out user" do
      kimboss = Fabricate(:user)
      session[:user_id] = kimboss.id
      delete :destroy, id: session[:id]
      expect(session[:id]).to be_nil
    end
  end

end