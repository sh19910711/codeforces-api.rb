module Codeforces::Models

  class User < Base

    attr_reader :user

    def initialize(client, base_user)
      super(client)

      @user = base_user
    end

    def submissions
      client.api.user.status(user.handle)
    end

    private

    def method_missing(method, *args, &block)
      user.send method, *args, &block
    end

  end

end

