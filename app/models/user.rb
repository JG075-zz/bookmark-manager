require 'bcrypt'
require 'dm-validations'
require './app/data_mapper_setup'

class User
  include DataMapper::Resource

  property :id, Serial
  property :username, String, required: true
  property :password_digest, Text

  validates_format_of :username, :as => :email_address
  validates_uniqueness_of :username
  validates_confirmation_of :password

  attr_reader :password
  attr_accessor :password_confirmation

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end
end
