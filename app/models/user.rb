class User < ApplicationRecord
  validates :name, presence: true
  validates :email, presence:   true,
                    uniqueness: { case_sensitive: false },
                    format:     { with: /\A[^@]+@[^@]+\z/ }
  has_secure_password

  before_save :format_email

  private

    def format_email
      self.email = email.downcase
    end
end
