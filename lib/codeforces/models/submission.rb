module Codeforces::Models

  class Submission < Base

    attr_reader :status
    attr_reader :user_id

    def initialize(client, base_status)
      super(client)

      @status = base_status
      @user_id = status.author.members.first.handle
    end

    def user
      client.send(:user, user_id)
    end

    private

    def method_missing(method, *args, &block)
      status.send method, *args, &block
    end

  end

end
