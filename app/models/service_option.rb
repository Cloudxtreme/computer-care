class ServiceOption < ActiveRecord::Base
  belongs_to :service
  has_many :service_option_values, :dependent => :destroy
  attr_accessible :is_arbitrary, :name, :placeholder, :label
end
