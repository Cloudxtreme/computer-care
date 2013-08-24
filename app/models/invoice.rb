class Invoice < ActiveRecord::Base
  belongs_to :order
  attr_accessible :order_id
end
