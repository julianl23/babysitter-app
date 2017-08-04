class AddRoleToUser < ActiveRecord::Migration[5.1]
  def change
    add_reference :users, :role, index: true
  end
end
