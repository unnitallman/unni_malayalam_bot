require 'telegram/bot'
require 'wikipedia'
require 'timeout'


token = "651483227:AAEI_rRuvfy8eBXfIwGXi9VFbhiFgNIQaAw"

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    puts message.text
    
    begin 
      text = ""
      Timeout::timeout(5) {
        page = Wikipedia.find(message.text)
        puts page.text
        text = page.text.split("\n").select{|para| para.size > 100}.first rescue nil
        text ||= "Not found"
        }
    rescue => e
      puts e
      text = "Not found"
    end

    bot.api.send_message(chat_id: message.chat.id, text: text)

    # bot.api.send_message(chat_id: message.chat.id, text: "I am downloding this now...")
    # `youtube-dl --extract-audio --audio-format mp3 #{message.text}`
    # bot.api.send_message(chat_id: message.chat.id, text: "Download completed!")
  end
end



