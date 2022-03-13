class AddNilToUsers < ActiveRecord::Migration[5.2]
  def change

    reversible do |direction|
      direction.up do
        User.find_each do |user|
          user.tokens = nil
          user.save!
        end
      end
    end
    
  end
end
