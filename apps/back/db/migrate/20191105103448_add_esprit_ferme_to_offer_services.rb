class AddEspritFermeToOfferServices < ActiveRecord::Migration[5.2]
  def change
    add_column :offer_services, :esprit_link, :string
    add_column :offer_services, :esprit_ferme, :boolean, default: false
  end
end
