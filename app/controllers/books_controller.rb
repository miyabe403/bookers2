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
    @books = Book.all
    @book = Book.all
  end

  def show
  end

  def edit
  end
  
 
end
