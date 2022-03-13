class AddAnnexeInfoToOffers < ActiveRecord::Migration[5.2]
  def change
    add_column :offers, :annexe_information, :text
  end
end
