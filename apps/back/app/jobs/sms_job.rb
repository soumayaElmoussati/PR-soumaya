class SmsJob < ApplicationJob
  queue_as :default

  def perform(message, phone)

    p "Sending SMS"

    require 'messagebird'

    if phone[0] == '0'
      phone.slice!(0)
      phone = "+33" + phone
    end

    if Rails.env != "production"
      client = MessageBird::Client.new("Y5GaDDBuKTCDvsQWg0ireAdAh")
    else
      client = MessageBird::Client.new("JqPGIWr7xZB9Nd2sN8bwZRKkk")
    end

    begin
      client.message_create('AgriVillage', phone, message, :reference => 'MyReference')
    rescue MessageBird::ErrorException => ex
      puts 'An error occured while requesting a Message object:'

      ex.errors.each do |error|
        puts "  code        : #{error.code}"
        puts "  description : #{error.description}"
        puts "  parameter   : #{error.parameter}"
      end
    end

    sleep 2

    p "Done ! SMS send"
  end
end
