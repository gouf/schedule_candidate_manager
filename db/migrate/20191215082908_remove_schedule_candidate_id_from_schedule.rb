class RemoveScheduleCandidateIdFromSchedule < ActiveRecord::Migration[6.0]
  def change
    remove_columns(:schedules, :schedule_candidate_id)
  end
end
