class InitializeAreaCodeAddresse < ActiveRecord::Migration[5.2]
  def up
    Address.all.each do |address|
      address.area_code = address.postal_code[0...2]
      address.save
    end
  end

  def down
    Address.all.each do |address|
      address.area_code = nil
    end
  end
end
