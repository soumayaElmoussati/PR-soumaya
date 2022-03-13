class Client < ApplicationRecord
  belongs_to :user
  has_many :bookings
  has_many :activity_bookings

  after_create :add_mailchimp_list


  def full_name
    user.full_name unless user.nil?
  end

  def send_welcome
    ClientMailer.with(client: self).welcome.deliver_later
  end


  def add_mailchimp_list
    CreateClientJob.perform_later(self)
  end


end
