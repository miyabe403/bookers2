class BooksController < ApplicationController
  def new
    @book = Book.new
  end
  
  # 投稿データの保存
  def create
    @book = Book.new(book_params) # 投稿するデータを Book モデルに紐づくデータとして保存する準備している
    @book.user_id = current_user.id  # 空のモデルでは、"[モデル名].[カラム名]"という形で、保存する。 current_user は、ログイン中のユーザー情報を取得することができる

    if @book.save
      redirect_to books_path
    else
      render :new
    end
  end
 
  def index 
    # @books = Book.all
    @book = Book.all
    @books = Book.all
  end

  def show
    @post_image = PostImage.find(params[:id])
  end

  def edit
    @book = Book.find(params[:id])
  end
  
  def show
    @book = Book.find(params[:id])
  end
  
  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to '/books'
  end
  
 # 投稿データのストロングパラメータ 
  private

  def book_params
    params.require(:book).permit(:title, :body, :image)
  end
end
