class User < ApplicationRecord

    VALID_USERNAME_FORMAT = /[a-zA-Z0-9_]/i

    validates :username, presence: true, length: { maximum: 28 },
                         format: { with: VALID_USERNAME_FORMAT },
                         uniqueness: { case_sensitive: true }

    has_secure_password
    validates  :password, presence: true, length: { minimum: 6 }
    
    has_many :ideas

end
