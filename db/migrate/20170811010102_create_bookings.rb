class CreateBookings < ActiveRecord::Migration[5.1]
  def change
    create_table :bookings do |t|
      t.integer :family_id
      t.integer :babysitter_id
      t.boolean :accepted, default: false
      t.datetime :from
      t.datetime :to

      t.timestamps
    end
  end
end
