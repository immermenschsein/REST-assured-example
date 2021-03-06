#!/usr/bin/env ruby

require 'bundler'
Bundler.setup(:default)

require 'sinatra'
require 'rest-client'
require 'uri'
require 'json'
require 'haml'

TWITTER_HOST = ENV['TWITTER_HOST'] || 'http://search.twitter.com'

get '/popular_tweets' do
  haml :popular_tweets
end

post '/tweet_search' do
  tweets_json = RestClient.get "#{TWITTER_HOST}/search.json?q=#{URI.escape params[:query]}&result_type=popular"

  haml :tweets_table,
    layout: false,
    locals: {
      tweets: JSON.parse(tweets_json)['results']
    }
end
