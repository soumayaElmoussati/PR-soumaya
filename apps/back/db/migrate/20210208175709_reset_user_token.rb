class ResetUserToken < ActiveRecord::Migration[5.2]
  def change
    User.update_all(tokens: nil)
  end
end
