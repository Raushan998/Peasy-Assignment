module RedisHelper
    def self.redis_connection
        @redis ||= Redis.new(host: 'localhost', port: 6379)
    end

    def self.set_female_count(by)
        redis_connection.incrby('female_count', by)
    end

    def self.set_male_count(by)
        redis_connection.incrby('male_count', by)
    end

    def self.get_male_count
        redis_connection.get('male_count')
    end

    def self.get_female_count
        redis_connection.get('female_count')
    end

    def self.reset_count
        redis_connection.del('male_count')
        redis_connection.del('female_count')
    end
end