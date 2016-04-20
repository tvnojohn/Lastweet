#encoding: utf-8
require 'rubygems'
require 'twitter'

#tweet
consumer_key = "YOUR_CONSUMER_KEY"
consumer_secret = "YOUR_CONSUMER_SECRET"
access_token = "YOUR_ACCESS_TOKEN"
access_token_secret= "YOUR_ACCESS_SECRET"

config = {
	consumer_key: consumer_key,
	consumer_secret: consumer_secret,
	access_token: access_token,
	access_token_secret: access_token_secret
}

$client = Twitter::REST::Client.new(config)

myid = $client.user.id

def tweet_id2time(id)
	case id
 	when Integer
		Time.at(((id.to_i >> 22) + 1288834974657) / 1000.0)
	else
		nil
	end
end

def posttweet(text)
	$client.update text #tweet
end

$client.user_timeline(myid, { count: 1 }).each do |tweet|
	str = "my last tweet is '"
	str += tweet.text
	str += "'\n"
	str += tweet_id2time(tweet.id).to_s
	str +="\sposted"
	posttweet(str)
end
