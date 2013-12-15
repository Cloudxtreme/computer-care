class CreateDiscountCodes < ActiveRecord::Migration
  def change
    create_table :discount_codes do |t|
      t.string :code
      t.boolean :is_valid

      t.timestamps
    end
  end
end
