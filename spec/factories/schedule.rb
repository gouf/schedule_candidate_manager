FactoryBot.define do
  factory :schedule do
    title { '面談? (未定)' }
    corporation_name { 'テスト企業名' }
    location { '横浜駅' }
    description { "#{corporation_name}\n予定詳細" }
  end
end
