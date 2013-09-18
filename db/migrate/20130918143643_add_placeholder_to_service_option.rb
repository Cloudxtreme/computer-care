class AddPlaceholderToServiceOption < ActiveRecord::Migration
  def change
    add_column :service_options, :placeholder, :Text
  end
end
