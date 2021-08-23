FactoryBot.define do
  factory :event do
    title { "Лучшее событие_#{rand(999)}" }
    address { "город #{rand(999)}" }
    datetime { DateTime.now + 2.weeks }

    association :user
  end
end
