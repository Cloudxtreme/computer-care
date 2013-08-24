class Order < ActiveRecord::Base
  has_many :order_services, :dependent => :destroy
  has_one :invoice
  attr_accessible :building, :date, :email, :first_name, :last_name, :postcode, :street, :telephone, :total_cost, :town, :paid
end
