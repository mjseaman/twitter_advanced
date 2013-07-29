class TwitterUser < ActiveRecord::Base
  has_many :tweets

  def fetch_tweets!
    new_tweets = Twitter.user_timeline(username, :count => 100)
    Tweet.delete_all("twitter_user_id = #{self.id}")
    new_tweets.each do |tweet|
      p tweet
      self.tweets << Tweet.create(
        text:tweet.text,
        created_at:tweet.created_at,
        )
    end
  end

  def up_to_date?
    self.tweets.any? { |tweet| tweet.created_at > (Time.now - (15*60))}
  end

end

