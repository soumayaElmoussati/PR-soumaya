class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :async, :recoverable, :rememberable
  include DeviseTokenAuth::Concerns::User

  has_one :farmer, dependent: :destroy
  accepts_nested_attributes_for :farmer, :allow_destroy => true

  has_one :client, dependent: :destroy
  accepts_nested_attributes_for :client, :allow_destroy => true

  has_one :admin, dependent: :destroy
  accepts_nested_attributes_for :admin, :allow_destroy => true

  validates :first_name, presence: true, length: { maximum: 200 }
  validates :last_name, presence: true, length: { maximum: 200 }

  def full_name
    "#{first_name.capitalize} #{last_name.upcase}"
  end

  def uid
    email
  end

  def self.from_google_payload(payload, isFarmer)
    where(uid: payload['email'], provider: 'google_auth2').first_or_create do |user|
      user.email = payload['email']
      user.first_name = payload['given_name']
      user.last_name = payload['family_name']
      user.password = Devise.friendly_token[0, 20]
      user.provider = 'google_auth2'
      user.uid = payload['email']

      # According to the param specified in the API, create a farmer
      # or a client. This works the same as the registration API.
      if isFarmer
        Farmer.create(user: user)
      else
        Client.create(user: user)
      end
    end
  end

  def self.from_facebook_payload(payload, isFarmer)
    where(uid: payload['email'], provider: 'facebook_auth2').first_or_create do |user|
      user.email = payload['email']
      user.first_name = payload['first_name']
      user.last_name = payload['last_name']
      user.password = Devise.friendly_token[0, 20]
      user.provider = 'facebook_auth2'
      user.uid = payload['email']

      # According to the param specified in the API, create a farmer
      # or a client. This works the same as the registration API.
      if isFarmer
        Farmer.create(user: user)
      else
        Client.create(user: user)
      end
    end
  end
end
