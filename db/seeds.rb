30.times do
  Task.create(
    title: "#{Faker::Pokemon.name}を捕まえる",
    content: "生息地：#{Faker::Pokemon.location}",
    end_period: Random.rand(Time.current.next_day .. Time.current.next_year),
    priority: [:low, :normal, :high].sample
   )
end