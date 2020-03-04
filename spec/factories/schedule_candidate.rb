FactoryBot.define do
  factory :schedule_candidate do
    schedule
    start_datetime { DateTime.current }
    end_datetime { DateTime.current }
  end
end
