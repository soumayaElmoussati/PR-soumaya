ActiveAdmin.register FarmerIncome do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :offer_id, :state, :start_date, :end_date, :period_name, :note, :stay_count, :expenses_balance, :lodging_income_balance, :farmer_balance, :housework_income_balance, :annexes_incomes_balance, :total_farmer_balance, :total_offer_income, :farmer_expenses

    index do
        selectable_column
        column :id
        column :state
        column :offer
        column :start_date
        column :end_date
        column :period_name
        column :stay_count
        column :expenses_balance
        column :lodging_income_balance
        column :farmer_balance
        column :housework_income_balance
        column :annexes_incomes_balance
				column :total_farmer_balance
        column :total_offer_income
        column :farmer_expenses
        column :created_at
        column :updated_at
        actions
    end


    form do |f|
        f.inputs do
          
        f.label "Offre:"
        f.select :offer_id, Offer.where(manager: true).collect { |v| [ v.name, v.id ] }, {}


        f.input :state

        f.input :start_date

        f.input :end_date

        f.input :period_name

        f.input :note

        f.actions
        end
    end

end
