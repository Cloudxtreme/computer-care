class Order < ActiveRecord::Base
  attr_accessible :building, :date, :email, :first_name, :last_name, :postcode, :street, :telephone, :total_cost, :town
end
