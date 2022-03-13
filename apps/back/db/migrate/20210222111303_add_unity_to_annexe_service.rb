class AddUnityToAnnexeService < ActiveRecord::Migration[5.2]
  def change
    add_column :annexe_services, :unity, :string
  end
end
