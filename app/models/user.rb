class User < ApplicationRecord
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates_presence_of :email
  validates_presence_of :uid
  validates_presence_of :provider
  validates_presence_of :full_name
end
