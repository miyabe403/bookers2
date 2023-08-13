class Book < ApplicationRecord
    # PostImage モデルには、ActiveStorage を使って画像を持たせます。
    has_one_attached :image
    
    belongs_to :user
end