# spec/factories/daily_records.rb
FactoryBot.define do
  factory :daily_record do
    date { Date.today }
    # Add other attributes as needed
  end
end
