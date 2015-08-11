FactoryGirl.define do
  sequence :name do |n|
    "Text#{n}"
  end

  factory :project do
    name
    association :user, factory: :user

    trait :invalid do
      name nil
    end
  end
end
