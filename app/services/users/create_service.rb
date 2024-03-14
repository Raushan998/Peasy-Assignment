module Users
  # Create Service for Users
  class CreateService
    include ::RedisHelper
    def initialize
      @fetch_data = RestClient.get(ENV['API_URL'])
    end

    def call
      ActiveRecord::Base.transaction do
        user_list[:results].each do |user_data|
          @user = User.find_or_initialize_by(uuid: user_data[:login][:uuid])
          @user.update!(user_params(user_data))
        end
      end
      store_gender_count
    rescue ActiveRecord::RecordInvalid => e
      Rails.logger.error "Error updating line item: #{e.message}"
      raise ActiveRecord::Rollback
    end

    private

    def user_params(user_data)
      {
        name: user_data[:name],
        gender: user_data[:gender],
        location: user_data[:location],
        age: user_data[:dob][:age]
      }
    end
    
    def store_gender_count
      male_count = user_list[:results].count { |user| user[:gender] == 'male' }
      female_count = user_list[:results].count { |user| user[:gender] == 'female' }
      RedisHelper.set_female_count(female_count)
      RedisHelper.set_male_count(male_count)
    end

    def user_list
      @user_list ||= parse_json(@fetch_data.body)
    end

    def parse_json(data)
      JSON.parse(data).deep_symbolize_keys
    end
  end
end
