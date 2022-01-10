require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    before {
      @user_params = {
        first_name: 'Joseph',
        last_name: 'Joestar',
        email: 'jojo@jomail.com',
        password: 'joestarsecrettechnique',
        password_confirmation: 'joestarsecrettechnique'
      }
    }

    it 'should save successfully when all fields are present and correct' do
      @user = User.new(@user_params)
      @user.save!
  
      expect(@user.id).to be_present
    end

    it 'should not save successfully when first_name is missing' do
      @user_params[:first_name] = nil
      @user = User.new(@user_params)
      @user.save
  
      expect(@user.id).to_not be_present
      expect(@user.errors.full_messages).to include("First name can't be blank")
    end

    it 'should not save successfully when last_name is missing' do
      @user_params[:last_name] = nil
      @user = User.new(@user_params)
      @user.save
  
      expect(@user.id).to_not be_present
      expect(@user.errors.full_messages).to include("Last name can't be blank")
    end

    it 'should not save successfully when email is missing' do
      @user_params[:email] = nil
      @user = User.new(@user_params)
      @user.save
  
      expect(@user.id).to_not be_present
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it 'should not save successfully when email exists' do
      @user1 = User.new(@user_params)
      @user1.save
      
      # make sure the check is not case sensitive
      @user_params[:email] = 'jOjO@jOmaIl.CoM'
      @user2 = User.new(@user_params)
      @user2.save
  
      expect(@user2.id).to_not be_present
      expect(@user2.errors.full_messages).to include("Email has already been taken")
    end
 
    it 'should not save successfully when password is missing' do
      @user_params[:password] = nil
      @user = User.new(@user_params)
      @user.save
  
      expect(@user.id).to_not be_present
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    it 'should not save successfully when password confirmation does not match' do
      @user_params[:password_confirmation] = 'diosecrettechnique'
      @user = User.new(@user_params)
      @user.save
  
      expect(@user.id).to_not be_present
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'should not save successfully when password is not at least 10 characters long' do
      @user_params[:password] = 'LisaLisa'
      @user_params[:password_confirmation] = 'LisaLisa'
      @user = User.new(@user_params)
      @user.save
  
      expect(@user.id).to_not be_present
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 10 characters)")
    end
  end

  describe '.authenticate_with_credentials' do
    before {
      @new_user = User.new(
        first_name: 'Joseph',
        last_name: 'Joestar',
        email: 'jojo@jomail.com',
        password: 'joestarsecrettechnique',
        password_confirmation: 'joestarsecrettechnique'
      )
      @new_user.save!

      @email = 'jojo@jomail.com'
      @password = 'joestarsecrettechnique'
      @user_id = @new_user[:id]
    }

    it 'should return the instance of the user if authenticated' do
      @authenticated = User.authenticate_with_credentials(@email, @password)
      expect(@authenticated.id).to eq(@user_id)
    end

    it 'should return the nil if not authenticated' do
      @authenticated = User.authenticate_with_credentials('not', 'real')
      expect(@authenticated).to be_nil
    end
  end
end
