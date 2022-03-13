class MoveFarmTypeToFarmTypes < ActiveRecord::Migration[5.2]
  def change
    # Migrate the farmType column to the farmTypes column
    # by searching for every entry in the offers
    if Offer.column_names.include? "farm_type"
      Offer.all.each do |offer|
        if !offer.farm_type.nil?
          offer.update(farm_types: offer.farm_type)
        end
      end
    end
  end
end
