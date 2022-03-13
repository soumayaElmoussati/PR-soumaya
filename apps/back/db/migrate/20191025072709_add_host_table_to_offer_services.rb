class AddHostTableToOfferServices < ActiveRecord::Migration[5.2]
  def change
    add_column :offer_services, :host_table, :boolean, default: false
    add_column :offer_services, :host_table_price, :integer, default: 0
  end
end
