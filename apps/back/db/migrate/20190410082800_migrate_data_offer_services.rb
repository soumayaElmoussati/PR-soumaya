class MigrateDataOfferServices < ActiveRecord::Migration[5.2]
  def up
    equipments = OfferEquipment.all
    equipments.each do |equipment|
      OfferService.create(
        offer: equipment.offer,
        breakfast: equipment.breakfast,
        linens: equipment.base_equipments,
        cleaning: true
      )
    end
  end

  def down
    OfferService.delete_all
  end
end
