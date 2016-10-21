ENV['RACK_ENV'] ||= 'development'

require 'sinatra/base'
require_relative './data_mapper_setup'

class BookmarkManager < Sinatra::Base

  get '/' do
    redirect to('/links')
  end

  get '/links' do
    @links = Link.all
    erb :'links/index'
  end

  get '/links/new' do
    erb :'links/new'
  end

  post '/links' do
    @links = Link.new(url: params[:url],
                      title: params[:title])
    tags = params[:tags].split(",")
    tags.each do |tag|
      tag = Tag.first_or_create(name: tag)
      @links.tags << tag
    end
    @links.save
    redirect to('/links')
  end

  get '/tags/:name' do
    tag = Tag.first(name: params[:name])
    @links = tag ? tag.links : []
    erb :'links/index'
  end

  get '/signup' do
    erb :'links/signup'
  end

  post '/signup' do
    user = User.new(username: params[:username], password: params[:password])
    user.save
    redirect to('/links')
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
