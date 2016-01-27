# require 'spec_helper'

# describe ProposalsController do
#   context 'GET new' do
#     it "renders new page" do
#       kimboss = Fabricate(:user)
#       session[:user_id] = kimboss
#       category1 = Fabricate(:category)
#       book = Fabricate(:book, user: kimboss, category: category1)
#       get :new, book_id: book.id
#       expect(response).to render_template(:new)
#     end
#     it "redirects to login page if user unauthenticated" do
#       kimboss = Fabricate(:user)
#       category1 = Fabricate(:category)
#       book = Fabricate(:book, user: kimboss, category: category1)
#       get :new, book_id: book.id
#       expect(response).to redirect_to sign_in_path
#     end
#   end

#   context 'POST create' do
#     context 'with valid input' do
#       it 'redirect_to show proposal page' do
#         kimboss = Fabricate(:user)
#         joe = Fabricate(:user)
#         session[:user_id] = kimboss.id
#         category1 = Fabricate(:category)
#         book = Fabricate(:book, user: joe, category: category1)
#         post :create, book_id: book.id, proposal: Fabricate.attributes_for(:proposal, sender_id: kimboss.id, reciever_id: joe.id, book_id: book.id) 
#         expect(response).to redirect_to inbox_path
#       end
#       it 'creates proposal in database' do
#         kimboss = Fabricate(:user)
#         joe = Fabricate(:user)
#         session[:user_id] = kimboss.id
#         category1 = Fabricate(:category)
#         book = Fabricate(:book, user: joe, category: category1)
#         post :create, book_id: book.id, proposal: Fabricate.attributes_for(:proposal, sender_id: kimboss.id, reciever_id: joe.id, book_id: book.id) 
#         expect(Proposal.count).to eq(1)
#       end
#       it 'creates flash message' do
#         kimboss = Fabricate(:user)
#         joe = Fabricate(:user)
#         session[:user_id] = kimboss.id
#         category1 = Fabricate(:category)
#         book = Fabricate(:book, user: joe, category: category1)
#         post :create, book_id: book.id, proposal: Fabricate.attributes_for(:proposal, sender_id: kimboss.id, reciever_id: joe.id, book_id: book.id) 
#         expect(flash[:success].nil?).to eq(false)
#       end
#     end

#     context 'with invalid input' do
#       it "renders new page" do
#         kimboss = Fabricate(:user)
#         joe = Fabricate(:user)
#         session[:user_id] = kimboss.id
#         category1 = Fabricate(:category)
#         book = Fabricate(:book, user: joe, category: category1)
#         post :create, book_id: book.id, proposal: Fabricate.attributes_for(:proposal, sender_id: kimboss.id, reciever_id: joe.id, book_id: book.id, date: nil) 
#         expect(response).to render_template :new
#       end
#       it "does not create proposal in database" do
#         kimboss = Fabricate(:user)
#         joe = Fabricate(:user)
#         session[:user_id] = kimboss.id
#         category1 = Fabricate(:category)
#         book = Fabricate(:book, user: joe, category: category1)
#         post :create, book_id: book.id, proposal: Fabricate.attributes_for(:proposal, sender_id: kimboss.id, reciever_id: joe.id, book_id: book.id, date: nil) 
#         expect(Proposal.count).to eq(0)
#       end
#       it "doesn't remember location for []" do
#         kimboss = Fabricate(:user)
#         joe = Fabricate(:user)
#         session[:user_id] = kimboss.id
#         category1 = Fabricate(:category)
#         book = Fabricate(:book, user: joe, category: category1)
#         post :create, book_id: book.id, proposal: {sender_id: kimboss.id, reciever_id: joe.id, book_id: book.id, location: []}
#         expect(assigns(:proposal).location).to eq(nil)
#       end
#       it "doesn't remember location for [Other, '']" do
#         kimboss = Fabricate(:user)
#         joe = Fabricate(:user)
#         session[:user_id] = kimboss.id
#         category1 = Fabricate(:category)
#         book = Fabricate(:book, user: joe, category: category1)
#         post :create, book_id: book.id, proposal: {sender_id: kimboss.id, reciever_id: joe.id, book_id: book.id, location: ['Other', '']}
#         expect(assigns(:proposal).location).to eq(nil)
#       end      
#       it "remembers location for [Kogan Plaza, '']" do
#         kimboss = Fabricate(:user)
#         joe = Fabricate(:user)
#         session[:user_id] = kimboss.id
#         category1 = Fabricate(:category)
#         book = Fabricate(:book, user: joe, category: category1)
#         post :create, book_id: book.id, proposal: {sender_id: kimboss.id, reciever_id: joe.id, book_id: book.id, location: ['Kogan Plaza', '']}
#         expect(assigns(:proposal).location).to eq('Kogan Plaza')
#       end
#       it "remembers user inputted location for [Other, user input]" do
#         kimboss = Fabricate(:user)
#         joe = Fabricate(:user)
#         session[:user_id] = kimboss.id
#         category1 = Fabricate(:category)
#         book = Fabricate(:book, user: joe, category: category1)
#         post :create, book_id: book.id, proposal: {sender_id: kimboss.id, reciever_id: joe.id, book_id: book.id, location: ['Other', "user input"]}
#         expect(assigns(:proposal).location).to eq('user input')
#       end
#       it "remembers user inputted location for [user input]" do
#         kimboss = Fabricate(:user)
#         joe = Fabricate(:user)
#         session[:user_id] = kimboss.id
#         category1 = Fabricate(:category)
#         book = Fabricate(:book, user: joe, category: category1)
#         post :create, book_id: book.id, proposal: {sender_id: kimboss.id, reciever_id: joe.id, book_id: book.id, location: ['user input']}
#         expect(assigns(:proposal).location).to eq('user input')
#       end
#       it "remembers user inputted location for [Kogan Plaza, user input]" do
#         kimboss = Fabricate(:user)
#         joe = Fabricate(:user)
#         session[:user_id] = kimboss.id
#         category1 = Fabricate(:category)
#         book = Fabricate(:book, user: joe, category: category1)
#         post :create, book_id: book.id, proposal: {sender_id: kimboss.id, reciever_id: joe.id, book_id: book.id, location: ['Kogan Plaza', 'user input']}
#         expect(assigns(:proposal).location).to eq('user input')
#       end
#       it "remembers Kogan Plaza for ['Kogan Plaza', 'University Yard']" do
#         kimboss = Fabricate(:user)
#         joe = Fabricate(:user)
#         session[:user_id] = kimboss.id
#         category1 = Fabricate(:category)
#         book = Fabricate(:book, user: joe, category: category1)
#         post :create, book_id: book.id, proposal: {sender_id: kimboss.id, reciever_id: joe.id, book_id: book.id, location: ['Kogan Plaza', 'University Yard']}
#         expect(assigns(:proposal).location).to eq('Kogan Plaza')
#       end 
#       it "remembers University Yard for ['University Yard','Kogan Plaza']" do
#         kimboss = Fabricate(:user)
#         joe = Fabricate(:user)
#         session[:user_id] = kimboss.id
#         category1 = Fabricate(:category)
#         book = Fabricate(:book, user: joe, category: category1)
#         post :create, book_id: book.id, proposal: {sender_id: kimboss.id, reciever_id: joe.id, book_id: book.id, location: ['University Yard','Kogan Plaza']}
#         expect(assigns(:proposal).location).to eq('University Yard')
#       end 
#     end

#   end


#   context "POST accept" do
#     it 'redirect_to inbox page' do
#       kimboss = Fabricate(:user)
#       joe = Fabricate(:user)
#       session[:user_id] = kimboss.id
#       category1 = Fabricate(:category)
#       book = Fabricate(:book, user: joe, category: category1)
#       proposal = Fabricate(:proposal, sender_id: kimboss.id, reciever_id: joe.id, book_id: book.id)
#       post :accept, book_id: book.id, id: proposal.id
#       expect(response).to redirect_to inbox_path
#     end
#     it 'sets reciever_confirmation to true' do
#       kimboss = Fabricate(:user)
#       joe = Fabricate(:user)
#       session[:user_id] = joe.id
#       category1 = Fabricate(:category)
#       book = Fabricate(:book, user: joe, category: category1)
#       proposal = Fabricate(:proposal, sender_id: kimboss.id, reciever_id: joe.id, book_id: book.id)
#       post :accept, book_id: book.id, id: proposal.id
#       expect(Proposal.first.reciever_confirmation).to eq(true)
#     end
#     it "only sets reciever_confirmation to true if user is reciever not sender" do
#       kimboss = Fabricate(:user)
#       joe = Fabricate(:user)
#       session[:user_id] = kimboss.id
#       category1 = Fabricate(:category)
#       book = Fabricate(:book, user: joe, category: category1)
#       proposal = Fabricate(:proposal, sender_id: kimboss.id, reciever_id: joe.id, book_id: book.id)
#       post :accept, book_id: book.id, id: proposal.id
#       expect(Proposal.first.reciever_confirmation).to eq(nil)
#     end
#     it 'deletes all proposals for book accept confirmed proposal' do
#       kimboss = Fabricate(:user)
#       joe = Fabricate(:user)
#       session[:user_id] = kimboss.id
#       category1 = Fabricate(:category)
#       book = Fabricate(:book, user: joe, category: category1)
#       proposal = Fabricate(:proposal, sender_id: kimboss.id, reciever_id: joe.id, book_id: book.id)
#       proposal_2 = Fabricate(:proposal, sender_id: joe.id, reciever_id: kimboss.id, book_id: book.id)
#       proposal_3 = Fabricate(:proposal, sender_id: kimboss.id, reciever_id: joe.id, book_id: book.id)
#       proposal_4 = Fabricate(:proposal, sender_id: joe.id, reciever_id: kimboss.id, book_id: book.id)
#       post :accept, book_id: book.id, id: proposal_4.id
#       expect(Book.first.proposals).to eq([proposal_4])
#     end
#     it 'sets book to closed in database' do
#       kimboss = Fabricate(:user)
#       joe = Fabricate(:user)
#       session[:user_id] = kimboss.id
#       category1 = Fabricate(:category)
#       book = Fabricate(:book, user: joe, category: category1)
#       proposal = Fabricate(:proposal, sender_id: kimboss.id, reciever_id: joe.id, book_id: book.id)
#       proposal_2 = Fabricate(:proposal, sender_id: joe.id, reciever_id: kimboss.id, book_id: book.id)
#       proposal_3 = Fabricate(:proposal, sender_id: kimboss.id, reciever_id: joe.id, book_id: book.id)
#       proposal_4 = Fabricate(:proposal, sender_id: joe.id, reciever_id: kimboss.id, book_id: book.id)
#       post :accept, book_id: book.id, id: proposal_4.id
#       expect(Book.first.closed).to eq(true)
#     end
#     it "destroys all unaccepted proposals sent by buyer for books in the category of the confirmed book" do
#       kimboss = Fabricate(:user)
#       joe = Fabricate(:user)
#       bryan = Fabricate(:user)
#       session[:user_id] = joe.id
#       category1 = Fabricate(:category)
#       category2 = Fabricate(:category)
#       book = Fabricate(:book, user: joe, category: category1)
#       book2 = Fabricate(:book, user: bryan, category: category1)
#       book3 = Fabricate(:book, user: bryan, category: category2)
#       book_1_proposal = Fabricate(:proposal, sender_id: kimboss.id, reciever_id: joe.id, book_id: book.id)
#       book_2_proposal = Fabricate(:proposal, sender_id: kimboss.id, reciever_id: bryan.id, book_id: book2.id)
#       book_3_proposal = Fabricate(:proposal, sender_id: kimboss.id, reciever_id: bryan.id, book_id: book3.id)
#       post :accept, book_id: book.id, id: book_1_proposal.id
#       expect(Proposal.all.size).to eq(2)
#     end
#     it "destroys all of buyer's accepted proposals for books in the same category that are not legit/latest" do
#       kimboss = Fabricate(:user)
#       joe = Fabricate(:user)
#       bryan = Fabricate(:user)
#       session[:user_id] = kimboss.id
#       category1 = Fabricate(:category)
#       category2 = Fabricate(:category)
#       book = Fabricate(:book, user: joe, category: category1)
#       book2 = Fabricate(:book, user: bryan, category: category1)
#       book3 = Fabricate(:book, user: bryan, category: category2)
#       book_1_proposal_1 = Fabricate(:proposal, sender_id: kimboss.id, reciever_id: joe.id, book_id: book.id)
#       book_1_proposal_2 = Fabricate(:proposal, sender_id: kimboss.id, reciever_id: joe.id, book_id: book.id)
#       book_1_proposal_3 = Fabricate(:proposal, sender_id: joe.id, reciever_id: kimboss.id, book_id: book.id, reciever_confirmation: true)
#       book_1_proposal_4 = Fabricate(:proposal, sender_id: kimboss.id, reciever_id: joe.id, book_id: book.id)
#       book_1_proposal_5 = Fabricate(:proposal, sender_id: joe.id, reciever_id: kimboss.id, book_id: book.id, reciever_confirmation: true)
#       book_2_proposal = Fabricate(:proposal, sender_id: kimboss.id, reciever_id: bryan.id, book_id: book2.id)
#       book_3_proposal= Fabricate(:proposal, sender_id: kimboss.id, reciever_id: bryan.id, book_id: book3.id)
#       post :accept, book_id: book.id, id: book_1_proposal_5.id
#       expect(Proposal.all.size).to eq(2)
#     end
#     it "it does not destroy other accepted proposals of books in same category that are legit, are the latest proposal for that book" do
#       kimboss = Fabricate(:user)
#       joe = Fabricate(:user)
#       bryan = Fabricate(:user)
#       session[:user_id] = kimboss.id
#       category1 = Fabricate(:category)
#       category2 = Fabricate(:category)
#       book = Fabricate(:book, user: joe, category: category1)
#       book2 = Fabricate(:book, user: bryan, category: category1)
#       book3 = Fabricate(:book, user: bryan, category: category2)
#       book_1_proposal = Fabricate(:proposal, sender_id: kimboss.id, reciever_id: joe.id, book_id: book.id)
#       book_1_proposal_2 = Fabricate(:proposal, sender_id: joe.id, reciever_id: kimboss.id, book_id: book.id, reciever_confirmation: true)
#       book_1_proposal_3 = Fabricate(:proposal, sender_id: joe.id, reciever_id: kimboss.id, book_id: book.id, reciever_confirmation: true)
#       book_1_proposal_4 = Fabricate(:proposal, sender_id: joe.id, reciever_id: kimboss.id, book_id: book.id, reciever_confirmation: true)
#       book_1_proposal_5 = Fabricate(:proposal, sender_id: joe.id, reciever_id: kimboss.id, book_id: book.id)
#       book_2_proposal = Fabricate(:proposal, sender_id: kimboss.id, reciever_id: bryan.id, book_id: book2.id, reciever_confirmation: true)
#       book_3_proposal= Fabricate(:proposal, sender_id: kimboss.id, reciever_id: bryan.id, book_id: book3.id, reciever_confirmation: true)
#       post :accept, book_id: book.id, id: book_1_proposal_5.id
#       expect(Proposal.all.size).to eq(3)
#     end
#     it "it destroys all previous proposals for book of category *other*" do
#       kimboss = Fabricate(:user)
#       joe = Fabricate(:user)
#       session[:user_id] = kimboss.id
#       category_Other = Fabricate(:category, name: "Other")
#       book = Fabricate(:book, user: joe, category: category_Other)
#       book_1_proposal_1 = Fabricate(:proposal, sender_id: kimboss.id, reciever_id: joe.id, book_id: book.id)
#       book_1_proposal_2 = Fabricate(:proposal, sender_id: kimboss.id, reciever_id: joe.id, book_id: book.id)
#       book_1_proposal_3 = Fabricate(:proposal, sender_id: joe.id, reciever_id: kimboss.id, book_id: book.id, reciever_confirmation: true)
#       book_1_proposal_4 = Fabricate(:proposal, sender_id: kimboss.id, reciever_id: joe.id, book_id: book.id)
#       book_1_proposal_5 = Fabricate(:proposal, sender_id: joe.id, reciever_id: kimboss.id, book_id: book.id)
#       post :accept, book_id: book.id, id: book_1_proposal_5.id
#       expect(Proposal.all.size).to eq(1)
#     end
#     it "it destroys all previous proposals for book of category *other*" do
#       kimboss = Fabricate(:user)
#       joe = Fabricate(:user)
#       session[:user_id] = kimboss.id
#       category_Other = Fabricate(:category, name: "Other")
#       book = Fabricate(:book, user: joe, category: category_Other)
#       book2 = Fabricate(:book, user: joe, category: category_Other)
#       book_1_proposal_1 = Fabricate(:proposal, sender_id: kimboss.id, reciever_id: joe.id, book_id: book.id)
#       book_1_proposal_2 = Fabricate(:proposal, sender_id: kimboss.id, reciever_id: joe.id, book_id: book.id)
#       book_1_proposal_3 = Fabricate(:proposal, sender_id: joe.id, reciever_id: kimboss.id, book_id: book.id)
#       book_1_proposal_4 = Fabricate(:proposal, sender_id: kimboss.id, reciever_id: joe.id, book_id: book.id)
#       book_1_proposal_5 = Fabricate(:proposal, sender_id: kimboss.id, reciever_id: joe.id, book_id: book.id)
#       book_1_proposal_6 = Fabricate(:proposal, sender_id: joe.id, reciever_id: kimboss.id, book_id: book.id)
#       book_2_proposal_1 = Fabricate(:proposal, sender_id: kimboss.id, reciever_id: joe.id, book_id: book2.id)
#       book_2_proposal_2 = Fabricate(:proposal, sender_id: joe.id, reciever_id: kimboss.id, book_id: book2.id)
#       post :accept, book_id: book.id, id: book_1_proposal_6.id
#       expect(Proposal.all.size).to eq(3)
#     end
#   end

#   context "DELETE cancel" do
#     it "redirects to show inbox page" do
#       kimboss = Fabricate(:user)
#       joe = Fabricate(:user)
#       session[:user_id] = kimboss.id
#       category1 = Fabricate(:category)
#       book = Fabricate(:book, user: joe, category: category1)
#       book_1_proposal = Fabricate(:proposal, sender_id: joe.id, reciever_id: kimboss.id, book_id: book.id)
#       delete :cancel, book_id: book.id, id: book_1_proposal.id
#       expect(response).to redirect_to inbox_path
#     end
#     it "should delete all proposals for that book with that negotiater" do
#       kimboss = Fabricate(:user)
#       joe = Fabricate(:user)
#       session[:user_id] = kimboss.id
#       category1 = Fabricate(:category)
#       book = Fabricate(:book, user: joe, category: category1)
#       book_1_proposal = Fabricate(:proposal, sender_id: joe.id, reciever_id: kimboss.id, book_id: book.id, reciever_confirmation: true)
#       book_1_proposal_2 = Fabricate(:proposal, sender_id: kimboss.id, reciever_id: joe.id, book_id: book.id)
#       book_1_proposal_3 = Fabricate(:proposal, sender_id: joe.id, reciever_id: kimboss.id, book_id: book.id)
#       book_1_proposal_4 = Fabricate(:proposal, sender_id: kimboss.id, reciever_id: joe.id, book_id: book.id, reciever_confirmation: true)
#       book_1_proposal_5 = Fabricate(:proposal, sender_id: joe.id, reciever_id: kimboss.id, book_id: book.id)
#       delete :cancel, book_id: book.id, id: book_1_proposal_5.id
#       expect(Proposal.all.size).to eq(0)
#     end
#     it "opens up proposal to be viewed if it was closed after being accepted" do
#       kimboss = Fabricate(:user)
#       joe = Fabricate(:user)
#       session[:user_id] = kimboss.id
#       category1 = Fabricate(:category)
#       book = Fabricate(:book, user: joe, category: category1)
#       book_1_proposal = Fabricate(:proposal, sender_id: kimboss.id, reciever_id: joe.id, book_id: book.id)
#       book_1_proposal_2 = Fabricate(:proposal, sender_id: joe.id, reciever_id: kimboss.id, book_id: book.id)
#       book_1_proposal_3 = Fabricate(:proposal, sender_id: kimboss.id, reciever_id: joe.id, book_id: book.id, reciever_confirmation: true)
#       delete :cancel, book_id: book.id, id: book_1_proposal_3.id
#       expect(Book.first.closed).to eq(nil)
#     end
#   end
# end








































