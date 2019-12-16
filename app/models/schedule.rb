class Schedule < ApplicationRecord
  has_many :schedule_candidates, dependent: :destroy

  # TODO: Schedule に予定情報詳細、ScheduleCandidate に開始・終了日時を記録するコードを書く

end
