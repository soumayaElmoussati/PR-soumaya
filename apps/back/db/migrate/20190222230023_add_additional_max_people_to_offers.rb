class AddAdditionalMaxPeopleToOffers < ActiveRecord::Migration[5.2]
  def change
    add_column :offers, :additional_max_people, :integer, default: 0
  end
end
