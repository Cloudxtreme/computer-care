class OrderServiceOption < ActiveRecord::Base
  belongs_to :order_service
  attr_accessible :order_service_id, :service_option_id, :value
end
