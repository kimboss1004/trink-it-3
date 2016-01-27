class CategoriesController < ApplicationController

  def show
    @category = Category.find(params[:id])
    @books = Book.where(category: @category, college: current_college).order("created_at DESC").page(params[:page]).per(15)
  end

end