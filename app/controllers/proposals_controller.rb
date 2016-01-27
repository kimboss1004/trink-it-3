class ProposalsController < ApplicationController
  before_action :require_user

  def new
    @book = Book.find(params[:book_id])
    @proposal = Proposal.new(book: @book)
  end

  def create
    @book = Book.find(params[:book_id]) 
    @proposal = Proposal.new(proposal_params)
    @proposal.book = @book
    set_proposal_location
    set_sender_reciever
    if @proposal.save
      flash[:success] = "Book request has been sent!"
      redirect_to inbox_path
    else
      render :new
    end
    
  end

  def show
    @book = Book.find(params[:book_id])
    @proposal = Proposal.find(params[:id])
  end

  def get_change_proposal
    @book = Book.find(params[:book_id])
    @old_proposal = Proposal.find(params[:id])  
    @proposal = Proposal.new(date: @old_proposal.date, time: @old_proposal.time, location: @old_proposal.location)    
  end

  def change
    @book = Book.find(params[:book_id]) 
    @old_proposal = Proposal.find(params[:id])  
    @proposal = Proposal.new(proposal_params)
    @proposal.book = @book
    @proposal.sender = current_user
    @proposal.reciever = current_user.other_guy(@old_proposal)
    set_proposal_location
    if @proposal.save
      flash[:success] = "Meetup conditions changed and sent. Waiting for acceptance"
      redirect_to inbox_path
    else
      render :get_change_proposal
    end    
  end

  def accept
    @book = Book.find(params[:book_id])
    @proposal = Proposal.find(params[:id])
    @proposal.reciever_confirmation = true
    @book.closed = true

    if current_user == @proposal.reciever && @proposal.save && @book.save
      flash[:success] = "Meetup confirmed!"
      clear_buyers_unconfirmed_proposals_in_a_category
      flash[:success] = "Meetup confirmed!"
    end
    redirect_to inbox_path
  end

  def cancel
    @book = Book.find(params[:book_id])
    @proposal = Proposal.find(params[:id])
    @book.closed = nil
    current_user.all_proposals_of_this_book_for_me_and_this_guy(current_user.other_guy(@proposal), @book).destroy_all
    redirect_to inbox_path
  end




  private # ----------------------------------------------------

  def clear_buyers_unconfirmed_proposals_in_a_category
    if @proposal.book.category.name.downcase != "other"
      Proposal.where("(reciever_id = #{@proposal.buyer.id} or sender_id = #{@proposal.buyer.id})").joins(:book).where(books: { category_id: @book.category_id }).where.not(id: @proposal.buyer.confirmed_proposals).destroy_all
    else
      Proposal.where(book_id: @book.id).where.not(id: @proposal).destroy_all
    end
  end

  def set_sender_reciever
    @proposal.sender = current_user
    @proposal.reciever = @book.user
  end

  def set_proposal_location
    format_location_array
    @proposal.location = params[:proposal][:location].last
  end

  def format_location_array
    if params[:proposal][:location].last == "" 
      params[:proposal][:location].pop
      if params[:proposal][:location].last == "Other"
        params[:proposal][:location].pop      
      end 
    elsif params[:proposal][:location].size == 2 && (params[:proposal][:location].last == "Kogan Plaza" || params[:proposal][:location].last == "University Yard" || params[:proposal][:location].last == "Funger Entrance")
      params[:proposal][:location].pop
      params[:proposal][:location].pop if params[:proposal][:location].last == "Other"
    end
  end

  def proposal_params
    params.require(:proposal).permit(:book_id, :date, :time, :message)
  end



end