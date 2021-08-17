FactoryBot.define do

  factory :event do
    title { "Лучшее событие_#{rand(999)}" }
    address { "город #{rand(999)}" }
    datetime { "2021-08-28 07:59:00"}

    association :user
  end
end
