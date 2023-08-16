class UsersController < ApplicationController
  # メソッドとして処理をまとめたことで、before_actionを使用することができます。
  # before_actionは、コントローラーで各アクションを実行する前に実行したい処理を指定することができるメソッドです。
  # 実行したい処理は、メソッドとしてまとめることで実行できます。
  # before_action :is_matching_login_user, only: [:edit, :update]
  
  def index
   @user = User.all
   @users = User.all
   @book = Book.new  # 部分テンプレートを呼び出すときに空の変数を用意 
  end

  def show
   @user = User.find(params[:id])
   @books = @user.books
   @book = Book.new # 部分テンプレートを呼び出すときに空の変数を用意
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user.id)
  end
  
  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
  
  def is_matching_login_user
    user = User.find(params[:id])  # 1. URLに含まれるユーザーidをparams[:id]で取得
    unless user.id == current_user.id  # 2. ログインしているユーザーのidをcurrent_user.idで取得
      redirect_to books_path  # 3. 1と2のidが一致していなかった場合、 投稿一覧にリダイレクトする
    end
  end
end
