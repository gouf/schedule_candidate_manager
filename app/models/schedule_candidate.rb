class ScheduleCandidate < ApplicationRecord
  attr_accessor :token

  after_create :insert_to_calendar

  belongs_to :schedule

  validates :start_datetime, presence: true
  validates :end_datetime, presence: true

  private

  def insert_to_calendar
    calendar_id =
      GoogleCalendar.new(token)
                    .insert_event(
                      summary: '面談? (未定)',
                      location: schedule.location,
                      description: [schedule.corporation_name, schedule.description].join("\n"),
                      start_datetime: start_datetime,
                      end_datetime: end_datetime
                    ).id

    self.calendar_event_id = calendar_id
    save!
  end
end
