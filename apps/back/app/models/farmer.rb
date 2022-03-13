class Farmer < ApplicationRecord
  belongs_to :user, dependent: :destroy
  has_many :offers
  has_many :activities

  has_many :pictures, as: :imageable, dependent: :destroy
  accepts_nested_attributes_for :pictures, :allow_destroy => true

  has_one :farmer_equipment, dependent: :destroy
  accepts_nested_attributes_for :farmer_equipment, :allow_destroy => true

  has_one :farmer_organisation, dependent: :destroy
  accepts_nested_attributes_for :farmer_organisation, :allow_destroy => true

  has_many :cloud_profile_pictures, dependent: :destroy
  accepts_nested_attributes_for :cloud_profile_pictures, allow_destroy: true

  validates_associated :pictures, :cloud_profile_pictures, :farmer_equipment, :farmer_organisation


  after_create :send_welcome, :create_stripe

  def full_name
    user.full_name unless user.nil?
  end

  def set_stripe_id

    if Rails.env != "production"
      api_key = 'sk_test_Rn5msomXPxHV2Y5ynnVopH3t'
    else
      api_key = 'sk_live_5yu6ZXc5hWG25fp2PXCJ7eDu004rx8VS3Q'
    end

    Stripe.api_key = api_key

    if self.stripe_user_id == nil

      account = Stripe::Account.create({
        type: 'express',
        country: 'FR',
        email: self.user.email,
        capabilities: {
          transfers: {requested: true}
        }
      })

      return account.id
    end

  end


  def create_stripe
    self.stripe_user_id = set_stripe_id
  end

  def send_welcome
    FarmerMailer.with(farmer: self).welcome.deliver_later
  end

end
