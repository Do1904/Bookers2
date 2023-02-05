class BookCommentsController < ApplicationController
  def create
    id = params[:book_id]
    book = Book.find(params[:book_id])
    comment = current_user.book_comments.new(book_comment_params)
    comment.book_id = book.id
    if comment.save
      flash[:success] = 'Comment added successfully'
      redirect_back(fallback_location: root_url)
    else
      @showing_book = Book.find(id)
      @user = @showing_book.user
      @book = Book.new
      @book_comment = BookComment.new
      render template: "books/show"
    end
    
  end
  
  def destroy
    BookComment.find(params[:id]).destroy
    redirect_back(fallback_location: root_url)
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
end
