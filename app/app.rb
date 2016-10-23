ENV['RACK_ENV'] ||= 'development'

require 'sinatra/base'
require 'sinatra/flash'
require_relative './data_mapper_setup'

class BookmarkManager < Sinatra::Base
  enable :sessions
  register Sinatra::Flash

  set :session_secret, 'super secret'

  helpers do
    def current_user
      @current_user ||= User.get(session[:user_id])
    end
  end

  get '/' do
    redirect to('/links')
  end

  get '/links' do
    current_user
    @links = Link.all
    erb :'links/index'
  end

  get '/links/new' do
    erb :'links/new'
  end

  post '/links' do
    @links = Link.new(url: params[:url], title: params[:title])
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

  get '/users/new' do
    @user = User.new
    erb :'users/new'
  end

  post '/users' do
    @user = User.new(username: params[:username], password: params[:password], password_confirmation: params[:password_confirmation])
    if @user.save
      session[:user_id] = @user.id
      redirect to('/links')
    else
      flash.now[:errors] = @user.errors.full_messages
      erb :'users/new'
    end
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
