ActiveAdmin.register Expense do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :offer_id, :responsable, :expense_date, :total_ttc, :total_ht, :comment, :state,
cloud_expense_pictures_attributes: [
    :_destroy,
    :id,
    :expense_id,
    :public_id,
    :url,
    :order
  ]

  show do
    panel "Expense details" do
      attributes_table_for expense do
        row :id
        row :state
        row :responsable
        row :expense_date
        row :total_ht
        row :total_ttc
        row :comment
        row :created_at
        row :updated_at
      end
    end

    panel "Expense cloud pictures" do
        table_for expense.cloud_expense_pictures, sortable: :order do
          column :id
          column :order
          column :image do |image|
            cl_image_tag(image.public_id, :width => 140, :height => 90, :crop => :fill)
          end
        end
    end
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs do
      f.label "Offre:"
      f.select :offer_id, Offer.where(manager: true).collect { |v| [ v.name, v.id ] }, {}
      f.input :state
      f.input :responsable, collection: [['AgriVillage', 'AgriVillage'], ['Agriculteur', 'Agriculteur']]
      f.input :expense_date
      f.input :total_ht
      f.input :total_ttc
      f.input :comment
      f.has_many :cloud_expense_pictures do |a|
        unless a.object.new_record?
          a.input :_destroy, :as => :boolean, :required => false, :label => "Delete this picture"
        end
        # a.input :image, :as => :file, :hint => "https://res.cloudinary.com/agrivillage/image/upload/qxfupljmxm0yuyfcoiqx"
        a.input :local_image, :as => :file, :hint => cl_image_tag(a.object.public_id, :width => 140, :height => 90, :crop => :fill)
        # a.input :url, :as => :file, :hint => image_tag(
        #   a.object.url.image_url(:thumbnail)
        # )
        a.input :order
      end
      f.actions
    end
  end

  controller do
    def update(options={}, &block)

      super do |success, failure|
        block.call(success, failure) if block
        failure.html { render :show }
      end

      @expense = Expense.find(params[:id])
      (params[:expense][:cloud_expense_pictures_attributes] || []).each do |item|
        if !item[1][:local_image].nil?
          res = Cloudinary::Uploader.upload(item[1][:local_image])
          @picture = @expense.cloud_expense_pictures.create()
          @picture.update_column(:order, item[1][:order])
          @picture.update_column(:public_id, res["public_id"])
          @picture.update_column(:url, "https://res.cloudinary.com/agrivillage/image/upload/" + res["public_id"])
        end
      end
      # super do |success, failure|
      #   block.call(success, failure) if block
      #   failure.html { render :show }
      # end
      # @old_pictures = @offer.cloud_pictures.sort_by {|obj| obj.order}
      @old_pictures = @expense.cloud_expense_pictures.each_with_index.sort_by {|h, idx| [h.order, idx] }.map(&:first)
      @expense.cloud_expense_pictures.clear
      @old_pictures.each do |picture|
        # @picture = @offer.cloud_pictures.create()
        @picture = @expense.cloud_expense_pictures.create(:order => picture[:order], :public_id => picture[:public_id], :url => picture[:url])
        # @picture.update_column(:order, picture[:order])
        # @picture.update_column(:public_id, picture[:public_id])
        # @picture.update_column(:url, picture[:url])
      end

      @expense.cloud_expense_pictures.each do |picture|
        if picture.public_id.nil?
          picture.destroy
        end
      end

    end
  end

end
