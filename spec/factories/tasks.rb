FactoryBot.define do
  factory :task do
    title { Faker::Lorem.characters(number: 20) }
    deadline { Faker::Date.forward(days: 30) }
    content { Faker::Lorem.paragraph(sentence_count: 3) }
  end
end
