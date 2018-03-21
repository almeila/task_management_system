FactoryGirl.define do
  factory :task do
    sequence(:title)   { |n| "MyString#{n}" }
    sequence(:content) { |n| "MyText#{n}" }
    sequence(:end_period) { |n| "2020-#{n}-01 00:00:00" }
  end
end