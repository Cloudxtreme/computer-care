class ServiceOptionValue < ActiveRecord::Base
  belongs_to :service_option
  attr_accessible :name, :service_option_id
end
