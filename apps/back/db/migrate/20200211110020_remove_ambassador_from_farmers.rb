class RemoveAmbassadorFromFarmers < ActiveRecord::Migration[5.2]
  def change
    remove_column :farmers, :ambassador, :boolean
  end
end
