class FixColumnName < ActiveRecord::Migration
  def up
    rename_column :student_codes, :valid, :is_valid
  end

  def down
  end
end
