class AddQuestionsToReviews < ActiveRecord::Migration[5.2]
  def change
    add_column :reviews, :situation, :string
    add_column :reviews, :lodging, :string
    add_column :reviews, :activity, :string
    add_column :reviews, :services, :string
    add_column :reviews, :contact, :string
    add_column :reviews, :process, :string
    add_column :reviews, :trip_note, :text
    add_column :reviews, :reference, :boolean
  end
end
