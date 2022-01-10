class User < ActiveRecord::Base
  
  # to use bcrypt
  has_secure_password
  
  validates :password, length: { minimum: 10 }
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  validates_uniqueness_of :email, :case_sensitive => false
  
  def self.authenticate_with_credentials(email, password)
    user = self.find_by_email(email)
    user && user.authenticate(password) ? user : nil
  end
end
