require 'google/apis/calendar_v3'

class GoogleCalendar
  # TODO: API を通して Google Calendar にイベントを作成する

  # AccessToken インスタンスを要求: app/models/access_token.rb
  def initialize(token)
    @calendar = ::Google::Apis::CalendarV3::CalendarService.new
    @calendar.authorization = token
  end

  def insert_event(**params)
    event =
      ::Google::Apis::CalendarV3::Event.new(
        summary: params.fetch(:summary, '面談? (未定)'),
        location: params.fetch(:location, ''),
        description: params.fetch(:description, ''),
        start: {
          date_time: params.fetch(:start_datetime).rfc3339(9),
          time_zone: 'Asia/Tokyo'
        },
        end: {
          date_time: params[:end_datetime].rfc3339(9),
          time_zone: 'Asia/Tokyo'
        }
      )

    @calendar.insert_event('primary', event)
  end
end
