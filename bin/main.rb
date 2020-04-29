require 'telegram/bot'
require_relative '../lib/calculations.rb'
require_relative '../lib/user_input_validation.rb'
require_relative '../lib/criticorblunder.rb'
require_relative '../lib/rolls.rb'
token = '1275379380:AAEfkC8K31fMnVPdeEYMSX7hOFdQR-Asecs'

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    valid_command = message.text.split('')
    if valid_command[0] == '/'
      bot.api.send_message(chat_id: message.chat.id, text: UserIpnut.new(message.text).check_input)
    end
  end
end
