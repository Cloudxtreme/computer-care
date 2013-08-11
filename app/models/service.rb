class Service < ActiveRecord::Base
  attr_accessible :base_cost, :name
  validates_presence_of :base_cost, :name
end
