# Twilio.configure do |config|
#   config.account_sid = ENV["ACCOUNT_SID"]
#   config.auth_token = ENV["AUTH_TOKEN"]
#   config.phone_number = ENV["PHONE_NUM"]
# end


require 'rubygems'
require 'twilio-ruby'

module TwilioSms
  def self.send_text(phone, content)
    # phone :- phone number to which you want to send sms
    # content :- Message text which you want to send
    twilio_sid = "AC84df1276f51e9572c55b98e8f85bd4ce" # paste twilio sid
    twilio_token = "05f50851cb39d9564b6d7d0b35a2e02e" # paste twilio token
    twilio_phone_number = "+12512140775" # paste twilio number
    begin

      @twilio_client = Twilio::REST::Client.new twilio_sid, twilio_token

      @twilio_client.messages.create(
      :from => twilio_phone_number,
      :to => phone,
      :body=> content

      )
    rescue Twilio::REST::TwilioError => e
       return e.message
    end
    return "send"
  end
end
