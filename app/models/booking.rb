class Booking < ApplicationRecord
  belongs_to :family,     class_name: 'User', foreign_key: 'family_id'
  belongs_to :babysitter, class_name: 'User', foreign_key: 'babysitter_id'
  belongs_to :availability, optional: true
  has_many :users

  # before_update :handle_availability_split

  def accept
    availability_id = availability.id
    self.accepted = true
    handle_availability_split
    self.availability = nil
    save!
    Availability.delete(availability_id)
  end

  def decline
    delete
  end

  private

  def handle_availability_split
    avail = availability
    if to.to_i == avail.to.to_i
      new_availability = Availability.new(from: avail.from,
                                          to: from - 1.hour,
                                          user_id: babysitter.id)
      new_availability.save
    elsif from.to_i == availability.from.to_i
      new_availability = Availability.new(from: to + 1.hour,
                                          to: avail.to,
                                          user_id: babysitter.id)
      new_availability.save
    else
      new_preceding_availability = Availability.new(from: avail.from,
                                                    to: from - 1.hour,
                                                    user_id: babysitter.id)

      new_trailing_availability = Availability.new(from: to + 1.hour,
                                                   to: avail.to,
                                                   user_id: babysitter.id)
      new_preceding_availability.save
      new_trailing_availability.save
    end
  end
end