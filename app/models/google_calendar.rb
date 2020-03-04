require 'google/apis/calendar_v3'
require 'google/api_client/client_secrets'

class GoogleCalendar
  def initialize(token)
    @calendar = ::Google::Apis::CalendarV3::CalendarService.new
    @token = token

    # AccessToken インスタンスを利用する: app/models/access_token.rb
    @calendar.authorization = AccessToken.new(token)
  end

  # ActiveRecord 経由でデータベースに情報を保存して...
  # * API リクエストなしに情報を表示
  # * Google Calendar 上のイベント ID を控えて後から操作
  # ...できるようにする
  #
  # params = {
  #   user_id: ...,
  #   title: ...,
  #   corporation_name: ...,
  #   description: ...,
  #   start_datetime: ...,
  #   end_datetime: ...,
  # }
  #
  def save_schedule_candidates(**params)
    schedule =
      Schedule.new(
        user_id: params.fetch(:user_id),
        title: params.fetch(:title) ,
        corporation_name: params.fetch(:corporation_name),
        description: params.fetch(:description)
      )

    Schedule.transaction do
      schedule.save!

      params.fetch(:start_datetime).zip(params.fetch(:end_datetime))
            .each do |start_datetime, end_datetime|
              calendar_event_id =
                insert_event(
                  summary: schedule.title,
                  description: [schedule.corporation_name, schedule.description].join("\n"),
                  start_datetime: start_datetime.to_date,
                  end_datetime: end_datetime.to_date,
                  location: schedule.location
                ).id

              ScheduleCandidate.create!(
                schedule_id: schedule.id,
                calendar_event_id: calendar_event_id,
                start_datetime: start_datetime,
                end_datetime: end_datetime
              )
          end
    end
  end

  # params = {
  #   summary: ...,         # イベントのタイトル String
  #   location: ...,        # 住所               String
  #   description: ...,     # イベントの詳細内容 String
  #   start_datetime: ...,  # イベントの開始時刻 DateTime
  #   end_datetime: ...     # イベントの開始時刻 DateTime
  # }
  def insert_event(**params)
    event =
      ::Google::Apis::CalendarV3::Event.new(
        summary: params.fetch(:summary, ''),
        location: params.fetch(:location, ''),
        description: params.fetch(:description, ''),
        start: {
          date_time: params.fetch(:start_datetime).rfc3339,
          time_zone: 'Asia/Tokyo'
        },
        end: {
          date_time: params[:end_datetime].rfc3339,
          time_zone: 'Asia/Tokyo'
        }
      )

    @calendar.insert_event('primary', event)
  end

  def delete_event(event_id)
    @calendar.delete_event('primary', event_id)
  end

  class << self
    # refresh_token を用いて 有効な token, refresh_token を再取得
    # Ref: https://github.com/googleapis/google-auth-library-ruby/issues/202
    def refresh_token(refresh_token)
      secrets =
        Google::APIClient::ClientSecrets.new(
          web: {
            refresh_token: refresh_token,
            client_id: ENV['GOOGLE_API_CLIENT_KEY'],
            client_secret: ENV['GOOGLE_API_CLIENT_SECRET']
          }
        )

      credentials = secrets.to_authorization.refresh!

      {
        refresh_token: credentials['refresh_token'],
        access_token: credentials['access_token'],
        expires_at: credentials['expires_in'].seconds.from_now
      }
    end
  end
end
