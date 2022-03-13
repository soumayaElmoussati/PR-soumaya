class UpdateMaxPeopleCount < ActiveRecord::Migration[5.2]
  def up
    offers = Offer.all
    offers.each do |offer|
      offer.max_people_count = offer.people_count + offer.additional_max_people
      offer.save
    end
  end

  def down
    offers = Offer.all
    offers.each do |offer|
      offer.update_column(max_people_count: 0)
    end
  end
end
