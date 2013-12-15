class DiscountCode < ActiveRecord::Base
  attr_accessible :code, :is_valid, :discount
  validates_presence_of :discount
  validates_numericality_of :discount
  validates :discount, :inclusion => 1..100

  before_create :set_valid, :generate_code

  private
    def set_valid
      self.is_valid = true
    end

    def generate_code
      self.code = SecureRandom.hex(16)
    end  
end
