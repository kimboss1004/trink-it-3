class MessagesController < ApplicationController
  before_action :require_user

  def create
    @book = Book.find(params[:id])
    @message = Message.new(sender: current_user, reciever: @book.user, book: @book, text: params[:message][:text])
    if @message.save
      flash[:success] = "Your message has been sent."
      redirect_to college_user_inbox_path(current_college, current_user)
    else
      render 'books/show'
    end
  end

  def inbox
    @messages_array = current_user.ordered_message_threads
  end

  def thread
    @message = Message.new
    leading_msg = Message.find(params[:id])
    @thread = Message.where("(sender_id = #{current_user.id} or reciever_id = #{current_user.id}) and (sender_id = #{current_user.other_guy(leading_msg).id} or reciever_id = #{current_user.other_guy(leading_msg).id}) and book_id = #{leading_msg.book.id}").order("created_at DESC")
    @thread.each do |msg|
      if msg.viewed.nil?
        msg.viewed = true;
        msg.save
      end
    end
  end

end