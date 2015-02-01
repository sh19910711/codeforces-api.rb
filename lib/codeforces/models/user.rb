module Codeforces::Models

  class User < Base

    def submissions
      client.api.user.status(base.handle)
    end

  end

end

