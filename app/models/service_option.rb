class ServiceOption < ActiveRecord::Base
  belongs_to :service
  attr_accessible :is_arbitrary, :name
  validates_presence_of :name
end
