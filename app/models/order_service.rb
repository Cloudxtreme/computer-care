class OrderService < ActiveRecord::Base
  belongs_to :order
  has_many :order_service_options, :dependent => :destroy
  attr_accessible :order_id, :service_id
end
