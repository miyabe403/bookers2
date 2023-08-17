class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  #（パスワードの正確性を検証）（ユーザ登録や編集、削除）
  #（パスワードをリセット）（ログイン情報を保存）（email のフォーマットなどのバリデーション）
  
  has_many :books, dependent: :destroy
  
  # profile_imageという名前でActiveStorageでプロフィール画像を保存
  has_one_attached :profile_image
  
  validates :name, length: { in: 2..20 }, presence: true, uniqueness: true # name：一意性を持たせ、かつ2～20文字の範囲で設定
  validates :introduction, length: { maximum: 50 }, presence: true # introduction：最大50文字までに設定
  validates :profile_image, presence: true
  
  # get_image メソッド =特定の処理を名前で呼び出すことができる 
  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/sample-author1.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image-jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed # 画像サイズの変更を行っています
  end
end
