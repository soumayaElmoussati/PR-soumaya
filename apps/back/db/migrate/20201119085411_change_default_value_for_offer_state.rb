class ChangeDefaultValueForOfferState < ActiveRecord::Migration[5.2]
  def change
    change_column_default :offers, :state, from: 0, to: 1
  end
end
