class BookmarkManager < Sinatra::Base
  delete '/sessions' do
    session[:user_id] = nil
    flash.keep[:notice] = 'You signed out. Thanks for using Bookmark Manager'
    redirect to('/links')
  end

  post '/sessions' do
    user = User.authenticate(params[:username], params[:password])
    if user
      session[:user_id] = user.id
      redirect to('/links')
    else
      flash.now[:errors] = ['The email or password is incorrect']
      erb :'sessions/new'
    end
  end

  get '/sessions/new' do
    erb :'sessions/new'
  end
end
