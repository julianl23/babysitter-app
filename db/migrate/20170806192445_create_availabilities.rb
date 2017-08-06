class CreateAvailabilities < ActiveRecord::Migration[5.1]
  def change
    create_table :availabilities do |t|
      t.datetime :from
      t.datetime :to
      t.text :note
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
