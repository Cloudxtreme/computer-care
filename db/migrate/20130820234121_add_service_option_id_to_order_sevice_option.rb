class AddServiceOptionIdToOrderSeviceOption < ActiveRecord::Migration
  def change
    add_column :order_service_options, :service_option_id, :integer
  end
end
