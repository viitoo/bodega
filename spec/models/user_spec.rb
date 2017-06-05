require 'rails_helper'

RSpec.describe User, type: :model do
  context 'when creating a new user' do
    let(:user) { spawn_user }

    it 'succeeds for valid input' do
      expect(user).to be_valid
    end

    it 'fails if Name is empty' do
      user.name = ''
      expect(user).not_to be_valid
    end

    it 'fails if Email is empty' do
      user.email = ''
      expect(user).not_to be_valid
    end

    it 'fails if Email is not unique (case insensitive)' do
      user.save
      user2 = user.dup.tap { |u| u.email.upcase! }
      expect(user2).not_to be_valid
    end

    it 'records Email in lowercase' do
      user.email = user.email.upcase
      user.save
      expect(user.email).to match(/\A[^A-Z]+\z/)
    end

    it 'fails if Password is empty' do
      clear_password(user)
      expect(user).not_to be_valid
    end

    it 'fails if Password Confirmation does not match' do
      user.password_confirmation = 'P@ssword'
      expect(user).not_to be_valid
    end
  end
end

def spawn_user
  User.new(name:     'Terence McKenna',
           email:    'tmck@gmail.com',
           password: 'password')
end

def clear_password(user)
  user.password_digest = nil
end
