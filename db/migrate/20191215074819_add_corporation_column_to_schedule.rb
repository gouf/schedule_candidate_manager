class AddCorporationColumnToSchedule < ActiveRecord::Migration[6.0]
  def change
    add_column :schedules, :corporation_name, :string, before: :created_at
  end
end
