class RemoveAmbassadorFromOffers < ActiveRecord::Migration[5.2]
  def change
    remove_column :offers, :ambassador, :boolean
  end
end
