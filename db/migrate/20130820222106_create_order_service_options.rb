class CreateOrderServiceOptions < ActiveRecord::Migration
  def change
    create_table :order_service_options do |t|
      t.integer :order_service_id
      t.text :value

      t.timestamps
    end
  end
end
