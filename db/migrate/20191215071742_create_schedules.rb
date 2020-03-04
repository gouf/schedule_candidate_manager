class CreateSchedules < ActiveRecord::Migration[6.0]
  def change
    create_table :schedules do |t|
      t.string :title
      t.string :address
      t.text :description
      t.references :schedule_candidate, null: false, foreign_key: true

      t.timestamps
    end
  end
end
