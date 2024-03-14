FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "User #{n}" }
    # Add other attributes as needed
  end
end
