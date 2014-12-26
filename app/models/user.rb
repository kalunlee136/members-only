class User < ActiveRecord::Base
    before_create :create_remember_token
    has_many :posts
    has_secure_password
    validates :password, length: {minimum: 6}
    
    #creates a randomly generated string used for hashing password
    def User.new_remember_token
        SecureRandom.urlsafe_base64
    end
    
    #takes a string and hashes the password to be stored
    def User.digest(token)
        Digest::SHA1.hexdigest(token.to_s)
    end

  private

    def create_remember_token
      self.remember_token = User.digest(User.new_remember_token)
    end
end
