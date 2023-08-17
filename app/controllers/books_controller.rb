class BooksController < ApplicationController
  def new
    @book = Book.new
  end
  
  # 投稿データの保存
  def create
    @book = Book.new(book_params) # 投稿するデータを Book モデルに紐づくデータとして保存する準備している
    @book.user_id = current_user.id  # 空のモデルでは、"[モデル名].[カラム名]"という形で、保存する。 current_user は、ログイン中のユーザー情報を取得することができる

    if @book.save
      redirect_to book_path(@book.id) #current_user.id では無く@book.idを指定する
    else
      render :new 
    end
  end
 
  def index 
    # @books = Book.all
    @book = Book.new #空のインスタンスを用意
    @books = Book.all
  end
 
  def show
    @book = Book.new #空のインスタンスを用意 
    @books = Book.all
  end

  def edit
    @book = Book.find(params[:id]) 
  end
  
  def show
    @book = Book.find(params[:id])
  end
   
  def update
    book = Book.find(params[:id])
    # book.update(book_params)
    # redirect_to book_path(book.id)
    
    if book.update(book_params)  # 3. データが入力されていればデータをデータベースに保存するためのupdateメソッド実行
      # 4. フラッシュメッセージを定義し、詳細画面へリダイレクト
      flash[:notice] = "successfully"
      redirect_to book_path(book.id)  # 「転送したいアクションへのURL」を指定します。
    else  # データが入力されていなければ、saveメソッドでfalseが返されます。
      # 4. flash.nowでフラッシュメッセージを定義し、new.html.erbを描画する
      flash.now[:alert] = "errors"  #キーをalertに変更
      @books = Book.all
      @book = Book.new
      render :edit  #  render :アクション名で、同じコントローラ内の別アクションのViewを表示できます。　
    end
  end
  
  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to '/books'
  end
  
 # 投稿データのストロングパラメータ 
  private

  def book_params
    params.require(:book).permit(:title, :body)  # ストロングパラメータの不要な image を削除
  end 
end
