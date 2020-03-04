# == Schema Information
#
# Table name: authentications
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  provider   :string           not null
#  uid        :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
describe Authentication do
  describe 'Test accessible attribtues' do
    subject { Authentication.new }

    it { is_expected.to respond_to(:user_id) }
    it { is_expected.to respond_to(:provider) }
    it { is_expected.to respond_to(:uid) }
    it { is_expected.to respond_to(:created_at) }
    it { is_expected.to respond_to(:updated_at) }
  end
end
