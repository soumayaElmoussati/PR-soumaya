class AddPaymentReceiptToBookings < ActiveRecord::Migration[5.2]
  def change
    add_column :bookings, :receipt_url, :string
  end
end
