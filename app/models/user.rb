class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :role
  has_many :availabilities
  before_validation :set_default_role 

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  def family?
    role.name == 'family'
  end

  def babysitter?
    role.name == 'babysitter'
  end

  def admin?
    role.name = 'admin'
  end

  private

  def set_default_role
    self.role ||= Role.find_by_name('family')
  end
end
