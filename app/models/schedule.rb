# == Schema Information
#
# Table name: schedules
#
#  id               :integer          not null, primary key
#  title            :string
#  description      :text
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  corporation_name :string
#  location         :string
#  user_id          :integer
#
class Schedule < ApplicationRecord
  # FIXME: ログインしていると他のユーザの予定が表示できる
  # TODO: current_user.id で検索可能なユーザのみのレコードを選択可能にする

  has_many :schedule_candidates, dependent: :destroy
  belongs_to :user

  validates :corporation_name, length: { minimum: 1 }

  def user_token
    user.tokens.last.token
  end
end
