class Invoice < ActiveRecord::Base
  belongs_to :order
  attr_accessible :order_id
  before_create :randomize_id

  private
    def randomize_id
      begin
        self.id = SecureRandom.random_number(1_000_000)
      end while Invoice.where(:id => self.id).exists?
    end  
end
