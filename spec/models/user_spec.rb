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
describe User do
  describe 'Test accessible attribtues' do
    subject { User.new }

    it { is_expected.to respond_to(:email) }
    it { is_expected.to respond_to(:crypted_password) }
    it { is_expected.to respond_to(:salt) }
    it { is_expected.to respond_to(:profile_image_url) }
    it { is_expected.to respond_to(:authentications) }
    it { is_expected.to respond_to(:created_at) }
    it { is_expected.to respond_to(:updated_at) }
  end
end
