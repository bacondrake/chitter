require 'dotenv'
Dotenv.load

require 'sinatra'
require 'erb'
require 'twitter'

# This require relative won't work properly for some reason
# require_relative './twitter_client'

    set :port, 5000
    # allow external access
    set :bind, '0.0.0.0'
    set :server, 'webrick'

    get '/' do
      @search_term = "friendface"
      @search_amount = 30

      # Should be able to put this in its own file but for some reason the #search method won't work if you do that.
      @client = Twitter::REST::Client.new do |config|
        # Use dotenv to hide these keys and tokens
        config.consumer_key        = ENV['CONSUMER_TOKEN']
        config.consumer_secret     = ENV['CONSUMER_SECRET']
        config.access_token        = ENV['ACCESS_TOKEN']
        config.access_token_secret = ENV['ACCESS_SECRET']
      end

      haml :index, layout: :bootstrap
    end