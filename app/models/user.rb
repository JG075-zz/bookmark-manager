require 'bcrypt'
require './app/data_mapper_setup'

class User
  include DataMapper::Resource

  property :id, Serial
  property :username, String
  property :password_digest, Text

  def password=(password)
    self.password_digest = BCrypt::Password.create(password)
  end
end
