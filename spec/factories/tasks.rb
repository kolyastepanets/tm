FactoryGirl.define do
  factory :task do
    name "MyString"
    status false
    association :project, factory: :project
  
    trait :invalid do
      name nil
    end
  end
end
