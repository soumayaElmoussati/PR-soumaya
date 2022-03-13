class MigrateDataOfferFarmTypes < ActiveRecord::Migration[5.2]
  def up
    Offer.all.each do |offer|
      oft = OfferFarmType.create(offer: offer)
      offer.farm_types.each do |farm_type|
        if oft.update_column(farm_type, true)
          puts "Record OfferFarmType #{oft.id} updated"
        else
          puts "Update error for OfferFarmType: #{oft.id}"
        end
      end
    end
  end

  def down
    OfferFarmType.delete_all
  end
end
