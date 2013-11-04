class AddLabelToServiceOption < ActiveRecord::Migration
  def change
    add_column :service_options, :label, :string
  end
end
