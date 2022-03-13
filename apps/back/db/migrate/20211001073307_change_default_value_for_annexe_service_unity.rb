class ChangeDefaultValueForAnnexeServiceUnity < ActiveRecord::Migration[5.2]
  def change
    change_column_default :annexe_services, :unity, 1
  end
end
