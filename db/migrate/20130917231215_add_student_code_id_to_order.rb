class AddStudentCodeIdToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :student_code_id, :Integer
  end
end
