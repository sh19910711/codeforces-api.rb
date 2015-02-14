module Codeforces::Models

  class Contest < Base

    def problems
      client.problems.contest base.id
    end

  end

end

