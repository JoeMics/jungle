class User < ActiveRecord::Base

  # to use bcrypt
  has_secure_password

end
