class CreateStudentCodes < ActiveRecord::Migration
  def change
    create_table :student_codes do |t|
      t.string :name
      t.string :email
      t.string :code
      t.boolean :valid

      t.timestamps
    end
  end
end
