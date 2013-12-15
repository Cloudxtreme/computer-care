class AddDiscountToDiscountCode < ActiveRecord::Migration
  def change
    add_column :discount_codes, :discount, :integer
  end
end
