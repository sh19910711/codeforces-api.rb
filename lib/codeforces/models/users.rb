module Codeforces::Models

  class Users < Base

    attr_reader :users

    def initialize(client, base_users)
      super(client)
      @users = base_users
    end

    def grep(option)
      users.select do |user|
        option.any? {|key, value| value === user.send(key) }
      end
    end

    private

    def method_missing(method, *args, &block)
      users.send method, *args, &block
    end

    def respond_to?(method)
      @users.respond_to?(method) || super
    end

  end

end
