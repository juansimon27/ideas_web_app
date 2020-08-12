class Idea < ApplicationRecord

    belongs_to :user
    
    validates  :title, presence: true, length: { maximum: 128 }
    validates  :content, presence: true

end
