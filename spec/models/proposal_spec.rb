# require 'spec_helper'


# describe Proposal do

#   it "should belong to user that sent it" do
#     kimboss = Fabricate(:user)
#     joe = Fabricate(:user)
#     category1 = Fabricate(:category)
#     book = Fabricate(:book, user: joe, category: category1)
#     proposal = Fabricate(:proposal, sender_id: kimboss.id, reciever_id: joe.id, book_id: book.id)
#     expect(proposal.sender).to eq(kimboss)
#   end
#   it "should belong to user that recieved it" do
#     kimboss = Fabricate(:user)
#     joe = Fabricate(:user)
#     category1 = Fabricate(:category)
#     book = Fabricate(:book, user: joe, category: category1)
#     proposal = Fabricate(:proposal, sender_id: kimboss.id, reciever_id: joe.id, book_id: book.id)
#     expect(proposal.reciever).to eq(joe)
#   end


# end