class AddCertificationToOffers < ActiveRecord::Migration[5.2]
  def change
    add_column :offers, :certificated, :boolean, default: false
  end
end
