FactoryGirl.define do
  factory :task do
    sequence(:title)   { |n| "MyString#{n}" }
    sequence(:content) { |n| "MyText#{n}" }
    sequence(:end_period) { |n| Time.current.next_year.since(n.days) }
    sequence(:priority) {[:low, :normal, :high].sample}
  end
end