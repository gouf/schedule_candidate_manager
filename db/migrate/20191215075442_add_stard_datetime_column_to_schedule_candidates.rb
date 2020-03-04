class AddStardDatetimeColumnToScheduleCandidates < ActiveRecord::Migration[6.0]
  def change
    add_column :schedule_candidates, :start_datetime, :datetime, before: :created_at
  end
end
