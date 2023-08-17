class Book < ApplicationRecord
    # Book モデルには、ActiveStorage を使って画像を持たせます。
    has_one_attached :profile_image 
    
    # PostImage モデルに対して、User モデルとの関係性を追加していきます。
    # PostImage モデルに関連付けられるのは、1 つの User モデルです。
    # このため、単数形の「user」になっている点に注意しましょう。
    belongs_to :user
    
     validates :title, presence: true # title：空でないように設定
     validates :body, length: { maximum: 200 }, presence: true # body：空でない、かつ最大200文字までに設定 
     # 不要なvalidatesのimageを削除
     
    
end