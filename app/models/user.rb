class User < ApplicationRecord
  mount_uploader :avatar, AvatarUploader
  has_many :articles, dependent: :destroy

  before_save do
    self.first_name = first_name.downcase.capitalize
    self.last_name = last_name.downcase.capitalize if !last_name.nil?
    self.email = email.downcase
  end

  validates :first_name, presence: true

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :email, presence: true,
                    uniqueness: { case_sensitive: false },
                    length: { maximum: 105 },
                    format: { with: VALID_EMAIL_REGEX }

  has_secure_password
end
