class CreateServiceOptions < ActiveRecord::Migration
  def change
    create_table :service_options do |t|
      t.string :name
      t.boolean :is_arbitrary
      t.integer :service_id

      t.timestamps
    end
  end
end
