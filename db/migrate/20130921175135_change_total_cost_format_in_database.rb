class ChangeTotalCostFormatInDatabase < ActiveRecord::Migration
  def self.up
   change_column :orders, :total_cost, :decimal
  end

  def self.down
   change_column :orders, :total_cost, :integer
  end
end
