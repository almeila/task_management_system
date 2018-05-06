# userが作成されている必要があります
30.times do
  first_user_id = User.find_by(email: 'testmail@first.com').id
  Task.create(
    title: "#{Faker::Pokemon.name}を捕まえる。",
    content: "生息地：#{Faker::Pokemon.location}",
    user_id: first_user_id,
    end_period: Random.rand(Time.current.next_day .. Time.current.next_year),
    priority: [:low, :normal, :high].sample
  )
end