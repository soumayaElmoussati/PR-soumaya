class ChangeOrderCloudExpensePictures < ActiveRecord::Migration[5.2]
  def change
    change_column_default :cloud_expense_pictures, :order, 1
  end
end
