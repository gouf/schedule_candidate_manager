class AddReferencesScheduleToScheduleCandidates < ActiveRecord::Migration[6.0]
  def change
    add_belongs_to :schedule_candidates, :schedule
  end
end
