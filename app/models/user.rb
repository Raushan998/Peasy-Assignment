class User < ApplicationRecord
  after_destroy :update_daily_records

  def self.create_user
    Users::CreateService.new.call
  end

  def update_daily_records
    @daily_record = DailyRecord.find_by(date: created_at.to_date)
    return unless @daily_record

    count_attribute = "#{gender}_count".to_sym
    @daily_record.update!(count_attribute => (@daily_record.send(count_attribute) - 1))
  end
end
