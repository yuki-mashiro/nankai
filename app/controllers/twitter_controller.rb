class TwitterController < ApplicationController
  require "twitter"

  def create(content_name, content_status, content_latency_time, content_check_latency_time)
    status =Content.status[content_status]

    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = Rails.application.secrets.consumer_key
      config.consumer_secret     = Rails.application.secrets.consumer_secret
      config.access_token        = Rails.application.secrets.access_token
      config.access_token_secret = Rails.application.secrets.access_token_secret
    end

    client.update("#{content_name}は【#{status}】です。#{create_message(content_latency_time.to_i)}【待ち時間確認時刻:#{content_check_latency_time}】")
  end

  def create_message(latency_time)
    message = "約#{latency_time}分待ちです。"
    if latency_time >= 30
      message = "約#{latency_time}分待ちです。お待たせして申し訳ございません。"
    end
    message
  end
end
