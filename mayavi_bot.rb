require 'telegram/bot'

token = "651483227:AAEI_rRuvfy8eBXfIwGXi9VFbhiFgNIQaAw"

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    puts message.text
    #{}`say #{message.text}`
    bot.api.send_message(chat_id: message.chat.id, text: "I am downloding this now...")
    `youtube-dl --extract-audio --audio-format mp3 #{message.text}`
    bot.api.send_message(chat_id: message.chat.id, text: "Download completed!")
  end
end