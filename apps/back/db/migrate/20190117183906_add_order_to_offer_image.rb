class AddOrderToOfferImage < ActiveRecord::Migration[5.2]
  def change
    add_column :pictures, :order, :integer, default: 0
  end
end
