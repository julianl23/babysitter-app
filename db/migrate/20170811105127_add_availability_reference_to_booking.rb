class AddAvailabilityReferenceToBooking < ActiveRecord::Migration[5.1]
  def change
    add_reference :bookings, :availability, foreign_key: true
  end
end
