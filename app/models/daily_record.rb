class DailyRecord < ApplicationRecord
  after_save :update_avg_age, if: -> { male_count_changed? || female_count_changed? }

  def self.create_records
    ::DailyRecords::CreateService.new.call
  end

  def update_avg_age
    male_avg_age = User.where(gender: 'male').average(:age).to_f
    female_avg_age = User.where(gender: 'female').average(:age).to_f
    update_columns(male_avg_age: male_avg_age, female_avg_age: female_avg_age)
  end
end
