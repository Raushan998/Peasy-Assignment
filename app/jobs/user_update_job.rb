class UserUpdateJob < ApplicationJob
    queue_as :default 
    
    def perform
        User.create_user
    end
end