class AddDefaultValueToAdditionalCost < ActiveRecord::Migration
  def change
    change_column :service_option_values, :additional_cost, :float, :default => 0
  end  
end
