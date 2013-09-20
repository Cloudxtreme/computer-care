class AddAgreedTermsToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :agreed_to_terms, :Boolean
  end
end
