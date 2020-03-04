class AddCalendarIdColumnToScheduleCandidate < ActiveRecord::Migration[6.0]
  def change
    add_column(:schedule_candidates, :calendar_event_id, :string, before: :schedule_id)
  end
end
