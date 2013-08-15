class AddAdditionalCostToServiceOptionValue < ActiveRecord::Migration
  def change
    add_column :service_option_values, :additional_cost, :float
  end
end
