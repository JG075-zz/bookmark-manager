require 'bcrypt'
require 'dm-validations'
require 'securerandom'
require './app/data_mapper_setup'

class User
  include DataMapper::Resource

  property :id, Serial
  property :username, String, required: true
  property :password_digest, Text
  property :password_token, String, length: 60
  property :password_token_time, Time

  validates_format_of :username, :as => :email_address
  validates_uniqueness_of :username
  validates_confirmation_of :password

  attr_reader :password
  attr_accessor :password_confirmation

  def generate_token
    self.password_token = SecureRandom.hex
    self.password_token_time = Time.now
    self.save
  end

  def self.find_by_valid_token(token)
    user = first(password_token: token)
    if (user && user.password_token_time + (60 * 60) > Time.now)
      user
    end
  end

  def self.authenticate(username, password)
    user = first(username: username)

    if user && BCrypt::Password.new(user.password_digest) == password
      user
    else
      nil
    end
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end
end
