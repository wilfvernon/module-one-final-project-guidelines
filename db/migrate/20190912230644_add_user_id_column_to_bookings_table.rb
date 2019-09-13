class AddUserIdColumnToBookingsTable < ActiveRecord::Migration[5.0]
  def change
    add_column :bookings, :user_id, :integer
  end
end