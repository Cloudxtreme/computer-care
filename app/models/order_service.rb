class OrderService < ActiveRecord::Base
  belongs_to :order
  has_many :order_service_options, :dependent => :destroy
  has_one :student_code
  attr_accessible :order_id, :service_id
end
