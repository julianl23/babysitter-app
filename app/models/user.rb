class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :role
  before_validation :set_default_role 

  def full_name 
    "#{self.first_name} #{self.last_name}"
  end

  private
  def set_default_role
    self.role ||= Role.find_by_name('family')
  end
end
