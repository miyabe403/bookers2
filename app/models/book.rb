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
    
    
end