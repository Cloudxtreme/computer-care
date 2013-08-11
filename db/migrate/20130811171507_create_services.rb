class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.string :name
      t.float :base_cost

      t.timestamps
    end
  end
end
