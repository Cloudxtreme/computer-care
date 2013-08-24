class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.integer :order_id

      t.timestamps
    end
  end
end
