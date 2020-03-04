# == Schema Information
#
# Table name: schedule_candidates
#
#  id                :integer          not null, primary key
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  start_datetime    :datetime
#  end_datetime      :datetime
#  schedule_id       :integer
#  calendar_event_id :string
#
class ScheduleCandidate < ApplicationRecord
  before_destroy :delete_calendar_event

  belongs_to :schedule

  validates :start_datetime, presence: true
  validates :end_datetime, presence: true

  private

  def delete_calendar_event
    GoogleCalendar.new(schedule.user_token).delete_event(calendar_event_id)
  end
end
