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
