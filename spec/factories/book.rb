FactoryBot.define do
  factory :book do
    title { Faker::Name.name }
    description { Faker::Lorem.sentence }

    association :author, factory: :user
  end
end


longest = %w{ cat sheep bear }.inject do |memo, word|
  puts memo, word
   memo.length > word.length ? memo : word
end
