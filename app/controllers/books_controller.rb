class BooksController < ApplicationController
  # メソッドとして処理をまとめたことで、before_actionを使用することができます。
  # before_actionは、コントローラーで各アクションを実行する前に実行したい処理を指定することができるメソッドです。
  # 実行したい処理は、メソッドとしてまとめることで実行できます。
  before_action :is_matching_login_user, only: [:edit, :update]
  
  def new
    @book = Book.new
  end
  
  # 投稿データの保存
  def create
    @book = Book.new(book_params) # 投稿するデータを Book モデルに紐づくデータとして保存する準備している
    @book.user_id = current_user.id  # 空のモデルでは、"[モデル名].[カラム名]"という形で、保存する。 current_user は、ログイン中のユーザー情報を取得することができる

    if @book.save
      flash[:notice] = "successfully" 
      redirect_to book_path(@book.id) #current_user.id では無く@book.idを指定する
    else
      # flash.now[:alert] = "errors"  #キーをalertに変更
      @books = Book.all #バリテーションのエラーメッセージを表示用に使用する一覧データ取得用の変数 
      render :index #render の遷移先を index に変更 
    end
  end
 
  def index 
    # @books = Book.all
    @book = Book.new #空のインスタンスを用意
    @books = Book.all
  end
 
  def show
    @book_new = Book.new #空のインスタンスを用意 formの中身を空にする用
    @book = Book.find(params[:id])
  end

  def edit 
    @book = Book.find(params[:id]) 
    @user = current_user
    if @book.user != @user # ブックのユーザと現在のユーザが等しくないとき
      redirect_to books_path # 投稿一覧へ遷移する
    end
  end
   
  def update
    @book = Book.find(params[:id])
    # book.update(book_params)
    # redirect_to book_path(book.id)
    
    if @book.update(book_params)  # 3. データが入力されていればデータをデータベースに保存するためのupdateメソッド実行
      # 4. フラッシュメッセージを定義し、詳細画面へリダイレクト
      flash[:notice] = "successfully"
      redirect_to book_path(@book.id)  # 「転送したいアクションへのURL」を指定します。 
    else  # データが入力されていなければ、saveメソッドでfalseが返されます。
      # 4. flash.nowでフラッシュメッセージを定義し、new.html.erbを描画する
      # flash.now[:alert] = "errors"  #キーをalertに変更
      @book = @book # 更新途中のデータを格納する　
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
  
  def is_matching_login_user
    book = Book.find(params[:id])  # 1. URLに含まれるブックidをparams[:id]で取得
    unless book.user.id == current_user.id  # 2. ブックに紐づくユーザーの取得とログインしているユーザーのidをcurrent_user.idで取得
      redirect_to books_path  # 3. 1と2のidが一致していなかった場合、 投稿一覧にリダイレクトする
    end
  end
end
