class BookmarkManager < Sinatra::Base
  get '/links' do
    current_user
    @links = Link.all
    erb :'links/index'
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

  get '/links/new' do
    erb :'links/new'
  end
end
