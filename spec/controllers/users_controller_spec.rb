require 'spec_helper'


describe UsersController do
  
  describe 'GET new' do
    it "makes instance of User" do
      get :new
      expect(assigns(:user)).to be_instance_of(User)
    end
  end

  describe 'POST create' do

    context 'with valid submission' do
      it "create user in database" do
        post :create, user: Fabricate.attributes_for(:user)
        expect(User.count).to eq(1)
      end
      it "redirects to sign in page" do
        post :create, user: Fabricate.attributes_for(:user)
        expect(response).to redirect_to sign_in_path
      end
      it "makes flash success message" do
        post :create, user: Fabricate.attributes_for(:user)
        expect(flash[:success].nil?).to eq(false)
      end
    end

    context 'with invalid submission' do
      it "render new user page" do
        post :create, user: { name: nil }
        expect(response).to render_template :new
      end
      it "makes instance of User" do
        post :create, user: { name: nil }
        expect(assigns(:user)).to be_instance_of(User)
      end
      it "does not create user in database" do
        post :create, user: { name: nil }
        expect(User.count).to eq(0)
      end
    end
    
  end

  describe 'GET edit' do
    context "with no authentication" do
      it "redirects to login page if user unauthenticated" do
        get :edit, college_id: 1, id: 5
        expect(response).to redirect_to sign_in_path      
      end
    end

    context "with authentication" do
      it "renders edit user page if current user is editing his own account" do
        kimboss = Fabricate(:user)
        college = College.create(name: "Stanford University")
        college.users << kimboss
        session[:user_id] = kimboss.id
        get :edit, college_id: college.id, id: kimboss.id
        expect(response).to render_template :edit
      end
      it "redirect_to root path if current user tries to edit another user" do
        kimboss = Fabricate(:user)
        user2 = Fabricate(:user)
        college = College.create(name: "Stanford University")
        college.users << kimboss
        session[:user_id] = kimboss.id
        get :edit, college_id: college.id, id: user2.id
        expect(response).to redirect_to college_path(college)       
      end
    end
  end

  describe "POST update" do
    context "with valid input" do 
      it "redirects to edit user page" do
        kimboss = Fabricate(:user)
        session[:user_id] = kimboss.id
        college = College.create(name: "Stanford University")
        college.users << kimboss
        put :update, college_id: college.id, id: kimboss.id, user: Fabricate.attributes_for(:user, password: "nin")
        expect(response).to redirect_to edit_college_user_path(college,kimboss)   
      end
      it "updates user" do
        kimboss = Fabricate(:user)
        college = College.create(name: "Stanford University")
        college.users << kimboss
        session[:user_id] = kimboss.id
        put :update, college_id: college.id, id: kimboss.id, user: { password: "nin"}
        expect(kimboss.reload.authenticate("nin")).to eq(kimboss) 
      end
      it "makes flash save message" do
        kimboss = Fabricate(:user)
        college = College.create(name: "Stanford University")
        college.users << kimboss
        session[:user_id] = kimboss.id
        put :update, college_id: college.id, id: kimboss.id, user: { password: "nin"}
        expect(flash[:success]).to eq("Your changes have been saved.")         
      end
    end

  end

  describe "GET get_join_college" do
    context "with unauthenticated user" do
      it "redirects to sign in page" do
        kimboss = Fabricate(:user)
        get :get_join_college, id: kimboss.id
        expect(response).to redirect_to sign_in_path
      end
    end
    context "with authenticated user" do
      it "redirects user to college page if college is present" do
        kimboss = Fabricate(:user)
        session[:user_id] = kimboss.id
        college = College.create(name: "Stanford University")
        college.users << kimboss
        get :get_join_college, id: kimboss.id
        expect(response).to redirect_to college_path(college)
      end
      it "redirects noncollege member user to root if he is not the user stated" do
        kimboss = Fabricate(:user)
        joe = Fabricate(:user)
        session[:user_id] = joe.id
        get :get_join_college, id: kimboss.id
        expect(response).to redirect_to root_path
      end
    end
  end

  describe "POST join_college" do
    context "with unauthenticated user" do
      it "redirects to sign in page" do
        kimboss = Fabricate(:user)
        post :get_join_college, id: kimboss.id
        expect(response).to redirect_to sign_in_path
      end
    end
    context "with authenticated user" do
      it "redirects user to college page if college is present" do
        kimboss = Fabricate(:user)
        session[:user_id] = kimboss.id
        college = College.create(name: "Stanford University")
        college.users << kimboss
        post :join_college, id: kimboss.id
        expect(response).to redirect_to college_path(college)
      end
      it "redirects noncollege member user to root if he is not the user stated" do
        kimboss = Fabricate(:user)
        joe = Fabricate(:user)
        session[:user_id] = joe.id
        post :join_college, id: kimboss.id
        expect(response).to redirect_to root_path
      end
      it "joins user to college in database" do
        kimboss = Fabricate(:user)
        session[:user_id] = kimboss.id
        college = College.create(name: "Stanford University")
        post :join_college, id: kimboss.id, user: {college_id: college}
        expect(User.first.college).to eq(college)       
      end
    end
  end


end





