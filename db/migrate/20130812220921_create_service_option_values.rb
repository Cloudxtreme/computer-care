class CreateServiceOptionValues < ActiveRecord::Migration
  def change
    create_table :service_option_values do |t|
      t.string :name
      t.integer :service_option_id

      t.timestamps
    end
  end
end
