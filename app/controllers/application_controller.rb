class ApplicationController < ActionController::Base
   before_action :authenticate_user!, except: [:top, :about] # ログインしていない状態でトップページ・アバウトページ以外にアクセスされた場合は、ログイン画面へリダイレクトするように設定
  # devise利用の機能（ユーザ登録、ログイン認証など）が使われる前にconfigure_permitted_parametersメソッドが実行されます。
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  # after_sign_in_path_forはDeviseが用意しているメソッドで、サインイン後にどこに遷移するかを設定しているメソッドです。
  def after_sign_in_path_for(resource)
    user_path(current_user.id)
  end
   
  # after_sign_out_path_forはDeviseが用意しているメソッドでサインアウト後にどこに遷移するかを設定するメソッドです。
  def after_sign_out_path_for(resource)
    root_path  
  end
  
   # protectedは呼び出された他のコントローラからも参照することができます。
  protected
  
   # ストロングパラメータの設定
  # configure_permitted_parametersメソッドでは、devise_parameter_sanitizer.permitメソッドを使うことで
  # ユーザー登録(sign_up)の際に、ユーザー名(name)のデータ操作を許可しています。
  def configure_permitted_parameters 
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email]) # emailの値も認証に使えるように変更 
  end
end
