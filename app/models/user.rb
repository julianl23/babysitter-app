class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :role
  has_many :availabilities
  # has_many :bookings, foreign_key: :babysitter_id
  # has_many :bookings, foreign_key: :family_id
  has_many :babysitter_bookings, class_name: 'Booking', foreign_key: 'babysitter_id'
  has_many :family_bookings, class_name: 'Booking', foreign_key: 'family_id'
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

  def pending_bookings
    if family?
      family_bookings.where(accepted: false)
    elsif babysitter?
      babysitter_bookings.where(accepted: false)
    end
  end

  def accepted_bookings
    if family?
      family_bookings.where(accepted: true)
    elsif babysitter?
      babysitter_bookings.where(accepted: true)
    end
  end

  private

  def set_default_role
    self.role ||= Role.find_by_name('family')
  end
end
