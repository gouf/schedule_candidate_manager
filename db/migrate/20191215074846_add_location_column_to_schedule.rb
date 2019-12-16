class AddLocationColumnToSchedule < ActiveRecord::Migration[6.0]
  def change
    add_column :schedules, :location, :string
  end
end
