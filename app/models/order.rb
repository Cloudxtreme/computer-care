class Order < ActiveRecord::Base
  has_many :order_services, :dependent => :destroy
  has_one :invoice
  has_one :student_code
  attr_accessible :building, :date, :email, :first_name, :last_name, :postcode, :street, :telephone, :total_cost, :town, :paid, :agreed_to_terms
end
