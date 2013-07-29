get '/' do
end

get '/:username' do

  @user = TwitterUser.find_or_create_by_username(params[:username])

  if @user.tweets.empty? || !@user.up_to_date?
    @user.fetch_tweets!
  end

  @tweets = @user.tweets.order("created_at DESC").limit(10)
  erb :index
end
