class User < ApplicationRecord
  before_save :downcase_email
  has_secure_password
  has_many :uploads
  validates :username, length: { maximum: 15 }, uniqueness: true, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, presence: true
  validates :password, presence: true, length: { minimum: 8 }, on: :create
  validates :password, format: {
                         with: /(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).*/,
                         message: "Password must contain atleast one uppercase, lowercase and number"
                       }, on: :create
  private
  def downcase_email
    self.email = email.downcase
  end
end
