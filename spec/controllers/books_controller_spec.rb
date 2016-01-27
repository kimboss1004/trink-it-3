require 'spec_helper'


describe BooksController do
  
  describe 'GET new' do
    it "sets instance of book" do
      college = Fabricate(:college)
      kimboss = Fabricate(:user, college: college)
      session[:user_id] = kimboss.id
      get :new, college_id: college.id
      expect(assigns(:book)).to be_instance_of(Book)
    end
  end

  describe 'POST create' do
    context 'with valid input' do
      it "redirects to book show page" do
        college = Fabricate(:college)
        kimboss = Fabricate(:user, college: college)
        session[:user_id] = kimboss.id
        category = Fabricate(:category)
        post :create, college_id: college.id, book: Fabricate.attributes_for(:book, category_id: category.id, college_id: college)
        expect(response).to redirect_to college_book_path(college,Book.first.id)
      end
      it "creates book in database" do
        college = Fabricate(:college)
        kimboss = Fabricate(:user, college: college)
        session[:user_id] = kimboss.id
        category = Fabricate(:category)
        post :create, college_id: college.id, book: Fabricate.attributes_for(:book, category_id: category.id, college_id: college)
        expect(Book.count).to eq(1)
      end
      it "creates association of book belonging to user" do
        college = Fabricate(:college)
        kimboss = Fabricate(:user, college: college)
        session[:user_id] = kimboss.id
        category = Fabricate(:category)
        post :create, college_id: college.id, book: Fabricate.attributes_for(:book, category_id: category.id, college_id: college)
        expect(Book.last.user).to eq(kimboss)
      end
      it "creates association of book belonging to category" do
        college = Fabricate(:college)
        kimboss = Fabricate(:user, college: college)
        session[:user_id] = kimboss.id
        category = Fabricate(:category)
        post :create, college_id: college.id, book: Fabricate.attributes_for(:book, category_id: category.id, college_id: college)
        expect(Book.first.category).to eq(category)
      end
    end
    context 'with invalid input' do
      it "renders new book page" do
        college = Fabricate(:college)
        kimboss = Fabricate(:user, college: college)
        session[:user_id] = kimboss.id
        category = Fabricate(:category)
        post :create, college_id: college.id, book: Fabricate.attributes_for(:book)
        expect(response).to render_template :new
      end
      it "does not create book in database" do
        college = Fabricate(:college)
        kimboss = Fabricate(:user, college: college)
        session[:user_id] = kimboss.id
        category = Fabricate(:category)
        post :create, college_id: college.id, book: Fabricate.attributes_for(:book)
        expect(Book.count).to eq(0)
      end
    end
  end

  describe 'GET edit' do
    it "retrieves book variable" do
      college = Fabricate(:college)
      kimboss = Fabricate(:user, college: college)
      session[:user_id] = kimboss.id
      category = Fabricate(:category)
      book = Fabricate(:book, user_id: kimboss.id, category_id: category.id, college_id: college.id)
      get :edit, college_id: college.id, id: book.id
      expect(assigns(:book)).to eq(book)
    end
  end

  describe 'PUT update' do
    context "with valid input" do
      it "redirects to show book page" do
        college = Fabricate(:college)
        kimboss = Fabricate(:user, college: college)
        session[:user_id] = kimboss.id
        category = Fabricate(:category)
        book = Fabricate(:book, user_id: kimboss.id, category_id: category.id, college_id: college.id)
        put :update, college_id: college.id, id: book.id, book: { price: book.price + 100 }
        expect(response).to redirect_to college_book_path(college,book)
      end
      it "updates book in the database" do
        college = Fabricate(:college)
        kimboss = Fabricate(:user, college: college)
        session[:user_id] = kimboss.id
        category = Fabricate(:category)
        book = Fabricate(:book, price: 100, user_id: kimboss.id, category_id: category.id, college_id: college.id)
        put :update, college_id: college.id, id: book.id, book: { price: book.price + 100 }
        expect(Book.first.price).to eq(200)
      end
      it "makes a flash save message" do
        college = Fabricate(:college)
        kimboss = Fabricate(:user, college: college)
        session[:user_id] = kimboss.id
        category = Fabricate(:category)
        book = Fabricate(:book, price: 100, user_id: kimboss.id, category_id: category.id, college_id: college.id)
        put :update, college_id: college.id, id: book.id, book: { price: book.price + 100 }
        expect(flash[:success]).to eq("Your changes have been saved.")
      end
    end
    context "with invalid input" do
      it "renders edit book page" do
        college = Fabricate(:college)
        kimboss = Fabricate(:user, college: college)
        session[:user_id] = kimboss.id
        category = Fabricate(:category)
        book = Fabricate(:book, user_id: kimboss.id, category_id: category.id, college_id: college.id)
        put :update, college_id: college.id, id: book.id, book: { price: nil }
        expect(response).to render_template :edit
      end
      it "does not update book in database" do
        college = Fabricate(:college)
        kimboss = Fabricate(:user, college: college)
        session[:user_id] = kimboss.id
        category = Fabricate(:category)
        book = Fabricate(:book, price: 50, user_id: kimboss.id, category_id: category.id, college_id: college.id)
        put :update, college_id: college.id, id: book.id, book: { price: nil }
        expect(book.reload.price).to eq(50)
      end
    end
  end

  describe "DELETE destroy" do
    it "redirects to root path" do
      college = Fabricate(:college)
      kimboss = Fabricate(:user, college: college)
      session[:user_id] = kimboss.id
      category = Fabricate(:category)
      book = Fabricate(:book, price: 50, user_id: kimboss.id, category_id: category.id, college_id: college) 
      delete :destroy, college_id: college.id, id: book.id
      expect(response).to redirect_to college_path(college)    
    end 
    it "deletes the book from database" do
      college = Fabricate(:college)
      kimboss = Fabricate(:user, college: college)
      session[:user_id] = kimboss.id
      category = Fabricate(:category)
      book = Fabricate(:book, price: 50, user_id: kimboss.id, category_id: category.id, college_id: college)  
      delete :destroy, college_id: college.id, id: book.id
      expect(Book.count).to eq(0) 
    end
    it "makes flash message" do
      college = Fabricate(:college)
      kimboss = Fabricate(:user, college: college)
      session[:user_id] = kimboss.id
      category = Fabricate(:category)
      book = Fabricate(:book, price: 50, user_id: kimboss.id, category_id: category.id, college_id: college)  
      delete :destroy, college_id: college.id, id: book.id
      expect(flash[:success]).to eq("Your posting has been deleted.") 
    end
    it "does not delete book if user is not creator" do
      college = Fabricate(:college)
      kimboss = Fabricate(:user, college: college)
      user2 = Fabricate(:user, college: college)
      session[:user_id] = kimboss.id
      category = Fabricate(:category)
      book = Fabricate(:book, price: 50, user_id: user2.id, category_id: category.id, college_id: college) 
      delete :destroy, college_id: college.id, id: book.id
      expect(Book.count).to eq(1) 
    end
  end

end






