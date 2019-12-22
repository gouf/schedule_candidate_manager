class Schedule < ApplicationRecord
  # FIXME: ログインしていると他のユーザの予定が表示できる
  # TODO: current_user.id で検索可能なユーザのみのレコードを選択可能にする
  # TODO: user_id カラムの追加

  attr_accessor :datetime_pairs, :google_access_token

  after_create :create_schedule_candidates

  has_many :schedule_candidates, dependent: :destroy

  validates :corporation_name, length: { minimum: 1 }

  private

  def create_schedule_candidates
    token = AccessToken.new(@google_access_token)

    [*@datetime_pairs].each do |start_datetime, end_datetime|
      ScheduleCandidate.create!(
        schedule_id: id,
        start_datetime: start_datetime,
        end_datetime: end_datetime,
        token: token
      )
    end
  end
end
