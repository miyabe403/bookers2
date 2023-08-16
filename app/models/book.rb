class Book < ApplicationRecord
    # Book モデルには、ActiveStorage を使って画像を持たせます。
    has_one_attached :image
    
    # PostImage モデルに対して、User モデルとの関係性を追加していきます。
    # PostImage モデルに関連付けられるのは、1 つの User モデルです。
    # このため、単数形の「user」になっている点に注意しましょう。
    belongs_to :user
    
     validates :title, presence: true
     validates :body, presence: true
     validates :image, presence: true
    
    # get_image メソッド =特定の処理を名前で呼び出すことができる
    # unless = 画像が設定されない場合はimagesに格納されているno_image.jpgという画像をデフォルト画像としてActiveStorageに格納する
    def get_image
      unless image.attached?
        file_path = Rails.root.join('app/assets/images/no_image.jpg')
        image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
      end
      image
    end
end