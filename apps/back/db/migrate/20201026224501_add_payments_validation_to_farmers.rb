class AddPaymentsValidationToFarmers < ActiveRecord::Migration[5.2]
  def change
    add_column :farmers, :payments_authorisation, :boolean, default: false
  end
end
