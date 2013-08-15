class AddCanCheckoutToService < ActiveRecord::Migration
  def change
    add_column :services, :can_checkout, :boolean
  end
end
