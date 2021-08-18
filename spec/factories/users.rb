FactoryBot.define do
  factory :user do
    name { "Жора_#{rand(999)}" }
    sequence(:email) { |n| "someguy_#{n}@example.com" }

    # Коллбэк — после фазы :build записываем поля паролей, иначе Devise не
    # позволит создать юзера
    after(:build) { |u| u.password_confirmation = u.password = "111111"}
  end
end
