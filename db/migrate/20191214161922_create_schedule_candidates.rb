class CreateScheduleCandidates < ActiveRecord::Migration[6.0]
  def change
    create_table :schedule_candidates do |t|
      t.string :corporation_name
      t.text :description
      t.string :location

      t.timestamps
    end
  end
end
