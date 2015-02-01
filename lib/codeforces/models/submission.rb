module Codeforces::Models

  class Submission < Base

    attr_reader :user_id

    def initialize(client, base)
      super
      @user_id = base.author.members.first.handle
    end

    def user
      client.send(:user, user_id)
    end

  end

end

