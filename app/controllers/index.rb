get '/' do
end

get '/:username' do
  
  @user = params[:username]

  erb :index
  # if @user.tweets.empty? || !@user.up_to_date?
  #   @user.fetch_tweets!
  # end

  # @tweets = @user.tweets.order("created_at DESC").limit(10)
  # erb :index
end

get '/tweets/' do
  p "in /tweets route"
  @user = TwitterUser.find_or_create_by_username(params[:username])

  if @user.tweets.empty? || !@user.up_to_date?
    @user.fetch_tweets!
  end

  @tweets = @user.tweets.order("created_at DESC").limit(10)

  erb :_tweets, layout: false
end

get '/tweets/:username/media' do
  @user = TwitterUser.find_or_create_by_username(params[:username])
  @user.fetch_tweets!
  @media_urls = @user.tweets.map(&:media_url).compact!
  p @media_urls
  erb :scrapbook
end

# get '/tweets/create' do
#   