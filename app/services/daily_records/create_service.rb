module DailyRecords
  class CreateService
    def call
      daily_record = DailyRecord.new(
        date: Date.today,
        male_count: RedisHelper.get_male_count,
        female_count: RedisHelper.get_female_count
      )
      daily_record.save
      daily_record.update_avg_age
      reset_records
    end

    def reset_records
      RedisHelper.reset_count
    end
  end
end
