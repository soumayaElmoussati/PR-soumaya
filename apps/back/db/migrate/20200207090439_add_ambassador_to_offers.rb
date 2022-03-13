class AddAmbassadorToOffers < ActiveRecord::Migration[5.2]
  def change
    add_column :offers, :ambassador, :boolean, default: false
  end
end
