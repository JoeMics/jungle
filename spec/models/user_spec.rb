require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    before {
      @user_params = {
        first_name: 'Joseph',
        last_name: 'Joestar',
        email: 'jojo@jomail.com',
        password: 'Dio',
        password_confirmation: 'Dio'
      }
    }

    it 'should save successfully when all fields are present and correct' do
      @user = User.new(@user_params)
      @user.save!
  
      expect(@user.id).to be_present
    end
  end
end
