class User < ActiveRecord::Base
  has_secure_password :validations => false
  has_many :books, dependent: :destroy
  has_many :profile_images
  has_many :sent, class_name: "Message", foreign_key: "sender_id"
  has_many :recieved, class_name: "Message", foreign_key: "reciever_id"  
  belongs_to :college
  # has_many :sent_proposals, class_name: "Proposal", foreign_key: "sender_id"
  # has_many :recieved_proposals, class_name: "Proposal", foreign_key: "reciever_id"

  validates :name, presence: true
  validates :email_address, presence: true, uniqueness: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
  validates :password, presence: true, length: { maximum: 20 }, if: :user_validations_needed?
 


  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider 
      user.uid      = auth.uid
      user.name     = auth.info.name
      user.email_address = auth.info.email
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save
    end
  end

  def in_college?
    return !!college
  end

  def user_validations_needed?
    if created_at.nil? && provider.nil?
      return true
    else
      return false
    end
  end

# --------------------- Messages --------------------------------------------------

  def ordered_message_threads
    bin = []
    my_messages = gather_my_messages
    my_messages.sort_by(&:created_at).each do |msg|
      if !bin.flatten.include?(msg)
        sub_bin = Message.where("(sender_id = #{self.id} or reciever_id = #{self.id}) and (sender_id = #{other_guy(msg).id} or reciever_id = #{other_guy(msg).id}) and book_id = #{msg.book.id}").order("created_at DESC")
        bin << sub_bin
      end
    end
    return bin
  end

  def gather_my_messages
    my_messages = []
    my_messages << self.sent
    my_messages << self.recieved
    return my_messages.flatten!
  end

  def other_guy(message)
    if message.sender == self
      return message.reciever
    else
      return message.sender
    end
  end

 # ---------------------------------- PRoposals --------------------------------------------
  # def unique_recieved_proposals
  #   dropbox = []
  #   recieved_proposals.where(reciever_confirmation: nil).each do |proposal|
  #     if unique_proposal?(proposal) && proposal == latest_proposal_of_this_book_related_to_me_and_my_guy(other_guy(proposal), proposal.book)
  #       dropbox << proposal
  #     end
  #   end
  #   return dropbox
  # end


  # def recieved_change_proposals
  #   dropbox = []
  #   recieved_proposals.where(reciever_confirmation: nil).each do |proposal|
  #     if !unique_proposal?(proposal) && proposal == latest_proposal_of_this_book_related_to_me_and_my_guy(other_guy(proposal), proposal.book)
  #       dropbox << proposal
  #     end
  #   end
  #   return dropbox    
  # end

  # def confirmed_proposals
  #   dropbox = []
  #   my_proposals.where(reciever_confirmation: true).each do |accepted_proposal|
  #     if accepted_proposal == latest_proposal_of_this_book_related_to_me_and_my_guy(other_guy(accepted_proposal), accepted_proposal.book)
  #       dropbox << accepted_proposal
  #     end
  #   end
  #   return dropbox
  # end

  # def pending_sent_proposals
  #   dropbox = []
  #   sent_proposals.where(reciever_confirmation: nil).each do |sent_proposal|
  #     dropbox << sent_proposal if sent_proposal == latest_proposal_of_this_book_related_to_me_and_my_guy(other_guy(sent_proposal), sent_proposal.book)
  #   end
  #   return dropbox
  # end


  # # returns other guy in proposal who is not current user
  # def other_guy(proposal)
  #   if proposal.reciever != self
  #     return proposal.reciever
  #   else
  #     return proposal.sender
  #   end
  # end

  # def all_proposals_of_this_book_for_me_and_this_guy(other_guy, book)
  #   Proposal.where("(reciever_id = #{self.id} or sender_id = #{self.id}) and (reciever_id = #{other_guy.id} or sender_id = #{other_guy.id}) and book_id = #{book.id}")
  # end

  # private # ------------------------------------------

  # # when using this method, make sure other guy is for sure not current user
  # def latest_proposal_of_this_book_related_to_me_and_my_guy(other_guy, book)
  #   Proposal.where("(reciever_id = #{self.id} or sender_id = #{self.id}) and (reciever_id = #{other_guy.id} or sender_id = #{other_guy.id}) and book_id = #{book.id}").last
  # end




  # # all my sent and recieved proposals
  # def my_proposals
  #   Proposal.where("(reciever_id = #{id}) or sender_id = #{id}")
  # end

  # # returns false if both users have sent each other a proposal for certain book, else returns true if only one user had sent a proposal
  # def unique_proposal?(proposal)
  #   if Proposal.where("((reciever_id = #{self.id}) and sender_id = #{other_guy(proposal).id}) and book_id = #{proposal.book_id}").any? && Proposal.where("((reciever_id = #{other_guy(proposal).id}) and sender_id = #{self.id}) and book_id = #{proposal.book_id}").any? 
  #     return false
  #   else
  #     return true
  #   end
  # end

end