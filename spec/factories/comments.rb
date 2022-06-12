FactoryBot.define do
  factory :comment do
    association :event
    body { "Hello, world!" }
    user_name { 'superuser' }
  end
end
