class CreateTips < ActiveRecord::Migration
  def change
    create_table :tips do |t|
      t.text :body
      t.boolean :published
      t.string :title

      t.timestamps
    end
  end
end
