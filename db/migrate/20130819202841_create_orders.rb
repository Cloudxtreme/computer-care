class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :telephone
      t.string :building
      t.string :street
      t.string :town
      t.string :postcode
      t.datetime :date
      t.integer :total_cost

      t.timestamps
    end
  end
end
