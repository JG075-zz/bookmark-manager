require './app/data_mapper_setup'

class Tag
  include DataMapper::Resource

  property :id,     Serial
  property :tag,    String
end
