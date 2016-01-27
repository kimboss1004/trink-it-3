require 'spec_helper'


describe User do

  # it "should have many recieved proposals" do
  #   kimboss = Fabricate(:user)
  #   joe = Fabricate(:user)
  #   category1 = Fabricate(:category)
  #   book = Fabricate(:book, user: joe, category: category1)
  #   book2 = Fabricate(:book, user: joe, category: category1)
  #   proposal = Fabricate(:proposal, sender_id: kimboss.id, reciever_id: joe.id, book_id: book.id)
  #   proposal2 = Fabricate(:proposal, sender_id: kimboss.id, reciever_id: joe.id, book_id: book2.id)
  #   expect(joe.recieved_proposals).to eq([proposal, proposal2])
  # end

  # it "should have many sent proposals" do
  #   kimboss = Fabricate(:user)
  #   joe = Fabricate(:user)
  #   category1 = Fabricate(:category)
  #   book = Fabricate(:book, user: joe, category: category1)
  #   book2 = Fabricate(:book, user: joe, category: category1)
  #   proposal = Fabricate(:proposal, sender_id: kimboss.id, reciever_id: joe.id, book_id: book.id)
  #   proposal2 = Fabricate(:proposal, sender_id: kimboss.id, reciever_id: joe.id, book_id: book2.id)
  #   expect(kimboss.sent_proposals).to eq([proposal, proposal2])
  # end

  # context "#unique_recieved_proposals" do
  #   it "return empty array if user has no recieved proposals with no confirmation" do
  #     kimboss = Fabricate(:user)
  #     expect(kimboss.unique_recieved_proposals).to eq([])
  #   end
  #   it "returns [] if proposal has confirmations" do
  #     kimboss = Fabricate(:user)
  #     joe = Fabricate(:user)
  #     category1 = Fabricate(:category)
  #     book = Fabricate(:book, user: joe, category: category1)
  #     book2 = Fabricate(:book, user: joe, category: category1)
  #     proposal = Fabricate(:proposal, sender_id: kimboss.id, reciever_id: joe.id, book_id: book.id, reciever_confirmation: true)
  #     expect(joe.unique_recieved_proposals).to eq([])
  #   end
  #   it "returns [] when proposal is not unique" do
  #     kimboss = Fabricate(:user)
  #     joe = Fabricate(:user)
  #     category1 = Fabricate(:category)
  #     book = Fabricate(:book, user: joe, category: category1)
  #     proposal = Fabricate(:proposal, sender_id: kimboss.id, reciever_id: joe.id, book_id: book.id)
  #     changed_proposal1 = Fabricate(:proposal, sender_id: joe.id, reciever_id: kimboss.id, book_id: book.id)
  #     changed_proposal2 = Fabricate(:proposal, sender_id: kimboss.id, reciever_id: joe.id, book_id: book.id)
  #     expect(joe.unique_recieved_proposals).to eq([])
  #   end
  #   it "does not return sent proposals even if unique" do
  #     kimboss = Fabricate(:user)
  #     joe = Fabricate(:user)
  #     category1 = Fabricate(:category)
  #     book = Fabricate(:book, user: joe, category: category1)
  #     proposal = Fabricate(:proposal, sender_id: kimboss.id, reciever_id: joe.id, book_id: book.id)
  #     expect(kimboss.unique_recieved_proposals).to eq([])
  #   end
  #   it "returns one unique recieved proposal" do
  #     kimboss = Fabricate(:user)
  #     joe = Fabricate(:user)
  #     category1 = Fabricate(:category)
  #     book = Fabricate(:book, user: joe, category: category1)
  #     proposal = Fabricate(:proposal, sender_id: kimboss.id, reciever_id: joe.id, book_id: book.id)
  #     expect(joe.unique_recieved_proposals).to eq([proposal])
  #   end
  #   it "returns two unique recieved proposals from two diff buyers" do
  #     kimboss = Fabricate(:user)
  #     bryan = Fabricate(:user)
  #     joe = Fabricate(:user)
  #     category1 = Fabricate(:category)
  #     book = Fabricate(:book, user: joe, category: category1)
  #     proposal = Fabricate(:proposal, sender_id: bryan.id, reciever_id: joe.id, book_id: book.id)
  #     proposal2 = Fabricate(:proposal, sender_id: kimboss.id, reciever_id: joe.id, book_id: book.id)
  #     expect(joe.unique_recieved_proposals).to eq([proposal, proposal2])
  #   end
  #   it "returns one unique recieved proposals and rejects nonunique recieved proposal" do
  #     kimboss = Fabricate(:user)
  #     bryan = Fabricate(:user)
  #     joe = Fabricate(:user)
  #     category1 = Fabricate(:category)
  #     book = Fabricate(:book, user: joe, category: category1)
  #     proposal = Fabricate(:proposal, sender_id: bryan.id, reciever_id: joe.id, book_id: book.id)
  #     changed_proposal1 = Fabricate(:proposal, sender_id: joe.id, reciever_id: bryan.id, book_id: book.id)
  #     changed_proposal2 = Fabricate(:proposal, sender_id: bryan.id, reciever_id: joe.id, book_id: book.id)
  #     proposal2 = Fabricate(:proposal, sender_id: kimboss.id, reciever_id: joe.id, book_id: book.id)
  #     expect(joe.unique_recieved_proposals).to eq([proposal2])
  #   end
  # end

  # context "#recieved_change_proposals" do
  #   it "returns [] if there are no changed proposals" do
  #     kimboss = Fabricate(:user)
  #     expect(kimboss.recieved_change_proposals).to eq([])
  #   end
  #   it "doesn't return sent proposals even if they are changed" do
  #     kimboss = Fabricate(:user)
  #     joe = Fabricate(:user)
  #     category1 = Fabricate(:category)
  #     book = Fabricate(:book, user: joe, category: category1)
  #     proposal = Fabricate(:proposal, sender_id: kimboss.id, reciever_id: joe.id, book_id: book.id)
  #     changed_proposal1 = Fabricate(:proposal, sender_id: joe.id, reciever_id: kimboss.id, book_id: book.id)
  #     expect(joe.recieved_change_proposals).to eq([])
  #   end
  #   it "returns 1 changed proposals" do
  #     kimboss = Fabricate(:user)
  #     joe = Fabricate(:user)
  #     category1 = Fabricate(:category)
  #     book = Fabricate(:book, user: joe, category: category1)
  #     proposal = Fabricate(:proposal, sender_id: kimboss.id, reciever_id: joe.id, book_id: book.id)
  #     changed_proposal1 = Fabricate(:proposal, sender_id: joe.id, reciever_id: kimboss.id, book_id: book.id)
  #     expect(kimboss.recieved_change_proposals).to eq([changed_proposal1])
  #   end
  #   it "returns latest changed proposal thats been changed 5 times" do
  #     kimboss = Fabricate(:user)
  #     joe = Fabricate(:user)
  #     category1 = Fabricate(:category)
  #     book = Fabricate(:book, user: joe, category: category1)
  #     proposal = Fabricate(:proposal, sender_id: kimboss.id, reciever_id: joe.id, book_id: book.id)
  #     changed_proposal1 = Fabricate(:proposal, sender_id: joe.id, reciever_id: kimboss.id, book_id: book.id)
  #     changed_proposal2 = Fabricate(:proposal, sender_id: kimboss.id, reciever_id: joe.id, book_id: book.id)
  #     changed_proposal3 = Fabricate(:proposal, sender_id: joe.id, reciever_id: kimboss.id, book_id: book.id)
  #     changed_proposal4 = Fabricate(:proposal, sender_id: kimboss.id, reciever_id: joe.id, book_id: book.id)
  #     expect(joe.recieved_change_proposals).to eq([changed_proposal4])
  #   end
  #   it "returns 2 changed proposals from 2 diff users on same book" do
  #     kimboss = Fabricate(:user)
  #     joe = Fabricate(:user)
  #     bryan = Fabricate(:user)
  #     category1 = Fabricate(:category)
  #     book = Fabricate(:book, user: kimboss, category: category1)
  #     proposal = Fabricate(:proposal, sender_id: joe.id, reciever_id: kimboss.id, book_id: book.id)
  #     changed_proposal1 = Fabricate(:proposal, sender_id: kimboss.id, reciever_id: joe.id, book_id: book.id)
  #     changed_proposal2 = Fabricate(:proposal, sender_id: joe.id, reciever_id: kimboss.id, book_id: book.id)
  #     proposal2 = Fabricate(:proposal, sender_id: bryan.id, reciever_id: kimboss.id, book_id: book.id)
  #     changed_proposal3 = Fabricate(:proposal, sender_id: kimboss.id, reciever_id: bryan.id, book_id: book.id)
  #     changed_proposal4 = Fabricate(:proposal, sender_id: bryan.id, reciever_id: kimboss.id, book_id: book.id)
  #     expect(kimboss.recieved_change_proposals).to eq([changed_proposal2, changed_proposal4])
  #   end
  #   it "returns changed proposals for 2 different books" do
  #     kimboss = Fabricate(:user)
  #     joe = Fabricate(:user)
  #     bryan = Fabricate(:user)
  #     category1 = Fabricate(:category)
  #     book = Fabricate(:book, user: kimboss, category: category1)
  #     book2 = Fabricate(:book, user: kimboss, category: category1)
  #     proposal = Fabricate(:proposal, sender_id: joe.id, reciever_id: kimboss.id, book_id: book.id)
  #     changed_proposal1 = Fabricate(:proposal, sender_id: kimboss.id, reciever_id: joe.id, book_id: book.id)
  #     changed_proposal2 = Fabricate(:proposal, sender_id: joe.id, reciever_id: kimboss.id, book_id: book.id)
  #     proposal2 = Fabricate(:proposal, sender_id: bryan.id, reciever_id: kimboss.id, book_id: book2.id)
  #     changed_proposal3 = Fabricate(:proposal, sender_id: kimboss.id, reciever_id: bryan.id, book_id: book2.id)
  #     changed_proposal4 = Fabricate(:proposal, sender_id: bryan.id, reciever_id: kimboss.id, book_id: book2.id)
  #     expect(kimboss.recieved_change_proposals).to eq([changed_proposal2, changed_proposal4])
  #   end
  #   it "returns [] if proposal is unique" do
  #     kimboss = Fabricate(:user)
  #     joe = Fabricate(:user)
  #     category1 = Fabricate(:category)
  #     book = Fabricate(:book, user: joe, category: category1)
  #     proposal = Fabricate(:proposal, sender_id: kimboss.id, reciever_id: joe.id, book_id: book.id)
  #     expect(joe.recieved_change_proposals).to eq([])
  #   end
  # end


  # context "#confirmed_proposals" do
  #   it "returns 0 accepted proposal" do
  #     kimboss = Fabricate(:user)
  #     joe = Fabricate(:user)
  #     category1 = Fabricate(:category)
  #     book = Fabricate(:book, user: joe, category: category1)
  #     expect(kimboss.confirmed_proposals).to eq([])
  #   end
  #   it "returns 1 accepted proposal" do
  #     kimboss = Fabricate(:user)
  #     joe = Fabricate(:user)
  #     category1 = Fabricate(:category)
  #     book = Fabricate(:book, user: joe, category: category1)
  #     proposal = Fabricate(:proposal, sender_id: kimboss.id, reciever_id: joe.id, book_id: book.id, reciever_confirmation: true)
  #     expect(kimboss.confirmed_proposals).to eq([proposal])
  #   end
  #   it "returns 2 accepted proposals" do
  #     kimboss = Fabricate(:user)
  #     joe = Fabricate(:user)
  #     bryan = Fabricate(:user)
  #     category1 = Fabricate(:category)
  #     book = Fabricate(:book, user: joe, category: category1)
  #     book2 = Fabricate(:book, user: bryan, category: category1)
  #     proposal1 = Fabricate(:proposal, sender_id: kimboss.id, reciever_id: joe.id, book_id: book.id, reciever_confirmation: true)
  #     proposal2 = Fabricate(:proposal, sender_id: kimboss.id, reciever_id: bryan.id, book_id: book2.id, reciever_confirmation: true)
  #     expect(kimboss.confirmed_proposals).to eq([proposal1, proposal2])
  #   end
  #   it "other guy accepts proposal, but then he sends change proposal. returns []" do
  #     kimboss = Fabricate(:user)
  #     joe = Fabricate(:user)
  #     category1 = Fabricate(:category)
  #     book = Fabricate(:book, user: joe, category: category1)
  #     proposal = Fabricate(:proposal, sender_id: kimboss.id, reciever_id: joe.id, book_id: book.id, reciever_confirmation: true)
  #     changeProposal = Fabricate(:proposal, sender_id: joe.id, reciever_id: kimboss.id, book_id: book.id)
  #     expect(kimboss.confirmed_proposals).to eq([])
  #   end
  #   it "other guy accepts proposal, then I send change proposal. returns []" do
  #     kimboss = Fabricate(:user)
  #     joe = Fabricate(:user)
  #     category1 = Fabricate(:category)
  #     book = Fabricate(:book, user: joe, category: category1)
  #     proposal = Fabricate(:proposal, sender_id: kimboss.id, reciever_id: joe.id, book_id: book.id, reciever_confirmation: true)
  #     accepted_change_proposal = Fabricate(:proposal, sender_id: kimboss.id, reciever_id: joe.id, book_id: book.id, reciever_confirmation: true)
  #     expect(kimboss.confirmed_proposals).to eq([accepted_change_proposal])
  #   end
  #   it "other guy accepts proposal, then I send change proposal that he accepts. returns it" do
  #     kimboss = Fabricate(:user)
  #     joe = Fabricate(:user)
  #     category1 = Fabricate(:category)
  #     book = Fabricate(:book, user: joe, category: category1)
  #     proposal = Fabricate(:proposal, sender_id: kimboss.id, reciever_id: joe.id, book_id: book.id, reciever_confirmation: true)
  #     accepted_change_proposal = Fabricate(:proposal, sender_id: kimboss.id, reciever_id: joe.id, book_id: book.id, reciever_confirmation: true)
  #     expect(kimboss.confirmed_proposals).to eq([accepted_change_proposal])
  #   end
  # end

  # context "#latest_proposal_of_this_book_related_to_me_and_my_guy" do
  #   it "returns the latest proposal between other guy and me for my book" do
  #     kimboss = Fabricate(:user)
  #     joe = Fabricate(:user)
  #     category1 = Fabricate(:category)
  #     book = Fabricate(:book, user: kimboss, category: category1)
  #     proposal1 = Fabricate(:proposal, sender_id: joe.id, reciever_id: kimboss.id, book_id: book.id)
  #     change_proposal1 = Fabricate(:proposal, sender_id: kimboss.id, reciever_id: joe.id, book_id: book.id, reciever_confirmation: true)
  #     expect(kimboss.send(:latest_proposal_of_this_book_related_to_me_and_my_guy, joe, book)).to eq(change_proposal1)
  #   end
  #   it "differentiates my guy's proposals from proposal exchanges of other users for that same book" do
  #     kimboss = Fabricate(:user)
  #     joe = Fabricate(:user)
  #     bryan = Fabricate(:user)
  #     category1 = Fabricate(:category)
  #     book = Fabricate(:book, user: joe, category: category1)
  #     proposal1 = Fabricate(:proposal, sender_id: joe.id, reciever_id: kimboss.id, book_id: book.id)
  #     proposal2 = Fabricate(:proposal, sender_id: bryan.id, reciever_id: kimboss.id, book_id: book.id)
  #     change_proposal1 = Fabricate(:proposal, sender_id: kimboss.id, reciever_id: joe.id, book_id: book.id)
  #     change_proposal2 = Fabricate(:proposal, sender_id: kimboss.id, reciever_id: bryan.id, book_id: book.id)
  #     expect(kimboss.send(:latest_proposal_of_this_book_related_to_me_and_my_guy, joe, book)).to eq(change_proposal1)
  #   end
  # end


  # context "pending_sent_proposals" do
  #   it "returns 0 sent proposals if none sent" do
  #     kimboss = Fabricate(:user)
  #     user2 = Fabricate(:user)
  #     category1 = Fabricate(:category)
  #     book = Fabricate(:book, user: user2, category: category1)
  #     expect(kimboss.pending_sent_proposals).to eq([])
  #   end
  #   it "returns 0 sent proposals if sent proposal is accepted" do
  #     kimboss = Fabricate(:user)
  #     user2 = Fabricate(:user)
  #     category1 = Fabricate(:category)
  #     book = Fabricate(:book, user: user2, category: category1)
  #     proposal = Fabricate(:proposal, sender_id: kimboss.id, reciever_id: user2.id, book_id: book.id, reciever_confirmation: true)
  #     expect(kimboss.pending_sent_proposals).to eq([])
  #   end
  #   it "returns 0 sent proposals if sent proposal is canceled" do
  #     kimboss = Fabricate(:user)
  #     user2 = Fabricate(:user)
  #     category1 = Fabricate(:category)
  #     book = Fabricate(:book, user: user2, category: category1)
  #     proposal = Fabricate(:proposal, sender_id: kimboss.id, reciever_id: user2.id, book_id: book.id, reciever_confirmation: false)
  #     expect(kimboss.pending_sent_proposals).to eq([])
  #   end
  #   it "returns 0 sent proposals if sent proposal is changed by reciever" do
  #     kimboss = Fabricate(:user)
  #     user2 = Fabricate(:user)
  #     category1 = Fabricate(:category)
  #     book = Fabricate(:book, user: user2, category: category1)
  #     proposal = Fabricate(:proposal, sender_id: kimboss.id, reciever_id: user2.id, book_id: book.id)
  #     proposal2 = Fabricate(:proposal, sender_id: user2.id, reciever_id: kimboss.id, book_id: book.id)
  #     expect(kimboss.pending_sent_proposals).to eq([])
  #   end
  #   it "returns 1 sent proposal" do
  #     kimboss = Fabricate(:user)
  #     user2 = Fabricate(:user)
  #     category1 = Fabricate(:category)
  #     book = Fabricate(:book, user: user2, category: category1)
  #     proposal = Fabricate(:proposal, sender_id: kimboss.id, reciever_id: user2.id, book_id: book.id)
  #     expect(kimboss.pending_sent_proposals).to eq([proposal])
  #   end
  #   it "returns change proposal I sent if it is the latest proposal" do
  #     kimboss = Fabricate(:user)
  #     user2 = Fabricate(:user)
  #     category1 = Fabricate(:category)
  #     book = Fabricate(:book, user: user2, category: category1)
  #     proposal = Fabricate(:proposal, sender_id: user2.id, reciever_id: kimboss.id, book_id: book.id)
  #     proposal2 = Fabricate(:proposal, sender_id: kimboss.id, reciever_id: user2.id, book_id: book.id)
  #     expect(kimboss.pending_sent_proposals).to eq([proposal2])
  #   end
  #   it "returns 2 sent proposals" do
  #     kimboss = Fabricate(:user)
  #     user2 = Fabricate(:user)
  #     user3 = Fabricate(:user)
  #     category1 = Fabricate(:category)
  #     book = Fabricate(:book, user: user2, category: category1)
  #     book_2 = Fabricate(:book, user: user3, category: category1)
  #     proposal = Fabricate(:proposal, sender_id: kimboss.id, reciever_id: user2.id, book_id: book.id)
  #     proposal2 = Fabricate(:proposal, sender_id: kimboss.id, reciever_id: user3.id, book_id: book_2.id)
  #     expect(kimboss.pending_sent_proposals).to eq([proposal,proposal2])
  #   end
  # end

end






