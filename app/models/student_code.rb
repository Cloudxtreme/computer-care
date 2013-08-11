class StudentCode < ActiveRecord::Base
  attr_accessible :code, :email, :name, :is_valid
  validates_presence_of :name, :email
  validates_uniqueness_of :email
  validates_format_of :email, :with => /@[A-Za-z0-9]+.ac.uk\Z/i, :on => :create

  before_create :set_valid, :generate_code, :send_email

  private
    def set_valid
      self.is_valid = true
    end

    def generate_code
      self.code = SecureRandom.hex(16)
    end

    def send_email
      NotificationMailer.student_discount(self.name, self.email, self.code).deliver
    end
end
