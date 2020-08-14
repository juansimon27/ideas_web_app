class User < ApplicationRecord
    before_save { email.downcase }

    VALID_USERNAME_FORMAT = /[a-zA-Z0-9_]/i
    VALID_EMAIL_FORMAT = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

    validates :username, presence: true, length: { maximum: 28 },
                         format: { with: VALID_USERNAME_FORMAT },
                         uniqueness: { case_sensitive: true }

    validates :email, presence: true, format: { with: VALID_EMAIL_FORMAT },
                                      uniqueness: { case_sensitive: false }

    has_secure_password
    validates  :password, presence: true, length: { minimum: 6 }
    validates  :password_confirmation, presence: true, length: { minimum: 6 }
    
    has_many :ideas

    def generate_password_reset_token!

        update_attribute(:reset_password_token, SecureRandom.hex(10))

    end

end
