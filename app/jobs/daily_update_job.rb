class DailyUpdateJob < ApplicationJob
    queue_as :default

    def perform
        DailyRecord.create_records
    end
end