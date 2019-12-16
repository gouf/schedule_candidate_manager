class RemoveAddressColumnFromSchedules < ActiveRecord::Migration[6.0]
  def change
    remove_column(:schedules, :address)
  end
end
