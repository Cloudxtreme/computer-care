class Service < ActiveRecord::Base
  has_many :service_options, :dependent => :destroy
  attr_accessible :base_cost, :name
  validates_presence_of :base_cost, :name
end
