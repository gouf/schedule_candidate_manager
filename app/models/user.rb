# == Schema Information
#
# Table name: users
#
#  id                :integer          not null, primary key
#  email             :string           not null
#  crypted_password  :string
#  salt              :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  profile_image_url :string           default("")
#
class User < ApplicationRecord
  authenticates_with_sorcery!

  has_many :tokens, dependent: :destroy
  has_many :authentications, dependent: :destroy
  has_many :schedules, dependent: :destroy
  accepts_nested_attributes_for :authentications
end
