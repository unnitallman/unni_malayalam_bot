require 'telegram/bot'
require 'httparty'
require 'wikipedia'
require 'timeout'
require './olam/api'

token = "556895034:AAGMbN_uXEjKAZvs_hwR_QKaR0pH-Hc55XI"

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    puts message.text

    text = Olam::Api.new.search message.text
    text = (text != "") && (text != nil) ? text : "Not found"

    bot.api.send_message(chat_id: message.chat.id, text: text)
  end
end



